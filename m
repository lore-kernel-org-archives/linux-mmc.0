From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] mmc: meson-gx: fixes for v4.14
Date: Wed, 4 Oct 2017 10:59:34 +0200
Message-ID: <CAPDyKFqoDraQquAvA_n5+9R9rQXHNX+GG=Z=vXhw3x6B2=R6ig@mail.gmail.com>
References: <20171002122743.32334-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171002122743.32334-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Heiner Kallweit <hkallweit1@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2 October 2017 at 14:27, Jerome Brunet <jbrunet@baylibre.com> wrote:
> This patchset fixes the issues reported by Heiner [0] with the odroid-c2.
> In a nutshell, this series does the following:
>
> * Make sure the mmc clock rate is not set higher than what is requested
> * Reset the tuning values on mmc power cycle instead of POWER_ON
> * Add tuning of the tx phase to the tuning function.
>
> This fixes the problem seen on the odroid-c2, both for hs200 and hs400.
> To check for regression, this series has also been tested on the gxl
> libretech-cc
>
> Ulf, could you please pick this as fixes for v4.14 ?

Thanks, applied for fixes!

Kind regards
Uffe

>
> [0]: https://lkml.kernel.org/r/e2171288-84ef-82db-2efc-300935e6c062@gmail.com
>
> Jerome Brunet (3):
>   mmc: meson-gx: make sure the clock is rounded down
>   mmc: meson-gx: fix rx phase reset
>   mmc: meson-gx: include tx phase in the tuning process
>
>  drivers/mmc/host/meson-gx-mmc.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> --
> 2.13.5
>
