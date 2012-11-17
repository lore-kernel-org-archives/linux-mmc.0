From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6 12/14] mmc: sdhci-pxav3: remove set_uhs_signaling function
Date: Sat, 17 Nov 2012 17:39:05 -0500
Message-ID: <87vcd37t2u.fsf@octavius.laptop.org>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
	<1350471893-29633-13-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48566 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255Ab2KQWjL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 17 Nov 2012 17:39:11 -0500
In-Reply-To: <1350471893-29633-13-git-send-email-keyuan.liu@gmail.com> (Kevin
	Liu's message of "Wed, 17 Oct 2012 19:04:51 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

Hi,

On Wed, Oct 17 2012, Kevin Liu wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> Because sdhci can do the same thing so no need to implement this.
>
> Acked-by:  Zhangfei Gao <zhangfei.gao@marvell.com>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>

In that case, we can remove the callbacks from sdhci.c/sdhci.h too --
sdhci-pxav3 was the only user.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
