From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] dw_mmc: support DDR mode
Date: Thu, 24 Feb 2011 15:19:11 +0000
Message-ID: <20110224151911.GA8768@void.printf.net>
References: <4D65E293.2040008@samsung.com> <AANLkTi=1zXrNucgtVqOdeL0hWVjDnY65Q1YZeZGfMpJR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59937 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365Ab1BXPTO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Feb 2011 10:19:14 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=1zXrNucgtVqOdeL0hWVjDnY65Q1YZeZGfMpJR@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Thu, Feb 24, 2011 at 10:22:05AM +0000, Will Newton wrote:
> On Thu, Feb 24, 2011 at 4:46 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> > This patch is applied DDR mode in dw_mmc.
> >
> > DW_MMC is supported DDR mode.
> > If set any bit in UHS_REG bit[16:31], the card of that slot is supported DDR mode.
> > For example, if UHS_REG[16] is set, card number 0 is DDR mode.
> >
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> This looks ok to me.
> 
> Acked-by: Will Newton <will.newton@imgtec.com>

Thanks, pushed to mmc-next for .39.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
