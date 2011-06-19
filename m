From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 0/5] Provide sdhci driver for mmp2 and pxa9xx
Date: Sat, 18 Jun 2011 23:16:43 -0400
Message-ID: <m262o21pes.fsf@bob.laptop.org>
References: <1307526121-12059-1-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57077 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524Ab1FSDQy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Jun 2011 23:16:54 -0400
In-Reply-To: <1307526121-12059-1-git-send-email-zhangfei.gao@marvell.com>
	(Zhangfei Gao's message of "Wed, 8 Jun 2011 17:41:56 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@marvell.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org

Hi,

On Wed, Jun 08 2011, Zhangfei Gao wrote:
> v3->v4
> Update patch sequence and mmp2_defconfig
> update driver/mmc/host/Kconfig
> Remove get_ro
>
> The patches to provide separate sdhci driver for mmp2 and pxa910
> based on sdhci-platfm.
> Rename to sdhci-pxav3.c and sdhci-pxav2.c
> Remove obsolete sdhci-pxa.c, which is used to share among pxa serious, since
> under this method, platform difference have to be put under arch/arm,
> which is not easy to track.
> As a result, mmp2 mmc resource should be updated accordingly.

Merged to mmc-next for 3.1.  Thanks, everyone!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
