From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: FW: [PATCH] mmc: mmci: Gate the clock in runtime suspend to
	save power
Date: Thu, 13 Dec 2012 10:08:12 +0000
Message-ID: <20121213100812.GE14363@n2100.arm.linux.org.uk>
References: <25B60CDC2F704E4E9D88FFD52780CB4C08B00BD3B1@SC-VEXCH1.marvell.com> <CADz5_gJ70KrHL5NoSPQbFdeHnQxWLh87zq6N+-V7J7Yq7t+aPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59351 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab2LMKIV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Dec 2012 05:08:21 -0500
Content-Disposition: inline
In-Reply-To: <CADz5_gJ70KrHL5NoSPQbFdeHnQxWLh87zq6N+-V7J7Yq7t+aPQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linus.walleij@linaro.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Thu, Dec 13, 2012 at 09:51:38AM +0800, Kevin Liu wrote:
> > Russell's concern is valid if suspend() will not wait for runtime_suspend()
> > to complete the last cycle before suspending.
> 
> pm_runtime_get_noresume is called before suspend and there are
> sdhci_runtime_pm_get/sdhci_runtime_pm_put within sdhci suspend/resume
> function.

What has the sdhci host driver code got to do with the MMCI host driver?
