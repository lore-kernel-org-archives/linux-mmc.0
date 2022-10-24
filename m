Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D09C67871
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Oct 2022 19:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJXTdz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiJXTdk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2022 15:33:40 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DF483F0B
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 11:04:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h14so8673329pjv.4
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f8aY9RhMEKsObZDgKD/q+Hql9XXZRTy7bmu7NkRdyns=;
        b=iQQmWu8syBAiJbc13i3aS6QnytKsJEaYdBF8x6Uym2shHqm8CQ2r9LEIuDpoIfqPjf
         KrDNgvRmpt7WA8T7uwSijwEKgECbq+6jJQz2URihTNRjzroBKEVaZ3HSFO4nE4LrBgIP
         RiiduUKMCc5lvsojnZ5q5PAHQrbw+EbbSgUd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8aY9RhMEKsObZDgKD/q+Hql9XXZRTy7bmu7NkRdyns=;
        b=C+Bzgiq24XhamO09/G/TQICAYJe+Zzj4dMkviJeRGc3SaUudhWJ8gCDpZYwvmvLnOY
         nnGLXesGPDrUB3ZSxWV04enLOpnzDOr7SCoLQRqb5MUO6jfISyTRwTnlS/Gs9aZGR9v+
         j+CQnzmK1mZJylaP9EuJzPOkX+ZWIpRwi1XwTQQRRPnIj1pHVOjFi75pbPz/+l6Ulzsy
         SgQfu5PXp2mFOXUczqVsTQdwRCQ/PNbfzgPUpU3VuyDoIujxFnZPbpuRqvNpO+9jK7HF
         o0jgGgqACbwIx+4I4iexY1bHCGFderN8V5R4kYK20v5a3r3iii8u1r8JdAZNC8GAhKTB
         eCbQ==
X-Gm-Message-State: ACrzQf2Wqm62HIMUzZLgOmnqNOpTHqk9jccApbLxmAZF8Shf79Xtnoiv
        9XHB0sS1fdoIuzk9XQTn0KI6gQ==
X-Google-Smtp-Source: AMsMyM5c5rtHNqdOi+VIejih9i8mvW87u/6WeAxFVUvCupTrqKYzULyIM4Uo0EPKPQtq7UHBo1IcEw==
X-Received: by 2002:a17:903:2c7:b0:186:9862:d16c with SMTP id s7-20020a17090302c700b001869862d16cmr10686729plk.133.1666634585822;
        Mon, 24 Oct 2022 11:03:05 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:808b:e2f6:edcf:ccb0])
        by smtp.gmail.com with UTF8SMTPSA id q14-20020a170902f78e00b0017fe9b038fdsm57986pln.14.2022.10.24.11.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 11:03:05 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mmc: sdhci_am654: 'select', not 'depends' REGMAP_MMIO
Date:   Mon, 24 Oct 2022 11:02:59 -0700
Message-Id: <20221024180300.2292208-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

REGMAP_MMIO is not user-configurable, so we can only satisfy this
dependency by enabling some other Kconfig symbol that properly 'select's
it.

Use select like everybody else.

Noticed when trying to enable this driver for compile testing.

Fixes: 59592cc1f593 ("mmc: sdhci_am654: Add dependency on MMC_SDHCI_AM654")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/mmc/host/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index f324daadaf70..fb1062a6394c 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1075,9 +1075,10 @@ config MMC_SDHCI_OMAP
 
 config MMC_SDHCI_AM654
 	tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
-	depends on MMC_SDHCI_PLTFM && OF && REGMAP_MMIO
+	depends on MMC_SDHCI_PLTFM && OF
 	select MMC_SDHCI_IO_ACCESSORS
 	select MMC_CQHCI
+	select REGMAP_MMIO
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  support present in TI's AM654 SOCs. The controller supports
-- 
2.38.0.135.g90850a2211-goog

