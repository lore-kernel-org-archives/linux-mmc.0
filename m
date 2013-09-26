From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH 08/27] mmc: msm_sdcc: Move away from using deprecated APIs
Date: Thu, 26 Sep 2013 13:58:45 -0700
Message-ID: <20130926205845.GB3146@codeaurora.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
 <1380207292-16968-9-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1380207292-16968-9-git-send-email-ulf.hansson@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 26, 2013 at 04:54:33PM +0200, Ulf Hansson wrote:
>Suspend and resume of cards are being handled from the protocol layer
>and consequently the mmc_suspend|resume_host APIs are deprecated.
>
>This means we can simplify the suspend|resume callbacks by removing the
>use of the deprecated APIs.
>
>Additionally, remove dead code which also used the deprecated APIs.
>
>Cc: David Brown <davidb@codeaurora.org>
>Cc: Daniel Walker <dwalker@fifo99.com>
>Cc: Bryan Huntsman <bryanh@codeaurora.org>
>Cc: linux-arm-msm@vger.kernel.org
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>---
> drivers/mmc/host/msm_sdcc.c |   27 ++-------------------------
> 1 file changed, 2 insertions(+), 25 deletions(-)

Acked-by: David Brown <davidb@codeaurora.org>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
