From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Fri, 14 Dec 2012 17:11:11 +0000
Message-ID: <20121214171110.GL14363@n2100.arm.linux.org.uk>
References: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60040 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538Ab2LNRLY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 12:11:24 -0500
Content-Disposition: inline
In-Reply-To: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

On Fri, Dec 14, 2012 at 03:38:46PM +0000, Pawel Moll wrote:
> The Versatile Express IOFPGA as shipped on VECD 5.0 (bitfiles v108/208
> and v116/216) contains a modified version of the PL180 MMCI, with
> PeriphID Configuration value changed to 0x2.
> 
> This version adds an optional "hardware flow control" feature. When
> enabled MMC card clock will be automatically disabled when FIFO is
> about to over/underflow and re-enabled once the host retrieved some
> data. This makes the controller immune to over/underrun errors caused
> by big interrupt handling latencies.

Wrong.  It doesn't make it "immune", it just makes it less likely to
occur - you just need a heavier workload to provoke it.

"This makes the controller more immune to over/underrun errors caused
by longer interrupt handling latencies" would be a more accurate
statement.
