From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] sdio: skip initialization on powered resume
Date: Sat, 22 Jan 2011 03:38:34 +0000
Message-ID: <20110122033834.GA7590@void.printf.net>
References: <477F20668A386D41ADCC57781B1F704307D2FE4A0F@SC-VEXCH1.marvell.com> <alpine.LFD.2.00.1009072119210.19366@xanadu.home> <477F20668A386D41ADCC57781B1F704307D2FE4A52@SC-VEXCH1.marvell.com> <1284459351.2359.17.camel@stummala-linux.in.qualcomm.com> <477F20668A386D41ADCC57781B1F704307D30738F5@SC-VEXCH1.marvell.com> <alpine.LFD.2.00.1009152222400.19366@xanadu.home> <AANLkTinjpe8iGcOyru=09WrBq4f5PfBo2QcUs40OycXg@mail.gmail.com> <477F20668A386D41ADCC57781B1F704307F4EA2865@SC-VEXCH1.marvell.com> <alpine.LFD.2.00.1101212148320.8580@xanadu.home> <477F20668A386D41ADCC57781B1F704307F4EA2885@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48863 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040Ab1AVDin (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Jan 2011 22:38:43 -0500
Content-Disposition: inline
In-Reply-To: <477F20668A386D41ADCC57781B1F704307F4EA2885@SC-VEXCH1.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bing Zhao <bzhao@marvell.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>, zhangfei gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirqus@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>

Hi Bing,

On Fri, Jan 21, 2011 at 07:27:06PM -0800, Bing Zhao wrote:
> I'll rebase and test the patch based on git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git tree. Should I use "master" or "mmc-next" branch?

mmc-next, please.  Thanks!

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
