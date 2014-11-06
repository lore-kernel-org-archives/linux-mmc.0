From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv2 4/5] mmc: shdci-bcm2835: add verify for 32-bit back-to-back
 workaround
Date: Wed, 05 Nov 2014 22:01:45 -0700
Message-ID: <545B00B9.5090108@wwwdotorg.org>
References: <Scott Branden <sbranden@broadcom.com> <1414651017-3545-1-git-send-email-sbranden@broadcom.com> <1414651017-3545-5-git-send-email-sbranden@broadcom.com> <5459AECF.8000402@wwwdotorg.org> <5459CB17.3020303@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:51654 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaKFFBr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Nov 2014 00:01:47 -0500
In-Reply-To: <5459CB17.3020303@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Peter Griffin <peter.griffin@linaro.org>, Chris Ball <chris@printf.net>, Piotr Krol <pietrushnic@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, linux-rpi-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com

On 11/05/2014 12:00 AM, Scott Branden wrote:
> On 14-11-04 08:59 PM, Stephen Warren wrote:
>> On 10/30/2014 12:36 AM, Scott Branden wrote:
>>> Add a verify option to driver to print out an error message if a
>>> potential back to back write could cause a clock domain issue.
>>
>>> index f8c450a..11af27f 100644
>>
>>> +#ifdef CONFIG_MMC_SDHCI_BCM2835_VERIFY_WORKAROUND
>>> +    struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +    struct bcm2835_sdhci_host *bcm2835_host = pltfm_host->priv;
>>> +
>>> +    if (bcm2835_host->previous_reg == reg) {
>>> +        if ((reg != SDHCI_HOST_CONTROL)
>>> +            && (reg != SDHCI_CLOCK_CONTROL)) {
>>
>> The comment in patch 3 says the problem doesn't apply to the data
>> register. Why does this check for these two registers rather than data?
> This Verify workaround patch still a work in progress.  I'm still
> getting more info from the silicon designers on the back-to-back
> register writes that are affect.  The spew of 0x20 or 0x28 or 0x2c
> register writes are all ok locations that don't need to be worked
> around.  This patch needs to be corrected with the proper register rules
> still.

FYI, I applied the series except for this patch, and everything
/appeared/ to work OK for a brief test (boot, log in, reboot). Still,
I'll hold off my Tested-by/acked-by until the comment in patch 3 and the
register list above match, and there's no log spew with everything applied.
