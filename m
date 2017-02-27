From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/7] Some cleanup for dwmmc
Date: Mon, 27 Feb 2017 20:41:07 +0900
Message-ID: <b1683639-b11c-448d-70aa-2f60b3508cad@samsung.com>
References: <CGME20170217025924epcas3p2fdf980ca678240d2dc0ece07472202b6@epcas3p2.samsung.com>
 <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:50265 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbdB0MOI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2017 07:14:08 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OM100HB574JEIB0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 27 Feb 2017 20:41:07 +0900 (KST)
In-reply-to: <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

Hi Shawn,

On 02/17/2017 11:56 AM, Shawn Lin wrote:
> Hi Jaehoon,
> 
> This is the first part of long term cleanup for dwmmc we need.
> No functional changes here, but just to remove the unnecessary
> function declare and improve the logic of dw_mci_reset for better
> understood.
> 

Thanks for sending patches. I'm doing the other things now..
So i will apply on these patches within this week. After checking.

I think this patches will be for 4.12..Sorry for late.

Best Regards,
Jaehoon Chung

> 
> 
> Shawn Lin (7):
>   mmc: dw_mmc: improve the timeout polling code
>   mmc: dw_mmc: move dw_mci_reset forward to avoid declaration
>   mmc: dw_mmc: move dw_mci_ctrl_reset forward to avoid declaration
>   mmc: dw_mmc: move dw_mci_get_cd forward to avoid declaration
>   mmc: dw_mmc: remove declaration of dw_mci_card_busy
>   mmc: dw_mmc: move mci_send_cmd forward to avoid declaration
>   mmc: dw_mmc: improve dw_mci_reset a bit
> 
>  drivers/mmc/host/dw_mmc.c | 383 ++++++++++++++++++++++------------------------
>  1 file changed, 182 insertions(+), 201 deletions(-)
> 

