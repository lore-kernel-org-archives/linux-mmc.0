Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF277C4361A
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 17:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B103C22AAB
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 17:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbgLDRT0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 12:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730100AbgLDRT0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2020 12:19:26 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1D3C08C5F2
        for <linux-mmc@vger.kernel.org>; Fri,  4 Dec 2020 09:18:04 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id a1so6111044ljq.3
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2020 09:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44c5zj1abPsOsm+uIkAlBTlmYFklVOwUyySZn/WhfTg=;
        b=FHXa4m1FTRAvBzZJmiIl1zO81P/XY4D4OYPg3oJnuuLM4R0gIQGECOwK/aXK52Nj4d
         01JWDK4f639RtV6cLCmpogCvNOGH8pKuaGIw9blR9bUoinHzzGXkiYBtGGQFzLAY+bnd
         j8oYzzq3BN9IpVetBiUG2lf2/nDhZ8bDfVdiVfbuoVayif0L2nHvcAxYsC31Tl5A2+AY
         nNg9ARWJFv/15h7IoQmqbnS0SuTp4RxF1fkKsz9zBoQvjpuzDVZvUq+0SJe61O4VGKqC
         d0fb8046Fr9EpKG3rSO5GUEa3tJvgd/tojIicy1PUJLTlR4UzHWpBta18fKPPovqVHj/
         h1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44c5zj1abPsOsm+uIkAlBTlmYFklVOwUyySZn/WhfTg=;
        b=EK2nI1OS+gwb/OufDRMk4Z8WAfWE5J5pSxh1HUOOnkTUkGbRIhrI6AP2cNt7q6SgWU
         gcW9lZt0fFXA6qCpoVBBEJmNpoFSen3pb16qwzbroYIvuHXWUsP0MFSQk8ZeTsrpmyQg
         46KlGoAN102dGWA3jPu+11m6S9CRsn5agQwBLZ6+dz7PAFo+6/LFKA6WIQzoz9wFY1O5
         /nwMus8Irj2nGVhLyyEWRSH8Qt8Lrn23jSKNw4CGbufXXWwCIdp7gM2UBNW3s8ofI+Jn
         vJqPGs1trB7RWB9XibWwrLXXz1Vs69tuIQACABLSbSmcDXha8W0zGuNwyY69BmwF/4SX
         MWww==
X-Gm-Message-State: AOAM533ZaOoudsk0NSW7d+I6vEr0llFrsfkG7Qw81fOr/FJsSllZC9V4
        jHN+tfETy/9Yt4bPdsvt5JWI7w==
X-Google-Smtp-Source: ABdhPJx8XSpFxN1FdRVqgHblet4qi3xanFtQFdvAEliEQpuxWbhNfYDnw3Hk4vLcoufIBkkNNd2RSQ==
X-Received: by 2002:a2e:8910:: with SMTP id d16mr3998218lji.295.1607102282846;
        Fri, 04 Dec 2020 09:18:02 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id w12sm1919802ljo.67.2020.12.04.09.18.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2020 09:18:02 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v4 4/4] mmc: sdhci-xenon: introduce ACPI support
Date:   Fri,  4 Dec 2020 18:16:26 +0100
Message-Id: <20201204171626.10935-5-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201204171626.10935-1-mw@semihalf.com>
References: <20201204171626.10935-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Previous patches dropped the strict dependency on the OF_*
in the sdhci-xenon driver. As a result the ACPI support
can be introduced (except for the XENON_A3700 variant)
by adding the necessary ID's in the acpi_match_table.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/mmc/host/sdhci-xenon.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 7d9335857715..c67611fdaa8a 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -11,6 +11,7 @@
  * Special thanks to Video BG4 project team.
  */
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
 #include <linux/module.h>
@@ -689,11 +690,22 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id sdhci_xenon_acpi_ids[] = {
+	{ .id = "MRVL0002", XENON_AP806},
+	{ .id = "MRVL0003", XENON_AP807},
+	{ .id = "MRVL0004", XENON_CP110},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, sdhci_xenon_acpi_ids);
+#endif
+
 static struct platform_driver sdhci_xenon_driver = {
 	.driver	= {
 		.name	= "xenon-sdhci",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_xenon_dt_ids,
+		.acpi_match_table = ACPI_PTR(sdhci_xenon_acpi_ids),
 		.pm = &sdhci_xenon_dev_pm_ops,
 	},
 	.probe	= xenon_probe,
-- 
2.29.0

