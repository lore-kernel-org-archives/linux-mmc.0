Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB7EC3F2D1
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 07:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA6A2166E
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 07:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJEz6AJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgCDHmX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:42:23 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38043 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbgCDHmW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 02:42:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so585825pgh.5;
        Tue, 03 Mar 2020 23:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CCrrlatLGe2pch85eka5KdA5M3nlY74sUhCA0YXJUZE=;
        b=GJEz6AJb/KHRv9csq+7DgHrOWlhG5OHcKer3cBUjJEe/j5EBdcEFxbfthHuzJQtyg0
         qBnsLuR8W/oV84NVivKrsGNTW1dP/CcjGyfCb2a2pTUIdK8nkGVmD3176rf01oQVW+wB
         U9rJTMwK0sFfdtXe9nYOOozN5o9S+i/47xfYRWm1XXdvNYi/tB1yPRUNBr9vgLJDSxi0
         JTqTz7rfmIvhlvYE4hfsaEbDoSkd4zVvbeYrszWGOb2SLr3PB1CYJCJwLrwfSmrMqiGu
         CucAWKSOc40584s5BEW6c2XrbaY4E/Z9eFVbrheqTvo+l+n1EghGyFMA89MHooD63sM1
         0wWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CCrrlatLGe2pch85eka5KdA5M3nlY74sUhCA0YXJUZE=;
        b=YU1ZS61Hx99uMJcxYSeOe7C8tBGlIAb2QrcFbS76Jn7TwDAeDDIsYm7FE5VMmGKDhe
         ziufDb71dTucpAocOZ8L9gps4ex1eTTcH4nLZ5ZTDuFvb5NRoMwdIshzIxYzwGzLTFM7
         WR5jd6atLYt3zJcXrzVbz+mWaZnSM8NmJVtE2Tojw1J/IMsJ1wgzIzrMmM3D40eixEBd
         /ncNgvX4WdkdOtLmEUvWsnIfWBW7vkgPyhVCUVBRlXO+puA7RfY7V6FbaxogzFA6IHtY
         IVcmWEIrqcfV4Ga6KureNSM21W6hL+NmdOoce0UxIxeZ8wGRXb9oviF7pSFqJuX54Ur8
         Ib0A==
X-Gm-Message-State: ANhLgQ0zSPpCqeCIWZHj4/S3oL9Vr1wqybIyKz1vh7ShHZSCjGK9N/jR
        oJj3fC3dq7LGiRVFbIzge6s=
X-Google-Smtp-Source: ADFU+vu5fZuXu66R5s8Y3mLio5TM8/kNc5DuVeYxvMEYhsmQWENep4y6myvf8QCC/HM/JRRuN0JBKw==
X-Received: by 2002:a62:e217:: with SMTP id a23mr1908057pfi.50.1583307740276;
        Tue, 03 Mar 2020 23:42:20 -0800 (PST)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k24sm24097374pgm.61.2020.03.03.23.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Mar 2020 23:42:19 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/3] Introduce the request_atomic() for the host
Date:   Wed,  4 Mar 2020 15:41:59 +0800
Message-Id: <cover.1583307441.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch set introduces a new request_atomic() interface for the
MMC host controller, which is used to submit a request to host in
the atomic context, such as in the irq hard handler, to reduce the
request latency.

Any comments are welcome. Thanks.

Baolin Wang (3):
  mmc: host: Introduce the request_atomic() for the host
  mmc: host: sdhci-sprd: Implement the request_atomic() API
  mmc: host: hsq: Support request_atomic() API

 drivers/mmc/host/mmc_hsq.c    |  5 ++++-
 drivers/mmc/host/sdhci-sprd.c | 28 ++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci.c      | 27 +++++++++++++++++++--------
 drivers/mmc/host/sdhci.h      |  1 +
 include/linux/mmc/host.h      |  3 +++
 5 files changed, 53 insertions(+), 11 deletions(-)

-- 
1.9.1

