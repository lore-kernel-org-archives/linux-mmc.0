From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/7] Some cleanup for dwmmc
Date: Fri, 03 Mar 2017 11:01:12 +0900
Message-ID: <78c7e572-55e8-1e61-9c0d-34dacd36508d@samsung.com>
References: <CGME20170217025943epcas2p220d9ae88c0a8849e2c82da50339cec31@epcas2p2.samsung.com>
 <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51115 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdCCDPn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Mar 2017 22:15:43 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OM701EP8UY0PTE0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 03 Mar 2017 11:01:12 +0900 (KST)
In-reply-to: <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On 02/17/2017 11:56 AM, Shawn Lin wrote:
> Hi Jaehoon,
> 
> This is the first part of long term cleanup for dwmmc we need.
> No functional changes here, but just to remove the unnecessary
> function declare and improve the logic of dw_mci_reset for better
> understood.
> 

Applied on my repository. Thanks!

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

