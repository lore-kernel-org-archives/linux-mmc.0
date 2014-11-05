From: Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCHv2 4/5] mmc: shdci-bcm2835: add verify for 32-bit back-to-back
 workaround
Date: Tue, 4 Nov 2014 23:00:39 -0800
Message-ID: <5459CB17.3020303@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com> <1414651017-3545-1-git-send-email-sbranden@broadcom.com> <1414651017-3545-5-git-send-email-sbranden@broadcom.com> <5459AECF.8000402@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:64821 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaKEHAm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Nov 2014 02:00:42 -0500
In-Reply-To: <5459AECF.8000402@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Peter Griffin <peter.griffin@linaro.org>, Chris Ball <chris@printf.net>, Piotr Krol <pietrushnic@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, linux-rpi-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com

On 14-11-04 08:59 PM, Stephen Warren wrote:
> On 10/30/2014 12:36 AM, Scott Branden wrote:
>> Add a verify option to driver to print out an error message if a
>> potential back to back write could cause a clock domain issue.
>
>> index f8c450a..11af27f 100644
>
>> +#ifdef CONFIG_MMC_SDHCI_BCM2835_VERIFY_WORKAROUND
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct bcm2835_sdhci_host *bcm2835_host = pltfm_host->priv;
>> +
>> +	if (bcm2835_host->previous_reg == reg) {
>> +		if ((reg != SDHCI_HOST_CONTROL)
>> +			&& (reg != SDHCI_CLOCK_CONTROL)) {
>
> The comment in patch 3 says the problem doesn't apply to the data
> register. Why does this check for these two registers rather than data?
This Verify workaround patch still a work in progress.  I'm still 
getting more info from the silicon designers on the back-to-back 
register writes that are affect.  The spew of 0x20 or 0x28 or 0x2c 
register writes are all ok locations that don't need to be worked 
around.  This patch needs to be corrected with the proper register rules 
still.
>
>> +			dev_err(mmc_dev(host->mmc),
>> +			"back-to-back write to 0x%x\n", reg);
>
> The continuation line should be indented at least one more level here.
>


