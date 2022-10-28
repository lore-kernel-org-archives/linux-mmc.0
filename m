Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1135FFA3741
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Oct 2022 22:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJ1W5I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Oct 2022 18:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiJ1W4o (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Oct 2022 18:56:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C00E22E0CC
        for <linux-mmc@vger.kernel.org>; Fri, 28 Oct 2022 15:56:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so5756335pjd.4
        for <linux-mmc@vger.kernel.org>; Fri, 28 Oct 2022 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rzSJgKy5DjDXCyAQwtZ/P57gLVTMALzGk3IGcvzcMzw=;
        b=UjNUyP9zPuD187EGRc7XI956s4WuAYRtR1UbWLr8aTyWMm4IEloDh5HMwjKboxiqg7
         DyockKVKwkIubAf89tNR3SbG3ChSdknkf0LghBIi/IJVPQ8KcLXcQa/iPA8FQHkJ2nL3
         dzuTWMl76ElEAJ5ozjRq8caid2tWQVZNXwYRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzSJgKy5DjDXCyAQwtZ/P57gLVTMALzGk3IGcvzcMzw=;
        b=8EkpcV4pVuS8ho+aJhHRtXzlg4m7ElbEhKTmh2+g3ppr8ZAzkTGeOU/EsfId+Xg+gu
         13fFE0QWQMDWOC03spKQ6Mcg2v7waPI/HmqEf1ildj7zhF3It+w5lZ0CQYTR0cNN3Bzb
         Hz/TJJYj7LxQgO370xaTdRVHwhZTPXh9iIe/G6qaS9bGUXohCRGtZvVme3tgNlpnXutv
         E+jjjgV4zn0OR0ZGrVBGuuSviAhC6xDR54UCrDjgXC+cvtYrz0Br0n5m05ifRqTAS8bl
         n/Kbcg/mVs/J5DTddYjByTXOcqLcRjOzgz55ABc2I0Vxfi4kqpH8ipixL4ocDw/cne9N
         hCKQ==
X-Gm-Message-State: ACrzQf0OurBaAjGqliQtGiX6VQbhJz7oA/FOcYhyFfjlQg1a2NhoSCmB
        40fwCak6f1ZqfI6tc3QtCw/YJA==
X-Google-Smtp-Source: AMsMyM4s+tgLT5YHN+KRfu/cEyv9cF8dTXCPT9Wdhv8zqmmdl0lvFSrfZrZKPnTL0Esib3hWUKg09A==
X-Received: by 2002:a17:902:f791:b0:17c:c1dd:a3b5 with SMTP id q17-20020a170902f79100b0017cc1dda3b5mr1336253pln.141.1666997800882;
        Fri, 28 Oct 2022 15:56:40 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:65f9:c180:249c:190f])
        by smtp.gmail.com with UTF8SMTPSA id u10-20020a170902bf4a00b001754064ac31sm3492890pls.280.2022.10.28.15.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 15:56:40 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mmc: sdhci-pci: Set PROBE_PREFER_ASYNCHRONOUS
Date:   Fri, 28 Oct 2022 15:56:37 -0700
Message-Id: <20221028155633.1.I6c4bfb31e88fad934e7360242cb662e01612c1bb@changeid>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This driver often takes on the order of 10ms to start, but in some cases
as much as 190ms. It shouldn't have many cross-device dependencies to
race with, nor racy access to shared state with other drivers, so this
should be a relatively low risk change. We've done similarly with a
variety of other MMC host drivers already.

This driver was pinpointed as part of a survey of top slowest initcalls
(i.e., are built in, and probing synchronously) on a lab of ChromeOS
systems.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/mmc/host/sdhci-pci-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 34ea1acbb3cc..0449630acbb3 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -2281,7 +2281,8 @@ static struct pci_driver sdhci_driver = {
 	.probe =	sdhci_pci_probe,
 	.remove =	sdhci_pci_remove,
 	.driver =	{
-		.pm =   &sdhci_pci_pm_ops
+		.pm =   &sdhci_pci_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
-- 
2.38.1.273.g43a17bfeac-goog

