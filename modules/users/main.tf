data "ignition_user" "martinbreu" {
  name                = "martinbreu"
  groups              = [
    "wheel",
    "docker"
  ]
  ssh_authorized_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDSp5/SBuVmer4jNfj5ztYsZyqe4uIK/BiEVbejC5fqbPadjVu2WW2l53aq586BfCLUtWGezWZSQekzz5zJNUxsCUqiCBY32GnESbh/MOfBNnx1Xwg6FeuVqzP91QgOWV9nzeVioO0Setg705FPoImlA0nwU6pS57QE3ll34R9Oky6xHV+wvVAj5K2YmDttsj/SOowo/kuwg2U9wS0qNQhX7FQjUk6kpeGoQ354NmmwCDaJtU9IUTY8BdXaM80USMc5V6huBYFnwoZXAkpKhTNo0ucFkXrrDaagghUK4FjoftG/EpDuQRVi3Hrgx3EHp89uBU1xOylgs9wR485gIm56nrErD2gr5i+rfRL4KTFoBekefQU2zIAKbZkSdFx7SdzdBPyWRszLFJCpVkfngsY3DLx9Lu6Vnt9vJNYXe06M/fqxBVEwP8esMJDZTZybp0cqAfUXUCAyKAxpgvlGJSz+pBJXtu5wOd6feK5ySJf52219QLXXfjlQxlYb13oEnxuESehTVHIqFpI88OTnU9LgF8mkcRudhVXoPw1k/9Sg34NZp4kB18p7rUezIplIMI1hRLYgmeqovRMSeV0Sb3n63iBSutHu1RMFG6VkBN59aVCx8+lg2SgLp2NcX4frgjNuVZBFko3ksniXosvhdTsoCcPW3R3rjMhKGfdoGaWbhQ== martinbreu"
  ]
}

data "ignition_user" "akiel" {
  name                = "akiel"
  groups              = [
    "wheel",
    "docker"
  ]
  ssh_authorized_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCXNWbPLgh2qbRY5h20MzK6ezuYqYFNW1uDbkXehsX0/9eWY8+W0lh/LN6qOhx0/SDhZS1m2HM1HXpK9rbgkx0CejW+Di6sAOE52/6r9d4q4LshxjSjQvn0YAulu7ErwAoTJgFcOcUf8GXMU0FbSUgSBiwjD/TUHw30ywWmDqWtR2YzZH5qYZMlDaoh3RXxZGbNc1t3YOpIAUXutJUzHn4ekG4OltF8Wc2uHfr+Q0jAwi4zthhNMnZ8cgLHze1AMRV/QvzPG/h6TQ+A2vhMSo9lCV0eRH/dg6dADSHNoQxFHB/7Z7VHXZZoOhD4L8W8P7rWnbeVevYw9enZECxdCqLR akiel"
  ]
}

data "ignition_user" "bkroll" {
  name                = "bkroll"
  groups              = [
    "wheel",
    "docker"
  ]
  ssh_authorized_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAwp4MKHmgq49N7QNUfXRZZ/hhs0co5kSs7QhHl7HfOLoRsi+cChS4BRWJm8EoGN8tvrkJvky7ke2tbrJNW++jIzlgfO/4zs4imo0ornWvMAWmS6iDl0j0hjJc18WVurQgYgQiCmylJdh+41e4ToqYpl2Qyy0lBtrvbE+RpoyQxx0fMJ9i5nei5T50E97diYHxq4ijw1BxKyRircZbvu0m0mUDs242yW2i7eIVafPQgP6BBjravXRSzuRblaReG63CESZfebCZHNH3NJ09+/6mkO6nZcjXxPpq1S95r88Sj3XWJK1EjMT2r+NKlFBYJfERZK6JTLz247tmn9AeDxAwFw== bkroll"
  ]
}

data "ignition_user" "dolchchr" {
  name                = "dolchchr"
  groups              = [
    "wheel",
    "docker"
  ]
  ssh_authorized_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMnqlHO7WFRCpFsyR+J9kiDEeCnbsnT2zxLqOJvNQPM6Np0+eOUeVsW7BkU7fwKo6BotqeGr971ig+GKmH+c+23yzz4QxT6H74yAG1wz5KrSZ3ePOYcJQL5DesbjP5RBga2U9Nrj/HvdQrefbOyAsyoVJEGhUhEEh+gVqvbDa5BtvgbUAxKYGNyadGGoyzITVe+EHdlJULmc/UvKm9tUdI3Rt8+D27Ol9q8G5ZcgKRqnBfRauNsW2q7d8jSA6t0rpH05sdWY9JTc2DudHMHwbn2ot9MT2ebqNoHSaNiNwRrFVxmWvf3+vYbxOOWQUCY+j2FozMf1Fdik9BwAA3Sb8T dolchchr"
  ]
}

data "ignition_user" "mlablans" {
  name                = "mlablans"
  groups              = [
    "wheel",
    "docker"
  ]
  ssh_authorized_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEA5utrg0FBLY56TyXweiIgMGoaxHqufNqjyQAul0Hk5VdSO2ZlC2erFd9o/Mbqqz4eZk1Ky9tJmyHuBFqUpHsRDjNRe+6AMBfrIbBHx91sWZQcAl2F8Cz0mOHmvt057RuXwcLncIzaKtonmIkLFyitmiDiNVYpxb0S9AfKGOr3x6i1e183EhMOK9hiB8oN7ROfXEkHK1fXlb8tVX3mx4saYO5ZJ9qy/mt+2bdnf6HEGosy+mslkU3qsAL5Zk4jf7r/0J+gmZpAxXgnr2y6gFO1zvfKybOv9f+BJSsTG1z2lqemqX8TLMTvHUbn3hEr6xoMjKGjovUikf6hntUjpnQXq+LNDiRjLZoJ3aDUzbhjCUuzwbJa2xLHpkdWsuT5ni0fEsG9yF4sLyoWwwANGxV1USzgOUFxd5JUufrAVwaPhZMZhQoDF1gPwa+wQAkXxoVnThDZZ5+e7Xk6zUjv2bjaroW7zpqU0v1UsWCf8Yf45170e41ifHYgetAu/0O1zgrDvTztSFvklqI3x+roy2IqvV5gsV47muYOfUeA7k9POVzsfgh4EGioeEIMZyGhNyLrWOq3k0lB04qpS9tU/OD/KvwDthw4h+lQdiRhdav/GnLhqUsVhdK+aKa0QvyGtGiIjT5UApLtg8zEA9l2E0lZ/fNBKVUiwYLLummsgbs3590= mlablans"
  ]
}
