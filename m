From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] [PATCH v4 1/1] mmc: Support of DUAL BUFFER DESC[ring] mode for dw_mmc
Date: Thu, 03 Nov 2011 08:35:33 -0400
Message-ID: <m2obwt8ju2.fsf@bob.laptop.org>
References: <1317123568-5203-1-git-send-email-shashidharh@vayavyalabs.com>
	<4E8BBD76.9020001@samsung.com>
	<CANYdXnpe0prpdJcYpi3yVqCecugwZ1999c2u2u6ffjXjSeCDnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47826 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933538Ab1KCMfx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Nov 2011 08:35:53 -0400
In-Reply-To: <CANYdXnpe0prpdJcYpi3yVqCecugwZ1999c2u2u6ffjXjSeCDnw@mail.gmail.com>
	(Shashidhar Hiremath's message of "Thu, 3 Nov 2011 17:17:06 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org

Hi,

On Thu, Nov 03 2011, Shashidhar Hiremath wrote:
> Hi Chris,
>   Can this patch be accepted by criteria that its an additional
> feature supported by the hardware and hence good to have the support
> in the driver.Also note the patch has been tested.

I think Will and James should make the call on that.

My own opinion is that it's not usually a good idea to merge code that
increases complexity for no performance gain; if the feature is actually
important, someone should find a way to finish it and measure a
performance gain (the gain can be in any of bandwidth, memory, or
lower CPU utilization) with it, to prove that the change is worthwhile.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
