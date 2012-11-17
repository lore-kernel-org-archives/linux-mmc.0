From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6 09/14] mmc: sdhci-pxav3: add quirks2
Date: Sat, 17 Nov 2012 17:09:09 -0500
Message-ID: <874nkn9916.fsf@octavius.laptop.org>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
	<1350471893-29633-10-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33690 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366Ab2KQWJP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 17 Nov 2012 17:09:15 -0500
In-Reply-To: <1350471893-29633-10-git-send-email-keyuan.liu@gmail.com> (Kevin
	Liu's message of "Wed, 17 Oct 2012 19:04:48 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

Hi,

On Wed, Oct 17 2012, Kevin Liu wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> Acked-by:  Zhangfei Gao <zhangfei.gao@marvell.com>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> ---
>  drivers/mmc/host/sdhci-pxav3.c          |    2 ++
>  include/linux/platform_data/pxa_sdhci.h |    2 ++
>  2 files changed, 4 insertions(+), 0 deletions(-)

It looks like you aren't using any of the quirks in quirks2, is that
right?  I'm still hoping we might be able to get rid of quirks2, so
I'd rather wait until you need it (or we get rid of it) before applying
this.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
