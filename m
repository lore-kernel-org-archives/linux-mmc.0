From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: add dependence in Kconfig for pxav2/pxav3
Date: Mon, 20 Jun 2011 13:50:26 +0200
Message-ID: <201106201350.26359.arnd@arndb.de>
References: <1308552287-18752-1-git-send-email-zhangfei.gao@marvell.com> <201106201007.33908.arnd@arndb.de> <BANLkTikVCp7xSrfdQtmi22Drs4KLntiD8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59230 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab1FTLuk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 07:50:40 -0400
In-Reply-To: <BANLkTikVCp7xSrfdQtmi22Drs4KLntiD8A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Monday 20 June 2011, zhangfei gao wrote:
> It is really a good suggestion, is include/linux/platform_data/ is newly added?
> Will move the header file to platform_data/pxa_sdhci.h
> arch/arm/plat-pxa/include/plat/sdhci.h =>
> include/linux/platform_data/pxa_sdhci.h

Yes, it is fairly new. The move looks correct to me.

	Arnd
