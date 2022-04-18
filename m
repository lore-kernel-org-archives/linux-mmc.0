Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B50C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Apr 2022 11:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbiDRMBT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Apr 2022 08:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiDRMBS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2022 08:01:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878BC1A800
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2022 04:58:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so351699pjf.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2022 04:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ijizZXHckJyY8byLZcyK/JgZoQnnrWvDKOblHUIK4F4=;
        b=M+yxBY4DCGA7bx9IJIM/oe+ZVEcjgYl6eFoO4izdUklnqi/Td//mMA2EN24H8dYoVe
         /eaFiuB2H5oMoRQrk1j5sVxm0wj5ErTf+EHG3XKmvknVA50xg/UQTxoGhvvFJxskUh/P
         kDwfFeA43bqiaIhtrze26B+N5iFVq5j0Wn3emvo57+Nbj0Y1pkhfl6mKGw7myI+WkBhS
         5EVhethoy+urLcHMXgOUpGV4keCPW/njyzWcXm+xyZoE9ZY+jL1WsRdtdVwfrf8EUNLA
         w6TQk8zxyimi9m0l8zV2a1e+5IWShpTByOLPT4R9IQHgdTBej/RjviBlAoTNrgu0HaEp
         QNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ijizZXHckJyY8byLZcyK/JgZoQnnrWvDKOblHUIK4F4=;
        b=MorLtG8JYU5XsI1oaxVo44lvQq1nScMIFSWg381nlt7YVTofapYAkrmQwcFs7yTpYc
         YxhKZY68HYUOhgkXH8S8FunOnKT2AJAY3X+roPhIwsFKJSI3ffc8D8GdTCMqFLXmm/Fr
         Yy8sbANNvKA/hTlPRf1chjRbtMINK1Rs+gkgAyHZnU99SmneEoVYuPUTpX/RPRQirw9D
         +i8O69c8z1x+tEjuNZPsgj9NMciBsD/k8vhf6uF30t18iOUt/giTv0DQJEgyUSNnl+nj
         C+7hh3iLKUZp/ed6RI8GwgJ+r8R+SZlIV4M9CL3N7dPd0UiK2rom84FsanssWK2zwxE6
         y69Q==
X-Gm-Message-State: AOAM532eIg992l/FGq6i50bds1KwhfhRWggvdT/SdY1vkRPLb7lZN9BU
        ey9H7vcNSreLewv321SHrIo=
X-Google-Smtp-Source: ABdhPJwArX4BSCfGnm0WS0ub5j6SMgKqb9COKWqDcpKTkaxj18hL4XNpIlRIP01GByn5NUaLjGfFQw==
X-Received: by 2002:a17:90b:3ecd:b0:1d1:7733:a125 with SMTP id rm13-20020a17090b3ecd00b001d17733a125mr14589817pjb.184.1650283119041;
        Mon, 18 Apr 2022 04:58:39 -0700 (PDT)
Received: from jason-z170xgaming7.genesyslogic.com.tw ([122.146.30.3])
        by smtp.gmail.com with ESMTPSA id u206-20020a6279d7000000b00505fdc42bf9sm12409749pfc.101.2022.04.18.04.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 04:58:38 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, dlunev@chromium.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        Tim.Hsieh@genesyslogic.com.tw
Subject: [PATCH V4 0/6] Preparations to support SD UHS-II cards
Date:   Mon, 18 Apr 2022 19:58:27 +0800
Message-Id: <20220418115833.10738-1-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Series [1] that has been posted by Ulf Hansson which provided some
 guidance and an overall structure.

Series [2] focused on UHS-II card control side to address Ulf's intention
 regarding to "modularising" sd_uhs2.c.

Series [3] is based on series [2] and adopt most of Ulf's comments.

Series [4] is based on series [3] and refined by Ulf Hanssion.

This series is the successor version of post [4], which is base on Ulf's
 "wip_uhs_v3" branch:
  1. Implement call back functions in sd_uhs2_ops.
  2. Adopt Ulf's comments for V3.

[1]
https://patchwork.kernel.org/project/linux-mmc/list/?series=438509

[2]
https://patchwork.kernel.org/project/linux-mmc/list/?series=589827

[3]
https://patchwork.kernel.org/project/linux-mmc/list/?series=606241

[4]
https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/log/?h=
wip_uhs_v3

Jason Lai (2):
  mmc: core: Add definitions for SD UHS-II cards
  mmc:core: Support UHS-II card control and access

Ulf Hansson (4):
  mmc: core: Cleanup printing of speed mode at card insertion
  mmc: core: Prepare to support SD UHS-II cards
  mmc: core: Announce successful insertion of an SD UHS-II card
  mmc: core: Extend support for mmc regulators with a vqmmc2

 drivers/mmc/core/Makefile    |    2 +-
 drivers/mmc/core/block.c     |    5 +-
 drivers/mmc/core/bus.c       |   38 +-
 drivers/mmc/core/core.c      |   33 +-
 drivers/mmc/core/core.h      |    1 +
 drivers/mmc/core/host.h      |    4 +
 drivers/mmc/core/mmc_ops.c   |   24 +-
 drivers/mmc/core/mmc_ops.h   |    1 +
 drivers/mmc/core/regulator.c |   34 +
 drivers/mmc/core/sd.c        |   11 +-
 drivers/mmc/core/sd.h        |    3 +
 drivers/mmc/core/sd_ops.c    |    9 +
 drivers/mmc/core/sd_ops.h    |    3 +
 drivers/mmc/core/sd_uhs2.c   | 1377 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h     |   47 ++
 include/linux/mmc/core.h     |   13 +
 include/linux/mmc/host.h     |   83 ++
 include/linux/mmc/sd_uhs2.h  |  263 +++++++
 18 files changed, 1916 insertions(+), 35 deletions(-)
 create mode 100644 drivers/mmc/core/sd_uhs2.c
 create mode 100644 include/linux/mmc/sd_uhs2.h

-- 
2.35.1

