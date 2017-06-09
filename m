From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 0/6] mmc: dw_mmc: remove the multiple slot concept
Date: Fri, 9 Jun 2017 09:38:06 +0800
Message-ID: <8d44814d-12d4-28af-116d-5a46be72eb01@rock-chips.com>
References: <CGME20170605044137epcas1p4e7e2b74aa17ea7d7137da7b677bfb282@epcas1p4.samsung.com>
 <20170605044135.18304-1-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:56714 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdFIBiT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 21:38:19 -0400
In-Reply-To: <20170605044135.18304-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, ulf.hansson@linaro.org

Hi Jaehoon,

On 2017/6/5 12:41, Jaehoon Chung wrote:
> DWMMC IP is provided the multiple slot.
> It's only used the one slot per an IP in mmc subsystem.
> If we can consider only one slot, then dwmmc controller codes can be more simpler than now.
> This patchset is the first step to remove the multiple slot.
> 
> In future work,
>     - Remove the entire slot structure.
>     - Move to slot's members into dwmci host.
> 

The whole series looks good to me.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Jaehoon Chung (6):
>    mmc: dw_mmc: deprecated the "num-slots" property
>    mmc: dw_mmc: remove the loop about finding slots
>    mmc: dw_mmc: change the array of slots
>    mmc: dw_mmc: remove the 'id' arguments about functions relevant to
>      slot
>    mmc: dw_mmc: use the 'slot' instead of 'cur_slot'
>    mmc: dw_mmc: remove the unnecessary slot variable
> 
>   drivers/mmc/host/dw_mmc-exynos.c |   4 +-
>   drivers/mmc/host/dw_mmc.c        | 165 +++++++++++++--------------------------
>   drivers/mmc/host/dw_mmc.h        |   7 +-
>   3 files changed, 57 insertions(+), 119 deletions(-)
> 

