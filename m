From: Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCHv2 5/5] mmc: sdhci-bcm2835: add sdhci quirk SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12
Date: Fri, 7 Nov 2014 10:30:45 -0800
Message-ID: <545D0FD5.1080605@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com> <1414651017-3545-1-git-send-email-sbranden@broadcom.com> <1414651017-3545-6-git-send-email-sbranden@broadcom.com> <5459AEEA.8050503@wwwdotorg.org> <5459CB76.3060601@broadcom.com> <545AFE2C.5050105@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:47147 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbaKGSbA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Nov 2014 13:31:00 -0500
In-Reply-To: <545AFE2C.5050105@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Peter Griffin <peter.griffin@linaro.org>, Chris Ball <chris@printf.net>, Piotr Krol <pietrushnic@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, linux-rpi-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com

On 14-11-05 08:50 PM, Stephen Warren wrote:
> On 11/05/2014 12:02 AM, Scott Branden wrote:
>> On 14-11-04 09:00 PM, Stephen Warren wrote:
>>> On 10/30/2014 12:36 AM, Scott Branden wrote:
>>>> SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 is missing and needed for this
>>>> controller.
>>>
>>> This seems fine, although any explanation of why this quirk is needed
>>> would be useful.
>>>
>> I don't know who to talk to at Arasan about this.  Will try hunting
>> around a little for more info as to why this is needed to have eMMC and
>> SD work properly through our internal testing on other non-2835 chipset
>> that shares the same SDHCI controller as 2835.
>
> I thought I heard that this wasn't a bug in the controller itself, but
> rather an integration issue between the IP core and the register bus
> it's attached to. Consequently, it may be SoC-specific or at least have
> SoC-specific variations?
Yes, this patch is to fix a different bug (in the IP) rather than the 
clock domain integration issue.
>

