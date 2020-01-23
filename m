Return-Path: <SRS0=fUFB=3M=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475FAC2D0DB
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jan 2020 20:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170732077C
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jan 2020 20:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpKn2eY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgAWUDB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:03:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36796 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgAWUDB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jan 2020 15:03:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so5098429ljg.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jan 2020 12:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CE81ES9colZ9LJcYyttHbY8aVJS9UvEcbtX66gtyy2E=;
        b=GpKn2eY5BAIsAhvRiSFxr/3nfax0j9bVKB9I5iWZy7ejFawDE1lemjHYj3JnD4AYF7
         WpUf6HzI+kP7xUVkxHwTcBwQWMZ42MGNXd39pry40m8itYHdFFUdzB4XpzZ78vZxlne5
         pDoqfnWIUXoRXCypX6sLCxKnebUGKNET0TXzl+40ocecSorkdDvQG8iqQS1M6KcDadc1
         MNG2xHgQ2gxTm8X8fUa/xF5WSPF5UoEB9GnGGRn4QqFgiituOdzWzlgN6bcGGKN9o4dv
         5QNnhyuvO4ULL+Adw713vc60Z8aKMjIzmOXmrPnlUYTu4/6m3Nj24X10lbLBGzSLawSb
         +KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CE81ES9colZ9LJcYyttHbY8aVJS9UvEcbtX66gtyy2E=;
        b=dajKmsBcpCoutAhOVPfHiMfZ2GEJjWLnSIlEmR5pTAGB3TnTIluCWkaWW7LGnlLbJx
         5CaPBLl7tLhZjzz02KSkCsj/26kvRa2DGIyh4/L+d5XjwdzyTYfSHEg/vg9gDrBu2nyM
         mdqOZTGKYeFNnvixDbajIHp+Oo0aTIjFLfzru69iJhtv9ykz/YibasXO9BsT/fXsu5yT
         6655OcFjQ38PcYRGSIlqp3h2w2+mW2ai7uSsE6xLAVMQ6r7IjnyK79F3omY3g6Wj+kj3
         9t1hxHKZOpWd8nFyg/xcqg8kG2GDQsLvbW/ud9BlmaAsdZoHJQIKVPHd1hnKi/0D0JT0
         a0Rg==
X-Gm-Message-State: APjAAAVmnadlUXoOnBAziTW9s8agRhSIEMPNWMULF99ss7Q9bKC2iEQL
        m7+iw5Gsps8gzpk2mDidn86k2A==
X-Google-Smtp-Source: APXvYqxDTc65ooMHbFqtuMAsz5UFQtlLj/mJDMkAbA2hWYv59r7jxMC2Jq1ezf/icxiqcyjcqWBU1Q==
X-Received: by 2002:a2e:8197:: with SMTP id e23mr32501ljg.250.1579809779317;
        Thu, 23 Jan 2020 12:02:59 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id e8sm2112163ljb.45.2020.01.23.12.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 12:02:58 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.5-rc8
Date:   Thu, 23 Jan 2020 21:02:57 +0100
Message-Id: <20200123200257.17258-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.5-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f667216c5c7c967c3e568cdddefb51fe606bfe26:

  mmc: sdhci-of-esdhc: re-implement erratum A-009204 workaround (2019-12-19 08:13:43 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.5-rc2-2

for you to fetch changes up to 2a187d03352086e300daa2044051db00044cd171:

  mmc: sdhci: fix minimum clock rate for v3 controller (2020-01-20 10:36:27 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci: Fix minimum clock rate for v3 controllers
 - sdhci-tegra: Fix SDR50 tuning override
 - sdhci_am654: Fixup tuning issues and support for CQHCI
 - sdhci_am654: Remove wrong write protect flag

----------------------------------------------------------------
Faiz Abbas (3):
      mmc: sdhci_am654: Remove Inverted Write Protect flag
      mmc: sdhci_am654: Reset Command and Data line after tuning
      mmc: sdhci_am654: Fix Command Queuing in AM65x

Michał Mirosław (2):
      mmc: tegra: fix SDR50 tuning override
      mmc: sdhci: fix minimum clock rate for v3 controller

 drivers/mmc/host/sdhci-tegra.c |  2 +-
 drivers/mmc/host/sdhci.c       | 10 ++++----
 drivers/mmc/host/sdhci_am654.c | 54 +++++++++++++++++++++++++++---------------
 3 files changed, 42 insertions(+), 24 deletions(-)
