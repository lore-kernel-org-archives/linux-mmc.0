From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/5] mmc: cavium: bug fixes for 4.12
Date: Fri, 19 May 2017 10:30:22 +0200
Message-ID: <CAPDyKFpaWvvxz3g_tq0WG=_O3e+0MSBnMqmud0Me=0Adf4NUrg@mail.gmail.com>
References: <20170516093655.17746-1-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170516093655.17746-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: David Daney <david.daney@cavium.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 16 May 2017 at 11:36, Jan Glauber <jglauber@cavium.com> wrote:
> Hi Ulf,
>
> here are some bug fixes for the new mmc driver. The only
> non-trivial fix should be the platform thing in patch #4 and #5.
>
> Tested on OcteonTx and on various MIPS boxes.
>
> thanks,
> Jan
>
> David Daney (2):
>   mmc: cavium-octeon: Fix interrupt enable code
>   mmc: cavium-octeon: Use proper GPIO name for power control
>
> Jan Glauber (3):
>   mmc: cavium: Prevent crash with incomplete DT
>   of/platform: Make of_platform_device_destroy globally visible
>   mmc: cavium: Fix probing race with regulator
>
>  drivers/mmc/host/cavium-octeon.c   | 4 ++--
>  drivers/mmc/host/cavium-thunderx.c | 4 +++-
>  drivers/mmc/host/cavium.c          | 8 ++++++--
>  drivers/of/platform.c              | 3 ++-
>  include/linux/of_platform.h        | 1 +
>  5 files changed, 14 insertions(+), 6 deletions(-)
>
> --
> 2.9.0.rc0.21.g7777322
>

I picked up patch1 and patch2 for fixes. The rest needs a re-spin.

Thanks and kind regards
Uffe
