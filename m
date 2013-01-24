From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Thu, 24 Jan 2013 07:57:15 -0500
Message-ID: <87wqv2hh78.fsf@laptop.org>
References: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45736 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863Ab3AXM5j (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Jan 2013 07:57:39 -0500
In-Reply-To: <1355499526-13790-1-git-send-email-pawel.moll@arm.com> (Pawel
	Moll's message of "Fri, 14 Dec 2012 15:38:46 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: linux-mmc@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Pawel,

On Fri, Dec 14 2012, Pawel Moll wrote:
> The Versatile Express IOFPGA as shipped on VECD 5.0 (bitfiles v108/208
> and v116/216) contains a modified version of the PL180 MMCI, with
> PeriphID Configuration value changed to 0x2.
>
> This version adds an optional "hardware flow control" feature. When
> enabled MMC card clock will be automatically disabled when FIFO is
> about to over/underflow and re-enabled once the host retrieved some
> data. This makes the controller immune to over/underrun errors caused
> by big interrupt handling latencies.
>
> This patch adds relevant device variant in the driver.
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  drivers/mmc/host/mmci.c |   13 +++++++++++++
>  drivers/mmc/host/mmci.h |    2 ++
>  2 files changed, 15 insertions(+)

Thanks for the reminder -- Russell's been reviewing and merging MMCI
patches lately, please can you add it to his patch tracker?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
