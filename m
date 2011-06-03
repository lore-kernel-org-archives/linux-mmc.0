From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 3/4] ARM: mmp2: update mmp2 mmc resource
Date: Fri, 3 Jun 2011 18:16:06 +0200
Message-ID: <201106031816.06914.arnd@arndb.de>
References: <1307094632-8949-1-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60767 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857Ab1FCQQZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2011 12:16:25 -0400
In-Reply-To: <1307094632-8949-1-git-send-email-zhangfei.gao@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@marvell.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Friday 03 June 2011, Zhangfei Gao wrote:
> 
>         mmp2 mmc driver name update to sdhci-pxav3 according with sdhci-pxav3.c
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  arch/arm/mach-mmp/brownstone.c |   11 ++++++++++-
>  arch/arm/mach-mmp/mmp2.c       |   16 ++++++++--------
>  2 files changed, 18 insertions(+), 9 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>
