Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7C5C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Apr 2022 14:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351209AbiDLOFv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Apr 2022 10:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349415AbiDLOFn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2022 10:05:43 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB795DA54
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 07:03:25 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id c15so24173283ljr.9
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 07:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FI3i4DL+p93iGd73hc2Cm0m5a7s8/TNa00wTXMOU0ks=;
        b=OQPw9yReNLf2lc7yzrrKpiDe9z2AVUlCam5txQ55MrKIk5wszCeEXLAG1I2neQnt9E
         q6XnFpmEqgpj3wOuUT5uGeQ08UUqsth91qUH21CG+GL+v49D8mW7crB+WpLPwAJ+nFn7
         FK6cEVLX7wzs7V3TR3CuZ4HpiceFtGouak4rgaAQa0F6KqBgBYPsaMeFq++RulFl7Bm5
         PH0BkLvu2lTtD47RPL2+5IPIoHrW+WlWVcCiCb1UmlTKSh7X4h6lLE/OecbQR1KY+a/7
         g+gjdbZo7fa0EqyY4x/Ni9rxjQGcCVpjsUGJaq0uWqIGhqN1LbLWE4tC2yJdiG2Fw9Si
         /KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FI3i4DL+p93iGd73hc2Cm0m5a7s8/TNa00wTXMOU0ks=;
        b=NGy9Aq7SAQlL/T1Y9AcASPSXgMxCexfb7JNm5tnoo2wDgRZuSllMvhxcYaNqRHHS9/
         tWY+PrC/QySlX8LzHZc5tr9yx2BJSQuzHpl7fgiTkKW8clExSVGGT1OVTankZLbcOaZx
         Zh9GWCciiZ4ZWjAcJR59cGm3S6VT0Ivlh/uPYjFnw5CpNYwuAJpVHOfECTGF6a9ugkMh
         4T9xbKl7MQPSOzBfZAvsAXqlS4bchvcCNMOTsx/DAQhD/xwLmdz19f+Y4/GAgqfgEPuI
         elAI6EWzibrLVtDJjxMWDuhLGeq0P238QYQB+h69+h1EcdhdIXEuTt6kP9a6+aPAPX41
         g1LQ==
X-Gm-Message-State: AOAM530SRVn8RjNQV399gNr90otlxRxQ02y/QqSuCxmDWNCnBvCOur4S
        KD84XvAff9rDuaPetiPuHHjnmzHSfL711g==
X-Google-Smtp-Source: ABdhPJyubUVJUrOhIw8kv51qEIkiAvuz1zIpTdA+msFn254owgYvu7zFCTI486BMZBt75DgVGgmxqQ==
X-Received: by 2002:a2e:9241:0:b0:24b:63e8:1cd with SMTP id v1-20020a2e9241000000b0024b63e801cdmr6090530ljg.390.1649772202576;
        Tue, 12 Apr 2022 07:03:22 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:73a:37d6:817b:98fe:fa3c:58f3])
        by smtp.gmail.com with ESMTPSA id q10-20020a2eb4aa000000b0024b51c3467asm1316062ljm.53.2022.04.12.07.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 07:03:20 -0700 (PDT)
From:   liu.ming50@gmail.com
To:     linux-mmc@vger.kernel.org
Cc:     avri.altman@wdc.com, ulf.hansson@linaro.org,
        Ming Liu <liu.ming50@gmail.com>
Subject: [mmc-utils] [PATCH] Revert "mmc-utils: Remove unused MMC_BLOCK_MAJOR"
Date:   Tue, 12 Apr 2022 16:03:31 +0200
Message-Id: <20220412140331.1146516-1-liu.ming50@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ming Liu <liu.ming50@gmail.com>

This reverts commit 118dc4a0909f3413b6f8bd086cef43262e89dc2a.

A compiling error was observed without this reverting, as follows:
| mmc_cmds.c: In function 'read_extcsd':
| mmc_cmds.c:72:25: error: 'MMC_BLOCK_MAJOR' undeclared (first use in this function)
|    72 |         ret = ioctl(fd, MMC_IOC_CMD, &idata);
|       |                         ^~~~~~~~~~~
| mmc_cmds.c:72:25: note: each undeclared identifier is reported only once for each function it appears in
| mmc_cmds.c: In function 'write_extcsd_value':
| mmc_cmds.c:93:25: error: 'MMC_BLOCK_MAJOR' undeclared (first use in this function)
|    93 |         ret = ioctl(fd, MMC_IOC_CMD, &idata);
|       |                         ^~~~~~~~~~~
| mmc_cmds.c: In function 'send_status':
| mmc_cmds.c:110:25: error: 'MMC_BLOCK_MAJOR' undeclared (first use in this function)
|   110 |         ret = ioctl(fd, MMC_IOC_CMD, &idata);
|       |                         ^~~~~~~~~~~
| mmc_cmds.c: In function 'set_write_protect':
| mmc_cmds.c:148:25: error: 'MMC_BLOCK_MAJOR' undeclared (first use in this function)
|   148 |         ret = ioctl(fd, MMC_IOC_CMD, &idata);
|       |                         ^~~~~~~~~~~
| mmc_cmds.c: In function 'send_write_protect_type':
| mmc_cmds.c:172:25: error: 'MMC_BLOCK_MAJOR' undeclared (first use in this function)
|   172 |         ret = ioctl(fd, MMC_IOC_CMD, &idata);
|       |                         ^~~~~~~~~~~
| mmc_cmds.c: In function 'do_rpmb_op':
| mmc_cmds.c:2157:25: error: 'MMC_BLOCK_MAJOR' undeclared (first use in this function)
|  2157 |         err = ioctl(fd, MMC_IOC_MULTI_CMD, mioc);
|       |                         ^~~~~~~~~~~~~~~~~
| mmc_cmds.c: In function 'erase':
| mmc_cmds.c:2659:29: error: 'MMC_BLOCK_MAJOR' undeclared (first use in this function)
|  2659 |         ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
|       |                             ^~~~~~~~~~~~~~~~~
| mmc_cmds.c: In function 'do_ffu':
| mmc_cmds.c:2888:37: error: 'MMC_BLOCK_MAJOR' undeclared (first use in this function)
|  2888 |                 ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
|       |                                     ^~~~~~~~~~~~~~~~~
| make: *** [Makefile:36: mmc_cmds.o] Error 1
| make: *** Waiting for unfinished jobs....

Signed-off-by: Ming Liu <liu.ming50@gmail.com>
---
 mmc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mmc.h b/mmc.h
index 25d6864..193dfee 100644
--- a/mmc.h
+++ b/mmc.h
@@ -19,6 +19,9 @@
 
 #include <linux/mmc/ioctl.h>
 
+/* From kernel linux/major.h */
+#define MMC_BLOCK_MAJOR			179
+
 /* From kernel linux/mmc/mmc.h */
 #define MMC_SWITCH		6	/* ac	[31:0] See below	R1b */
 #define MMC_SEND_EXT_CSD	8	/* adtc				R1  */
-- 
2.25.1

