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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D632C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D5C2076A
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jfqafy0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGJLMP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgGJLMO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:12:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A73CC08C5CE;
        Fri, 10 Jul 2020 04:12:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g67so2386957pgc.8;
        Fri, 10 Jul 2020 04:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8w87dZu+AXaxXmtJyyfj57eeIxgjjlo27WZMKJg5/8=;
        b=Jfqafy0IhQ1F7vYTGTPiFIM1vkS9YTFf+ErfGF8DVFPKsKv0VcUSK4F4oWjbpVx2eZ
         EtkvgMynMCCqCtpts2voU4hHe/uERNThBxWISEA4GPQd639QRecVLwj5de0c0H0gWn7p
         5Nl6ltnzMEiXSU86lg+OitLUwzu0bsTnWS7/w20GUMdX+tI5wum0UVH8FYmGNIqnvNt3
         L4rpUYJKWAMfhDDpLcTnPHWf14OKFgEXgo5SCyD6g/mQr8saf7xgRl7OOMIxnn1h5d60
         U8irdVpLSXqluV0tPA5imk8MG/dvGVjLpplUTZcKfgp9bZmbSzlBMLAdAwkVbMAuy2nD
         HKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8w87dZu+AXaxXmtJyyfj57eeIxgjjlo27WZMKJg5/8=;
        b=KxqTw8pKEpapxUKBoHPfcc6nYI0X245MAGycjFsKT1VXXyxzYfocT642YzjGNMZn1D
         mAccKFB/PU1C0IN9UBiinPhx2/qg9uuCuj4sW3x/aJPGTPmmcv6TApg0pkaqu5cRxAvl
         gcJ/xfOopFiPWSFsDwOtnnYCsjX93iPY0tWsXZWOdJu99zoM61az94QyAxAbzwRzkTZt
         GEgjbG/++W7qy3Etd4H2uCFAacCE4MHop7ephRSVulHVo3uqxXPyyfK9fnEUKF6r7USz
         aUFFjZU8jL+51KzEMbmcmGhdXPZy/ExYMHCU6x3VJKu9BBYGY5i5quzl5pK2QRtIhcjz
         BTgQ==
X-Gm-Message-State: AOAM533xSmTQhMOYH8rJGtpKbpwHG9P+oULn3me8ebIrnvHXi4omhJCw
        K31TG/EJzKpwgNQfd3qGqJY=
X-Google-Smtp-Source: ABdhPJzwnZwvKSQKlNLwA/3ppBc4+nfB9rPPhw9n+Bd7qqbPRP9Tw35XqS7ggl1QKl9v9Vw1nV7cog==
X-Received: by 2002:a63:5a60:: with SMTP id k32mr57460324pgm.73.1594379533769;
        Fri, 10 Jul 2020 04:12:13 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id c30sm5386865pfj.213.2020.07.10.04.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:12:13 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 20/21] mmc: sdhci-uhs2: add post-mmc_attach_sd hook
Date:   Fri, 10 Jul 2020 19:12:57 +0800
Message-Id: <20200710111257.29992-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "post" hook for mmc_attach_sd(), uhs2_post_attach_sd, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci.c | 9 +++++++++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5d84e61f6ad9..a2cc5f758547 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3155,6 +3155,14 @@ static void sdhci_uhs2_enable_clk(struct mmc_host *mmc)
 		udelay(10);
 	}
 }
+
+static void sdhci_uhs2_post_attach_sd(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (host->ops && host->ops->uhs2_post_attach_sd)
+		host->ops->uhs2_post_attach_sd(host);
+}
 #endif /* CONFIG_MMC_SDHCI_UHS2 */
 
 static const struct mmc_host_ops sdhci_ops = {
@@ -3177,6 +3185,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.uhs2_set_reg		= sdhci_uhs2_set_reg,
 	.uhs2_disable_clk	= sdhci_uhs2_disable_clk,
 	.uhs2_enable_clk	= sdhci_uhs2_enable_clk,
+	.uhs2_post_attach_sd    = sdhci_uhs2_post_attach_sd,
 #endif /* CONFIG_MMC_SDHCI_UHS2 */
 };
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c825a8130bc1..d613ff8daaf6 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -723,6 +723,7 @@ struct sdhci_ops {
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	/* UHS-2 support */
 	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
+	void    (*uhs2_post_attach_sd)(struct sdhci_host *host);
 };
 
 struct sdhci_uhs2_ops {
-- 
2.27.0

