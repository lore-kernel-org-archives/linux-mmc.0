From: Stefan Wahren <info@lategoodbye.de>
Subject: Re: [PATCHv2 4/5] mmc: shdci-bcm2835: add verify for 32-bit
 back-to-back workaround
Date: Tue, 22 Dec 2015 21:13:01 +0100
Message-ID: <5679AECD.4090506@lategoodbye.de>
References: <Scott Branden <sbranden@broadcom.com>
 <1414651017-3545-1-git-send-email-sbranden@broadcom.com>
 <1414651017-3545-5-git-send-email-sbranden@broadcom.com>
 <5459AECF.8000402@wwwdotorg.org> <5459CB17.3020303@broadcom.com>
 <545B00B9.5090108@wwwdotorg.org> <545D1006.5040705@broadcom.com>
 <5679726A.1070300@lategoodbye.de> <5679A339.9000302@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.augenpunkt.de ([213.239.207.9]:44300 "EHLO
	www.augenpunkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451AbbLVUN3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Dec 2015 15:13:29 -0500
In-Reply-To: <5679A339.9000302@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Peter Griffin <peter.griffin@linaro.org>, Chris Ball <chris@printf.net>, Piotr Krol <pietrushnic@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Joe Perches <joe@perches.com>

Hi Scott,

Am 22.12.2015 um 20:23 schrieb Scott Branden:
> Hi Stefan,
>
> On 15-12-22 07:55 AM, Stefan Wahren wrote:
>> Hi Scott,
>>
>> Am 07.11.2014 um 19:31 schrieb Scott Branden:
>>> On 14-11-05 09:01 PM, Stephen Warren wrote:
>>>> On 11/05/2014 12:00 AM, Scott Branden wrote:
>>>>> On 14-11-04 08:59 PM, Stephen Warren wrote:
>>>>>> On 10/30/2014 12:36 AM, Scott Branden wrote:
>>>>>>> Add a verify option to driver to print out an error message if a
>>>>>>> potential back to back write could cause a clock domain issue.
>>>>>>
>>>>>>> index f8c450a..11af27f 100644
>>>>>>
>>>>>>> +#ifdef CONFIG_MMC_SDHCI_BCM2835_VERIFY_WORKAROUND
>>>>>>> +    struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>>> +    struct bcm2835_sdhci_host *bcm2835_host = pltfm_host->priv;
>>>>>>> +
>>>>>>> +    if (bcm2835_host->previous_reg == reg) {
>>>>>>> +        if ((reg != SDHCI_HOST_CONTROL)
>>>>>>> +            && (reg != SDHCI_CLOCK_CONTROL)) {
>>>>>>
>>>>>> The comment in patch 3 says the problem doesn't apply to the data
>>>>>> register. Why does this check for these two registers rather than
>>>>>> data?
>>>>> This Verify workaround patch still a work in progress.  I'm still
>>>>> getting more info from the silicon designers on the back-to-back
>>>>> register writes that are affect.  The spew of 0x20 or 0x28 or 0x2c
>>>>> register writes are all ok locations that don't need to be worked
>>>>> around.  This patch needs to be corrected with the proper register
>>>>> rules
>>>>> still.
>>> Thanks for testing.  Yes, I have work to do on the verify patch above
>>> still.
>>
>> do you still have plans to submit a V3 of this patch series?
> No, I do not have plans to submit a V3 of this patch series.
>
> I submitted this patch as RPI has a similar controller to the SoCs I am
> familiar with as well as needing similar work arounds   You can take
> over the patchset.  Or, try and get the sdhci-iproc.c driver going on
> RPI.  The sdhci-iproc is the production driver we use on a variety of
> SoCs and support and test this driver.

after applying the patch series both drivers are very similiar so i 
prefer the latter. I will give it a try. Thanks for the hint about 
sdhci-iproc.

Regards
Stefan


