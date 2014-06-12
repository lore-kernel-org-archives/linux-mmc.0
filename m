From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [GIT PULL] MMC updates for 3.16-rc1
Date: Thu, 12 Jun 2014 07:25:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1406120724100.5160@axis700.grange>
References: <86ha3so84o.fsf@void.printf.net>
 <CA+55aFxBwteZeUHG+Z-cdLU_YCO4f8TDuYvGmXc0-v9M1H11+g@mail.gmail.com>
 <CA+55aFyEbFLFWLKP5kHw85qTRNoviFk8LhivxXJgAMROdvJtsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFyEbFLFWLKP5kHw85qTRNoviFk8LhivxXJgAMROdvJtsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chris Ball <chris@printf.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

On Wed, 11 Jun 2014, Linus Torvalds wrote:

> On Tue, Jun 10, 2014 at 2:50 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Also, that new drivers/mmc/host/usdhi6rol0.c driver is one f*cking
> > noisy compile, and knisr certainly has never been tested in a 64-bit
> > environment. Please either fix it, or make it depend on BROKEN.
> 
> Guys? Seriously, if that driver isn't fixed, I'm going to mark it
> broken myself. It pretty much generates as many lines of warnings as
> the rest of my "allmodconfig" build combined.
> 
> It's extremely annoying, and the crazy warnings are likely to hide
> potential real problems elsewhere, so right now that driver has
> negative value. I do a lot of allmodconfig builds during the merge
> window, and I am not going to look at that warning much longer.
> 
> Fix it promptly, or it gets disabled.

I sent a patch a few hours ago: 
https://patchwork.kernel.org/patch/4338531/ Since it's only changing print 
format strings, it should be a trivial one to review, so, just waiting for 
Chris to pick it up and push it to you. Sorry about the trouble.

Thanks
Guennadi
