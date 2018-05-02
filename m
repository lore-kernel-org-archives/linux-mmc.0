From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 00/14] mmc: sdhci-omap: Add UHS/HS200 mode support
Date: Wed, 2 May 2018 15:15:11 +0200
Message-ID: <CAPDyKFqb=Dyi=UMZBLKcrBbmaWbGEjf-Vp5vQ0b7_F__+YnXHQ@mail.gmail.com>
References: <20180427114723.2687-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427114723.2687-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 27 April 2018 at 13:47, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Add UHS/HS200 mode support in sdhci-omap. The programming sequence
> for voltage switching, tuning is followed from AM572x TRM
> http://www.ti.com/lit/ug/spruhz6j/spruhz6j.pdf
> (Similar to all AM57x/DRA7x SoCs). The patch series also implements
> workaround for errata published in
> http://www.ti.com/lit/er/sprz429l/sprz429l.pdf
>
> patches are created on top of
> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
>
> The patches along with dt has also been pushed to
> https://github.com/kishon/linux-wip.git sdhci_uhs_v5

Thanks, applied for next!

Kind regards
Uffe

>
> Changes from v4:
> *) Added comment in sdhci for disabling HS200/HS400 mode
> *) Fixed a couple of chunks in "Program a relatively accurate SW timeout
>    value" which were missed in the previous revision
> *) Added a patch in sdhci-omap to get IODelay values of 3.3v DDR mode.
> *) Added pinctrl binding documentation for sdhci-omap which was missed
>    before.
>
> Changes from v3:
> *) Fixed Adrian's comment on error handling when __sdhci_add_host()
>    fails
> *) Used Adrian's patches for programming SW timeout value.
>
> Changes from v2:
> *) Patches in v2 already applied to mmc -next are dropped from the
>    series.
> *) Changed SW timeout logic as per Adrians's suggestion
> *) Validated SDIO with the current patches (added a couple of fixes
>    found while adding SDIO support).
> *) Used soc_device_match() instead of pdata-quirks as per Tony's
>    suggestions.
>
> Changes from v1:
> *) Only poll on DAT0 and DATI for card_busy status
> *) Cleanup iodelay patch as suggested by Tony.
> *) Added quirk to disable HW timeout
> *) Use the existing data timer but program a relatively accurate
>    SW timeout value (Impacts all platforms)
> *) Fix a bug in sdhci which was using data_timer for non data line
>    commands
>
> Adrian Hunter (2):
>   mmc: sdhci: Add quirk to disable HW timeout
>   mmc: sdhci: Factor out target_timeout calculation
>
> Kishon Vijay Abraham I (12):
>   mmc: sdhci-omap: Fix when capabilities are obtained from
>     SDHCI_CAPABILITIES reg
>   mmc: sdhci-omap: Remove setting ADMA capability in driver
>   mmc: sdhci-omap: Workaround for Errata i843
>   mmc: sdhci-omap: Invoke sdhci_get_of_property to read sdhci dt
>     properties
>   mmc: sdhci: Disable 1.8v modes (HS200/HS400/UHS) if controller can't
>     support 1.8v
>   mmc: sdhci: Program a relatively accurate SW timeout value
>   mmc: sdhci-omap: Workaround for Errata i834
>   dt-bindings: sdhci-omap: Add K2G specific binding
>   mmc: sdhci-omap: Add support for MMC/SD controller in k2g SoC
>   mmc: sdhci-omap: Add sdhci_omap specific ops for enable_sdio_irq
>   dt-bindings: sdhci-omap: Add pinctrl bindings
>   mmc: sdhci-omap: Get IODelay values for 3.3v DDR mode
>
>  .../devicetree/bindings/mmc/sdhci-omap.txt    |   7 +
>  drivers/mmc/host/sdhci-omap.c                 |  92 +++++++++--
>  drivers/mmc/host/sdhci.c                      | 148 ++++++++++++++----
>  drivers/mmc/host/sdhci.h                      |  15 ++
>  include/linux/mmc/host.h                      |   4 +
>  5 files changed, 226 insertions(+), 40 deletions(-)
>
> --
> 2.17.0
>
