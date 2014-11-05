From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv2 4/5] mmc: shdci-bcm2835: add verify for 32-bit back-to-back
 workaround
Date: Tue, 04 Nov 2014 21:44:49 -0700
Message-ID: <5459AB41.8080101@wwwdotorg.org>
References: <Scott Branden <sbranden@broadcom.com> <1414651017-3545-1-git-send-email-sbranden@broadcom.com> <1414651017-3545-5-git-send-email-sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:48686 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbaKEEov (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Nov 2014 23:44:51 -0500
In-Reply-To: <1414651017-3545-5-git-send-email-sbranden@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Peter Griffin <peter.griffin@linaro.org>, Chris Ball <chris@printf.net>, Piotr Krol <pietrushnic@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, linux-rpi-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com

On 10/30/2014 12:36 AM, Scott Branden wrote:
> Add a verify option to driver to print out an error message if a
> potential back to back write could cause a clock domain issue.

> diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c

>  static inline void bcm2835_sdhci_writel(struct sdhci_host *host,
>  						u32 val, int reg)
>  {
> +#ifdef CONFIG_MMC_SDHCI_BCM2835_VERIFY_WORKAROUND
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct bcm2835_sdhci_host *bcm2835_host = pltfm_host->priv;
> +
> +	if (bcm2835_host->previous_reg == reg) {
> +		if ((reg != SDHCI_HOST_CONTROL)
> +			&& (reg != SDHCI_CLOCK_CONTROL)) {
> +			dev_err(mmc_dev(host->mmc),
> +			"back-to-back write to 0x%x\n", reg);

This fires a *ton* on reg 0x20 and 0x30 on my rev 2 model B with the
patches applied on top of next-20141031. Without the patches applied,
everything works fine. As far as I can tell, SD card accesses no longer
work (or perhaps there's just so much log spew over serial that it takes
more than 1.5 minutes to get to the login prompt).
