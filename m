From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 4/5 RFC] mmc: sdhci-iproc: add bcm2835 support
Date: Tue, 19 Jan 2016 20:25:13 +0100 (CET)
Message-ID: <237859241.191026.18ea8ff0-3c4b-4fe9-876a-992ca235d960.open-xchange@email.1und1.de>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
 <1453042744-16196-5-git-send-email-stefan.wahren@i2se.com>
 <569D5D69.9000003@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:59076 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702AbcAST0A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2016 14:26:00 -0500
In-Reply-To: <569D5D69.9000003@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ray Jui <rjui@broadcom.com>, Lee Jones <lee@kernel.org>, Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>, Stephen Warren <swarren@wwwdotorg.org>, Jon Mason <jonmason@broadcom.com>
Cc: kernel@martin.sperl.org, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi Scott,

> Scott Branden <sbranden@broadcom.com> hat am 18. Januar 2016 um 22:47
> geschrieben:
>
>
> Hi Stefan,
>
> The caps likely need to be looked at in greater detail. Some comments
> inline.

yes i'm hopeful that someone from Broadcom knows more about the capabilities.
This patch only copies them from the other driver, because i don't want to
introduce new issues.

Unfortunately the BCM2835 datasheet refers only to a non-public Asaran document
( SD3.0_Host_AHB_eMMC4.4_Usersguide_ver5.9_jan11_10.pdf ).

Best regards
Stefan

[1] -
https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
