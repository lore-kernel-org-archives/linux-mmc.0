From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] ARM: dts: imx50: imx50-esdhc use imx53-esdhc
Date: Sun, 9 Oct 2016 22:25:01 +0200
Message-ID: <5eae97cb-7a15-9bcf-f732-6141f99f0990@mleia.com>
References: <1476030890-18274-1-git-send-email-akurz@blala.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:59401 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751066AbcJIUcV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 9 Oct 2016 16:32:21 -0400
In-Reply-To: <1476030890-18274-1-git-send-email-akurz@blala.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Kurz <akurz@blala.de>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, linux-mmc@vger.kernel.org

Hi Alexander,

On 09.10.2016 18:34, Alexander Kurz wrote:
> According to the reference manuals, both imx50/imx53 SOC seem to share
> the same eSDHC controller, especially the section on "Multi-block Read"
> mentioned in commit 361b8482026c ("mmc: sdhci-esdhc-imx: fix multiblock
> reads on i.MX53") is identical for both SOC.
> Hence, let imx50 use imx53-esdhc.
> 
> Signed-off-by: Alexander Kurz <akurz@blala.de>
> ---
>  arch/arm/boot/dts/imx50.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
> index e245713..769eac7 100644
> --- a/arch/arm/boot/dts/imx50.dtsi
> +++ b/arch/arm/boot/dts/imx50.dtsi
> @@ -99,7 +99,7 @@
>  				ranges;
>  
>  				esdhc1: esdhc@50004000 {
> -					compatible = "fsl,imx50-esdhc";
> +					compatible = "fsl,imx50-esdhc", "fsl,imx53-esdhc";

Instead of this change please add "fsl,imx50-esdhc" compatible to a list found in
drivers/mmc/host/sdhci-esdhc-imx.c

Regarding DTS change if the controllers are the same I think it may
have sense to add "fsl,imx50-esdhc" compatible to imx53.dtsi definitions,
but not the other way round.

--
With best wishes,
Vladimir
