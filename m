From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 00/13] mmc: meson-gx: driver fixups and upgrades
Date: Wed, 30 Aug 2017 15:13:57 +0200
Message-ID: <CAPDyKFogy=L=BDKtMhKCN0nMLi-Yy5SHgAhB_=jog+CX91breA@mail.gmail.com>
References: <20170828142915.27020-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170828142915.27020-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 28 August 2017 at 16:29, Jerome Brunet <jbrunet@baylibre.com> wrote:
> The patchset features several bugfixes, rework and upgrade for the
> meson-gx MMC driver.
>
> The main goal is to improve readability and enable new high speed
> modes, such as eMMC DDR52 and sdcard UHS modes up to SDR50 (100Mhz)
>
> SDR104 is not working with a few cards on the p200 and the
> libretech-cc. I suspect that 200Mhz might be a bit too fast for the PCB
> of these boards, adding noise to the signal and eventually breaking
> the communication with some cards. The same cards are working well on a
> laptop or the nanopi-k2 at 200Mhz.
>
> This series has been tested on gxbb-p200, gxbb-nanopi-k2 and
> gxl-s905x-libretech-cc
>
> Changes since v2 [1]:
> * Drop patches 1 to 3: Applied.
> * Drop patch 4: Debug stuff which should not have been sent.
> * Added fix to previous patch 3:
>   If the clock register is not initialized before registering the clk
>   with CCF, the framework will complain about an illegal divider value.
>   This had gone unnoticed because it was later fixed by the clock init
>   rework.
>
>   Ulf, I know it is getting late but it would be nice if patch #1 of
>   this v3 could go with 3 patches you already applied. The rest can
>   wait for the following cycle.

I decided to pick them all, so applied for next!

For patch1, I decided to update the changelog a bit, avoiding to have
a specific fixes tag, becasue the fix might not end up having the same
hash, when/if I rebase my branch.

Thanks!

Kind regards
Uffe

>
> Changes since v1 [0]:
> * Reorder patches to have fixes first, then rework and finally
>   enhancements.
> * Use CCF to manage clock phases
>
> [0]: https://lkml.kernel.org/r/20170804174353.16486-1-jbrunet@baylibre.com
> [1]: https://lkml.kernel.org/r/20170821160301.21899-1-jbrunet@baylibre.com
>
> Jerome Brunet (13):
>   mmc: meson-gx: initialize sane clk default before clock register
>   mmc: meson-gx: cfg init overwrite values
>   mmc: meson-gx: rework set_ios function
>   mmc: meson-gx: rework clk_set function
>   mmc: meson-gx: rework clock init function
>   mmc: meson-gx: fix dual data rate mode frequencies
>   mmc: meson-gx: work around clk-stop issue
>   mmc: meson-gx: simplify interrupt handler
>   mmc: meson-gx: implement card_busy callback
>   mmc: meson-gx: use CCF to handle the clock phases
>   mmc: meson-gx: implement voltage switch callback
>   mmc: meson-gx: change default tx phase
>   mmc: meson-gx: rework tuning function
>
>  drivers/mmc/host/meson-gx-mmc.c | 710 ++++++++++++++++++++++++++++------------
>  1 file changed, 493 insertions(+), 217 deletions(-)
>
> --
> 2.9.5
>
