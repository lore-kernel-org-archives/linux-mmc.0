From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: add dependence in Kconfig for pxav2/pxav3
Date: Mon, 20 Jun 2011 13:49:38 +0200
Message-ID: <201106201349.38459.arnd@arndb.de>
References: <1308552287-18752-1-git-send-email-zhangfei.gao@marvell.com> <BANLkTinGM3YUxYHgFBs9KMOrjWe1m8Esww@mail.gmail.com> <BANLkTi=_qEQT5f_FcAEYz2Y5p6FGJU+P5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56112 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab1FTLtw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 07:49:52 -0400
In-Reply-To: <BANLkTi=_qEQT5f_FcAEYz2Y5p6FGJU+P5Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Monday 20 June 2011, zhangfei gao wrote:
> Currently, clk_enable, clk_disable, clk_get_rate realization are
> located at arch.
> Driver/clk/clkdev.c only realize clk_get/put.
> 
> I am afraid it may difficult to build the driver on other arch, like
> x86,  so we may still need "depends on ARCH_MMP" for safety.

I would recommend turning this into "depends on CLKDEV_LOOKUP" instead.
Always be specific with your dependencies so you enable the option
on all platforms that are able to build it, but not on any of the
others.

	Arnd
