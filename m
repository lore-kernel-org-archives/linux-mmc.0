Return-Path: <SRS0=tDGl=5J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B73BC54FCF
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FE320719
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bf1+yGdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgCXSHo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:07:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33790 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbgCXSHo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2020 14:07:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id f20so3771849ljm.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2020 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPTlvoqZxYaSsWLUlKp85khmY6NurtsqQgDSkrG+7e0=;
        b=Bf1+yGdfLrsGJ6+JaogwSOUV0Vi7WwKZ+Cb5iYqxq+c0uY2CpetQ2VNbyVM+M8sWsK
         zL25zQ+xc7lTghUek8g6mbW/DmIGmav25OcsQfcV5SmnUiNK5x65gEa8twh29GqzUact
         jZxA6eyH0f2d6NVZKxi9GRRBahd0SC3JDEvZHDidgPV4/uZIp6GaY0kqVGYmDQRKe69F
         McC5nUKNjhXo/saS0Dl3uHzLSUGdkRbE4naEAnbQTcamZXkueeNRI5bzbpkgCsFFVWYu
         FBp9JmCCBqOXtA98yBgB/btHPGrO7C8vAlatAXtd131puXJtWynZF7WmA26mmtYpGp5F
         NhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPTlvoqZxYaSsWLUlKp85khmY6NurtsqQgDSkrG+7e0=;
        b=gofIdQ/4Yc1G02byPkzEv0Mk2ivfni9kN9C2dhar2XOetRocSf31dHdnP4T5xx3v6e
         Z6ZEOiS31DJ5JchVaCeHvENt8/L54+68TwkcVnw2Ont1/ciakiesNKksaJVQoRtV9pi4
         FXQONup+FLbN2SbLtCVWEHMV0f+2WbQdCqWp6rsgFLb9DiXWXfWJUCbliHUXeHXhveQb
         e/BQfnP6oQn56OmtWeyDuOBfinsoiafrBr54WHzKiNZ7D1/jyq4T72KIcMtoouplhg6T
         2CEj8IlbXU+4AR0/hNYn6BkLcaZauI8mBqRLW4Snx7mnqTuetRyq1BmYzFi3+8QcF5Gg
         fBiw==
X-Gm-Message-State: ANhLgQ3sv6pHS8ufb3G9e9HCb773mKvTOR48PSTf2YFdFp7P5k1fTNJj
        053Ki/6QBHhT6XKX8rr9v2tQmA==
X-Google-Smtp-Source: ADFU+vsmiqtQhBKMKWssgrrK/lWoNR93iW5uPXpAPArpqGQeeABNK4dyIrGfgUB3Yob+0jpdRC3cVw==
X-Received: by 2002:a2e:8608:: with SMTP id a8mr17888175lji.59.1585073262792;
        Tue, 24 Mar 2020 11:07:42 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 3sm12113809ljq.18.2020.03.24.11.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:07:42 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH 5.4.28 0/5] mmc: Fix some busy detect problems
Date:   Tue, 24 Mar 2020 19:07:33 +0100
Message-Id: <20200324180738.28892-1-ulf.hansson@linaro.org>
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

