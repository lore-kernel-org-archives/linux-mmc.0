From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH] mmc: sdhci: fix retuning timer wrongly deleted in
 sdhci_tasklet_finish
Date: Fri, 15 Jul 2011 01:51:34 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300018F85B9E0@SAUSEXMBP01.amd.com>
References: <1310362031-8186-1-git-send-email-Aaron.Lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:9470 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab1GOGvo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jul 2011 02:51:44 -0400
In-Reply-To: <1310362031-8186-1-git-send-email-Aaron.Lu@amd.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Lu, Aaron" <Aaron.Lu@amd.com>, Philip Rakity <prakity@marvell.com>, zhangfei gao <zhangfei.gao@gmail.com>

Hi Philip, Zhangfei

Do you have any comments on this patch?

Thanks,
Arindam

> -----Original Message-----
> From: Aaron Lu [mailto:Aaron.Lu@amd.com]
> Sent: Monday, July 11, 2011 10:57 AM
> To: Chris Ball
> Cc: Nath, Arindam; linux-mmc@vger.kernel.org; Lu, Aaron
> Subject: [PATCH] mmc: sdhci: fix retuning timer wrongly deleted in
> sdhci_tasklet_finish
> 
> Currently, the retuning timer for retuning mode 1 will be deleted in
> function sdhci_tasklet_finish after a mmc request done, which will make
> retuning timing never trigger again. This patch fixed this problem.
> 
> Signed-off-by: Aaron Lu <Aaron.Lu@amd.com>
> ---
>  drivers/mmc/host/sdhci.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 91d9892..6250bac 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1863,9 +1863,6 @@ static void sdhci_tasklet_finish(unsigned long
> param)
> 
>  	del_timer(&host->timer);
> 
> -	if (host->version >= SDHCI_SPEC_300)
> -		del_timer(&host->tuning_timer);
> -
>  	mrq = host->mrq;
> 
>  	/*
> --
> 1.7.1


