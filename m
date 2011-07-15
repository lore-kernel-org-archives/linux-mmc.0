From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 2/2 v2] ARM: mach-shmobile: use GPIO interrupt also for
 card eject on SDHI0 on mackerel
Date: Fri, 15 Jul 2011 20:25:06 +0900
Message-ID: <CANqRtoTqppKKRyOnLYQqA=wEm--OpyNNe4vDw9-EjOYZ6vJkEg@mail.gmail.com>
References: <Pine.LNX.4.64.1107140123070.30737@axis700.grange>
	<Pine.LNX.4.64.1107151254300.22613@axis700.grange>
	<Pine.LNX.4.64.1107151257220.22613@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1107151257220.22613@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jul 15, 2011 at 7:59 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> When we switch to transaction-based runtime PM on SDHI / TMIO MMC,
> also card eject events will have to be detected by the platform.
> This patch prepares mackerel to this switch.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> v2: reconfiguring the pin for card insertion and ejection is no longer
> needed.

Hi Guennadi,

Thanks for your work on this. I may be reading the code wrong, or
perhaps my stack of patches is not the same as yours, but I can't see
any code dealing with hotplug for SDHI2? It looks to me that your
patch is updating the comment about PORT162 and IRQ0 but does nothing
about it on the software side. I sort of assume that we want to have
hotplug support via IRQ on all SDHI channels if possible. But maybe
that's not possible?

Cheers,

/ magnus
