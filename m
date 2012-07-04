From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci-pci: CaFe has broken card detection
Date: Tue, 03 Jul 2012 20:32:44 -0400
Message-ID: <878vf074cz.fsf@octavius.laptop.org>
References: <20120703221340.221729D401E@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50801 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081Ab2GDAcr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Jul 2012 20:32:47 -0400
In-Reply-To: <20120703221340.221729D401E@zog.reactivated.net> (Daniel Drake's
	message of "Tue, 3 Jul 2012 23:13:39 +0100 (BST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Dan,

On Tue, Jul 03 2012, Daniel Drake wrote:
> At http://dev.laptop.org/ticket/11980 we have determined that the
> Marvell CaFe SDHCI controller reports bad card presence during
> resume. It reports that no card is present even when it is.
>
> Around 400ms after resuming, a "card inserted" interrupt is generated,
> at which point it starts reporting presence.
>
> Work around this hardware oddity by setting the
> SDHCI_QUIRK_BROKEN_CARD_DETECTION flag. Thanks to Chris Ball for helping
> with diagnosis.
>
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  drivers/mmc/host/sdhci-pci.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 69ef0be..504da71 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -157,6 +157,7 @@ static const struct sdhci_pci_fixes sdhci_ene_714 = {
>  static const struct sdhci_pci_fixes sdhci_cafe = {
>  	.quirks		= SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER |
>  			  SDHCI_QUIRK_NO_BUSY_IRQ |
> +			  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
>  			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>  };

Thanks, pushed to mmc-next for 3.6 with a stable@ tag to fix the regression.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
