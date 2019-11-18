defmodule SpaceAge do
  @earth_period 31557600
  @factors %{
    :mercury => 0.2408467,
    :venus => 0.61519726,
    :mars => 1.8808158,
    :jupiter => 11.862615,
    :saturn => 29.447498,
    :uranus => 84.016846,
    :neptune => 164.79132
  }
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    case planet do
      :mercury -> seconds/(@factors.mercury*@earth_period)
      :venus -> seconds/(@factors.venus*@earth_period)
      :earth -> seconds/@earth_period
      :mars -> seconds/(@factors.mars*@earth_period)
      :jupiter -> seconds/(@factors.jupiter*@earth_period)
      :saturn -> seconds/(@factors.saturn*@earth_period)
      :uranus -> seconds/(@factors.uranus*@earth_period)
      :neptune -> seconds/(@factors.neptune*@earth_period)
    end
  end
end
