Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3454FC10F29
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 10:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA08206EC
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 10:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwxZK12o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgCQKO2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:14:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35551 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgCQKO1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Mar 2020 06:14:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id u68so11693405pfb.2;
        Tue, 17 Mar 2020 03:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Fjm25eN67Hl8nyOyYLv4A1iv8wxFfMXZZCpQcIx04n4=;
        b=mwxZK12o2yFozq5LmtW0340Kj6e5cy3+iINHt9d9FhoP8FJlNCV8FF6meN5ck887xS
         GRZv1Qp0O3sU7pgv/l/oUShq7oHzVeEnm4Vbm3/m6wYJ4qEN1p29cXL+14V+ZlNmaX/c
         7W5/qT6+5mNtAbtdZXZEaNeck7+gxwvquI8h8hGJS2J9azOozAhXJzAALPyjsJ5ehYTT
         vBh9GwLyaQcRlJAVwO3JHoCT2V90gkT6UP6iSK7ZXnvviLPiFULFaB25xJ5tMmZF4Bb+
         2A/u0oK5nYGBHoTaNZ7jZJnmIRjRefvsoe7i2nJqXyYt0ibVdkn5o4OpWyBQxb2l7pf9
         kgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Fjm25eN67Hl8nyOyYLv4A1iv8wxFfMXZZCpQcIx04n4=;
        b=VCBOcJ9UA7k4yub+CcGxONelzLaFotoUv5NfnrfqbmOI/wHNr7X9/JaPO9jug8Z58y
         Elxmj5EO4L2cUuIfwlSAWg8Vfb41yzUzwz6OI2T3HdbMAxFWcTuYS4p1WNiq1qVeHLUt
         igarpQRma339uy/zxqDOdSB0I58yq/Nx528Cd/Wq8ZG1Lal3PojDfUiqRyl789nTS0ZE
         WbjwuzBsJWFe4Bx5oQ44IWXGchtGZdECHwtp2r72SEdFQF/9m3gCE1igOzE/2GNspK65
         5W3Ln3MEmpAVT0ASVRsLF2545a2ZtYsfboPFWnrBxvke1esUioXAXskaS+VOIeGGSblT
         CJvQ==
X-Gm-Message-State: ANhLgQ2LYx5CfGa/cLHzcWnuVXu5+/B5zhefq/HlW9qxjDtnvv5kXsw6
        AxqkgW9DIuzSk0vyZ7cbDQs=
X-Google-Smtp-Source: ADFU+vt0gPIsnKNi8QcQSYy1f9nkaTot8YwWssQrEJGM+YdgqdtFrAlpfD6o2Cfwk8GkTzGbj9Jveg==
X-Received: by 2002:a65:5688:: with SMTP id v8mr4021453pgs.403.1584440066838;
        Tue, 17 Mar 2020 03:14:26 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s25sm2195487pgv.70.2020.03.17.03.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Mar 2020 03:14:26 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mmc: host: sdhci: Implement the request_atomic() API
Date:   Tue, 17 Mar 2020 18:14:10 +0800
Message-Id: <3e1b588cd5579b63f4efcc5dd0d3a155f8de5a07.1584428736.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584428736.git.baolin.wang7@gmail.com>
References: <cover.1584428736.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584428736.git.baolin.wang7@gmail.com>
References: <cover.1584428736.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Implement the request_atomic() ops for the sdhci driver to process
one request in the atomic context if the card is nonremovable.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci.c | 27 +++++++++++++++++++--------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9c37451..4febbcb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2016,17 +2016,12 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
  *                                                                           *
 \*****************************************************************************/
 
-void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
+static void sdhci_start_request(struct mmc_host *mmc, struct mmc_request *mrq,
+				int present)
 {
-	struct sdhci_host *host;
-	int present;
+	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
 
-	host = mmc_priv(mmc);
-
-	/* Firstly check card presence */
-	present = mmc->ops->get_cd(mmc);
-
 	spin_lock_irqsave(&host->lock, flags);
 
 	sdhci_led_activate(host);
@@ -2043,6 +2038,22 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 }
+
+void sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	sdhci_start_request(mmc, mrq, 1);
+}
+EXPORT_SYMBOL_GPL(sdhci_request_atomic);
+
+void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	int present;
+
+	/* Firstly check card presence */
+	present = mmc->ops->get_cd(mmc);
+
+	sdhci_start_request(mmc, mrq, present);
+}
 EXPORT_SYMBOL_GPL(sdhci_request);
 
 void sdhci_set_bus_width(struct sdhci_host *host, int width)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cac2d97..5507a73 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -775,6 +775,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
+void sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
-- 
1.9.1

