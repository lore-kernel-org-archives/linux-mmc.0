From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [PATCH v3 5/6] ARM: shmobile: lager: Set clock rates for SDHI
Date: Tue, 30 Jun 2015 03:06:39 +0100
Message-ID: <1435629999.23818.52.camel@codethink.co.uk>
References: <1435332116.23818.7.camel@codethink.co.uk>
	 <1435332230.23818.12.camel@codethink.co.uk>
	 <87a8vjjas8.wl%kuninori.morimoto.gx@renesas.com>
	 <1435622561.23818.43.camel@codethink.co.uk>
	 <1435627793.23818.45.camel@codethink.co.uk>
	 <1435627910.23818.46.camel@codethink.co.uk>
	 <87zj3ieztx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87zj3ieztx.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, Ian Molton <ian@mnementh.co.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@lists.codethink.co.uk, linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 2015-06-30 at 01:45 +0000, Kuninori Morimoto wrote:
> Hi Ben
> 
> > > > > SH-MMC is using this style. and I think it is flexible for every speed.
> > > > > Please check sh_mmcif_clock_control(), sh_mmcif_clk_setup()
> > > > > on ${LINUX}/drivers/mmc/host/sh_mmcif.c
> > > > 
> > > > That's certainly a nicer way of doing this.  The difficulty I see is
> > > > that tmio_mmc doesn't know anything about the input clock, and not all
> > > > of the drivers using it actually use the clock framework.
> > > 
> > > More importantly, that algrithm can result in overclocking the card.
> > 
> > ...and some of the multiplications overflow!
> 
> Can you show us more detail ?
> It seems bug...

The requested clock rate can be up to 52 MHz and the divider can be up
to 1024.  With div == 1024 and clk == 52000000, clk * div overflows.

Ben.


