From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: fixed a wrong UHS_REG 16 bit clear
Date: Fri, 22 Feb 2013 10:12:27 +0900
Message-ID: <5126C5FB.4090006@samsung.com>
References: <1361493166-12251-1-git-send-email-hyeonsu.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:24530 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022Ab3BVBMU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Feb 2013 20:12:20 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MIL00BYNKM4ZF70@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 22 Feb 2013 10:12:18 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MIL00APHKOIHA50@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 22 Feb 2013 10:12:18 +0900 (KST)
In-reply-to: <1361493166-12251-1-git-send-email-hyeonsu.kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hyeonsu Kim <hyeonsu.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, kyungmin.park@samsung.com, Seungwon Jeon <tgih.jun@samsung.com>

Plz add the commit message and CC'd Mr.Seungwon.

On 02/22/2013 09:32 AM, Hyeonsu Kim wrote:
> Signed-off-by: Hyeonsu Kim <hyeonsu.kim@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 323c502..390c15c 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -789,9 +789,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  	/* DDR mode set */
>  	if (ios->timing == MMC_TIMING_UHS_DDR50)
> -		regs |= (0x1 << slot->id) << 16;
> +		regs |= ((0x1 << slot->id) << 16);
>  	else
> -		regs &= ~(0x1 << slot->id) << 16;
> +		regs &= ~((0x1 << slot->id) << 16);
>  
>  	mci_writel(slot->host, UHS_REG, regs);
>  
> 

