Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E270C4338F
	for <linux-mmc@archiver.kernel.org>; Sun,  8 Aug 2021 17:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E9B460F0F
	for <linux-mmc@archiver.kernel.org>; Sun,  8 Aug 2021 17:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhHHRZh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 8 Aug 2021 13:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbhHHRZh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Aug 2021 13:25:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA64C061760;
        Sun,  8 Aug 2021 10:25:18 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ca5so24250626pjb.5;
        Sun, 08 Aug 2021 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HlPsvuTsI6t7vckJCQOniDOCiLMI84O0sX3drejVkqs=;
        b=rsweLqa4/7PjnIm81U/PuG78AhlKmwSdX5c3ZLjgSWBb01JVxwmH7ZUn/q3W8EGTz7
         EsPO5fGXj5OtN7gz3XrtXFqVAmBMDqEP88MScm1TbrZLR4en0vHSQ8/TnFGXWrW0t/HJ
         V0EmtzyyyR1INAsPTO72TlZNTJNahcLaaZblxtz6sGMvOFK3UvMj2fTrBRveSlinACrE
         FQr/HjwMBjJ4IJn2IqiQzLzVcDDeHiwMC2FPbs2xMCmxue2+e+v3Sqc4GeU/vRHhb5Az
         d8Pw/34E9x/EWbGOuOwoNs6BXtMiK5tI0GUu/R8CrzHFa2ffqDXyyKyDKUtjqJDEnio+
         d/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HlPsvuTsI6t7vckJCQOniDOCiLMI84O0sX3drejVkqs=;
        b=ron94hOPnt1hXrFNf+Mg8+92d7s7JdiymgJjVPa8KlGyUwxx7cZhSo+o5czlYkpiVN
         1eq99tsvizL5MEED/MdcPAGSX0kbI7S/IecWPfHgLuclarCX1geK4zK1ENTEgxXkMtFV
         ejBOAUNXdPDkC9+SOLBDf9WrTPiPqxCrHUupabtSIrDsnAvg3/Afzx85BqEqocs+TQ9R
         80NXygrjhRV4BCPgWulg+j8jZ/EECVWDyaNCFOIhtkGwkBoBEm6JyEL74xRGxwPybJzb
         tTF03Gl79OOFtGe+JjBmWvhKzDtlGnInTqU/dHhoIQMAWU1TRkUhjkSgR4/5pBf3bHAC
         AGkg==
X-Gm-Message-State: AOAM531fCAwfIlZp+1UD/ovS1/CxI+umdL3Az27b7/873qobHPlphbZA
        1YmYBkO0GV2b9oFuuzRpcNY=
X-Google-Smtp-Source: ABdhPJxwBJe+oiz6oU6guTuWe5V6ar0KVHTERR6ai9nyoCFBLtxNFv1cL4K2JyT1gv7gf+C9nCCEAQ==
X-Received: by 2002:a65:6787:: with SMTP id e7mr125820pgr.345.1628443517505;
        Sun, 08 Aug 2021 10:25:17 -0700 (PDT)
Received: from localhost.localdomain ([106.51.233.109])
        by smtp.gmail.com with ESMTPSA id g25sm17733922pfk.138.2021.08.08.10.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 10:25:16 -0700 (PDT)
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: core: Return correct emmc response in case of ioctl error
Date:   Sun,  8 Aug 2021 22:54:48 +0530
Message-Id: <20210808172448.4641-1-nishadkamdar@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When a read/write command is sent via ioctl to the kernel,
and the command fails, the actual error response of the emmc
is not sent to the user.

Following are the tests carried out using commands
17 (Single BLock Read),
24 (Single Block Write),
18 (Multi Block Read),
25 (Multi Block Write)

The tests are carried out on a 64Gb emmc device. All of these
tests try to access an "out of range" sector address (0x09B2FFFF).

It is seen that without the patch the response received by the user
is not OUT_OF_RANGE error (R1 response 31st bit is not set) as per
JEDEC specification. After applying the patch proper response is seen.

The user level ioctl testcode for the above commands and their
respective outputs without and with the patch are shown below:

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
test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 17 09B2FFFF
Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
Entering the do_mmc_commands:Device: /dev/mmcblk0 options[17, 0x09B2FFF]
Forming CMD17
Sending CMD17: ARG[0x09b2ffff]
Error: Connection timed out

Response: 00000000  (Wrong response)

CMD17 (Output with patch):
==========================
test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 17 09B2FFFF
[sudo] password for test:
Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
Entering the do_mmc_commands:Device: /dev/mmcblk0 options[17, 09B2FFFF]
Forming CMD17
Sending CMD17: ARG[0x09b2ffff]
Error: Connection timed out

