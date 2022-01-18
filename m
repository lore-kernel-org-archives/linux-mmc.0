Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18246C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Jan 2022 12:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiARMoE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiARMoD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jan 2022 07:44:03 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828B1C061574
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jan 2022 04:44:03 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i17so12928609pfk.11
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jan 2022 04:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JcNjekrqs4DZb50/wOTQ0e34O8QEui9GsDVW2ggaJRw=;
        b=UIDcqQTtrlN3/WTfo/9+FOzTfnDxJhoWKu5CUTDk2It7g8Y6Mq65blQMshpq5pBUAe
         dIYvHACtdX/MaOtJh2k2JliCSMysVY9GPleesC9aJ4o1g2vfp6+vhoLgMyXI4vQ6lsjf
         UqqoIR8eOEsGpeKMTuHtHb9IFaeDPcgN9HXk0m9b+9a3doPwZA1f6PFi5BXETxHw4Y1o
         lTxJvJtamDU/14/+jFrKbT/l/JK4r6GHWRbXE/AvUjWDXwT8Fsyvmoakyxn9/ysiUdzd
         op9bEkMliIjprhFGlL8h0qAWasFfBR6zPpUM1T/QXSed2znTe/RKuukXgJU8qsvlkAbz
         Z8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JcNjekrqs4DZb50/wOTQ0e34O8QEui9GsDVW2ggaJRw=;
        b=o1oBJTRKRs4cCZmhIUVbflyybJ4j7WrnQLOc1kwA/r1gaqhP/zeyC68DecA2PLwijj
         ArZA+ZgFo2kDPh+EWY9VKSOlWE9B7IsOA44t2m1o8ftv9E7BeHSB0F7GA7RZZChVuzXn
         t/ZC8bbICNp2gZlOjuKhCdtZ2apdPB2EegalCQNL1MeDSAiqBPW50aCPIoyQUapHkiEv
         BDZ9jS702pinPd/lxU56SgAH83OPG5Na6rl82tRn2e5kqApEh6CJdqmibN8mgTN6nroL
         wbScdHa2KbZi/0iEnL/Kl+ro2e1j/WbdylXQLz7iyLeNxBK7TfWa0oBQ/6ubbnAxOKzT
         43HA==
X-Gm-Message-State: AOAM530Kd/j4SH0esidZdtntcyhTilSSBMZ+ne3jANV9/WHALNic6hnx
        JMApamiq8mQoeGNsu6HGtVCXyt104WcI5g==
X-Google-Smtp-Source: ABdhPJwKixl/G1xrJENMLV9RwsNrqkGDKwsLv1IVYX/IMsuMFEXcg2Ulr8sqY57VAVnAV/7lkhqOHw==
X-Received: by 2002:a65:6ab8:: with SMTP id x24mr23015764pgu.50.1642509843063;
        Tue, 18 Jan 2022 04:44:03 -0800 (PST)
Received: from jason-z170xgaming7.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id n10sm362005pfj.120.2022.01.18.04.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 04:44:02 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        otis.wu@genesyslogic.com.tw,
        Jason Lai <jasonlai.genesyslogic@gmail.com>
Subject: [PATCH v2 0/7] Preparations to support SD UHS-II cards
Date:   Tue, 18 Jan 2022 20:43:48 +0800
Message-Id: <20220118124355.167552-1-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Series [1] that has been posted by Ulf Hansson which provided some guidance
and an overall structure.

Series [2] focused on UHS-II card control side to address Ulf's intention
regarding to "modularising" sd_uhs2.c.

Series [3] is based on series [2] and adopt most of Ulf's comments.

This series is the successor version of post [3], which adopts Ulf's
comments about series [3]:
1. Remove unnecessary debug print.
2. Rephrase description about uhs2_cmd_assemble() in sd_uhs2.c
3. Place UHS-II variables in the appropriate structure.
4. Integrate 5 callback functions in host->uhs2_host_operation().

Kind regards
Jason Lai

[1]
https://patchwork.kernel.org/project/linux-mmc/list/?series=438509

[2]
https://patchwork.kernel.org/project/linux-mmc/list/?series=539737

[3]
https://patchwork.kernel.org/project/linux-mmc/list/?series=589827

Jason Lai (3):
  mmc: add UHS-II related definitions in headers
  mmc: Implement content of UHS-II card initialization functions
  mmc: core: Support UHS-II card access

Ulf Hansson (4):
  mmc: core: Cleanup printing of speed mode at card insertion
  mmc: core: Prepare to support SD UHS-II cards
  mmc: core: Announce successful insertion of an SD UHS-II card
  mmc: core: Extend support for mmc regulators with a vqmmc2

 drivers/mmc/core/Makefile    |    2 +-
 drivers/mmc/core/bus.c       |   38 +-
 drivers/mmc/core/core.c      |   43 +-
 drivers/mmc/core/core.h      |    1 +
 drivers/mmc/core/host.h      |    4 +
 drivers/mmc/core/regulator.c |   34 ++
 drivers/mmc/core/sd_uhs2.c   | 1113 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h     |   35 ++
 include/linux/mmc/core.h     |    1 +
 include/linux/mmc/host.h     |   68 +++
 10 files changed, 1319 insertions(+), 20 deletions(-)
 create mode 100644 drivers/mmc/core/sd_uhs2.c

-- 
2.34.0

