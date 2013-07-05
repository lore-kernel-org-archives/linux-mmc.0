From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: Add sanity NULL pointer check
Date: Fri, 05 Jul 2013 11:25:29 +0900
Message-ID: <51D62E99.9010506@samsung.com>
References: <1372948801-20230-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:56238 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755500Ab3GECZ2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jul 2013 22:25:28 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MPF0042PYQCXIL0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 05 Jul 2013 11:25:24 +0900 (KST)
In-reply-to: <1372948801-20230-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-mmc@vger.kernel.org, khilman@linaro.org, tgih.jun@samsung.com, kdorfman@codeaurora.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>

Hi Ezequiel,

Already posted the patch for this issue.

https://patchwork.kernel.org/patch/2811611/

Best Regards,
Jaehoon Chung


On 07/04/2013 11:40 PM, Ezequiel Garcia wrote:
> Commit 762877485 "mmc: core: Handle card shutdown from mmc_bus"
> added shutdown support. However, there are some situations where the
> 'owner' struct pointer can be NULL.
> 
> Solve this by adding a check, just as it's done in the other busses.
> 
> This commit solves a panic upon a reboot request, found in today's linux-next,
> on a Armada 370 Mirabox board.
> 
> [snip]
> [  225.592003] Unable to handle kernel NULL pointer dereference at virtual address 0000004c
> [  225.600114] pgd = eea2c000
> [  225.602897] [0000004c] *pgd=2ea38831, *pte=00000000, *ppte=00000000
> [  225.609216] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
> [  225.614628] CPU: 0 PID: 1100 Comm: init Not tainted 3.10.0-next-20130704 #19
> [  225.621690] task: ef1adb00 ti: ef3ce000 task.ti: ef3ce000
> [  225.627111] PC is at mmc_bus_shutdown+0x14/0x5c
> [  225.631657] LR is at device_shutdown+0x34/0x184
> [  225.636196] pc : [<c0267548>]    lr : [<c01b487c>]    psr: 600f0013
> [  225.636196] sp : ef3cfe68  ip : 00000002  fp : 00000000
> [  225.647693] r10: 00000000  r9 : ef3ce000  r8 : c049229c
> [  225.652927] r7 : ef304c3c  r6 : c04b4f30  r5 : ef304c08  r4 : ef304000
> [  225.659466] r3 : ef304c08  r2 : 00000000  r1 : 00000000  r0 : ef304c00
> [  225.666005] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [  225.673153] Control: 10c5387d  Table: 2ea2c019  DAC: 00000015
> [  225.678909] Process init (pid: 1100, stack limit = 0xef3ce238)
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> This patch applies cleanly on today's linux-next.
> 
> Honestly, I can't see how the owner pointer can be NULL,
> but every other bus driver is checking, so I guess it can
> be NULL under some circumstance.
> 
>  drivers/mmc/core/bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index b9e5bea..8fcf0b9 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -129,7 +129,8 @@ static void mmc_bus_shutdown(struct device *dev)
>  	struct mmc_host *host = card->host;
>  	int ret;
>  
> -	drv->shutdown(card);
> +	if (drv)
> +		drv->shutdown(card);
>  
>  	if (host->bus_ops->shutdown) {
>  		ret = host->bus_ops->shutdown(host);
> 

