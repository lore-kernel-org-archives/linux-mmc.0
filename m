From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc-util: add the method to enable the bkops
Date: Fri, 21 Sep 2012 06:21:30 -0400
Message-ID: <m3392bfzh1.fsf@pullcord.laptop.org>
References: <505C3C85.3070505@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59213 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753362Ab2IUKVV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Sep 2012 06:21:21 -0400
In-Reply-To: <505C3C85.3070505@samsung.com> (Jaehoon Chung's message of "Fri,
	21 Sep 2012 19:08:05 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Maya Erez <merez@codeaurora.org>

Hi Jaehoon,

On Fri, Sep 21 2012, Jaehoon Chung wrote:
> This patch added the method to enable the bkops.
> In ext_csd register, BKOPS_EN bit is one-time programable.
> So if you want to use the bkops, use the this command.
>
> <usage>
> #mmc bkops enable /dev/mmcblk0
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Reviewd-by: Venkatraman S <svenkatr@ti.com>

Thanks for the reminder -- pushed to mmc-utils.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
