From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sdhci-pxa move platform data to include/linux/platform_data
Date: Mon, 20 Jun 2011 18:29:09 +0200
Message-ID: <201106201829.09485.arnd@arndb.de>
References: <1308579112-5027-1-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60516 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235Ab1FTQ3T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 12:29:19 -0400
In-Reply-To: <1308579112-5027-1-git-send-email-zhangfei.gao@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Monday 20 June 2011, Zhangfei Gao wrote:
> 
>         As suggested by Arnd, move platform data to include/linux/platform_data,
>         Add 'depends on CLKDEV_LOOKUP' since clk API is used,
>         As a result driver could be built on all platforms which support CLKDEV_LOOKUP
>         This can improve the build test coverage
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> CC: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

BTW, For some reason, your changelog text above is still indented funny. This should
not happen if you use git-format-patch rather than git-show.

	Arnd
