From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] powerpc/esdhc: enable the card insert/remove interrupt
Date: Tue, 23 Oct 2012 01:26:48 -0700
Message-ID: <20121023082648.GA21690@lizard>
References: <1350975677-8195-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48722 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab2JWI3r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Oct 2012 04:29:47 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2585453pad.19
        for <linux-mmc@vger.kernel.org>; Tue, 23 Oct 2012 01:29:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1350975677-8195-1-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>, Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org

On Tue, Oct 23, 2012 at 03:01:17PM +0800, r66093@freescale.com wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> The current eSDHC driver use the poll mode to detect
> if the SD/MMC card is inserted or removed, which will generate
> many interrupts and impact the performance. 
> Therefore, change the default card detect to interrupt mode,
> if the board can't support this mode, we still use the poll mode.
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Anton Vorontsov <cbouatmailru@gmail.com>
> CC: Chris Ball <cjb@laptop.org>
> ---

IIRC, the card detection is broken SOC-revision-wise, not board-wise. So
the change seems wrong.

Also, take a look at this:

	http://lkml.org/lkml/2010/7/14/127

I started the work but never finished, unfortunately it caused some
regressions for non-FSL hardware...

>  drivers/mmc/host/sdhci-of-esdhc.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index ffc1226..5dc362f 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -196,6 +196,11 @@ static void esdhc_of_detect_limitation(struct platform_device *pdev,
>  	if (vvn == VENDOR_V_22)
>  		pdata->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>  
> +	/* P4080DS and MPC837XMDS board don't support interrupt mode */
> +	if (of_machine_is_compatible("fsl,mpc837xmds") ||
> +	    of_machine_is_compatible("fsl,P4080DS"))
> +		pdata->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +
>  	iounmap(ioaddr);
>  end:
>  	return;
> @@ -223,7 +228,7 @@ static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
>  	 * card detection could be handled via GPIO
>  	 * eSDHC cannot support End Attribute in NOP ADMA descriptor
>  	 */
> -	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
> +	.quirks = ESDHC_DEFAULT_QUIRKS
>  		| SDHCI_QUIRK_NO_CARD_NO_RESET
>  		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>  	.ops = &sdhci_esdhc_ops,
> -- 
> 1.7.9.5
