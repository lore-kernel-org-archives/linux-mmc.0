From: Richard Zhao <richard.zhao@freescale.com>
Subject: Re: [PATCH v2 5/5] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Thu, 24 Feb 2011 14:16:55 +0800
Message-ID: <20110224061653.GA3657@b20223-02.ap.freescale.net>
References: <1298369606-29972-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1298369606-29972-5-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110222113222.GE2755@pengutronix.de>
 <AANLkTimbx6=YvRHFuVkmPVYvYtwME31PxXWNHNfFsVRQ@mail.gmail.com>
 <20110222155130.GJ2755@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:36994 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab1BXGSL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 01:18:11 -0500
Received: from mail191-tx2 (localhost.localdomain [127.0.0.1])	by
 mail191-tx2-R.bigfish.com (Postfix) with ESMTP id 7263519F029D	for
 <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 06:18:09 +0000 (UTC)
Received: from TX2EHSMHS047.bigfish.com (unknown [10.9.14.253])	by
 mail191-tx2.bigfish.com (Postfix) with ESMTP id 6290031008A	for
 <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 06:17:04 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id p1O6GvIF028313	for
 <linux-mmc@vger.kernel.org>; Wed, 23 Feb 2011 23:16:57 -0700 (MST)
Received: from b20223-02 (B20223-02.ap.freescale.net [10.192.242.48])	by
 de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id p1O6Guau015605	for
 <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 00:16:57 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20110222155130.GJ2755@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Olof Johansson <olof@lixom.net>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, linuxzsc@gmail.com

Hi Wolfram,

On Tue, Feb 22, 2011 at 04:51:30PM +0100, Wolfram Sang wrote:
> 
> > > Thanks for respinning \o/ This approach looks better to me, but CCing
> > > Olof to comment on abstraction issues if he has them. Will do a deeper
> > > review later this week.
> > 
> > 
> > I like it! Definitely the right approach. Pushing quirks down into the
> > I/O accessors is definitely the only scalable way to handle all the
> > various buggy controllers out there.
> > 
> > Acked-by: Olof Johansson <olof@lixom.net>
> 
> Glad to hear that. I do have a few issues though, will report them later
> as mentioned before, it needs a bit of time.
What issues on what SoC/board did you find? Maybe we can help debug?

Thanks
Richard
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |



