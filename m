From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2 1/1]mmc: check SDIO card wake up during suspending
Date: Thu, 18 Nov 2010 13:23:55 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1011181319480.6448@xanadu.home>
References: <AANLkTimgPjY0=+mQxf+qa73L_2KfhH+A3XHhb_z1xp58@mail.gmail.com>
 <AANLkTikP7o=H6MC9LYVm=TKMZtj2Y=o7DAq3NEHXx8o+@mail.gmail.com>
 <AANLkTimYfU1EMOPZ7R+vmf7cbPD2+BmdwQErPOx8FrD0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:8539 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab0KRSX6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Nov 2010 13:23:58 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LC300DM9F3AQFF0@vl-mh-mrz25.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Thu, 18 Nov 2010 13:23:35 -0500 (EST)
In-reply-to: <AANLkTimYfU1EMOPZ7R+vmf7cbPD2+BmdwQErPOx8FrD0@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <niej0001@gmail.com>
Cc: linux-mmc@vger.kernel.org, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Bing Zhao <bzhao@marvell.com>, zhangfei gao <zhangfei.gao@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

On Thu, 18 Nov 2010, Jun Nie wrote:

> >From 642b2e88fc4b6344290c88ce506fcda1bcc860a3 Mon Sep 17 00:00:00 2001
> From: Jun Nie <njun@marvell.com>
> Date: Fri, 12 Nov 2010 19:43:49 +0800
> Subject: [PATCH] mmc: check SDIO card wake up during suspending
> 
> It is possible that SDIO card send card interrupt to wake up
> system just after SDIO func driver and SDIO card firmware commit
> suspend state, while system is still in suspending process and
> mmc interrupt is not release yet.
> 
> Interrupt storm may happen if func driver does not notify firmware
> to clear the wake up source. If func driver issue SDIO bus transaction
> to have firmware clear the source and driver continue to handle the
> wake up event, system may enter suspend before all transaction done.
> In this case, SDIO card will not enter lower power mode never. But
> system can not be wake up for only card insert/remove/interrupt irq are
> listed in wake up source in SD spec. Data/command done irq can
> not wake up system.
> 
> This patch check SDIO card interrupt and stop system suspend if there
> are card interrupt after func driver suspend.
> 
> Signed-off-by: Jun Nie <njun@marvell.com>

There is a structural problem with your patch.  Why do you have to dig 
into card specific data from sdhci_suspend_host()?  The fact that you 
need to include mmc/card.h into sdhci.c is a sign of layering 
violation, and all host drivers would have to be similarly modified, 
leading to unmaintainable code.  While the race might be real, there has 
to be another way to fix it.


Nicolas
