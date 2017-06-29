From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/6] mmc: dw_mmc: remove the multiple slot concept
Date: Thu, 29 Jun 2017 19:56:43 +0900
Message-ID: <e2934d73-9e61-3a00-fa78-feb9ba5a99a0@samsung.com>
References: <CGME20170605044137epcas1p4e7e2b74aa17ea7d7137da7b677bfb282@epcas1p4.samsung.com>
        <20170605044135.18304-1-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:43795 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbdF2K4q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jun 2017 06:56:46 -0400
In-reply-to: <20170605044135.18304-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com

On 06/05/2017 01:41 PM, Jaehoon Chung wrote:
> DWMMC IP is provided the multiple slot.
> It's only used the one slot per an IP in mmc subsystem.
> If we can consider only one slot, then dwmmc controller codes can be more simpler than now.
> This patchset is the first step to remove the multiple slot.
> 
> In future work,
>    - Remove the entire slot structure.
>    - Move to slot's members into dwmci host.

Applied to my dwmmc repository.

Best Regards,
Jaehoon Chung

> 
> Jaehoon Chung (6):
>   mmc: dw_mmc: deprecated the "num-slots" property
>   mmc: dw_mmc: remove the loop about finding slots
>   mmc: dw_mmc: change the array of slots
>   mmc: dw_mmc: remove the 'id' arguments about functions relevant to
>     slot
>   mmc: dw_mmc: use the 'slot' instead of 'cur_slot'
>   mmc: dw_mmc: remove the unnecessary slot variable
> 
>  drivers/mmc/host/dw_mmc-exynos.c |   4 +-
>  drivers/mmc/host/dw_mmc.c        | 165 +++++++++++++--------------------------
>  drivers/mmc/host/dw_mmc.h        |   7 +-
>  3 files changed, 57 insertions(+), 119 deletions(-)
> 

