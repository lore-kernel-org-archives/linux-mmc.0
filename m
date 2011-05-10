From: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH] drivers/mmc/card/block.c: fix potential null dereference
 'idata'
Date: Tue, 10 May 2011 09:57:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105100955580.4600@ask.diku.dk>
References: <4DC7F4AB.90607@gmail.com> <Pine.LNX.4.64.1105091631400.15483@pc-004.diku.dk>
 <4DC802C0.9040302@gmail.com> <Pine.LNX.4.64.1105091713080.15483@pc-004.diku.dk>
 <4DC8117C.7060200@gmail.com> <Pine.LNX.4.64.1105091811320.15483@pc-004.diku.dk>
 <BANLkTinhy7QwE0a40efJhHazmGSgitKVdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mgw2.diku.dk ([130.225.96.92]:56297 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752875Ab1EJH5d (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2011 03:57:33 -0400
In-Reply-To: <BANLkTinhy7QwE0a40efJhHazmGSgitKVdw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Vladimir Motyka <vladimir.motyka@gmail.com>, cjb@laptop.org, kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 10 May 2011, Andy Shevchenko wrote:

> On Mon, May 9, 2011 at 7:12 PM, Julia Lawall <julia@diku.dk> wrote:
> > I guess there is also a point at which idata has been successfully
> > allocated but idata->buf has not.
> And? kfree() simple ignores NULL pointers.

Unnecessarily calling a function suggests that calling that function is 
necessary when it is not.  But it is probably not a big deal, especially 
for a well known function like kfree.

julia

> I would prefer to see previous version of patch, but let maintainer to choose.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
