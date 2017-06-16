From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 0/9] mmc: core: Some trivial re-factoring and cleanups
Date: Fri, 16 Jun 2017 08:49:51 +0800
Message-ID: <13516833-41bd-ce12-7970-b4af55e3126e@rock-chips.com>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:47270 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdFPAtz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jun 2017 20:49:55 -0400
In-Reply-To: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Ulf,

On 2017/6/8 21:27, Ulf Hansson wrote:
> I have collected some cleanups along the road on the mmc core, now I thought it
> was time to post them. None of these changes causes any functional changes, but
> the goal is rather to just make the code more readable and avoid open coding.
> 
> 
> Ulf Hansson (9):
>    mmc: core: Don't export some eMMC specific functions from core.c
>    mmc: core: Move mmc bkops functions from core.c to mmc_ops.c
>    mmc: core: Move mmc_interrupt_hpi() from core.c to mmc_ops.c
>    mmc: core: Move mmc_flush_cache() from core.c to mmc_ops.c
>    mmc: core: Make mmc_can_reset() static
>    mmc: core: Remove redundant code in mmc_send_cid()
>    mmc: core: Re-factor code for sending CID
>    mmc: core: Drop mmc_all_send_cid() and use mmc_send_cxd_native()
>      instead
>    mmc: core: Clarify code for sending CSD

Looks good to me, so

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
>   drivers/mmc/core/core.c    | 207 -------------------------------------
>   drivers/mmc/core/mmc.c     |   8 +-
>   drivers/mmc/core/mmc_ops.c | 250 +++++++++++++++++++++++++++++++++++++++------
>   drivers/mmc/core/mmc_ops.h |   3 -
>   drivers/mmc/core/sd.c      |   6 +-
>   5 files changed, 221 insertions(+), 253 deletions(-)
> 

