From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv2 4/5] mmc: shdci-bcm2835: add verify for 32-bit back-to-back
 workaround
Date: Tue, 04 Nov 2014 21:59:59 -0700
Message-ID: <5459AECF.8000402@wwwdotorg.org>
References: <Scott Branden <sbranden@broadcom.com> <1414651017-3545-1-git-send-email-sbranden@broadcom.com> <1414651017-3545-5-git-send-email-sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:43124 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbaKEFAB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Nov 2014 00:00:01 -0500
In-Reply-To: <1414651017-3545-5-git-send-email-sbranden@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Peter Griffin <peter.griffin@linaro.org>, Chris Ball <chris@printf.net>, Piotr Krol <pietrushnic@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, linux-rpi-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com

On 10/30/2014 12:36 AM, Scott Branden wrote:
> Add a verify option to driver to print out an error message if a
> potential back to back write could cause a clock domain issue.

> index f8c450a..11af27f 100644

> +#ifdef CONFIG_MMC_SDHCI_BCM2835_VERIFY_WORKAROUND
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct bcm2835_sdhci_host *bcm2835_host = pltfm_host->priv;
> +
> +	if (bcm2835_host->previous_reg == reg) {
> +		if ((reg != SDHCI_HOST_CONTROL)
> +			&& (reg != SDHCI_CLOCK_CONTROL)) {

The comment in patch 3 says the problem doesn't apply to the data
register. Why does this check for these two registers rather than data?

> +			dev_err(mmc_dev(host->mmc),
> +			"back-to-back write to 0x%x\n", reg);

The continuation line should be indented at least one more level here.
