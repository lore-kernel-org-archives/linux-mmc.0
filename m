From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: support sdhci-mmp2
Date: Mon, 23 May 2011 17:01:38 +0200
Message-ID: <201105231701.38198.arnd@arndb.de>
References: <1306156882-12124-1-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:60945 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab1EWPBx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2011 11:01:53 -0400
In-Reply-To: <1306156882-12124-1-git-send-email-zhangfei.gao@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@marvell.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <mark.brown314@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

On Monday 23 May 2011, Zhangfei Gao wrote:
>         Delete sdhci-pxa.c and replace with sdhci-mmp2.c specificlly for mmp2
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  arch/arm/plat-pxa/include/plat/sdhci.h |   43 ++++-
>  drivers/mmc/host/Kconfig               |    9 +-
>  drivers/mmc/host/Makefile              |    2 +-
>  drivers/mmc/host/sdhci-mmp2.c          |  304 ++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pxa.c           |  303 -------------------------------
>  5 files changed, 349 insertions(+), 312 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-mmp2.c
>  delete mode 100644 drivers/mmc/host/sdhci-pxa.c

Hi Zhangfei,

You should really try to improve your changelog texts. Instead of
the one-line summary that describes what you do 'Delete sdhci-pxa.c and
replace ...', please provide a paragraph explaining why you do it,
and what the bigger plan is here.

Also, when renaming a file, please use 'git diff -M' or 'git format-patch -M'
to detect renames and generate a diff for the changes you did to the file.

	Arnd
