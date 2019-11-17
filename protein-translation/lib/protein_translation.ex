defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(strand) do
    get_rna(String.to_charlist(strand))
  end

  # Header --------------------------------------------------------
  def get_rna(charlist, codon \\ [], codon_list \\ [])
  # - --------------------------------------------------------------
  def get_rna([hd|tl], codon, codon_list) do
      if length(codon) < 3 do 
          get_rna(tl, codon ++ [hd], codon_list) 
      else
          get_rna(tl, [] ++ [hd], codon_list ++ codon ++ [','])
      end    
  end
  # ---------------------------------------------------------------
  def get_rna([], codon, codon_list) do
     codon_list ++ codon
    |> List.to_string()
    |> String.split(",")
    |> (&(for codon <- &1, do: of_codon(codon))).()
    |> (
            fn resp_list -> 
                if String.length(List.to_string(Keyword.get_values(resp_list, :error))) > 0 do
                    {:error, "invalid RNA"}
                else
                    Keyword.get_values(resp_list, :ok) |>
                    Enum.split_while(fn protein -> !(protein==="STOP") end) |>
                    Tuple.to_list() |>
                    (&({:ok, Enum.at(&1,0)})).()
                    
                end            
            end
      ).() 
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case codon do
      "UGU" -> {:ok, "Cysteine"}
      "UGC" -> {:ok, "Cysteine"}
      "UUA" -> {:ok, "Leucine"}
      "UUG" -> {:ok, "Leucine"}
      "AUG" -> {:ok, "Methionine"}
      "UUU" -> {:ok, "Phenylalanine"}
      "UUC" -> {:ok, "Phenylalanine"}
      "UCU" -> {:ok, "Serine"}
      "UCC" -> {:ok, "Serine"}
      "UCA" -> {:ok, "Serine"}
      "UCG" -> {:ok, "Serine"}
      "UGG" -> {:ok, "Tryptophan"}
      "UAU" -> {:ok, "Tyrosine"}
      "UAC" -> {:ok, "Tyrosine"}
      "UAA" -> {:ok, "STOP"}
      "UAG" -> {:ok, "STOP"}
      "UGA" -> {:ok, "STOP"}
          _  -> {:error, "invalid codon"}
    end
  end
end
