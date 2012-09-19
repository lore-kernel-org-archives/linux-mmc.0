From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/6] mmc: sdhci: fixes and enhancements
Date: Tue, 18 Sep 2012 22:53:47 -0400
Message-ID: <m31uhylo3o.fsf@pullcord.laptop.org>
References: <1348020762-12932-1-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50057 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310Ab2ISCxZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 18 Sep 2012 22:53:25 -0400
In-Reply-To: <1348020762-12932-1-git-send-email-keyuan.liu@gmail.com> (Kevin
	Liu's message of "Wed, 19 Sep 2012 10:12:36 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

Hi,

On Tue, Sep 18 2012, Kevin Liu wrote:
> This patchset does as follows:
> [PATCH 1/6] mmc: sdhci-pxav3: fix build error
> [PATCH 2/6] mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
> [PATCH 3/6] mmc: sdhci: set regulator min/max voltage according to spec
> [PATCH 4/6] mmc: sdhci: refine code for sd clock disable/enable in set ios
> [PATCH 5/6] mmc: sdhci: keep the saved clock var up to date
> [PATCH 6/6] mmc: sdhci: fix null return check of regulator_get

I'm worried that 2-5 might cause regressions for unexpected reasons, so
I'll plan on merging these for 3.8 instead of 3.7 (assuming that no-one
objects to them); hope that's okay.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
