From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/2] mmc: sdhci-of-arasan: Add Support for Intel LGM SDXC
Date: Wed, 9 Oct 2019 11:12:19 +0200
Message-ID: <CAPDyKFqDB_aOikZYSDEvQKF3PsD=AXq0PZJTj8AUAH0XaGj8Eg@mail.gmail.com>
References: <20191009012818.32763-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191009012818.32763-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ramuthevar,Vadivel MuruganX" <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, DTML <devicetree@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, cheol.yong.kim@intel.com, qi-ming.wu@intel.com
List-Id: linux-mmc@vger.kernel.org

On Wed, 9 Oct 2019 at 03:28, Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> The current arasan sdhci PHY configuration isn't compatible
> with the PHY on Intel's LGM(Lightning Mountain) SoC devices.
>
> Therefore, add a new compatible, to adapt the Intel's LGM
> SDXC PHY with arasan-sdhc controller to configure the PHY.
>
> Linux code base : V5.4-rc1
>
> Ramuthevar Vadivel Murugan (2):
>   dt-bindings: mmc: sdhci-of-arasan: Add new compatible for Intel LGM
>     SDXC
>   mmc: sdhci-of-arasan: Add Support for Intel LGM SDXC
>
> changes from v1:
>  -  commit message updated
>  -  Acked-by tag added
>
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 17 +++++++++++++++++
>  drivers/mmc/host/sdhci-of-arasan.c                     | 15 +++++++++++++++
>  2 files changed, 32 insertions(+)

Applied for next, thanks!

Kind regards
Uffe
