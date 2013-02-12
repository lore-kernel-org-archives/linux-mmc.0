From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] mmc: check correct variable after kzalloc()
Date: Tue, 12 Feb 2013 15:35:00 +0300
Message-ID: <20130212123500.GP4937@mwanda>
References: <20130212122454.GC19045@elgon.mountain>
 <87pq05ogy9.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39977 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932957Ab3BLMez (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Feb 2013 07:34:55 -0500
Content-Disposition: inline
In-Reply-To: <87pq05ogy9.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Namjae Jeon <linkinjeon@gmail.com>, Konstantin Dorfman <kdorfman@codeaurora.org>, Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, kbuild@01.org, kernel-janitors@vger.kernel.org

On Tue, Feb 12, 2013 at 07:27:26AM -0500, Chris Ball wrote:
> Hi Dan,
> 
> On Tue, Feb 12 2013, Dan Carpenter wrote:
> > There is a typo here so we check "mqrq_cur->packed" instead of
> > "mqrq_prev->packed".
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> > index c0d1315..97a848b 100644
> > --- a/drivers/mmc/card/queue.c
> > +++ b/drivers/mmc/card/queue.c
> > @@ -378,7 +378,7 @@ int mmc_packed_init(struct mmc_queue *mq, struct mmc_card *card)
> >  	}
> >  
> >  	mqrq_prev->packed = kzalloc(sizeof(struct mmc_packed), GFP_KERNEL);
> > -	if (!mqrq_cur->packed) {
> > +	if (!mqrq_prev->packed) {
> >  		pr_warn("%s: unable to allocate packed cmd for mqrq_prev\n",
> >  			   mmc_card_name(card));
> >  		kfree(mqrq_cur->packed);
> >
> 
> Thanks, this is already fixed via a rebase edit to to the original patch
> in mmc-next.  (Fengguang's 0-day bot caught it.)
> 

Ah, grand.  We try to avoid duplicates but there is a gap in our
system...

regards,
dan carpenter
