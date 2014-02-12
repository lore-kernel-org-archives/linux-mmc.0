From: Simon Horman <horms@verge.net.au>
Subject: Re: mmc: sh_mobile_sdhi: DT update for R-Car
Date: Wed, 12 Feb 2014 18:47:35 +0900
Message-ID: <20140212094731.GA6630@verge.net.au>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
 <87d2j87m6u.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87d2j87m6u.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Jan 30, 2014 at 09:30:20PM -0800, Kuninori Morimoto wrote:
> Hi Chris, Simon
> 
> These are v2 of updates code for R-Car.
> I separated v1 patches into for mmc, and for SH-ARM.
> This is "mmc" part patches.
> 
> Kuninori Morimoto (4):
>       mmc: SDHI: tidyup sh_mobile_sdhi_of_match position
>       mmc: SDHI: update sh_mobile_sdhi_of_data for r8a7778
>       mmc: SDHI: update sh_mobile_sdhi_of_data for r8a7779
>       mmc: SDHI: update sh_mobile_sdhi_of_data for r8a7790
> 
>  drivers/mmc/host/sh_mobile_sdhi.c |   41 +++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> )

To aid other developers I have pushed these
in the topic/r-car-sdhi branch of my renesas tree.

To be clear, I am not picking these patches up,
that is Chris's domain.
