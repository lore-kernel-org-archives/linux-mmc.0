Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1704FC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Apr 2022 10:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348845AbiDZKah (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Apr 2022 06:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348787AbiDZKa2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2022 06:30:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB597CA0C7
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 03:06:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p10so31015589lfa.12
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 03:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=buYIEkZGtPXCru56pipwVvOC7qPXwxIaSSF1o4dnOTw=;
        b=Yq0f64tMeyHseF6dm+UJXJq7hpkxPmjktLmOek1YIupiKJeErQepBUX5G2Th2LxHOO
         uzoiDvKGVTwqxKrvoGQb6lwm7OW+rjw6C94CSyf46+wHIYqDCV55bOQVW8E3+PFLW+1h
         QdJwvzMCnQ64IHvntEx8HcmKWGnJk7phL3NKeTJfyBwbIupTy3cXmYZLIl7qFBn61lvD
         2W9EzmxLW7DptpCPA873KhdiIMx7Yq05LAt7hqDHTtYGmVNiZHxjULL/mhN50NCd8RJV
         sQwYfLVF10VNFh7UetbqXOdd5dTw9oaYgkupn8w/gWcC4l4ZRkxRaqx/zJZAyo7Q1Unv
         InAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=buYIEkZGtPXCru56pipwVvOC7qPXwxIaSSF1o4dnOTw=;
        b=mYUEScueehkzsMQBK8tUiV9+feSVPCv8UIdpHzw0zUFmwF3/hUzuvZXmU3WQ0Kj+FL
         d6mAlhRpfpADpfwYEydce+kxw/rxOvjP4DblmoZGdnU+BTS6Trneyo9B8v0/hnBqVUdT
         WtawmBhMu2/xb0/xHu7veshKSpy94z84sJAltKvrSb/28MA+7fLSE3NK1gf/atBRScnK
         pgqnhKSjAMN5+dM4m2rnRjOy3m/SFPcEIsHSyPaJq5K67L4i4VqI69wBoxoH5+ohxia0
         YHVSVT4ok2f9UmUKUrPgxnB3ivXidXcGwZTcPNoRmapd4jpYi4AwSlf1QXpRPAvsieJf
         mfIQ==
X-Gm-Message-State: AOAM530iJaT9zttiq0dUYn3vi0OQUfaumldd5twFIUc825WHvrJvZndp
        GLTFyw0ZugvAPspmF6v2BMxshpwygg1wQA==
X-Google-Smtp-Source: ABdhPJwc93M8oY2GAQslCyI361jrj0wG8f2KN+c4FnPjlqlo9hGxazLLBFk6gScweoS9hxa8fAEN4g==
X-Received: by 2002:a19:8c4b:0:b0:44a:b6a4:4873 with SMTP id i11-20020a198c4b000000b0044ab6a44873mr15960995lfj.549.1650967579535;
        Tue, 26 Apr 2022 03:06:19 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id j5-20020a2eb705000000b0024ee0f8ef8asm1486284ljo.79.2022.04.26.03.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 03:06:18 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Cc:     Ming Liu <liu.ming50@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc-utils: Fix build error MMC_BLOCK_MAJOR undeclared
Date:   Tue, 26 Apr 2022 12:06:05 +0200
Message-Id: <20220426100605.36019-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The reported build error:
In function read_extcsd: mmc_cmds.c:72:18: error: MMC_BLOCK_MAJOR
undeclared (first use in this function)

In commit 118dc4a0909f ("mmc-utils: Remove unused MMC_BLOCK_MAJOR") the
define for MMC_BLOCK_MAJOR was dropped. In a way this commit is still
correct, but unfortunately it also introduced a dependency to a commit for
the Linux kernel (83fc5dd57f86 mmc: fix compilation of user API), which
fixes the mmc uapi header file (mmc: fix compilation of user API).

Rather than relying on the commit in the kernel, let's include the missing
header for MMC_BLOCK_MAJOR.

Reported-by: Ming Liu <liu.ming50@gmail.com>
Fixes: 118dc4a0909f ("mmc-utils: Remove unused MMC_BLOCK_MAJOR")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 mmc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mmc.h b/mmc.h
index 25d6864..0796532 100644
--- a/mmc.h
+++ b/mmc.h
@@ -17,6 +17,7 @@
  * those modifications are Copyright (c) 2016 SanDisk Corp.
  */
 
+#include <linux/major.h>
 #include <linux/mmc/ioctl.h>
 
 /* From kernel linux/mmc/mmc.h */
-- 
2.25.1

