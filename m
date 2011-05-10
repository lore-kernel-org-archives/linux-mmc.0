From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] drivers/mmc/card/block.c: fix potential null dereference 'idata'
Date: Tue, 10 May 2011 10:47:52 +0300
Message-ID: <BANLkTinhy7QwE0a40efJhHazmGSgitKVdw@mail.gmail.com>
References: <4DC7F4AB.90607@gmail.com>
	<Pine.LNX.4.64.1105091631400.15483@pc-004.diku.dk>
	<4DC802C0.9040302@gmail.com>
	<Pine.LNX.4.64.1105091713080.15483@pc-004.diku.dk>
	<4DC8117C.7060200@gmail.com>
	<Pine.LNX.4.64.1105091811320.15483@pc-004.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49833 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722Ab1EJHrw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2011 03:47:52 -0400
In-Reply-To: <Pine.LNX.4.64.1105091811320.15483@pc-004.diku.dk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: Vladimir Motyka <vladimir.motyka@gmail.com>, cjb@laptop.org, kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 9, 2011 at 7:12 PM, Julia Lawall <julia@diku.dk> wrote:
> I guess there is also a point at which idata has been successfully
> allocated but idata->buf has not.
And? kfree() simple ignores NULL pointers.
I would prefer to see previous version of patch, but let maintainer to choose.

-- 
With Best Regards,
Andy Shevchenko
