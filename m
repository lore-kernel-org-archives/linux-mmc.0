From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] mmc: mshci: Add support Mobile Storage Host Controller
 Interface
Date: Mon, 10 Jan 2011 13:09:14 +0900
Message-ID: <00b101cbb07c$262bf780$7283e680$%kim@samsung.com>
References: <1294399237-5716-1-git-send-email-kgene.kim@samsung.com>
 <20110107115123.GD32436@pengutronix.de>
 <AANLkTimQSQ2GViH3VFj6Z+beuwRStPGJqzqMpxZkYjMo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:33543 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab1AJEJT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jan 2011 23:09:19 -0500
In-reply-to: <AANLkTimQSQ2GViH3VFj6Z+beuwRStPGJqzqMpxZkYjMo@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Will Newton' <will.newton@gmail.com>, 'Wolfram Sang' <w.sang@pengutronix.de>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, cjb@laptop.org, 'Hyunsung Jang' <hs79.jang@samsung.com>, 'Hyuk Lee' <hyuk1.lee@samsung.com>

Will Newton wrote:
> 
> On Fri, Jan 7, 2011 at 11:51 AM, Wolfram Sang <w.sang@pengutronix.de>
wrote:
> >
> >> The 'mshci.c' is based on 'linux/drivers/mmc/host/sdhci.c' and
> >> the role is exactly same with that.
> >
> > Can you sum up the differences why you cannot sdhci.c directly, please?
> 
> The driver looks like it is for the same block (or very close) to the
> Synopsys DesignWare IP driver I submitted last month called dw_mmc. It
> would be interesting to see if that driver might be a suitable
> replacement.

Oops :-( 

Mr. Jang and Mr. Lee didn't know that there was submitted driver which is
for Synopsys DesignWare MMC controller. Of course me too.
Actually, they surveyed when needed implementation that, but couldn't find
any driver for it at that time...

Anyway, Will's dw_mmc can replace this so we can drop this and we'll adopt
and test it on our platform.

Thanks and Happy New year!

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

