Return-Path: <SRS0=tDGl=5J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B822C43331
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6203620775
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+JGXSE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgCXSIG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:08:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34146 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgCXSIF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2020 14:08:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id e7so5065784lfq.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2020 11:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPTlvoqZxYaSsWLUlKp85khmY6NurtsqQgDSkrG+7e0=;
        b=I+JGXSE88YxvsPtUKlKF1MiO+8fi4bFqL2WOW/yPYvRT9cwEQS/37Jp5hl/fgqFuDE
         UHodP3Xk1fMPjkkc+Yi5H571MGWc3aQc7T2L6MCiz5Nv1Z/M7XVm4Kfu6gxEc8gO07X1
         ny1uaJlnI+jh06WKE/D5LPTI782s2+FJjqOpjfRSXYuSSWEgDHqjOuG4HEFyZt4Eb5ba
         2VC5qBgCGmp9T57tVzVu9lSvkp9DqWzArXOpoEAxuLlShW52X7wgpjjUleBqVzS4FV4f
         KyXUrn86dd2Y7dbFzGed6V9PcIURvkf74tMmCoULwyd2XgVtt9mWtdjU8sSmRcry0Bhv
         muFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPTlvoqZxYaSsWLUlKp85khmY6NurtsqQgDSkrG+7e0=;
        b=mUKhW868fW/BFN928wQlqtBOO2dXnqC7swSpH0r2YXfA4QgdYuUAF6/0cxp+Xa2QfK
         GfCni1dSc5lcMMZrQg4xD1KulJKI6jMQrVIBOveR0RNDMSrfjZwA7LVYoRwtn2OXE/yI
         1xNgE5+hllj5tK+j+xLDXQdKlOnXRNNfRXXECg7H6RoQt9yVBZ/QQduN7vRG2Q09rTGr
         xmTCkvcmWKOGmO7JgD5RiUPts6iTCofa3c35y4at8GU/3pEeniAB3ZZQ3KcMU7XzD3u0
         /L4HoXygwCV8qlO0nDvR9gDS3hJavjqWCIJCsgcfxmc6iXKge5ZYUBiwYyetF+uveizH
         VIdA==
X-Gm-Message-State: ANhLgQ0U4L5FlSq8JnQ+akjp9rsR6lUoCKTuVAYy3zNNXkyjIpl+e50T
        5wLHeGqndQFONS5YmgU7rqvFrQ==
X-Google-Smtp-Source: ADFU+vvwI3tniNorQxIU8Y/4s10YAbQxIuBl20Dl6KNeWPiFC7CtWz4MoGatq0qFp+/aAPq7i3z+0w==
X-Received: by 2002:a19:be94:: with SMTP id o142mr10246761lff.13.1585073283419;
        Tue, 24 Mar 2020 11:08:03 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id s10sm11029858ljp.87.2020.03.24.11.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:08:02 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH 4.19.113 0/5] mmc: Fix some busy detect problems
Date:   Tue, 24 Mar 2020 19:07:55 +0100
Message-Id: <20200324180800.28953-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series provides a couple of manually backported mmc changes that fixes some
busy detect issues, for a couple of mmc host drivers (sdhci-tegra|omap).

Ulf Hansson (5):
  mmc: core: Allow host controllers to require R1B for CMD6
  mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for erase/trim/discard
  mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for eMMC sleep command
  mmc: sdhci-omap: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
  mmc: sdhci-tegra: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY

 drivers/mmc/core/core.c        | 5 ++++-
 drivers/mmc/core/mmc.c         | 7 +++++--
 drivers/mmc/core/mmc_ops.c     | 8 +++++---
 drivers/mmc/host/sdhci-omap.c  | 3 +++
 drivers/mmc/host/sdhci-tegra.c | 3 +++
 include/linux/mmc/host.h       | 1 +
 6 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.20.1

