From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 1/1] mmc: Support of DUAL BUFFER DESC[ring] mode for dw_mmc
Date: Wed, 21 Sep 2011 14:42:20 -0400
Message-ID: <m2boud3fg3.fsf@bob.laptop.org>
References: <1314704721-5175-1-git-send-email-shashidharh@vayavyalabs.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55136 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751Ab1IUSm0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Sep 2011 14:42:26 -0400
In-Reply-To: <1314704721-5175-1-git-send-email-shashidharh@vayavyalabs.com>
	(Shashidhar Hiremath's message of "Tue, 30 Aug 2011 17:15:21 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, will.newton@gmail.com, linux-mmc@vger.kernel.org

Hi,

On Tue, Aug 30 2011, Shashidhar Hiremath wrote:
> This Patch adds the support for Dual Buffer Descriptor mode of
> Operation for the dw_mmc driver.The patch also provides the configurability
> Option for choosing DUAL_BUFFER mode or the chained modes through menuconfig.
> The Menuconfig option for selecting Dual Buffer mode or chained mode
> is selected only if Internal DMAC is enabled.
>
> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>

I'm reluctant to merge an untested patch, so I'm inclined to wait until
someone says they're seeing a quantified performance gain with this and
want it to be merged.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
