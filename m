Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51016C4361A
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 17:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0248B22B40
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 17:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgLDRSp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 12:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgLDRSp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2020 12:18:45 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04667C0613D1
        for <linux-mmc@vger.kernel.org>; Fri,  4 Dec 2020 09:17:59 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id z1so7449689ljn.4
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2020 09:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ll5ceqpDB5AdmiQFATtP2DWHGOxrfl42uXcXhf76pqk=;
        b=xdGWAY0zvpDfyJTgs6/RnXCyaYqU4PutYcp33RY6VqcJwLk7gQMoH6e4uMop3GpyEZ
         Ewv1KBXzGIPDRAQI/qli28e7GuVAuk5BrpLQX8c7lIB5sVuek5NOV6ripxJR1HNuGtcM
         iC1ghHKxGJ0GUz1HaXnWUGAmDIxLwd4yWAMMaCWstChYe0LRHzANUjO3h+zARuYKY4jK
         IEEPQOORJFuCRKzDFDI6eEL5GWkRW2UR47J/PsnZlMin6QAawFw6BgnnUiJPmkNsrX4w
         92MkmIng19yUTsmMK57/Y+hWR1Mt+BxOFRDpLUyhxFAWQPZST7vjFqG0Fb6CSR8ajViJ
         EfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ll5ceqpDB5AdmiQFATtP2DWHGOxrfl42uXcXhf76pqk=;
        b=eMBHAE/PIH8pTNITb5hduQRs3+/LZCvau/s2rCkSPSbrloxdO+OE9epwi3gf5XEZR8
         a4ZVJ2EenvfFWEKzHO9VWLhvOa5gmDPBQar+4vFunWylkuYq6v7GCnry0cA3XI/ICy+j
         PxthMTPAQiNRpg+QAjdxavCfZcgLncdxRevqGCinuVXwLsmniYsG7ABALbvE1hSxLQHV
         jaV9lIj6nrxSTUhBgKad0RwqKqOzhYuNXlJcq4jBaC+P+G/vAidyWuE5nOq/zR0Tw8r9
         8D7mS+a3eFCzv9FK68iFhGT7udfHSIo8DoH+ceZLGV+cJ8+jI35whulYiK9pBTsE8t2r
         rE/w==
X-Gm-Message-State: AOAM532omssH39mH+GKE9xLd8qh2Z7RomqpLDhi4DENg0yvLlqHHXrHq
        2UsHKiDmzsTk1jU0VPYXMZ9T5g==
X-Google-Smtp-Source: ABdhPJzxsOJ3qEOb5WmcVd8vJ97fQ4sUK96p6qsU+5u1svoxfj3O0sS93J3LoY3K4K7mmmvrhbuYcQ==
X-Received: by 2002:a2e:9c8d:: with SMTP id x13mr3825747lji.468.1607102277264;
        Fri, 04 Dec 2020 09:17:57 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id w12sm1919802ljo.67.2020.12.04.09.17.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2020 09:17:56 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v4 0/4] sdhci-xenon ACPI support
Date:   Fri,  4 Dec 2020 18:16:22 +0100
Message-Id: <20201204171626.10935-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

The fourth version of the sdhci-xenon ACPI support
addresses a comment regarding clk handling in xenon_runtime_resume.

The MacchiatoBin firmware for testing can be obtained from:
https://drive.google.com/file/d/1Y8BhyaCrksQgT_GPfpqqiYHpQ41kP8Kp

Changelog:
v3->v4
  * [3/4] Call clk_prepare_enable unconditionally in xenon_runtime_resume.
  * Add Adrian's Acked-by to all patches.

v2->v3
  * [3/4] Call clk_disable_unprepare unconditionally.
  * Add Adrian's Acked-by to all patches.

v1->v2
  * Split single commit to 4
  * Use device_match_data and dedicated ACPI ID's per controller
    variant

Marcin Wojtas (4):
  mmc: sdhci-xenon: use match data for controllers variants
  mmc: sdhci-xenon: switch to device_* API
  mmc: sdhci-xenon: use clk only with DT
  mmc: sdhci-xenon: introduce ACPI support

 drivers/mmc/host/sdhci-xenon.h     | 12 ++-
 drivers/mmc/host/sdhci-xenon-phy.c | 40 +++++----
 drivers/mmc/host/sdhci-xenon.c     | 91 +++++++++++++-------
 3 files changed, 91 insertions(+), 52 deletions(-)

-- 
2.29.0

