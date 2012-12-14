From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Fri, 14 Dec 2012 17:35:45 +0000
Message-ID: <1355506545.31602.5.camel@hornet>
References: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
	 <20121214171110.GL14363@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:51254 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756840Ab2LNRft convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 12:35:49 -0500
In-Reply-To: <20121214171110.GL14363@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

On Fri, 2012-12-14 at 17:11 +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 14, 2012 at 03:38:46PM +0000, Pawel Moll wrote:
> > The Versatile Express IOFPGA as shipped on VECD 5.0 (bitfiles v108/=
208
> > and v116/216) contains a modified version of the PL180 MMCI, with
> > PeriphID Configuration value changed to 0x2.
> >=20
> > This version adds an optional "hardware flow control" feature. When
> > enabled MMC card clock will be automatically disabled when FIFO is
> > about to over/underflow and re-enabled once the host retrieved some
> > data. This makes the controller immune to over/underrun errors caus=
ed
> > by big interrupt handling latencies.
>=20
> Wrong.  It doesn't make it "immune", it just makes it less likely to
> occur - you just need a heavier workload to provoke it.

Why do you think so? The MMC clock is cut off when the FIFO gets full,
so there will be no more data received - no overflow is possible.

Pawe=C5=82


