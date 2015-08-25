From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 00/16] omap_hsmmc: regulator usage cleanup and fixes
Date: Tue, 25 Aug 2015 13:50:19 +0200
Message-ID: <CAPDyKFpSst5wnR-ZJd3w1J-iWYXqKvXAJTaye_DK=NH_cBzsgw@mail.gmail.com>
References: <1438604801-11823-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438604801-11823-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-mmc@vger.kernel.org

On 3 August 2015 at 14:26, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Changes from v1:
> *) return on -EPROBE_DEFER and other fatal errors. (Don't return only
>    if the return value is -ENODEV)
> *) Remove the beagle x15 dts patch. It can be part of a different
>    series.
> *) Avoid using regulator_is_enabled for vqmmc since if the regulator
>    is shared and the other users are not using regulator_is_enabled
>    then there can be unbalanced regulator_enable/regulator_disable
>
> This patch series does the following
> *) Uses devm_regulator_get_optional() for vmmc and then removes the
>    CONFIG_REGULATOR check altogether.
> *) return on -EPROBE_DEFER and any other fatal errors
> *) enable/disable vmmc_aux regulator based on prior state
>
> I've pushed this patch series to
> git://git.ti.com/linux-phy/linux-phy.git mmc_regulator_cleanup_fixes_v2
>
> Please note the branch also has the pbias fixes [1] & [2].
> [1] -> https://lkml.org/lkml/2015/7/27/358
> [2] -> https://lkml.org/lkml/2015/7/27/391
>
> This series is in preparation for implementing the voltage switch
> sequence so that UHS cards can be supported.
>
> Did basic read/write test in J6, J6 Eco, Beagle-x15, AM437x EVM,
> Beaglebone black, OMAP5 uEVM and OMAP4 PANDA.
>
> Kishon Vijay Abraham I (15):
>   mmc: host: omap_hsmmc: use devm_regulator_get_optional() for vmmc
>   mmc: host: omap_hsmmc: return on fatal errors from omap_hsmmc_reg_get
>   mmc: host: omap_hsmmc: cleanup omap_hsmmc_reg_get()
>   mmc: host: omap_hsmmc: use the ocrmask provided by the vmmc regulator
>   mmc: host: omap_hsmmc: use mmc_host's vmmc and vqmmc
>   mmc: host: omap_hsmmc: remove unnecessary pbias set_voltage
>   mmc: host: omap_hsmmc: return error if any of the regulator APIs fail
>   mmc: host: omap_hsmmc: add separate functions for enable/disable
>     supply
>   mmc: host: omap_hsmmc: add separate function to set pbias
>   mmc: host: omap_hsmmc: avoid pbias regulator enable on power off
>   mmc: host: omap_hsmmc: don't use ->set_power to set initial regulator
>     state
>   mmc: host: omap_hsmmc: enable/disable vmmc_aux regulator based on
>     previous state
>   mmc: host: omap_hsmmc: use regulator_is_enabled to find pbias status
>   mmc: host: omap_hsmmc: use ios->vdd for setting vmmc voltage
>   mmc: host: omap_hsmmc: remove CONFIG_REGULATOR check
>
> Roger Quadros (1):
>   mmc: host: omap_hsmmc: use "mmc_of_parse_voltage" to get ocr_avail
>
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    2 +
>  drivers/mmc/host/omap_hsmmc.c                      |  340 +++++++++++++-------
>  2 files changed, 224 insertions(+), 118 deletions(-)
>
> --
> 1.7.9.5
>

I tried to apply this on top of my next branch, but it didn't work.
Could you please rebase and send a v3!?
While you do that, please add Tony's tested-by tag as well.

Kind regards
Uffe
