From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: add dependence in Kconfig for pxav2/pxav3
Date: Mon, 20 Jun 2011 15:25:54 +0200
Message-ID: <201106201525.54913.arnd@arndb.de>
References: <1308552287-18752-1-git-send-email-zhangfei.gao@marvell.com> <201106201349.38459.arnd@arndb.de> <BANLkTimMB9T1-s9pEc-zzhQB7m-ZOT1DFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:62663 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100Ab1FTN0K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 09:26:10 -0400
In-Reply-To: <BANLkTimMB9T1-s9pEc-zzhQB7m-ZOT1DFg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Monday 20 June 2011, zhangfei gao wrote:
> Select CLKDEV_LOOKUP is compile driver/clk/clkdev.c, which only
> provide clk_get, clk_put.
> Is it unsafe to assume all clk_get_rate/clk_enable/clk_disable are
> provided by the arch, which CLKDEV_LOOKUP?
> Any possibility CLKDEV_LOOKUP is selected but clk_get_rate is not realized.

I would consider that a bug, so you can ignore that case.

	Arnd
