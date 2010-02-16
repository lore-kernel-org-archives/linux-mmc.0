From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] tmio_mmc: keep card-detect interrupts enabled
Date: Tue, 16 Feb 2010 23:44:38 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1002162343190.4778@axis700.grange>
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
 <Pine.LNX.4.64.1002161028200.4778@axis700.grange>
 <20100216135146.beacf701.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20100216135146.beacf701.akpm@linux-foundation.org>
Sender: linux-sh-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <damm@opensource.se>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 16 Feb 2010, Andrew Morton wrote:

> On Tue, 16 Feb 2010 10:34:55 +0100 (CET)
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 
> > On SuperH platforms the SDHI controller does not produce any command IRQs after
> > a completed IO. This leads to card-detect interrupts staying disabled. Do not
> > disable card-detect interrupts on DATA IRQs.
> > 
> 
> Why is the current code disabling card-detect interrupts on DATA IRQs? 
> Was that just a bug?
> 
> What effect will this change have for current users of this driver?

Unfortunately, I cannot answer these questions, best I can do is refer you 
to this reply from Ian:

http://article.gmane.org/gmane.linux.drivers.video-input-infrastructure/11995

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
