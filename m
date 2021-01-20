Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781D6C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 17:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5B120705
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 17:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbhATRav (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 12:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387710AbhATOsK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2021 09:48:10 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6AFC061575
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 06:47:29 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id my11so3241531pjb.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 06:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jlkUCRECPn1JzcA3719LXaq3XQK9JuWCVgpVUPK45uE=;
        b=vMEiJPVToombxMLqJX0wXG6rzvM+HHrDI5IcY+I2OXFnCvqT1ZIlT4Rlmm/ifJiV2b
         NQdxl7xfJFN4EdaGIpnPnyk2pB4Eu6+b4008zBZC4xICgJToyWtNW89vevu12h0miYJb
         /3RBt+uZz2ZO3+xPHdXyYjq5QXj2qa4w79niz5Mn4/B0+yDtdxT3Jp8gwJNdrUw3pytr
         5HxyJC4was7lmKOB2cRO5i3aGajrciaBntkf+qwaWz7zjr9pKEdnbGrR7eQ+nfnR1dF7
         wWA1oBIcdRXAgVYghEj45+RGMvJ9yuyb8M0+zesv1f2ENSjvE2ce6EO46O/Y+Z1vqkk1
         tZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jlkUCRECPn1JzcA3719LXaq3XQK9JuWCVgpVUPK45uE=;
        b=YK49wBZD7xO+RamNt3OPZpQumT3vCNUTEUF/WODQSm94ajD6rXdrqrO7d/PSNtZb9F
         W0b6cHKz0C+mADLVdtVA5gKwpbDlxrGjlpVzzF9M+kOTFMO93dB54/wOxQExQRpZuTgx
         +IDY7NPSDRQd49PE2KdZ5LqI1sruohaaURHweCozwesAx7WSmjMHX3CslmsReCo7ZG4I
         Bb8FYITOZLmRc/P2VKyWM8dhfhHpFT96ZydT9Kjku+vH4XdtQ/hbIGERr5WWdwy0GR25
         j53RIqx8ZYXiAo158EsCL8/6CnihliyzrHuKqT+qAejDsiOyqNsd4T8l3cPgHEiTUgIy
         Ak0A==
X-Gm-Message-State: AOAM530pVrZDcj2af0J+i+20/EuTG5ooCg8GtMkOnrRDPhJSrB4bIC7Y
        0Bj7dRDGcEH5bkXGHx9bi+I=
X-Google-Smtp-Source: ABdhPJymFocj95/O/ZGeel2Dqc93gmgCR8eWwFfh6VTP4LpZmlohV8OQ9H59nQnsnQN8if2np/htJQ==
X-Received: by 2002:a17:902:f54e:b029:de:19f9:c45f with SMTP id h14-20020a170902f54eb02900de19f9c45fmr10116312plf.48.1611154048867;
        Wed, 20 Jan 2021 06:47:28 -0800 (PST)
Received: from localhost.localdomain ([210.0.158.164])
        by smtp.googlemail.com with ESMTPSA id u14sm2631369pgj.13.2021.01.20.06.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 06:47:28 -0800 (PST)
From:   Fengnan Chang <fengnanchang@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, Fengnan Chang <fengnanchang@gmail.com>
Subject: [PATCH v2] mmc: limit the time of retries when analyse tuples failed
Date:   Wed, 20 Jan 2021 22:45:51 +0800
Message-Id: <20210120144550.697303-1-fengnanchang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

when analyse tuples failed, may enter an endless loop，so limit the time of retries.

Signed-off-by: Fengnan Chang <fengnanchang@gmail.com>
---
 drivers/mmc/core/sdio_cis.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index dcb3dee59fa5..47423a6d13fb 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -266,6 +266,7 @@ static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)

 	do {
 		unsigned char tpl_code, tpl_link;
+		u64 timeout = get_jiffies_64() + 10 * HZ;

 		ret = mmc_io_rw_direct(card, 0, 0, ptr++, 0, &tpl_code);
 		if (ret)
@@ -318,6 +319,8 @@ static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)
 			prev = &this->next;

 			if (ret == -ENOENT) {
+				if (time_after64(get_jiffies_64(), timeout))
+					break;
 				/* warn about unknown tuples */
 				pr_warn_ratelimited("%s: queuing unknown"
 				       " CIS tuple 0x%02x (%u bytes)\n",
--
2.25.1

