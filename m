From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 3/4] mmc: dw_mmc: Convert to mmc_send_tuning()
Date: Mon, 8 Dec 2014 11:10:05 +0100
Message-ID: <CAPDyKFpOvs_ML+1edoTzeTPctiMV0B8EeD8aE8daGwjeG7gwMQ@mail.gmail.com>
References: <1417780783-12939-1-git-send-email-ulf.hansson@linaro.org>
	<1417780783-12939-4-git-send-email-ulf.hansson@linaro.org>
	<CAGOxZ525JR9vTuKAZJJjDF6iq3R2-DuEcJFEOT9KkEMZGimUFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:42418 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbaLHKKG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Dec 2014 05:10:06 -0500
Received: by mail-qc0-f171.google.com with SMTP id r5so3242853qcx.2
        for <linux-mmc@vger.kernel.org>; Mon, 08 Dec 2014 02:10:05 -0800 (PST)
In-Reply-To: <CAGOxZ525JR9vTuKAZJJjDF6iq3R2-DuEcJFEOT9KkEMZGimUFw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Aisheng Dong <b29396@freescale.com>, Stephen Boyd <sboyd@codeaurora.org>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

On 6 December 2014 at 13:43, Alim Akhtar <alim.akhtar@gmail.com> wrote:
> Hi Ulf,
>
> On Fri, Dec 5, 2014 at 5:29 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Instead of having a local hack taking care of sending the tuning
>> command and as well to verify the response pattern, let's convert to
>> the common mmc_send_tuning() API.
>>
>> This change affects the Exynos variant, since it's the only one which
>> support the dw_mmc's ->execute_tuning() callback.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>

Alim, thanks for helping out testing!

> With this change HS200 mode does not work on exynos5800 peach-pi board.
> I got below error while testing this series:
>
> mmc0: tuning execution failed
> mmc0: error -5 whilst initialising MMC card
>
> Though, your's next branch with commit _a1d06b4_ works fine in HS200 mode.

I was looking into the details of what change my patchset introduces
for dw_mmc-exynos. Apparently, dw_mmc-exynos was using the
MMC_STOP_TRANSMISSION to end the tuning reqeust (CMD21/19). The new
mmc_send_tuning() API doesn't, which also conforms to what the eMMC/SD
specifications states.

Do you have any idea of why dw_mmc-exynos was using
MMC_STOP_TRANSMISSION for CMD19/21?

To see if my theory is correct, could you try out the following patch
on top of $subject patch?
BTW, I have queued patch 1 and 2, from this patchset available on my
next branch.


>From e1ac35bb0e90254275ec7088f41e6e2d59e48367 Mon Sep 17 00:00:00 2001
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Dec 2014 10:58:48 +0100
Subject: [PATCH] mmc: core: End tuning request with stop command

Not to be merged!

This patch adds the MMC_STOP_TRANSMISSION command to end a tuning
request. For some reason dw_mmc seems to need this to complete the
tuning request without errors.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 3b044c5..aa79e0c 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -551,6 +551,7 @@ int mmc_send_tuning(struct mmc_host *host)
 {
        struct mmc_request mrq = {NULL};
        struct mmc_command cmd = {0};
+       struct mmc_command stop = {0};
        struct mmc_data data = {0};
        struct scatterlist sg;
        struct mmc_ios *ios = &host->ios;
@@ -576,10 +577,14 @@ int mmc_send_tuning(struct mmc_host *host)

        mrq.cmd = &cmd;
        mrq.data = &data;
+       mrq.stop = &stop;

        cmd.opcode = opcode;
        cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;

+       stop.opcode = MMC_STOP_TRANSMISSION;
+       stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
+
        data.blksz = size;
        data.blocks = 1;
        data.flags = MMC_DATA_READ;
-- 
1.9.1

Kind regards
Uffe
