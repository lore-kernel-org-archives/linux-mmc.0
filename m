From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/2] mmc: add SDHCI OF Synopsys DWC MSHC dirver
Date: Mon, 9 Jul 2018 13:32:01 +0200
Message-ID: <CAPDyKFp09ch9X0dxC33RBNf4yLzJ439ZCV7sqCiGM300KO48xA@mail.gmail.com>
References: <20180706151930.78b3024b@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180706151930.78b3024b@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Prabu Thangamuthu <Prabu.T@synopsys.com>, Manjunath M B <Manjunath.MB@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

On 6 July 2018 at 09:19, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> Add support for Synopsys SDHCI compatible DesignWare Cores Mobile
> Storage Host Controller which can support eMMC/SD/SDIO.
>
> Since v1:
>   - move the dt bindings into a separate patch
>
> Jisheng Zhang (2):
>   dt: bindings: Add bindings for SDHCI Synopsys DWC MSHC
>   mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC dirver
>
>  .../bindings/mmc/sdhci-of-dwcmshc.txt         |  20 +++
>  drivers/mmc/host/Kconfig                      |  11 ++
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/sdhci-of-dwcmshc.c           | 116 ++++++++++++++++++
>  4 files changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
>  create mode 100644 drivers/mmc/host/sdhci-of-dwcmshc.c
>
> --
> 2.18.0
>

Thanks, applied for next!

Kind regards
Uffe
