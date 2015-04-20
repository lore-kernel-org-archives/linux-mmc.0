From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 1/5] mmc: dt-bindings: add Mediatek MMC bindings
Date: Mon, 20 Apr 2015 10:31:16 +0200
Message-ID: <20150420083116.GQ4946@pengutronix.de>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
 <1426562035-16709-2-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39741 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbbDTIbc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Apr 2015 04:31:32 -0400
Content-Disposition: inline
In-Reply-To: <1426562035-16709-2-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream@mediatek.com, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, bin.zhang@mediatek.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org

Hi Chaotian,

On Tue, Mar 17, 2015 at 11:13:51AM +0800, Chaotian Jing wrote:
> Document the device-tree binding of Mediatek MMC host
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 33 ++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> new file mode 100644
> index 0000000..ac43f77
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -0,0 +1,33 @@
> +* MTK MMC controller
> +
> +The MTK  MSDC can act as a MMC controller
> +to support MMC, SD, and SDIO types of memory cards.
> +
> +This file documents differences between the core properties in mmc.txt
> +and the properties used by the msdc driver.
> +
> +Required properties:
> +- compatible: Should be "mediatek,mt8173-mmc","mediatek,mt8135-mmc".
> +- interrupts: Should contain MSDC interrupt number
> +- clocks: MSDC source clock
> +- clock-names: "source"

When I remove the clk_ignore_unused from the command line SD/MMC stops
working on the MT8173. This is because msdc50_0_h_sel is disabled, when
I enable this clock SD/MMC works again. This clock should probably be
added here and handled appropriatly in the driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
