From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 32/32] mmc: bcm2835: Import bcm2835-mmc and switch to it
Date: Thu, 02 Jun 2016 22:03:04 +0200
Message-ID: <1464897784.24775.126.camel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
	 <1464817421-8519-33-git-send-email-kraxel@redhat.com>
	 <e16936ee-3b0d-3798-72e0-8969c2c1a309@i2se.com>
	 <87oa7j314j.fsf@eliezer.anholt.net>
	 <2100811505.238666.65d5fa25-985a-4a30-86e2-3a7bebb5caaf.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38024 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964772AbcFBUDJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Jun 2016 16:03:09 -0400
In-Reply-To: <2100811505.238666.65d5fa25-985a-4a30-86e2-3a7bebb5caaf.open-xchange@email.1und1.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>, Russell King <linux@armlinux.org.uk>, Lee Jones <lee@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, open list <linux-kernel@vger.kernel.org>, "open list:MULTIMEDIA CARD MMC, SECURE DIGITAL SD AND..." <linux-mmc@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, linux-rpi-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>

  Hi,

> > Despite the fact that this is my commit, I don't think it should be
> > merged.  We should figure out why sdhci-iproc.c isn't working, instead.
> 
> so it doesn't work with sdhci-bcm2835 on RPi 3, too?

With sdhci-bcm2835 rpi3 wifi doesn't work for me.
I didn't try sdhci-iproc yet.

cheers,
  Gerd

