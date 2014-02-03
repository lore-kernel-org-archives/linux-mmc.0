From: Simon Horman <horms@verge.net.au>
Subject: Re: mmc: sh_mobile_sdhi: DT update for R-Car
Date: Mon, 3 Feb 2014 15:41:59 +0900
Message-ID: <20140203064156.GE30047@verge.net.au>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
 <87d2j87m6u.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:39358 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbaBCGmB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Feb 2014 01:42:01 -0500
Content-Disposition: inline
In-Reply-To: <87d2j87m6u.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

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

I agree with Sergei that patches 2 and 3 could be consolidated,
but I also don't feel strongly about it, so please use your best judgement
there.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

