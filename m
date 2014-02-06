From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ARM: shmobile: bockw: use wp-gpios instead of WP pin
Date: Thu, 6 Feb 2014 15:59:05 +0900
Message-ID: <20140206065903.GE17591@verge.net.au>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
 <87zjmc676u.wl%kuninori.morimoto.gx@gmail.com>
 <20140203063549.GD30047@verge.net.au>
 <87zjm7fyst.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87zjm7fyst.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Feb 03, 2014 at 05:32:08PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > Latest Renesas Chip has some SDHI channels and the WP pin
> > > availability depends on its channel or HW implementation.
> > > Thus, this patch decides new policy whch indicates
> > > WP is disabled as default.
> > > But, we can use wp-gpios property to enable it as
> > > other method.
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > > Simon
> > > 
> > > This was included on v1 patch series,
> > > but no relationship with mmc part patches.
> > 
> > So I could take this patch into the renesas tree now?
> 
> Yes, I guess so

Thanks, I have queued this up.

> 
> # my PC broken this morning somehow...

Ouch
