From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 0/5 RFC] mmc: sdhci-iproc: add bcm2835 support
Date: Wed, 20 Jan 2016 22:18:06 +0100 (CET)
Message-ID: <374314185.237972.d69bddce-8c03-4cf7-b6d6-f0cbd113f569.open-xchange@email.1und1.de>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
 <87bn8hcmjr.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:63025 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbcATVS6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2016 16:18:58 -0500
In-Reply-To: <87bn8hcmjr.fsf@eliezer.anholt.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Stephen Warren <swarren@wwwdotorg.org>, Jon Mason <jonmason@broadcom.com>
Cc: kernel@martin.sperl.org, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org


> Eric Anholt <eric@anholt.net> hat am 19. Januar 2016 um 22:00 geschrieben:
>
>
> Stefan Wahren <stefan.wahren@i2se.com> writes:
>
> > This patch series based on the suggestion of Scott Branden to implement
> > bcm2835 support into sdhci-iproc [1].
> >
> > These changes provide the following advantages:
> > * no need to maintain a separate driver for bcm2835
> > * improve support and test coverage of bcm2835 mmc support
> > * get the rid of SDHCI_CAPABILITIES hack in bcm2835_sdhci_readl
> > * increase write performance by avoiding delays in write ops
> >
> > Patch 1 and 2 adopt two sdhci-bcm2835 fixes to sdhci-iproc. The third patch
> > tries to specify as much quirks as possible in the bcm283x.dtsi as possible.
> > Patch 4 and 5 are the actually changes for bcm2835 support.
> >
> > These series has been tested on Raspberry Pi B with dd (direct I/O):
> >
> > sdhci-bcm2835
> >
> > 378 kB/s WRITE
> > 10,6 MB/s READ
> >
> > sdhci-iproc (after applying patch series)
> >
> > 881 kB/s WRITE
> > 10,8 MB/s READ
>
> I started a while ago at looking at merging the sdhost driver (for the
> other controller on these boards that you can use instead), since
> apparently the hardware's a better choice to use. This looks like a
> really nice simplification for us for the Arasan mode, though. Would
> you also want to delete the old 2835 driver after this series?

Yes, that would be a necessary step. I don't know when it's the right time.

What is the usual procedure for such a necessary driver?

>
> These patches are all:
>
> Acked-by: Eric Anholt <eric@anholt.net>
