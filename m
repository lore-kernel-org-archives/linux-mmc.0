From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH 1/1] mmc: core: Further fix thread wake-up
Date: Mon, 19 Dec 2016 21:22:32 +0530
Message-ID: <9e0109c6-d3a1-3776-9beb-5f5277f2f4dd@codeaurora.org>
References: <1482155854-24963-1-git-send-email-adrian.hunter@intel.com>
 <1482155854-24963-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33862 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755334AbcLSPwl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2016 10:52:41 -0500
In-Reply-To: <1482155854-24963-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>



On 12/19/2016 7:27 PM, Adrian Hunter wrote:
> Commit e0097cf5f2f1 ("mmc: queue: Fix queue thread wake-up") did not go far
> enough. mmc_wait_for_data_req_done() still contains some problems and can
> be further simplified.  First it should not touch
> context_info->is_waiting_last_req because that is a wake-up control used by
> the owner of the context. Secondly, it should always return when one of its
> wake-up conditions is met because, again, that is contolled by the owner of
> the context.
>
> While the current block driver does not have an issue, these problems were
> exposed during testing of the Software Command Queue patches.
>
> Fixes: e0097cf5f2f1 ("mmc: queue: Fix queue thread wake-up")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Patch looks good to me. Please feel free to add.

Tested-by: Harjani Ritesh <riteshh@codeaurora.org>

Regards
Ritesh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
