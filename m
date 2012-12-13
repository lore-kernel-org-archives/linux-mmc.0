From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: FW: [PATCH] mmc: mmci: Gate the clock in runtime suspend to
	save power
Date: Thu, 13 Dec 2012 10:11:17 +0000
Message-ID: <20121213101117.GF14363@n2100.arm.linux.org.uk>
References: <25B60CDC2F704E4E9D88FFD52780CB4C08B00BD3B1@SC-VEXCH1.marvell.com> <CADz5_gJ70KrHL5NoSPQbFdeHnQxWLh87zq6N+-V7J7Yq7t+aPQ@mail.gmail.com> <CAPDyKFrt4zWmhyO-UJAFPOH=90n4OwRPv3nczr4jPGBnc_jT5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59357 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802Ab2LMKLX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Dec 2012 05:11:23 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFrt4zWmhyO-UJAFPOH=90n4OwRPv3nczr4jPGBnc_jT5w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kevin Liu <keyuan.liu@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Thu, Dec 13, 2012 at 10:04:46AM +0100, Ulf Hansson wrote:
> Anyway, this need to be thought of as future step, since this patch is
> not changing anything to that sequence as Kevin also is pointing out.

Given that Kevin is talking about stuff in sdhci as if it affects MMCI,
and that neither of you have picked that up, you're *still* not gaining
any confidence from me that you're actually thinking about the changes
you're making.  So I'm not really caring about how many acks your patches
get, I'm still going to be reluctant to apply them without thinking about
them for a bit.
