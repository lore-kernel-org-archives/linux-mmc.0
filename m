From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/2] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Sat, 1 Jan 2011 16:28:46 -0800
Message-ID: <AANLkTimdB+kXKX7sJK4sVZuvmX=Zj=kW5asJzyZXoURL@mail.gmail.com>
References: <1293096475-19634-1-git-send-email-olof@lixom.net>
	<1293096828-19985-1-git-send-email-olof@lixom.net>
	<20101223112346.GA5044@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63174 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab1ABA2r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 1 Jan 2011 19:28:47 -0500
In-Reply-To: <20101223112346.GA5044@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, Mike Rapoport <mike@compulab.co.il>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>

On Thu, Dec 23, 2010 at 3:23 AM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
>
>> Changes since v2:
>> =A0 =A0 =A0 * Whitespace fixes
>> =A0 =A0 =A0 * Changed order of test in get_ro
>
> What benefit has the reordering? (And just to make sure: You still
> return -1 meaning "read-only". I assume this is intentional)

Looking at drivers/mmc/core/sd.c:mmc_sd_setup_card(), returning <0
means no RO detection, and will print a warning to that effect. If no
other RO-related quirks are included (i.e. such as
SDHCI_QUIRK_INVERTED_WRITE_PROTECT), the value will be passed up
through sdhci_get_ro and thus handled appropriately.

So on second look the code as it is seems correct to me.

Still, I have a 8-bit fix to incorporate, so I'll repost a v4 anyway.


-Olof
