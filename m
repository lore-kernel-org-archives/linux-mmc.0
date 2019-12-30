Return-Path: <SRS0=mt+k=2U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CE4C2D0C2
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Dec 2019 11:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04132053B
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Dec 2019 11:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyj1sSag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfL3Ljt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:39:49 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40501 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfL3Ljt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Dec 2019 06:39:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so17856902pgt.7;
        Mon, 30 Dec 2019 03:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Tf8YHcGOJoCskDvrArX1HeDQELyzh/fIJsLpatwNjo=;
        b=Zyj1sSagjq9IPjQsK4++LDAfXeH/3fdIzayTxQArXRhMuIeFdIzVf4h9YqYmru/wK6
         a1pjT1+zBsCbailwJrzd4HdaV+ZjwsW6tSrbPm5PbvfgQkPdBXQX379Ti5AgMlMRBNec
         uz4XX95aAMgndfklZtaSHHBn8DKvVZyJ8Js752b+hecaP1Smk/t4Hj8dLBIzm+lBhMYo
         33lDBiKx1j0SofS31ZqhrfhJctgWYX21t+TbtXftOqizpRqpNOK40xIet8tx2C82txf2
         P21CvBjIg/YZIN/GbE/k0v1U9WuNVVRtBEywFyPnHuemVVtU/39cYyphvhBfbJ98Ts9N
         M6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Tf8YHcGOJoCskDvrArX1HeDQELyzh/fIJsLpatwNjo=;
        b=W2ThiqreHaEk1OHmZq38d0VGNNxyJ40cFLTHviQVSFpyQaX7CAX8eJwMvMz42i1LVG
         WiQbXjulI03I/IcebBPM/W5McocO2kzcI1c4lOuETpSTMC/J2h93f8gP4lWaMY6f1Ptk
         kIhxoSDADO9Vdt+bKBLugyPyd4hlXodBGuP3ipvSMnkutsLFQ6x8JM/T7RVYxZMcUA11
         Z9Q2/5lhu1OWYwHUrVkSJgdBXdy4e2bRJ5T97rgfu2L8uuehYoBSG9iQcPQLWI/NQrQ1
         HZToEXd7sSwQTGvs0FW0zt1UXAQBxaDhooZsBoygytFFw5eNAzpqRJXhR+hWp7OsfW8d
         dW9w==
X-Gm-Message-State: APjAAAV2KC9UOlqPTanz5MR1M3eww+nc4Gvz8othw4h+laPrSfHBs4uN
        JOsITEICjNB29uIONL7T1oE=
X-Google-Smtp-Source: APXvYqz0sEH6PV8Jjd1yYMCWb8McEqaWmCslqRtqiEfxFH+fDKKpCMpuz1HlRzfk21N5q2uGHFzZUA==
X-Received: by 2002:a63:a4b:: with SMTP id z11mr68298958pgk.97.1577705988645;
        Mon, 30 Dec 2019 03:39:48 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id a10sm48329528pgm.81.2019.12.30.03.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 03:39:48 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC,PATCH 5/6] mmc: sdhci-uhs2: Introduce a uhs2_pre_detec_init function
Date:   Mon, 30 Dec 2019 19:39:59 +0800
Message-Id: <20191230113959.38150-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Introduce a uhs2_pre_detect_init function before detect uhs2 interface.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 49bda02dd305..d0cccc358cf2 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -506,6 +506,9 @@ int sdhci_uhs2_do_detect_init(struct sdhci_host *host)
 	DBG("%s: begin UHS2 init.\n", __func__);
 	spin_lock_irqsave(&host->lock, flags);
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n",
 				mmc_hostname(host->mmc));
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index ea5e2119e1c9..3b5b9c8e6663 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -904,6 +904,7 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 	void    (*uhs2_post_attach_sd)(struct sdhci_host *host);
 };
 
-- 
2.24.1

