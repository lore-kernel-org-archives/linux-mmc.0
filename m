From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Thu, 24 Jan 2013 13:03:23 +0000
Message-ID: <1359032603.26878.55.camel@hornet>
References: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
	 <87wqv2hh78.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:58130 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab3AXNDZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jan 2013 08:03:25 -0500
In-Reply-To: <87wqv2hh78.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

On Thu, 2013-01-24 at 12:57 +0000, Chris Ball wrote:
> Hi Pawel,
> 
> On Fri, Dec 14 2012, Pawel Moll wrote:
> > The Versatile Express IOFPGA as shipped on VECD 5.0 (bitfiles v108/208
> > and v116/216) contains a modified version of the PL180 MMCI, with
> > PeriphID Configuration value changed to 0x2.
> >
> > This version adds an optional "hardware flow control" feature. When
> > enabled MMC card clock will be automatically disabled when FIFO is
> > about to over/underflow and re-enabled once the host retrieved some
> > data. This makes the controller immune to over/underrun errors caused
> > by big interrupt handling latencies.
> >
> > This patch adds relevant device variant in the driver.
> >
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > ---
> >  drivers/mmc/host/mmci.c |   13 +++++++++++++
> >  drivers/mmc/host/mmci.h |    2 ++
> >  2 files changed, 15 insertions(+)
> 
> Thanks for the reminder -- Russell's been reviewing and merging MMCI
> patches lately, please can you add it to his patch tracker?

Sure, thanks!

Pawel


