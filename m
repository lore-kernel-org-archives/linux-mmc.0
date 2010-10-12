From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 2/2] sdhci-s3c: Add support no internal clock divider
 in host controller
Date: Tue, 12 Oct 2010 14:37:00 -0700
Message-ID: <20101012143700.93ea1812.akpm@linux-foundation.org>
References: <1286783400-7277-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTinC850pde5Diuz5U40RCDGR1DeQzTAfLUHWm0rB@mail.gmail.com>
	<20101012025946.GA8534@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50691 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751013Ab0JLViF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 17:38:05 -0400
In-Reply-To: <20101012025946.GA8534@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Kyungmin Park <kmpark@infradead.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, Jeongbae Seo <jeongbae.seo@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>

On Tue, 12 Oct 2010 03:59:46 +0100
Chris Ball <cjb@laptop.org> wrote:

> Hi Kyungmin,
> 
> On Tue, Oct 12, 2010 at 11:53:35AM +0900, Kyungmin Park wrote:
> > Hi Chris,
> > 
> > we make a conclusion use this patch. Can you merge it for 2.6.37?
> > 
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> I don't feel that I can, because Ben Dooks is listed as the maintainer
> for this driver and the patch does not have his ACK.
> 
> I don't know what to do about this; I've already tried asking Ben
> whether he intends to continue maintaining sdhci-s3c, with no reply.
> 

People get busy and take vacations and change roles, etc.

Sometimes, the best you can do is to make everyone aware of what's
going on and then simply proceed on your own.

