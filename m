Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84924C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4972076A
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJ9Ca77b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGJLKV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJLKV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:10:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C65BC08C5CE;
        Fri, 10 Jul 2020 04:10:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k5so2103219plk.13;
        Fri, 10 Jul 2020 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dLfBKiqpz5EiKywgE0yB9WT/RYihQi2mbssOelfoHw0=;
        b=vJ9Ca77bH7p0DulTZ4e770baRLuddEbRx8xicTWnfaG9DjxAag0yOPpVlm/VIAs+XQ
         oDQ8AxlewBO2CA6Fq8DuWbFoJwLrsN2eOB70y1kHApbj4tk220c8ZrYNHM3QZmQUlho7
         3As2hgljt3suLKzCfO/LQEANVuOQqGj4wilxVHDlW+o7xSzyvTowXlFzyf+N2QJKtYwF
         zpozqSCTO4Z83+xjKmufmrX6Vlpukc7mh4JnB4Q5Y4syrSwNW/c+xuY1qVhRqPTEwT7Y
         coub31+cfdlaCmaCJlrP/bWTzeellUELCq2x2YuDpgSE2MW8tDHQZnF/QqnZbFdL9uGV
         ALpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dLfBKiqpz5EiKywgE0yB9WT/RYihQi2mbssOelfoHw0=;
        b=KuFJTQ44mA+ScLaWAE3WTpzo6wPVNrcQwgqPX9fM2J5MPxhLVszTpMLAu02HbLt5lm
         pOJlfEU4pLeVqr9c5sdqKl40/MqDkiVKGpEvonc/MFFPAwmaYkmJpBB93EIxWqPNg/+B
         etdxvwKQ9dggKI5pkSu1Hz2pLTW5gwr0ZqYJYEQ7wcY9cPP4Aan+G5s0OR3zIaV9QBTB
         OrFarOMwA13PYB9+I7a2rBhC2uCIpkGSp9JehnwiFh54631Am+UZ7YuZ0/0jR2GkPVXU
         Sj3L33HUeARxajPhvFN6BOueZUkn2GJ8TGaoRDHST0vm14rwDXkMjXIZ6KKh/w6unm2z
         8xqQ==
X-Gm-Message-State: AOAM531vlCs/t9tRgcoHOrueZvk4qjfUaGcOJAM+TZQ8z1y31HixDq5Z
        h4VfEPaUKApXC0mOftSVD5fu1JC9
X-Google-Smtp-Source: ABdhPJwI9lWowh+owLufJVcE9e4ty10ucd5K10bYaioElYjSbv5+jab2lXM38QsdKGLNS7DPejD3eA==
X-Received: by 2002:a17:90b:3809:: with SMTP id mq9mr5026522pjb.156.1594379421083;
        Fri, 10 Jul 2020 04:10:21 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id q5sm5617263pfc.130.2020.07.10.04.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:10:20 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 13/21] mmc: sdhci: UHS-II support, skip signal_voltage_switch()
Date:   Fri, 10 Jul 2020 19:11:04 +0800
Message-Id: <20200710111104.29616-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

sdhci_start_signal_voltage_switch() should be called only in UHS-I mode,
and not for UHS-II mode.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5511649946b9..7f2537648a08 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2623,8 +2623,13 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 	/*
 	 * Signal Voltage Switching is only applicable for Host Controllers
 	 * v3.00 and above.
+	 * But for UHS2, the signal voltage is supplied by vdd2 which is
+	 * already 1.8v so no voltage switch required.
 	 */
-	if (host->version < SDHCI_SPEC_300)
+	if (host->version < SDHCI_SPEC_300 ||
+	    (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+	     host->version >= SDHCI_SPEC_400 &&
+	     host->mmc->flags & MMC_UHS2_SUPPORT))
 		return 0;
 
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-- 
2.27.0

