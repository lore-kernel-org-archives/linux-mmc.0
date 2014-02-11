From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: enable trim in eMMC device
Date: Tue, 11 Feb 2014 11:48:46 +0900
Message-ID: <52F98F8E.9090906@samsung.com>
References: <1391798398-24634-1-git-send-email-puthik@chromium.org>
 <1392072891-21302-1-git-send-email-puthik@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:14373 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbaBKCsk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Feb 2014 21:48:40 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0T000DK953EI70@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 11 Feb 2014 11:48:39 +0900 (KST)
In-reply-to: <1392072891-21302-1-git-send-email-puthik@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Puthikorn Voravootivat <puthik@chromium.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: MMC list <linux-mmc@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Grant Grundler <grundler@chromium.org>


As my understanding, if erase will be used by default, MMC_CAP_ERASE flags can be removed. isn't?

Best Regards,
Jaehoon Chung

On 02/11/2014 07:54 AM, Puthikorn Voravootivat wrote:
> Force all host to have erase capacity to enable trim or
> discard feature in supported eMMC device.
> 
> Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
> ---
> V2 change:
> Instead of add MMC_CAP_ERASE just only for dw_mmc, this patch adds
> this capability to all host.
> 
>  drivers/mmc/core/host.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 49bc403..a21f590 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -521,6 +521,8 @@ int mmc_add_host(struct mmc_host *host)
>  	WARN_ON((host->caps & MMC_CAP_SDIO_IRQ) &&
>  		!host->ops->enable_sdio_irq);
>  
> +	host->caps |= MMC_CAP_ERASE;
> +
>  	err = device_add(&host->class_dev);
>  	if (err)
>  		return err;
> 

