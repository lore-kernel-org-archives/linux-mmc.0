From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6 11/14] mmc: sdhci: fix the bug that DDR50 can't work for emmc
Date: Fri, 07 Dec 2012 14:10:55 -0500
Message-ID: <87r4n1bruo.fsf@octavius.laptop.org>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
	<1350471893-29633-12-git-send-email-keyuan.liu@gmail.com>
	<87zk2f7t8h.fsf@octavius.laptop.org>
	<CADz5_gJq9vA1mhabMtupBaBqfNcwGV6TnkaOZwoLocwNgmLPFw@mail.gmail.com>
	<CADz5_g+ncZdBLQwSh2Vkia+OD7VtXuLtKFsp-z2bM8JJu10Sog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40410 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756699Ab2LGTLG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Dec 2012 14:11:06 -0500
In-Reply-To: <CADz5_g+ncZdBLQwSh2Vkia+OD7VtXuLtKFsp-z2bM8JJu10Sog@mail.gmail.com>
	(Kevin Liu's message of "Mon, 19 Nov 2012 16:57:11 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, Haojian Zhuang <haojian.zhuang@gmail.com>, cxie4@marvell.com, Philip Rakity <prakity@nvidia.com>, kliu5@marvell.com

Hi,

On Mon, Nov 19 2012, Kevin Liu wrote:
> In fact, I don't think 3.3v vccq for emmc can work under DDR50 mode
> with SD host.

I've checked on the scope that we're reaching DDR50 with our 3.3V vccq
eMMC, so it looks like this isn't true.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
