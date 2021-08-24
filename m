Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC1CC4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 19:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2790E61163
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 19:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhHXTSa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 15:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbhHXTSa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 15:18:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D64C061757;
        Tue, 24 Aug 2021 12:17:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso2482235pjh.5;
        Tue, 24 Aug 2021 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+4xPI+b9gcqTacves1GJHdBbgUOL7d4IuoFmSsHpYzA=;
        b=WrbjOdyZY07c5RqPjHbLotTsWRei299jFNgFbmy5m9hCYruNFTzxVIB/o/+W1XxJcP
         0cbyF8K9yHmyVwcevxnHOYcVPU5thiTNRkax36kdqtR1AMcqWO11iVt9bG+F/Io6zvA0
         kBo/WXAKUuQBfDR/mleyRXfu/R3cR83osrRiCaD/eexRNxF7VJI+n+2Y826VIvHUvdgI
         hgoA1Yho6RTKcpkNtrIxJkbtVDo5hpgQaE6ELeKurIruakuDcSn8v54EFCZiikroBKIU
         oePQydycrUD4Kkb7ioq2+ZpJOLG2XwwBHiMQFDc1JoFTvCMRgMn/X9shlXiTmM36ajKt
         Ng1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+4xPI+b9gcqTacves1GJHdBbgUOL7d4IuoFmSsHpYzA=;
        b=XWgiAPh41RKh+XJ6H1Fdf6/8IZrOr2OEYMyptYeHB6H1o+8XDtxJK93jC6ASjPuHBY
         wffR8vA7/7SW4ybsTVoZEc9Kckb8k2bHrazENvKLMt21SXar7+GKGluY+EdZhCyCUdTl
         z0CaBQpAE9MvCqCAcx4HuJKsy/b7RWqfHVT21Pw6BDii4LksB5y0UY9+8DUKgRYQ+CgZ
         eRn6LPO/ztDwldaKqJd8zsoATqKGrF1JLwnr/JFUPe+T9ft7xyK+mja52nSu+ZIkL5Zb
         R1UdKGMsvzUYLCNzmBBaxM6gCT6m5JOn3XCybn4PfBjdlfp1b7MT6SGiOXS5qFZiC7tK
         QsPQ==
X-Gm-Message-State: AOAM5305ewj5UiTgxuzZz9WMPpNkTz+sIVqkt9xueUCta8lWdY1l4o4x
        cU6eJ8fxCg0Pm6ZsIK4X4R8=
X-Google-Smtp-Source: ABdhPJx7U1lqKzlqTsa0i4LLziCoXD2mZVkRuQX4ZRbZL0EMjWuIEfq6N0lYNXUO6stlDLjz2fKvjw==
X-Received: by 2002:a17:90a:2e0e:: with SMTP id q14mr6077329pjd.16.1629832665030;
        Tue, 24 Aug 2021 12:17:45 -0700 (PDT)
Received: from localhost.localdomain ([106.51.233.109])
        by smtp.gmail.com with ESMTPSA id j16sm15498180pfc.70.2021.08.24.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 12:17:44 -0700 (PDT)
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] mmc: core: Return correct emmc response in case of ioctl error
Date:   Wed, 25 Aug 2021 00:47:26 +0530
Message-Id: <20210824191726.8296-1-nishadkamdar@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When a read/write command is sent via ioctl to the kernel,
and the command fails, the actual error response of the emmc
is not sent to the user.

IOCTL read/write tests are carried out using commands
17 (Single BLock Read), 24 (Single Block Write),
18 (Multi Block Read), 25 (Multi Block Write)

The tests are carried out on a 64Gb emmc device. All of these
tests try to access an "out of range" sector address (0x09B2FFFF).

It is seen that without the patch the response received by the user
is not OUT_OF_RANGE error (R1 response 31st bit is not set) as per
JEDEC specification. After applying the patch proper response is seen.
This is because the function returns without copying the response to
the user in case of failure. This patch fixes the issue.

Hence, this memcpy is required whether we get an error response or not.
Therefor it is moved up from the current position up to immediately
after we have called mmc_wait_for_req().

The test code and the output of only the CMD17 is included in the
commit to limit the message length.

CMD17 (Test Code Snippet):
==========================
        printf("Forming CMD%d\n", opt_idx);
        /*  single block read */
        cmd.blksz = 512;
        cmd.blocks = 1;
        cmd.write_flag = 0;
        cmd.opcode = 17;
        //cmd.arg = atoi(argv[3]);
        cmd.arg = 0x09B2FFFF;
        /* Expecting response R1B */
        cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;

        memset(data, 0, sizeof(__u8) * 512);
        mmc_ioc_cmd_set_data(cmd, data);

        printf("Sending CMD%d: ARG[0x%08x]\n", opt_idx, cmd.arg);
        if(ioctl(fd, MMC_IOC_CMD, &cmd))
                perror("Error");

        printf("\nResponse: %08x\n", cmd.response[0]);

CMD17 (Output without patch):
=============================
test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 17
Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
Entering the do_mmc_commands:Device: /dev/mmcblk0 options[17, 0x09B2FFF]
Forming CMD17
Sending CMD17: ARG[0x09b2ffff]
Error: Connection timed out

Response: 00000000
(Incorrect response)

CMD17 (Output with patch):
==========================
test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 17
[sudo] password for test:
Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
Entering the do_mmc_commands:Device: /dev/mmcblk0 options[17, 09B2FFFF]
Forming CMD17
Sending CMD17: ARG[0x09b2ffff]
Error: Connection timed out

Response: 80000900
(Correct OUT_OF_ERROR response as per JEDEC specification)

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
Changes in v4:
  - Moved the existing 
    "memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));"
    from a couple of lines further down in the code, up to 
    immediately after we have called mmc_wait_for_req().
  - Modified the commit message to explain this change
Changes in v3:
  - Shorten the commit message to include only CMD17 related
    code and test.
Changes in v2:
  - Make commit message clearer by adding test cases as outputs.

 drivers/mmc/core/block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 672cc505ce378..94bb8b4cd6a4e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -557,6 +557,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		return mmc_sanitize(card, idata->ic.cmd_timeout_ms);
 
 	mmc_wait_for_req(card->host, &mrq);
+	memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
 
 	if (cmd.error) {
 		dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
@@ -606,8 +607,6 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if (idata->ic.postsleep_min_us)
 		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
 
-	memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));
-
 	if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
 		/*
 		 * Ensure RPMB/R1B command has completed by polling CMD13
-- 
2.17.1

