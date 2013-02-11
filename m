From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 3/3] mmc: sdhci: update signal voltage switch code
Date: Mon, 11 Feb 2013 14:15:58 -0500
Message-ID: <87d2w6pspd.fsf@octavius.laptop.org>
References: <1355743766-18536-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50726 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758941Ab3BKTQQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Feb 2013 14:16:16 -0500
In-Reply-To: <1355743766-18536-1-git-send-email-kliu5@marvell.com> (Kevin
	Liu's message of "Mon, 17 Dec 2012 19:29:26 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>
Cc: linux-mmc@vger.kernel.org, johan.rudholm@stericsson.com, per.forlin@stericsson.com, ulf.hansson@linaro.org, fredrik.soderstedt@stericsson.com, dsd@laptop.org, leafy.myeh@allwinnertech.com, subhashj@codeaurora.org, prakity@nvidia.com, zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com

Hi,

On Mon, Dec 17 2012, Kevin Liu wrote:
> The protocal related code is moved to core stack. So update the host
> driver accordingly.
>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> Tested-by: Tim Wang <wangtt@marvell.com>

Thanks, pushed to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