Response: 80000900
(Correct OUT_OF_ERROR response as per JEDEC specification)

CMD24 (Test Code Snippet):
==========================
        printf("Forming CMD%d\n", opt_idx);
        cmd.opcode = 24;
        //cmd.arg = atoi(argv[3]);
        cmd.arg = 0x09B2FFFF;
        cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
        cmd.blksz = 512;
        cmd.blocks = 1;
        cmd.write_flag = 1;

        memset(data, 0xA5, sizeof(__u8) * 512);
        mmc_ioc_cmd_set_data(cmd, data);

        printf("Sending CMD%d: ARG[0x%08x]\n", opt_idx, cmd.arg);
        if(ioctl(fd, MMC_IOC_CMD, &cmd))
                perror("Error");

        printf("\nResponse: %08x\n", cmd.response[0]);

CMD24 (Output without patch):
=============================
test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 24 0x09B2FFF
[sudo] password for test:
Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
Entering the do_mmc_commands:Device: /dev/mmcblk0 options[24, 0x09B2FFF]
Forming CMD24
Sending CMD24: ARG[0x09b2ffff]
Error: Connection timed out

Response: 00000000 (Incorrect response)

CMD24 (Output with patch):
==========================
test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 24 09B2FFFF
Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
Entering the do_mmc_commands:Device: /dev/mmcblk0 options[24, 09B2FFFF]
Forming CMD24
Sending CMD24: ARG[0x09b2ffff]
Error: Connection timed out

Response: 80000900
(Correct OUT_OF_RANGE response as per JEDEC specification)

CMD18 (Test Code Snippet):
==========================
        printf("Forming CMD%d\n", opt_idx);

        cmd.blksz = 512;
        cmd.blocks = 1;
        cmd.write_flag = 0;
        cmd.opcode = 18;
        //cmd.arg = atoi(argv[3]);
        cmd.arg = 0x09B2FFFF;

        cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;

        memset(data, 0, sizeof(__u8) * 512);
        mmc_ioc_cmd_set_data(cmd, data);

        printf("Sending CMD%d: ARG[0x%08x]\n", opt_idx, cmd.arg);
        if(ioctl(fd, MMC_IOC_CMD, &cmd)) {
                printf(" error ioctl \n");
                perror("Error");
        }

        printf("\nResponse: %08x\n", cmd.response[0]);

CMD18 (Output without patch):
=============================
test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 18 0x09B2FFF
Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
Entering the do_mmc_commands:Device: /dev/mmcblk0 options[18, 0x09B2FFF]
Forming CMD18
Sending CMD18: ARG[0x09b2ffff]
 error ioctl
Error: Connection timed out

Response: 00000000 (Incorrect response)

CMD18 (Output with patch):
==========================
test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 18 09B2FFFF
Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
Entering the do_mmc_commands:Device: /dev/mmcblk0 options[18, 09B2FFFF]
Forming CMD18
Sending CMD18: ARG[0x09b2ffff]
 error ioctl
Error: Connection timed out

Response: 80000900
(Correct OUT_OF_RANGE response as per JEDEC specification)

CMD25 (Test Code Snippet):
==========================
        printf("Forming CMD%d\n", opt_idx);
        cmd.opcode = 25;
        //cmd.arg = atoi(argv[3]);
        cmd.arg = 0x09B2FFFF;
        cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;

        cmd.blksz = 512;
        cmd.blocks = 1;
        cmd.write_flag = 1;

        memset(data, 0xA5, sizeof(__u8) * 512);
        mmc_ioc_cmd_set_data(cmd, data);

        printf("Sending CMD%d: ARG[0x%08x]\n", opt_idx, cmd.arg);
        if(ioctl(fd, MMC_IOC_CMD, &cmd)) {
                printf("\nerror ioctl\n");
                perror("Error");
        }

        printf("\nResponse: %08x\n", cmd.response[0]);

CMD25 (Output without patch):
=============================
test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 25 0x09B2FFF
Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
Entering the do_mmc_commands:Device: /dev/mmcblk0 options[25, 0x09B2FFF]
Forming CMD25
Sending CMD25: ARG[0x09b2ffff]

error ioctl
Error: Connection timed out

Response: 00000000 (Incorrect response)

CMD25 (Output with patch):
==========================
test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 25 09B2FFFF
Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
Entering the do_mmc_commands:Device: /dev/mmcblk0 options[25, 09B2FFFF]
Forming CMD25
Sending CMD25: ARG[0x09b2ffff]

error ioctl
Error: Connection timed out

Response: 80000900
(Correct OUT_OF_RANGE response as per JEDEC specification)

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v2:
  - Make commit message clearer by adding test cases as outputs

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

