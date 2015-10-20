From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/9] Add tune support of Mediatek MMC driver
Date: Tue, 20 Oct 2015 18:41:02 +0200
Message-ID: <CAPDyKFrTrR5U7QoXpiWj29bUD5SEp4ccbx8qNs9HF0cYxuqdBw@mail.gmail.com>
References: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Barry Song <baohua@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Lars-Peter Clausen <lars@metafoo.de>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Howard Chen <ibanezchen@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Kristina Martsenko <kristina.martsenko@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Stephen Boyd <sboyd@codeau>
List-Id: linux-mmc@vger.kernel.org

On 20 October 2015 at 11:13, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> Change in v2:
> Drop the 400mhz and use assigned-clock-parents to instead
> Split the original tune patch to several independent patches
> Re-write the mmc_send_tuning()
> Fix GPD checksum error
> Move the HS400 setting to ops->prepare_hs400_tuning()
> Modify SD driving settings
>
> Change in v1:
> Add DT bindings for eMMC hardware reset
> Add pinctrl of data strobe pin for HS400 mode
> Modify eMMC driving settings
> Add 400mhz source clock for HS400 mode
> Add eMMC HS200/HS400 mode support
> Add SD SDR50/SDR104 mode support
> Add implement of tune function with CMD19/CMD21
>
> Chaotian Jing (9):
>   mmc: core: Add DT bindings for eMMC hardware reset support
>   mmc: dt-bindings: update Mediatek MMC bindings
>   mmc: mediatek: make cmd_ints_mask to const
>   mmc: mediatek: change the argument "ddr" to "timing"
>   mmc: mediatek: fix got GPD checksum error interrupt when data transfer
>   mmc: mediatek: add implement of ops->hw_reset()
>   mmc: mmc: extend the mmc_send_tuning()
>   mmc: mediatek: add HS400 support
>   arm64: dts: mediatek: add HS200/HS400/SDR50/SDR104 support
>
>  Documentation/devicetree/bindings/mmc/mmc.txt    |   1 +
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |  11 +-
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  27 ++-
>  drivers/mmc/core/host.c                          |   2 +
>  drivers/mmc/core/mmc_ops.c                       |   8 +-
>  drivers/mmc/host/dw_mmc-exynos.c                 |   4 +-
>  drivers/mmc/host/dw_mmc.c                        |   2 +-
>  drivers/mmc/host/dw_mmc.h                        |   2 +-
>  drivers/mmc/host/mtk-sd.c                        | 296 ++++++++++++++++++++---
>  drivers/mmc/host/sdhci-esdhc-imx.c               |   6 +-
>  drivers/mmc/host/sdhci-msm.c                     |   2 +-
>  drivers/mmc/host/sdhci-sirf.c                    |   2 +-
>  include/linux/mmc/core.h                         |   2 +-
>  13 files changed, 314 insertions(+), 51 deletions(-)
>
> --
> 1.8.1.1.dirty

I have reviewed the patches, I think they overall looks good! Some
comments though.

You need to split patch 9, the DT parts enabling hw reset shall go in
separately.

Regarding the hw-reset changes in patch1, patch6 and patch9, I believe
I requested you to separate the HW reset changes from $subject
patchset as they are unrelated, please do this.

Running checkpatch, it gave me warnings and errors for patch 8.
Patch7 didn't apply to my next branch.

Kind regards
Uffe
