From: Adam Lee <adam.lee@canonical.com>
Subject: Re: [PATCH] mmc: sdhci-pci: set the clear transfer mode register
 quirk for O2Micro
Date: Wed, 5 Aug 2015 13:46:54 +0800
Message-ID: <20150805054654.GA13200@adam-laptop>
References: <1438583608-17777-1-git-send-email-adam.lee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36557 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbHEFrE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2015 01:47:04 -0400
Received: by pacgq8 with SMTP id gq8so26667820pac.3
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2015 22:47:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438583608-17777-1-git-send-email-adam.lee@canonical.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Peter Guo <peter.guo@bayhubtech.com>

On Mon, Aug 03, 2015 at 02:33:28PM +0800, Adam Lee wrote:
> This patch fixes MMC not working issue on O2Micro/BayHub Host, which
> requires transfer mode register to be cleared when sending no DMA
> command.
> 
> Signed-off-by: Peter Guo <peter.guo@bayhubtech.com>
> Signed-off-by: Adam Lee <adam.lee@canonical.com>
> ---
>  drivers/mmc/host/sdhci-pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 94f54d2..b3b0a3e 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -618,6 +618,7 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
>  static const struct sdhci_pci_fixes sdhci_o2 = {
>  	.probe = sdhci_pci_o2_probe,
>  	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +	.quirks2 = SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD,
>  	.probe_slot = sdhci_pci_o2_probe_slot,
>  	.resume = sdhci_pci_o2_resume,
>  };
> -- 
> 2.5.0
> 

Hi, Ulf

Please add a cc stable sign off when you apply it, I forgot it, thanks.

"Cc: stable <stable@vger.kernel.org>"

-- 
Adam Lee
