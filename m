From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: Re: [PATCH V3 1/3] mmc: sdhci: add support for using external DMA devices
Date: Mon, 3 Dec 2018 18:46:33 +0800
Message-ID: <CAG2=9p9mpC_mB4ghbrJm=e4Ewa9pL7R0zURg=erFPw4MR4S+Zg@mail.gmail.com>
References: <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
 <1543471664-22856-1-git-send-email-zhang.chunyan@linaro.org>
 <cb2cdfb9-f3e6-72cd-2d55-734b08ea3e15@intel.com> <42f994b2-ba98-8160-6eef-11eeb8a10f5e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <42f994b2-ba98-8160-6eef-11eeb8a10f5e@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, Lyra Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 3 Dec 2018 at 17:01, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi Chunyan,
>
> On 29/11/18 2:53 PM, Adrian Hunter wrote:
> > On 29/11/18 8:07 AM, Chunyan Zhang wrote:
> >> Some standard SD host controllers can support both external dma
> >> controllers as well as ADMA/SDMA in which the SD host controller
> >> acts as DMA master. TI's omap controller is the case as an example.
> >>
> >> Currently the generic SDHCI code supports ADMA/SDMA integrated in
> >> the host controller but does not have any support for external DMA
> >> controllers implemented using dmaengine, meaning that custom code is
> >> needed for any systems that use an external DMA controller with SDHCI.
> >>
> >> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> >> ---
> >>  drivers/mmc/host/Kconfig |  14 ++++
> >>  drivers/mmc/host/sdhci.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++-
> >>  drivers/mmc/host/sdhci.h |   8 ++
> >>  3 files changed, 206 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >> index 1b58739..4183f43 100644
> >> --- a/drivers/mmc/host/Kconfig
> >> +++ b/drivers/mmc/host/Kconfig
> >> @@ -969,6 +969,7 @@ config MMC_SDHCI_XENON
> >>  config MMC_SDHCI_OMAP
> >>      tristate "TI SDHCI Controller Support">>        depends on MMC_SDHCI_PLTFM && OF
> >> +    select MMC_SDHCI_EXTERNAL_DMA if DMA_ENGINE
>
>
> This should be in patch 2.

Ok, will move to.

Thanks,
Chunyan

>
> Thanks,
> Faiz
