Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81AFC43460
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 18:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF02460FE6
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 18:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhDASLJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbhDASBa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Apr 2021 14:01:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E02CC0610DF;
        Thu,  1 Apr 2021 05:43:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id l18so1787773edc.9;
        Thu, 01 Apr 2021 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCKXcpD1vJ5o2Go2fE0XaHwxmBn3kpY/Gm+6qhTOdVM=;
        b=ge2lo5JjUwpRBG0Td7gmhKs9YXEyeFhv7rg5xiE98kGP2sUzvXE2/VE2PoVLg+ZB71
         6koUxGQm9mqkCfvyV104rD+RlUa2WgximlVlOy31cFzZtgeiS7v7g26B+Lp7RIe6hCaY
         wfsouVUlEKjJeKd+xaaLfN0PGVLWVk8izGdFrP/1GuL/xHs2foOKv4E4o0kcgfSMBio7
         jXxv7Sh0t4kWfin8ccX/pWR+rQEK109xww40bJEncP3PcMmufijB7ZOt0KSVw46zTFD2
         j6YUmo/qNDgJ4ZzuoNWTWOuqJHFXPWkkG6RkQbV1PHwMTQKOokc6k7QGGUs2VUt55mG2
         9Iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCKXcpD1vJ5o2Go2fE0XaHwxmBn3kpY/Gm+6qhTOdVM=;
        b=OQ4yw42/CQgwYW39Kr/5OoMj+csmZysQqpCLxsLB8VwtZwIoRWp6U4KV1ueLLRzgN9
         WYwKuChMRwDMDJ21Pw/YqBdfBDLR3kQYsBw79is/PjVrlFo0bBBt8wXpQCjqPz0vvz7X
         ONJH8sDh6nJSpdKSE0JffMYowHffLhfGLAUqFAZ8hXAWKgmg1b7vHL0Xh1cCF/Jr1qrK
         hHBmO1yStBh3laxYuNDZb9k6J+sIf9GtCVLyS3oO/6p+dXaCZ6xNjGq25XGyHjzyg+Sm
         p+PApvxUsjVfUhKonRST9gqUhxgsEfLjDKKl9gFrNhNXCeAogJRi/TFFPvm6whoNL6bd
         nOdw==
X-Gm-Message-State: AOAM533OUgrLxQRDA2hnfS3CkMbrb9uShuIxQCVIozVKuvKHdARPqXmu
        wAmoj4NqRNyTQISuB1ISIzs=
X-Google-Smtp-Source: ABdhPJwsvkuX6LJ7+XJKF+vRR9FkrRfbyhV5VH9WU2vFPDSCSTkeg8fEmP0JKLe/Uo76Aqf6CnZCrQ==
X-Received: by 2002:aa7:cd0e:: with SMTP id b14mr9859581edw.354.1617281033250;
        Thu, 01 Apr 2021 05:43:53 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id v8sm3469939edq.76.2021.04.01.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 05:43:52 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v1 0/2] Tow minor changes of eMMC sanitize
Date:   Thu,  1 Apr 2021 14:43:41 +0200
Message-Id: <20210401124343.102915-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>


Bean Huo (2):
  mmc: core: Let sanitize timeout readable/writable via sysfs
  mmc: core: Let sanitize not retry in case of timeout/failure

 drivers/mmc/core/block.c   | 13 ++++---
 drivers/mmc/core/mmc.c     | 80 ++++++++++++++++++++++++++++----------
 drivers/mmc/core/mmc_ops.c | 20 +++++-----
 drivers/mmc/core/mmc_ops.h |  4 +-
 include/linux/mmc/card.h   |  1 +
 5 files changed, 81 insertions(+), 37 deletions(-)

-- 
2.25.1

