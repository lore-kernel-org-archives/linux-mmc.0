From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH V7 13/25] mmc: core: Do not prepare a new request twice
Date: Mon, 28 Nov 2016 10:18:50 +0530
Message-ID: <ec8930e2-73f5-016a-2bd6-8847e1585c1d@codeaurora.org>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
 <1480068442-5169-14-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43358 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753809AbcK1Es6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2016 23:48:58 -0500
In-Reply-To: <1480068442-5169-14-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>



On 11/25/2016 3:37 PM, Adrian Hunter wrote:
> mmc_start_req() assumes it is never called with the new request already
> prepared. That is true if the queue consists of only 2 requests, but is not
> true for a longer queue. e.g. mmc_start_req() has a current and previous
> request but still exits to queue a new request if the queue size is
> greater than 2. In that case, when mmc_start_req() is called again, the
> current request will have been prepared already. Fix by flagging if the
> request has been prepared.
>
> That also means ensuring that struct mmc_async_req is always initialized
> to zero, which wasn't the case in mmc_test.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Looks good!

Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

Regards
Ritesh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
