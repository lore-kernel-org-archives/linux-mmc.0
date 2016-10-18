From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: Regression after "do not use CMD13 to get status after speed mode
 switch"
Date: Tue, 18 Oct 2016 09:36:27 +0530
Message-ID: <5f261465-9cc6-4403-5e1b-23df1b347dcb@codeaurora.org>
References: <CACRpkdbfNq+R9U9AwsKBM=xyKKTzyVDkiW4jqJ0Nb2LXvq20BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58865 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbcJREGf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 00:06:35 -0400
In-Reply-To: <CACRpkdbfNq+R9U9AwsKBM=xyKKTzyVDkiW4jqJ0Nb2LXvq20BA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>

Hi Linus,

Recently for the same patch below was submitted for Qcom sdhci-msm driver.

https://patchwork.kernel.org/patch/9237679/

You mentioned yours is mmci driver.
See if it provides any hints.


Regards
Ritesh


On 10/17/2016 8:02 PM, Linus Walleij wrote:
> Hi Chaotian,
>
> my Dragonboard 8060 has a regression on detecting the eMMC after
> bisecting it down to this patch (which is sadly already in v4.8):
>
> commit 08573eaf1a70104f83fdbee9b84e5be03480e9ed
> Author: Chaotian Jing <chaotian.jing@mediatek.com>
> Date:   Thu May 19 16:47:41 2016 +0800
> mmc: mmc: do not use CMD13 to get status after speed mode switch
>
> Before this patch the eMMC is detected and all partitions enumerated
> immediately, but after the patch it doesn't come up at all, except
> sometimes, when it appears minutes (!) after boot, all of a sudden.
>
> Do you have any ideas on what can be wrong?
>
> This is the Qualcomm MMCI variant whid does *not* support
> busydetection in hardware.
>
> I will continue looking at it but would be happy for any hints on how to
> solve it, currently I cannot mount root off the eMMC because of this.
>
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
