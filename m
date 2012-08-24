From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2] mmc: dw-mmc: fixed secstion mismatch in reference
Date: Fri, 24 Aug 2012 12:53:52 +0900
Message-ID: <00ab01cd81ac$13f62970$3be27c50$%jun@samsung.com>
References: <500E38ED.1090604@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:50757 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab2HXDx6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 23:53:58 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9800FQ1QTNGEF0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 24 Aug 2012 12:53:53 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M9800JGGQTTIK50@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 24 Aug 2012 12:53:53 +0900 (KST)
In-reply-to: <500E38ED.1090604@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>

On July 24, 2012, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Fixed the below message.
> 
> WARNING: drivers/mmc/host/built-in.o(.text+0x5ee8): Section mismatch in reference from the function
> dw_mci_probe() to the function .init.text:dw_mci_init_slot()
> The function dw_mci_probe() references
> the function __init dw_mci_init_slot().
> This is often because dw_mci_probe lacks a __init
> annotation or the annotation of dw_mci_init_slot is wrong
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Changelog v2:
> 	- added __init macro to dw_mmc_pltfm_probe.(reviewed by Seungwon)
>  drivers/mmc/host/dw_mmc-pltfm.c |    2 +-
>  drivers/mmc/host/dw_mmc.c       |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 92ec3eb..58ed89b 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -21,7 +21,7 @@
>  #include <linux/mmc/dw_mmc.h>
>  #include "dw_mmc.h"
> 
> -static int dw_mci_pltfm_probe(struct platform_device *pdev)
> +static int __init dw_mci_pltfm_probe(struct platform_device *pdev)
>  {
>  	struct dw_mci *host;
>  	struct resource	*regs;
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 72dc3cd..7955eba 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1760,7 +1760,7 @@ static void dw_mci_work_routine_card(struct work_struct *work)
>  	}
>  }
> 
> -static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
> +static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  {
>  	struct mmc_host *mmc;
>  	struct dw_mci_slot *slot;

Looks good to me.
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

> --
> 1.7.4.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

