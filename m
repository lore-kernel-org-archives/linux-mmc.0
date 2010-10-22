From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v5 2/2] sdhci-s3c: Add support no internal clock divider in
 host controller
Date: Fri, 22 Oct 2010 14:44:11 +0900
Message-ID: <002d01cb71ac$298fbab0$7caf3010$%kim@samsung.com>
References: <1286783400-7277-1-git-send-email-kgene.kim@samsung.com>
 <AANLkTinC850pde5Diuz5U40RCDGR1DeQzTAfLUHWm0rB@mail.gmail.com>
 <20101012025946.GA8534@void.printf.net>
 <20101012143700.93ea1812.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:17557 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500Ab0JVFnx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2010 01:43:53 -0400
In-reply-to: <20101012143700.93ea1812.akpm@linux-foundation.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Andrew Morton' <akpm@linux-foundation.org>, 'Chris Ball' <cjb@laptop.org>
Cc: 'Kyungmin Park' <kmpark@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, 'Jeongbae Seo' <jeongbae.seo@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Andrew Morton wrote:
> 
> On Tue, 12 Oct 2010 03:59:46 +0100
> Chris Ball <cjb@laptop.org> wrote:
> 
> > Hi Kyungmin,
> >
> > On Tue, Oct 12, 2010 at 11:53:35AM +0900, Kyungmin Park wrote:
> > > Hi Chris,
> > >
> > > we make a conclusion use this patch. Can you merge it for 2.6.37?
> > >
> > > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> >
> > I don't feel that I can, because Ben Dooks is listed as the maintainer
> > for this driver and the patch does not have his ACK.
> >
> > I don't know what to do about this; I've already tried asking Ben
> > whether he intends to continue maintaining sdhci-s3c, with no reply.
> >
> 
> People get busy and take vacations and change roles, etc.
> 
> Sometimes, the best you can do is to make everyone aware of what's
> going on and then simply proceed on your own.

Hi Chris,

How was going on?
I couldn't find this in your tree yet :-(
Please let me know about your merge plan of this.
If any problems, please kindly let me know :-)

Ben,
If you're ok this to you, please send your ack...
it would be helpful to Chris to handle this ;-)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

