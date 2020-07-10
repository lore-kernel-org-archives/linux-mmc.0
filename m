Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689E0C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBF32076A
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWFUzpMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgGJLLy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgGJLLx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:11:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC6C08C5CE;
        Fri, 10 Jul 2020 04:11:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so2116149plo.7;
        Fri, 10 Jul 2020 04:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LNlz30IWOHI0EzUpbjw6GP+YcxLHXUvj3TU9mudyrqE=;
        b=TWFUzpMkGWdEJR/dntGvghD70r4RnseZlevMSVT2OkXokxRQRxOnIW2L+DZn89hDF9
         exlyHvKx3g1QMGKjL5jO+YIsy2dySSJh+3CX3ZsgyVQlVT/4v4LW3TviUKuUn6pPim5q
         QvoZkSwSfFDHanr0rbYx4X3jLHpqpUHH438yPXC8tlZaVqj83zCBkbuYlYa57p/WgevE
         UZdrtdPnuAIDV9QZXBDcukGQ72rPFHX1uv4n56SNfezP5qPtqC9k7rMvEKGQqe14yE7f
         B4Ok65wV1CfcJSWLK9w1nKFnO61zIEaLIRZSH3laz3V9tvPYAqa0ckflwnCchJPCnvl8
         tv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LNlz30IWOHI0EzUpbjw6GP+YcxLHXUvj3TU9mudyrqE=;
        b=WTXpyVlL2fdf0iTy87SdLi793lJCFJdIvD2QMGkHVMbnCrJ8LiX7FLaNFeH5HX6yX9
         e69QuS7HXHA7Ql86YvL5aqY3KiDPlLgfe2Mnbr6vQNTHSgD8eiumBRW0qVB/MctZKqsB
         KssrR+CJXdHMlF2XivHacvVLFJSmKb+LmnCj6UasO4POQh/jiCfW8Ytrr5xIbvJUn6BT
         H7Q2FmSHL6X9O1WZqP8O9C4hXW8pK5Bj7tcKo0Dt4IJfLRh5iv3kLERj4vFzAcMzOU6G
         Xs8bbfyWqpJSYHX4CWc9KsCwiYgIYwDaCzxYKCi24n0x/PcyJIFbitG7bVVRgHVv2/Gi
         +z9A==
X-Gm-Message-State: AOAM533qCplmghn44SgV1fResg4234InYDSpIAbx2MwOf/Tfm+Gz1Yve
        8ASLepASCs7BoirccYIuu6A=
X-Google-Smtp-Source: ABdhPJzXMpnI3N2MmVSAmrIXDJg32JEDi0wJm3cFwqCUc+s/bm9ffzDOAN7dPvVGoLrWwlCDqTN6yw==
X-Received: by 2002:a17:902:7c91:: with SMTP id y17mr26294187pll.103.1594379513255;
        Fri, 10 Jul 2020 04:11:53 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id gv16sm5436756pjb.5.2020.07.10.04.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:11:52 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 18/21] mmc: sdhci-uhs2: add pre-detect_init hook
Date:   Fri, 10 Jul 2020 19:12:36 +0800
Message-Id: <20200710111236.29885-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 3cb13071dd9d..3f7ebf5d18c5 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -525,6 +525,9 @@ static int sdhci_uhs2_do_detect_init(struct sdhci_host *host)
 	DBG("%s: begin UHS2 init.\n", __func__);
 	spin_lock_irqsave(&host->lock, flags);
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n",
 			mmc_hostname(host->mmc));
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 927aaba28932..c825a8130bc1 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -721,6 +721,8 @@ struct sdhci_ops {
 	void	(*request_done)(struct sdhci_host *host,
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
+	/* UHS-2 support */
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 struct sdhci_uhs2_ops {
-- 
2.27.0

