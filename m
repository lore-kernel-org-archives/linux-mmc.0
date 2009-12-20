From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC] tmio_mmc: keep card-detect interrupts enabled
Date: Sun, 20 Dec 2009 18:20:48 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0912201807370.14323@axis700.grange>
References: <Pine.LNX.4.64.0911061127240.4389@axis700.grange>
 <c09aa50a0911090242l35d0dfb2vec0cdeff8b86d33e@mail.gmail.com>
 <Pine.LNX.4.64.0911091530030.4289@axis700.grange>
 <c09aa50a0911091218i681449e0r5cb96b9db3e0def6@mail.gmail.com>
 <Pine.LNX.4.64.0911092134440.4289@axis700.grange>
 <c09aa50a0911091736k27d66483t9012e296bfbf578a@mail.gmail.com>
 <Pine.LNX.4.64.0911282002490.3696@axis700.grange>
 <Pine.LNX.4.64.0912162223170.5283@axis700.grange>
 <Pine.LNX.4.64.0912172113510.5991@axis700.grange>
 <20091217131239.0dfd5534.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:39897 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751946AbZLTRUa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 20 Dec 2009 12:20:30 -0500
In-Reply-To: <20091217131239.0dfd5534.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>

Hi Andrew

On Thu, 17 Dec 2009, Andrew Morton wrote:

> On Thu, 17 Dec 2009 21:25:52 +0100 (CET)
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 
> > I originally submitted this [1] patch on the 6th of November, then 
> > accidentally the MMC list got dropped from CC and the discussion moved to 
> > another irrelevant list, Ian's last reply is at [2]. Unfortunately, Ian 
> > hasn't replied to my reminders since then, and I don't see this patch 
> > anywhere upstream. Is there any way we could get it into 2.6.33?
> 
> Please redo and retest it against curent mainline and do a full resend.

As I tried to re-test, I found out, that some other patches from Ian are 
currently missing in the mainline, so, even though this my specific patch 
doesn't depend on those changes, unfortunately, I currently cannot test 
tmio_mmc on sh. Will resubmit as soon as those patches hit mainline.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
