From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH V7 05/25] mmc: queue: Factor out
 mmc_queue_reqs_free_bufs()
Date: Mon, 28 Nov 2016 09:20:58 +0530
Message-ID: <6d37ee73-f9fa-c9cc-a4f3-092d91b75f56@codeaurora.org>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
 <1480068442-5169-6-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60160 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbcK1DvE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2016 22:51:04 -0500
In-Reply-To: <1480068442-5169-6-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>



On 11/25/2016 3:37 PM, Adrian Hunter wrote:
> In preparation for supporting a queue of requests, factor out
> mmc_queue_reqs_free_bufs().
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Looks good!
Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

Regards
Ritesh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
