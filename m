From: Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 4/5 RFC] mmc: sdhci-iproc: add bcm2835 support
Date: Tue, 19 Jan 2016 11:47:26 -0800
Message-ID: <569E92CE.8060204@broadcom.com>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
 <1453042744-16196-5-git-send-email-stefan.wahren@i2se.com>
 <569D5D69.9000003@broadcom.com>
 <237859241.191026.18ea8ff0-3c4b-4fe9-876a-992ca235d960.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:62155 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756737AbcASTrb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2016 14:47:31 -0500
In-Reply-To: <237859241.191026.18ea8ff0-3c4b-4fe9-876a-992ca235d960.open-xchange@email.1und1.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Ray Jui <rjui@broadcom.com>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Stephen Warren <swarren@wwwdotorg.org>, Jon Mason <jonmason@broadcom.com>
Cc: kernel@martin.sperl.org, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi Stefan,

On 16-01-19 11:25 AM, Stefan Wahren wrote:
> Hi Scott,
>
>> Scott Branden <sbranden@broadcom.com> hat am 18. Januar 2016 um 22:47
>> geschrieben:
>>
>>
>> Hi Stefan,
>>
>> The caps likely need to be looked at in greater detail. Some comments
>> inline.
>
> yes i'm hopeful that someone from Broadcom knows more about the capabilities.
> This patch only copies them from the other driver, because i don't want to
> introduce new issues.
This patch can go in as is and we can have another patch when more 
accurate capabilities are determined.  If/when I have time I can go and 
deduce what the capability settings should be on BCM2835.  I should be 
revisiting this IP for other reasons in the next month or so and will 
try to look into it.
>
> Unfortunately the BCM2835 datasheet refers only to a non-public Asaran document
> ( SD3.0_Host_AHB_eMMC4.4_Usersguide_ver5.9_jan11_10.pdf ).
Yes, if Arasan allowed such document to be published that would help...
>
> Best regards
> Stefan
>
> [1] -
> https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
>

Regards,
Scott
