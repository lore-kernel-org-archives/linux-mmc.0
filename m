From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: Regression after "do not use CMD13 to get status after speed mode
 switch"
Date: Tue, 18 Oct 2016 18:03:52 -0700
Message-ID: <d222f9f5-873f-fcd4-01f9-64085d2084e9@codeaurora.org>
References: <CACRpkdbfNq+R9U9AwsKBM=xyKKTzyVDkiW4jqJ0Nb2LXvq20BA@mail.gmail.com>
 <5f261465-9cc6-4403-5e1b-23df1b347dcb@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38382 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932945AbcJSBDy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 21:03:54 -0400
In-Reply-To: <5f261465-9cc6-4403-5e1b-23df1b347dcb@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>

On 10/17/2016 09:06 PM, Ritesh Harjani wrote:
> Hi Linus,
>
> Recently for the same patch below was submitted for Qcom sdhci-msm
> driver.
>
> https://patchwork.kernel.org/patch/9237679/
>
> You mentioned yours is mmci driver.
> See if it provides any hints.
>

I still see an mmc1 error on apq8074 dragonboard, but I don't see the
long 10 minute timeout. Maybe this is a different problem?

[    5.440702] mmc1: card never left busy state
[    5.440729] mmc1: error -110 whilst initialising SD card
[    5.546527] mmc1: Reset 0x1 never completed.
[    5.546548] sdhci: =========== REGISTER DUMP (mmc1)===========
[    5.549854] sdhci: Sys addr: 0x00000000 | Version:  0x00003802
[    5.555497] sdhci: Blk size: 0x00004000 | Blk cnt:  0x00000000
[    5.561310] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[    5.567127] sdhci: Present:  0x01f80000 | Host ctl: 0x00000000
[    5.572944] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[    5.578759] sdhci: Wake-up:  0x00000000 | Clock:    0x00000003
[    5.584575] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[    5.590391] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[    5.596207] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[    5.602023] sdhci: Caps:     0x2329c8b2 | Caps_1:   0x00008007
[    5.607838] sdhci: Cmd:      0x00000000 | Max curr: 0x00000000
[    5.613653] sdhci: Host ctl2: 0x00000000
[    5.619468] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
[    5.623549] sdhci: ===========================================


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

