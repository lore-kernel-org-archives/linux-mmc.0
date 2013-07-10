From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 5/7] mmc: SDHI: add DT compatibility strings for
 further SoCs
Date: Wed, 10 Jul 2013 10:08:55 +0900
Message-ID: <20130710010854.GI32603@verge.net.au>
References: <Pine.LNX.4.64.1307090940310.28812@axis700.grange>
 <CANqRtoQY7hwEhN5XMXG5V234aXDFZ_kfei8ZQL+VMKaaxW=0DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANqRtoQY7hwEhN5XMXG5V234aXDFZ_kfei8ZQL+VMKaaxW=0DQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, SH-Linux <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 09, 2013 at 06:06:00PM +0900, Magnus Damm wrote:
> On Tue, Jul 9, 2013 at 4:43 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Add further OF compatibility strings to the SDHI driver to be able to
> > precisely control driver's behaviour on each of them.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> >
> > v4:
> > 1. added r8a7778 and r8a7779 per Morimoto-san's request
> > 2. sh* and r8a* entries now sorted alphabetically
> 
> This looks good to me, thanks.
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up for v3.12 in the soc branch.
It should appear in renesas-next-20130710
