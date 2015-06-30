From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [PATCH v3 5/6] ARM: shmobile: lager: Set clock rates for SDHI
Date: Tue, 30 Jun 2015 02:31:50 +0100
Message-ID: <1435627910.23818.46.camel@codethink.co.uk>
References: <1435332116.23818.7.camel@codethink.co.uk>
	 <1435332230.23818.12.camel@codethink.co.uk>
	 <87a8vjjas8.wl%kuninori.morimoto.gx@renesas.com>
	 <1435622561.23818.43.camel@codethink.co.uk>
	 <1435627793.23818.45.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1435627793.23818.45.camel@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, Ian Molton <ian@mnementh.co.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@lists.codethink.co.uk, linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 2015-06-30 at 02:29 +0100, Ben Hutchings wrote:
> On Tue, 2015-06-30 at 01:02 +0100, Ben Hutchings wrote:
> > On Mon, 2015-06-29 at 06:23 +0000, Kuninori Morimoto wrote:
> [...]
> > > If so, why we can't use max-frequency ?
> > > We can calculate/set SDHI IP clocks via 
> > > max-frequency / clk_round_rate() / clk_set_rate()
> > > since we know SDHI's divider capability.
> > > 
> > > SH-MMC is using this style. and I think it is flexible for every speed.
> > > Please check sh_mmcif_clock_control(), sh_mmcif_clk_setup()
> > > on ${LINUX}/drivers/mmc/host/sh_mmcif.c
> > 
> > That's certainly a nicer way of doing this.  The difficulty I see is
> > that tmio_mmc doesn't know anything about the input clock, and not all
> > of the drivers using it actually use the clock framework.
> 
> More importantly, that algrithm can result in overclocking the card.

...and some of the multiplications overflow!

Ben.


