From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/3] mmc: cavium: bug fixes for 4.12
Date: Mon, 22 May 2017 18:04:11 +0200
Message-ID: <CAPDyKFpdDyv6fKVKCAY-NQ0sbA0f_iGEdGWySq6Um_4HY6_jqw@mail.gmail.com>
References: <20170522110921.15395-1-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170522110921.15395-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: David Daney <david.daney@cavium.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 22 May 2017 at 13:09, Jan Glauber <jglauber@cavium.com> wrote:
> Changes to v1:
> - Fixed platform device leak, apply fix also to Octeon driver
> - Use mmc_regulator_get_supply
>
> Jan Glauber (3):
>   mmc: cavium: Prevent crash with incomplete DT
>   of/platform: Make of_platform_device_destroy globally visible
>   mmc: cavium: Fix probing race with regulator
>
>  drivers/mmc/host/cavium-octeon.c   | 11 ++++++++++-
>  drivers/mmc/host/cavium-thunderx.c |  6 ++++++
>  drivers/mmc/host/cavium.c          | 25 ++++++++++---------------
>  drivers/of/platform.c              |  3 ++-
>  include/linux/of_platform.h        |  1 +
>  5 files changed, 29 insertions(+), 17 deletions(-)
>
> --
> 2.9.0.rc0.21.g7777322
>

Thanks, applied for fixes!

Kind regards
Uffe
