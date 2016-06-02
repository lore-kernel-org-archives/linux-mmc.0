From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 32/32] mmc: bcm2835: Import bcm2835-mmc and switch to it
Date: Thu, 2 Jun 2016 18:52:45 +0200
Message-ID: <e16936ee-3b0d-3798-72e0-8969c2c1a309@i2se.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-33-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:49471 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161314AbcFBQxd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Jun 2016 12:53:33 -0400
In-Reply-To: <1464817421-8519-33-git-send-email-kraxel@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-rpi-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, "open list:MULTIMEDIA CARD MMC, SECURE DIGITAL SD AND..." <linux-mmc@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>

Hi Gerd,

Am 01.06.2016 um 23:43 schrieb Gerd Hoffmann:
> From: Eric Anholt <eric@anholt.net>
>
> With this we can get wifi (brcmfmac) to probe.  Without it we're stuck
> with timeouts from sdio.c when it tries to set the bus width to 4.

adding a new MMC driver to fix a wifi issue is really weird.

Beside that there are already two MMC drivers (sdhci-bcm2835.c and
sdhci-iproc.c) in the Kernel which are compatible to BCM2835. Why should
we add two new ones?

Stefan
