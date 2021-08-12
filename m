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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97883C4338F
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Aug 2021 06:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A7161038
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Aug 2021 06:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhHLG6L (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Aug 2021 02:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhHLG6L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Aug 2021 02:58:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AF2C061765;
        Wed, 11 Aug 2021 23:57:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so9195007pjb.3;
        Wed, 11 Aug 2021 23:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/oIkmpuRct1iuZiBlhfx+uUrzMQCcYf9oSBv+0fmA1E=;
        b=iCrJ7xzmPU1n4CJ3A87AELaWWIZz9owuP9miS4FZSDUodOmBPEU4Ky8Gh2VB6t+T0l
         6KiKhgn9SmkSEzB5DBFRWQqxqUu4eYwAn7GkFPpgpaXmY12Bd0K77+IB+oKIzw/XoRBZ
         rdm2lFo4xfbYMeOjTk/N4WlgueSmRSaR0h/M1PnoETX0MsEPNOIB8dMxG7rr/RSWBFPS
         QwrxjxkW8+8WKj73Kf0FEAc0KQDRu4gHPCbIxr/Qjt7wxr7GfQzaIw9Ww2rvQii1+cCb
         QVcnZ7PQJqIQ30g5i32K8PGVMTC79nWCJcOrJ+aTXXz1opMXLnTQ11XgFwhOcZf+ETfI
         r0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/oIkmpuRct1iuZiBlhfx+uUrzMQCcYf9oSBv+0fmA1E=;
        b=CPQ/CyzVxaKdK12ReNvBtVpJ/JdwPXtwiBIg7VRMHcPI8Qz+rLRIbxlNfqZRBEaesH
         Orj1PLWNVYcQ3OcRk3L5QYbba+gvUgqZ1rd2PuHsWs959vDHB5Ip32D1vD3O2Qpk7QnS
         CcFX52T7Cud5jNpLe+NTs8yhlyBzvpeQRp0TAPUCSia9p8fWt5Vhy6XF/HAatlQzuB7w
         26VIlvICrukKkaLH/UsnwLfxnttNQhzUqfu+e2wGGidly3F+EivIDf7QojZMwLC0Y+yZ
         gtbXE/ju2U1tWsBLq35E3X2AGu1CPcik5R9dYt1KzKFvLdJOR9/DG0CQAX/sBrRjkcx/
         3J1A==
X-Gm-Message-State: AOAM530WP0zi7PlPQdFEYydjdLrQnkU5IgT5i+12KFhquXKjPHQcBmyq
        vFqhHwgRceb0cDnRlLfQxCMdk3mL9xUBbDSjBJ8=
X-Google-Smtp-Source: ABdhPJzaTT4uviarShkveSCxtxdmHkfpCbFQSrwwQHQQDR7jgtbi18faQXbtudIoV5qqIpljTQSoMA==
X-Received: by 2002:aa7:8185:0:b029:3aa:29a2:39d3 with SMTP id g5-20020aa781850000b02903aa29a239d3mr2729500pfi.28.1628751465968;
        Wed, 11 Aug 2021 23:57:45 -0700 (PDT)
Received: from localhost.localdomain ([106.51.233.109])
        by smtp.gmail.com with ESMTPSA id k197sm1910452pfd.190.2021.08.11.23.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 23:57:45 -0700 (PDT)
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] mmc: core: Return correct emmc response in case of ioctl error
Date:   Thu, 12 Aug 2021 12:27:30 +0530
Message-Id: <20210812065730.3986-1-nishadkamdar@gmail.com>
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
Changes in v2:
  - Make commit message clearer by adding test cases as outputs.
Changes in v3:
  - Shorten the commit message to include only CMD17 related
    code and test.

 drivers/mmc/core/block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index a9ad9f5fa9491..efa92aa7e2368 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -522,11 +522,13 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if (cmd.error) {
 		dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
 						__func__, cmd.error);
+		memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
 		return cmd.error;
 	}
 	if (data.error) {
 		dev_err(mmc_dev(card->host), "%s: data error %d\n",
 						__func__, data.error);
+		memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
 		return data.error;
 	}
 
-- 
2.17.1

