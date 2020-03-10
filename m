Return-Path: <SRS0=AZQG=43=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02059C10F27
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 15:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1D2215A4
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 15:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wb8KLpem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgCJPdt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:33:49 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:35017 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgCJPdt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Mar 2020 11:33:49 -0400
Received: by mail-lj1-f173.google.com with SMTP id u12so10445656ljo.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2020 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SfzE4jRtNpXlK2zcVo4+x24MTpsQQGPfGgY331EDlm4=;
        b=Wb8KLpemWL6aZKZIvd5drXop5eVrNoye/DWGMSflGGiYkGqu1qxTjZAXE1DfDSEges
         ZxDzle+f+T0eNqLspGsmwZksY1CSB6axTaq69BgZYPpUQoiXllQ3nmoI89O9N6YYBQVi
         CiVIGtXaalg3F/U59zMSP0PamcWXyYllekkFnHqu6GnEgviqQ+TrftzvP/o01W5ZqRdn
         TrUOiwKPya58MRF5A/OPXmb+8xQeW/+TJqGE+5tN/1SJKB46cncKDP1r90lLEhVpDYaF
         gugHPYRRFsmErqkaCgsiM5AD1bhBh27DuDDqxK9ZvMqoEy3S2ADDfCTPBXn/TzEmo+2h
         GZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SfzE4jRtNpXlK2zcVo4+x24MTpsQQGPfGgY331EDlm4=;
        b=FTOCoSR7M0MEcBy6LW3HIhJZzHN0oOJQDZc5pJRP3vwRGzCpNcy4gsyeJsVMKGoR+Y
         cCTzIlO35YsFOQ8DEkyfS+c7rPTzAqg4hAZEj7PGnew7eQ/oMsqyHQHQuzaDrHID1Jsi
         KjoX7WlrmORzfJLQcAl5yvbGgTJPKes8OId9PCKHS8d1Oaz3to9GRmEk7RcapBt85Mji
         3vbZ7yEbwxenDwjw3XGd2ASX7ji+KBEe/RsmjSMpiBnw6rh7dcgeC+fWjFGQ+NA4M0D7
         FKY65oxL9qmwG4sN44tQe+vBkqjrJIo6LZaK10nTXv5FdWLeWHIsLTGDDSvGFQvccoUA
         oeXg==
X-Gm-Message-State: ANhLgQ3RBBxhs4HC8StqG8+1MgJvREblhI26sQvrrL9JkoXNZu3VD9tK
        MOYX1CwIwWdxX0pJmOr3bgWMFxub2lI=
X-Google-Smtp-Source: ADFU+vtpyt0K8reug2l0vZQdbhE69a7PbIK3nSqOBLf1ny+S+rEJu4Qxo352IE0xLKVAgWE+VCL5GA==
X-Received: by 2002:a2e:960b:: with SMTP id v11mr12948786ljh.115.1583854425673;
        Tue, 10 Mar 2020 08:33:45 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id c22sm17283776lfi.41.2020.03.10.08.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 08:33:44 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl,
        Bitan Biswas <bbiswas@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 0/4] mmc: Fix busy detection timeouts for some SDHCI variant
Date:   Tue, 10 Mar 2020 16:33:36 +0100
Message-Id: <20200310153340.5593-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The mmc core may decide (for CMD6 and erase/trim/discard operations) to convert
from using an R1B response into using an R1 response, in cases when the needed
busy timeout exceeds the host's maximum supported HW max_busy_timeout. The core
does this to prevent the host from doing HW busy detection and instead rely on
polling, as to cope with the needed busy timeout.

However, it has turned out that some SDHCI variants (tegra, omap), really
requires R1B for all commands that have this response associated with them. This
became especially obvious when commit 24ed3bd01d6a ("mmc: core: Specify timeouts
for BKOPS and CACHE_FLUSH for eMMC") (and a few other commits on top) got
introduced in v5.6-rc1, as several people reported errors (thanks!). More
precisely, the mentioned commit triggered the existing problems described above
in the SDHCI variant drivers, when an eMMC cache flush command (CMD6) was
issued.

This series fixes these problems, but the changes are also targeted for stable
releases as the problems have existed since a long time back.

Please help out in testing this!

Kind regards
Ulf Hansson


Ulf Hansson (4):
  mmc: core: Allow host controllers to require R1B for CMD6
  mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for erase/trim/discard
  mmc: sdhci-omap: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
  mmc: sdhci-tegra: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY

 drivers/mmc/core/core.c        | 5 ++++-
 drivers/mmc/core/mmc_ops.c     | 6 ++++--
 drivers/mmc/host/sdhci-omap.c  | 3 +++
 drivers/mmc/host/sdhci-tegra.c | 3 +++
 include/linux/mmc/host.h       | 1 +
 5 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.20.1

