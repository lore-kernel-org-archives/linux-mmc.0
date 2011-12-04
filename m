From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: RE: [PATCH] arm, da8xx, mmc: set second MMC controllers default
 queue
Date: Sun, 4 Dec 2011 13:25:35 +0000
Message-ID: <B6A220404B6BFC4BBD2AB91C54D39DF4029FE5@DBDE01.ent.ti.com>
References: <1322991210-20486-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44867 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753951Ab1LDNZu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Dec 2011 08:25:50 -0500
In-Reply-To: <1322991210-20486-1-git-send-email-hs@denx.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Schocher <hs@denx.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "juha.kuikka@gmail.com" <juha.kuikka@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Ido Yariv <ido@wizery.com>, "Nori, Sekhar" <nsekhar@ti.com>, Wolfgang Denk <wd@denx.de>

Hi,

On Sun, Dec 04, 2011 at 15:03:30, Heiko Schocher wrote:
> The MMC driver allocates channels with EVENTQ_DEFAULT they
> get put into EVENTQ_1 which the second EDMA controller does
> not have and hence transfers stall. This is tried to fix
> in commit f23fe857bbea393b4b94fe2218c98d934bd3d4cf
> from Ido Yariv, but missed a fix for the second MMC
> controller on da850.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Signed-off-by: juha.kuikka@gmail.com
> Reported-by: juha.kuikka@gmail.com
> Cc: linux-mmc@vger.kernel.org
> Cc: davinci-linux-open-source@linux.davincidsp.com
> Cc: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
> Cc: Ido Yariv <ido@wizery.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Wolfgang Denk <wd@denx.de>
> ---
>  arch/arm/mach-davinci/dma.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
> index da90103..e10a251 100644
> --- a/arch/arm/mach-davinci/dma.c
> +++ b/arch/arm/mach-davinci/dma.c
> @@ -1513,7 +1513,7 @@ static int __init edma_probe(struct platform_device *pdev)
>  		 * started by the codec engine will not cause audio defects.
>  		 */
>  		for (i = 0; i < edma_cc[j]->num_channels; i++)
> -			map_dmach_queue(j, i, EVENTQ_1);
> +			map_dmach_queue(j, i, info[j]->default_queue);
>  
>  		queue_tc_mapping = info[j]->queue_tc_mapping;
>  		queue_priority_mapping = info[j]->queue_priority_mapping;

Acked-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>

Regards,
Sudhakar
