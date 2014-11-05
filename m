From: Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCHv2 2/5] mmc: sdhci-bcm2835: make shift calculations consistent
Date: Tue, 4 Nov 2014 21:19:37 -0800
Message-ID: <5459B369.8030902@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com> <1414651017-3545-1-git-send-email-sbranden@broadcom.com> <1414651017-3545-3-git-send-email-sbranden@broadcom.com> <5459AC0C.8080703@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:37771 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbaKEFTm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Nov 2014 00:19:42 -0500
In-Reply-To: <5459AC0C.8080703@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Peter Griffin <peter.griffin@linaro.org>, Chris Ball <chris@printf.net>, Piotr Krol <pietrushnic@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, linux-rpi-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com

On 14-11-04 08:48 PM, Stephen Warren wrote:
> On 10/30/2014 12:36 AM, Scott Branden wrote:
>> Make the shift calculations consistent rather than having different
>> implementations to calculate the same thing.
>
>> diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
>
>> +#define REG_OFFSET_IN_BITS(reg) ((reg) << 3 & 0x18)
>
> This should really be the following so people don't have to memorize
> operator precedence:
>
> #define REG_OFFSET_IN_BITS(reg) (((reg) << 3) & 0x18)
>
> (I've been bit by people mis-remembering precedence in very similar code...)
>
Good idea.
