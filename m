From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/9] mmc: tmio: tmio_mmc_host has .dma
Date: Thu, 08 Jan 2015 14:09:17 +0100
Message-ID: <9752854.8NpfY0BrAf@wuerfel>
References: <87zj9xogln.wl%kuninori.morimoto.gx@renesas.com> <87d26qt4oc.wl%kuninori.morimoto.gx@renesas.com> <87387lu3sv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87387lu3sv.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thursday 08 January 2015 07:30:36 Kuninori Morimoto wrote:
> 
> Hmm... indeed Arnd's patch and my patch-set conflicts.
> I have these patch / patch-set
>  1) header cleanup for tmio
>  2) slave_id cleanup for shdma
>  3) add DMA feature for sh_mobile_sdhi
> 
> 1 ) and 2) conflicts here. one idea is like this
>  1) header cleanup for tmio
>  2) add DMA feature for sh_mobile_sdhi
>  3) slave_id cleanup for shdma
> 
> 1) and 2) can be controled by Ulf with no-conflict.
> if these are merged correctly, I can send 3) to DMAEngine ML.
> Then, I can point the Ulf's branch as base branch.
> 
> Arnd, Ulf what do you think ?
> 

Sounds good. You could also leave out the sh_mobile_sdhi part from
3) patch to avoid the conflict, and add a comment in that place
as part of 2), to say that the slave_id assignment can be removed
once the other parts are done. That way, we know where we're at
if we want to remove slave_id from dma_slave_config and it's still
part of the sdhi driver.

	Arnd
