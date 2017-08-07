From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 00/14] mmc: meson-gx: driver fixups and upgrade
Date: Mon, 07 Aug 2017 18:48:22 +0200
Message-ID: <1502124502.2759.32.camel@baylibre.com>
References: <20170804174353.16486-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170804174353.16486-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, 2017-08-04 at 19:43 +0200, Jerome Brunet wrote:
> The patchset features several bugfixes, rework and upgrade for the
> meson-gx MMC driver.
> 
> The main goal is to improve readability and enable new high speed
> modes, such as eMMC DDR52 and sdcard UHS modes up to SDR50 (100Mhz)
> 
> While full speed SDR104 is stable with most cards, a few seems to
> require an even more precise tuning. For this, we'll probably have
> to implement per-line delay calibration.
> 
> This series has been tested on gxbb-p200, gxbb-nanopi-k2 and
> gxl-s905x-libretech
> 

Ulf, Kevin,

Please ignore this series. I'll resend it soon

I've discovered new things around the tuning capabilities of the SoC.
I'll probably rework the tuning function again.

Sorry for the noise

Regards
Jerome

> Jerome Brunet (14):
>   mmc: meson-gx: fix mux mask definition
>   mmc: meson-gx: remove CLK_DIVIDER_ALLOW_ZERO clock flag
>   mmc: meson-gx: clean up some constants
>   mmc: meson-gx: use _irqsave variant of spinlock
>   mmc: meson-gx: cfg init overwrite values
>   mmc: meson-gx: rework set_ios function
>   mmc: meson-gx: rework clk_set function
>   mmc: meson-gx: rework clock init function
>   mmc: meson-gx: simplify interrupt handler
>   mmc: meson-gx: implement card_busy callback
>   mmc: meson-gx: rework tuning function
>   mmc: meson-gx: fix dual data rate mode frequencies
>   mmc: meson-gx: work around clk-stop issue
>   mmc: meson-gx: implement voltage switch callback
> 
>  drivers/mmc/host/meson-gx-mmc.c | 611 ++++++++++++++++++++++++++-------------
> -
>  1 file changed, 396 insertions(+), 215 deletions(-)
> 
