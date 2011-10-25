From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Tue, 25 Oct 2011 10:53:44 +0200
Message-ID: <CACRpkdabG-0nQ4cOU4gzemsSd9Xx0qi4We6-=MhtBikNgXL0mg@mail.gmail.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>
	<20111021173637.GG21648@n2100.arm.linux.org.uk>
	<CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com>
	<CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
	<20111024093632.GH9893@n2100.arm.linux.org.uk>
	<CACRpkdY6rzYsYQW+GACL6Ux8o=Eo-3wn62O0YZxJZ=F2WbE4DQ@mail.gmail.com>
	<20111024095638.GJ9893@n2100.arm.linux.org.uk>
	<4EA66DAD.3000609@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49783 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab1JYIxo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2011 04:53:44 -0400
Received: by iaby12 with SMTP id y12so320151iab.19
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2011 01:53:44 -0700 (PDT)
In-Reply-To: <4EA66DAD.3000609@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sebastian Rasmussen <sebras@gmail.com>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>

On Tue, Oct 25, 2011 at 10:05 AM, Adrian Hunter <adrian.hunter@intel.co=
m> wrote:

> The spec does say that it is OK to turn off the clock, but it
> must be turned back on to release the busy signal. =A0That will alway=
s
> happen with the block driver because it always sends a status command
> when waiting.

Aha, thanks for clearing this up!

> Maybe it is an issue with SDIO but currently SDIO is using
> MMC_QUIRK_BROKEN_CLK_GATING by default (although wl1271 is
> using it)

IIRC SDIO is supposed to allow their clock to be cut, if it is a
peripheral that needs constant clocking it should have its own
clockline/crystal or whatever, basically.

However most SDIO device engineers just see the MCLK
and like "hey, clock, I'll just lock my PLL onto that sweet
clock line and save the crystal..." violating the spec. In worst
cases they even drive the entire logic inside the device from
the MCLK line and count on it being perpetually enabled.
Atleast that's how I think about it.

Yours,
Linus Walleij
