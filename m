Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D23C433B4
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 17:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B84D6112E
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 17:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhDAR65 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbhDAR4a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Apr 2021 13:56:30 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C425C08EA71;
        Thu,  1 Apr 2021 06:29:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id e14so2863555ejz.11;
        Thu, 01 Apr 2021 06:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u34nFRjLVwzysoOA/oy6vY5XOYz6wBKtkXwoLHEI8Dc=;
        b=fD4BXnL8Utz3VrJ53HF6sV2M7ZiBuilqEyXfsdlQoP/AV+Dkr8IEOf/FSWoQSGC8S9
         95VqChTQOP/qKBfVcFLvqcsErIf+ssLY9rXpuEmTdsRYAkUUqVi5cbXd+7uk8J21TmM2
         ST/gOGr0BU0+S/H70VDUbddQGj9Fz1p8d7wXwGxJlzsbeJvLelaO0KXlRdE35nEVsIX0
         jE+tyN4TvTmxQbt+Na9HvUoh26rlrweCrZ8m64JnG+MWF8eYuZI46ZFSbwEGlHwuiLxQ
         dm0MAnove+bhv0gnDEsJ9L1qmMQ1tbDRwWYe4Y8lvdM+SnJ3fh+PdlFC1vrA5VVGPXrQ
         HiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u34nFRjLVwzysoOA/oy6vY5XOYz6wBKtkXwoLHEI8Dc=;
        b=gZicxDO1BXjQoJC0gy42PLspboCYN5NDthp+Usx2xgwfGu1h3sWeUhTj/iZpLCUTtK
         QsYFom4LKPPft9Tb4bUKXQziWoxk5TaE1HP8HR9Kg1GohHjhHHhxHFantIwqb9tovY8b
         fn13iyDjDDy1EIXtm0lLat2ofOv+UpufDfjezXwERPpwgZGnh+gllgoZszhYidNxcdBe
         ldyaTl1X8KV/0MusOeE/TZVKtr5VKRO8Vuk9XuRqlluLoHwbAT25uHEqf/2hn4RhEbgV
         tyKImKT6K9N0XiGAD1UL/D1O9w3ryplEZB2mQwCS7nITLvJB6eYaoW55cfC7Aufkdrl8
         4rXw==
X-Gm-Message-State: AOAM5324eZm/6eCvkFSZv6/NhJJEAIr1lLEd2vPbIE6Kt8VUUAm1u230
        3ZVjZMZhXrEzReO6yR6Rq7o=
X-Google-Smtp-Source: ABdhPJxb/n/OZ7jxUTMWqVrYFw4Cc8aABK1/1OEZf4LxA85klG6rjrrAFRKo/aaSyR8X9OuOuwF59g==
X-Received: by 2002:a17:906:fcd2:: with SMTP id qx18mr8827914ejb.327.1617283743255;
        Thu, 01 Apr 2021 06:29:03 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id cf4sm3488399edb.19.2021.04.01.06.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 06:29:02 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v2 0/2] Tow minor changes of eMMC sanitize
Date:   Thu,  1 Apr 2021 15:28:51 +0200
Message-Id: <20210401132853.105448-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Changelog:

V1--V2:
   1. change wrong nouns in patch 1/2 commit message

Bean Huo (2):
  mmc: core: Let sanitize timeout readable/writable via sysfs
  mmc: core: Let sanitize not retry in case timeout

 drivers/mmc/core/block.c   | 13 +++---
 drivers/mmc/core/mmc.c     | 81 ++++++++++++++++++++++++++++----------
 drivers/mmc/core/mmc_ops.c | 20 +++++-----
 drivers/mmc/core/mmc_ops.h |  4 +-
 include/linux/mmc/card.h   |  1 +
 5 files changed, 82 insertions(+), 37 deletions(-)

-- 
2.25.1

