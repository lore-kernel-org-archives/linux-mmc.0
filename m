From: Simon Horman <simon@horms.net>
Subject: Re: [patch 1/3] mmc, sh: Move MMCIF_PROGRESS_* into sh_mmcif.h
Date: Mon, 6 Dec 2010 10:28:02 +0900
Message-ID: <20101206012801.GA3735@verge.net.au>
References: <20101206001243.949375995@vergenet.net>
 <20101206001310.658304531@vergenet.net>
 <AANLkTikdKiNg3Mvz3ycqyqh=thNSWijPURK6HG+fbY-o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikdKiNg3Mvz3ycqyqh=thNSWijPURK6HG+fbY-o@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Dec 06, 2010 at 09:57:17AM +0900, Magnus Damm wrote:
> On Mon, Dec 6, 2010 at 9:12 AM, Simon Horman <horms@verge.net.au> wrote:
> > Allow MMCIF_PROGRESS_* to be shared.
> >
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> I'm a bit hesitant to this change. This because the progress really
> hasn't anything to do with the MMCIF hardware block. The enum does use
> the MMCIF prefix though, so I guess i should be silent. =)
> 
> In the future I can imagine that there will be more boards making use
> of this feature, and other MMC/SD-capable hardware blocks that want to
> support early loading. Perhaps moving the enum into the header like
> you suggest is the easiest way forward. Unless there is any easy way
> to share the same progress code between MMCIF and say SDHI.

The way that I see things is that with the last patch in this series
there are two files using these enums, one under arch/sh and one under
arch/arm. They both relate to using MMCIF. And they both assume that
there are states we are interested in that can be usefully displayed.
If SHDI can make use of this it may make sense to move it somewhere
else at that time.

OTOH, its just 4 integers and this is really just debugging code.
I wouldn't be opposed to removing it altogether.

