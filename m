Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC67BC07E95
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jul 2021 05:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C052611C1
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jul 2021 05:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhGMFhx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jul 2021 01:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhGMFhw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jul 2021 01:37:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE9CC0613DD;
        Mon, 12 Jul 2021 22:35:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso736583pjc.0;
        Mon, 12 Jul 2021 22:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=656y0SKEsy91nowxlCSTTz6ISrr5oJXdnBWsOy7Nsr8=;
        b=nlDvi2MGKgJeL5t0xES8danv7/BM6DypzHg0eCGgt5SllNYZRGNBj1nqE65IuPl4rz
         bJG5UyTZB+xtQWoQsT5Ctge07azgaXGi7weWWAdb5hfnjh1c6B3Q53/dWYLh/VL63VZq
         V7AOzZvu5sLLizTX8pkG8PR6ouXIOelIQFjc4tjljZP3Jaxbd9ZApVfPpg9dj1Bh3mqU
         D7shlZix/loS84G/KP10dkyBebNpdug/ReDF0NJZqXTxI2fafBQuaOD0qsAl5Pybc8gR
         2hcuDsxiEx/4D4zkWgnWJrlW7mVmiQNCDWcMQh4pysgLT2l8Id+CjcEDPVmRq7CmL7sk
         8wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=656y0SKEsy91nowxlCSTTz6ISrr5oJXdnBWsOy7Nsr8=;
        b=ezodV9oTbY2FED72XJup6C9Os+8WgSrJ4qiBVaeUazu1nnShqqXjykpOnkFbjk4pvX
         QySV3QefgNu7xSuXvH+sJdifY/ZFHi4ErjHx8e7NyW70GBK6Xq6P5Uaz/Iaqxo/B9YrK
         Qrr7/smi4GTX6o3TmOgDOq8dqpprK1u1/wHmu55fNW6CEUcw4qku7T4AvpIB2GnlkIEJ
         tp5wFi+moG9/n77QHXVg8Re+9gmYh2981pKCV3o7mVpDJuFcgwT14K4mCDE9yD92qqMZ
         TMYOQWc/E8JOaE+uEho39TMGEubraQTeeCfzIC3XbWXJ8gtho31bhmeacVsk3MA6/vEG
         vpBQ==
X-Gm-Message-State: AOAM531R9DMBZXpeGeUxAC2Wwdy7r/FoF1mMLkUcrUGsyCPTeisFSm3h
        rfYvokBVnocl3MVn5JuLm30=
X-Google-Smtp-Source: ABdhPJzXwmnO5r9arR/SE1wfye8TnYN828QMIhq+WED3DbfkhIGM3nIlAbD6A+Ht3YUCcaVPwv44kA==
X-Received: by 2002:a17:902:b210:b029:11a:bf7b:1a83 with SMTP id t16-20020a170902b210b029011abf7b1a83mr2183268plr.84.1626154500899;
        Mon, 12 Jul 2021 22:35:00 -0700 (PDT)
Received: from KSAKATA-T470.us.oracle.com ([161.97.199.233])
        by smtp.gmail.com with ESMTPSA id q3sm17691295pfj.89.2021.07.12.22.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 22:35:00 -0700 (PDT)
From:   oracleks043021@gmail.com
To:     beanhuo@micron.com, kenny.gibbons@oracle.com,
        kimito.sakata@oracle.com, rkamdar@micron.com, chris@printf.net,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] mmc-utils: Fix for Firmware Version string printing
Date:   Mon, 12 Jul 2021 23:34:58 -0600
Message-Id: <20210713053458.1441-1-oracleks043021@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Kimito Sakata <kimito.sakata@oracle.com>

Added a local buffer to create a NULL terminated string to print the
Firmware Version instead of attempting to print directly from
ext_csd buffer. The last byte of the Firmware Version field may not
be NULL and the next field may also not be which may cause it to
print garbage.

Tested on x86 platform.
---
 mmc_cmds.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index afa85b7..205e6e5 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1392,6 +1392,7 @@ int do_read_extcsd(int nargs, char **argv)
 	__u32 regl;
 	int fd, ret;
 	char *device;
+	char lbuf[10];
 	const char *str;
 
 	if (nargs != 2) {
@@ -1833,8 +1834,9 @@ int do_read_extcsd(int nargs, char **argv)
 	}
 
 	if (ext_csd_rev >= 7) {
-		printf("eMMC Firmware Version: %s\n",
-			(char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
+                memset(lbuf, 0, sizeof(lbuf));
+		strncpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
+		printf("eMMC Firmware Version: %s\n", lbuf);
 		printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
 		printf("eMMC Life Time Estimation B [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
-- 
2.31.1

