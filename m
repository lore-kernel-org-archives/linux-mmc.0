From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2] mmc: mxcmmc: fix bug that may block a data transfer
 forever.
Date: Thu, 21 Feb 2013 13:57:55 +0100
Message-ID: <20130221135755.44440261@crub>
References: <1347014617-16238-1-git-send-email-javier.martin@vista-silicon.com>
	<20130219151414.2aa318d7@crub>
	<CACKLOr0vTr=8F7Ly_bQCL5FLWhn8hqmsLaUeGfDUMM7OaEqWOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:57127 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab3BUM57 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Feb 2013 07:57:59 -0500
In-Reply-To: <CACKLOr0vTr=8F7Ly_bQCL5FLWhn8hqmsLaUeGfDUMM7OaEqWOg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: linux-mmc@vger.kernel.org, viresh.linux@gmail.com, g.liakhovetski@gmx.de, vinod.koul@linux.intel.com, s.hauer@pengutronix.de, cjb@laptop.org, fabio.estevam@freescale.com, gcembed@gmail.com

Hi,

On Thu, 21 Feb 2013 13:32:08 +0100
javier Martin <javier.martin@vista-silicon.com> wrote:
...
> It was tested executing a loop with bonnie++ for a week.
> I didn't notice the race condition. Have you had real issues or just
> found  it by analysing the code?

I've had real issues, but my setup is different. I'm using this mxcmmc
driver with extensions on mpc5121e (with different DMA controller/driver).
It is quite difficult to reproduce the issue on my test system. I've also
an i.mx31 based pcm037 board but the SD-Card slot is broken on it, so I
can not test the driver on i.mx31.

Thanks,

Anatolij
