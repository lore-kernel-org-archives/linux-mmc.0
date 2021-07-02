Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17137C11F6C
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 08:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE96E613FB
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 08:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhGBIDB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Jul 2021 04:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhGBIDA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jul 2021 04:03:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED90C061762
        for <linux-mmc@vger.kernel.org>; Fri,  2 Jul 2021 01:00:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n11so5912231pjo.1
        for <linux-mmc@vger.kernel.org>; Fri, 02 Jul 2021 01:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HMlqyUhnpsm9OXWKnTS1RpX8qdYsLnBSBouKvMJLUSE=;
        b=RTivhvOWvVqbsIkxHVrJLb+T+trZ+bw0mG7IZbRRFFR6STFaeviWiaaVjjjIR/92Tt
         C3u4t1s++66ZYYqn5hMQEKS8mV+RlYXWRyJWBjm/jTGhSS5YOHXKPzHhI9QEBJ6VW2NM
         90gWCA3GSSPQ1hR3HlmcTCBhjvmRk8nHj2g2ZzkCRm1RyaC+Ft0IY53zQi/wIjd0rm3R
         k5anpLzw1id+wYeUvITqo5dWWe+Z32EFewWq8HKCNjeQp64EpQsxyktYWifs+q8Ofov8
         p3Fvd8YEKaC3DLSE+hPk2s7lTtRPxXVA8L/AS/D5ogwuxhOacsvJJSsrycEdNOHaXNi7
         kcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HMlqyUhnpsm9OXWKnTS1RpX8qdYsLnBSBouKvMJLUSE=;
        b=Ie189yi1zC45fDEp2rM5t0EmeEnUWRFdsrzrDnh9wAY0EtirqQgyDw7eRl5UHHI3hD
         BeA1fK0zQrUVOjjTl4Ar7aT4v7yF6mVyabhCq9FCV8d06mlUxaOfz0ymHunPoDGJDIai
         T50Y7DhJPJwy5/eJlRu6RR0qcvNEYIbVze/J8sFWlhFTf3hA3E2IOzf9w0peANx9RW3K
         Yh7BigQPYmD+E7ENvyYRW0YcdpK9A16f9KIBVnEsb1Ytx1n4qPQOwejhj/uggHK6lVx/
         LIs7A7WEYMK2XJ2vIJbMN/dEkr+idGHayCQusCHSvxCbr6xuxnlWLZtLu/WqTQepITWf
         EB0g==
X-Gm-Message-State: AOAM531/d1snXhRGP4zAh78Fgak2WPH41XgCNqDAF/Nrw5m9LPW1nVwt
        EvAt7nrZc+ioZkrE5SjbATpBFoy5viRTfQ==
X-Google-Smtp-Source: ABdhPJy0Isp9tv41Tfvt/LhJ+sPff/04t+8YSoIrJKpQQ4PIXxuoGCfsExD0QSwUa00scSFuD1qAGA==
X-Received: by 2002:a17:902:7d83:b029:11d:75c2:79a6 with SMTP id a3-20020a1709027d83b029011d75c279a6mr3275511plm.62.1625212827782;
        Fri, 02 Jul 2021 01:00:27 -0700 (PDT)
Received: from localhost.localdomain (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id b6sm2508925pgw.67.2021.07.02.01.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 01:00:27 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jason Lai <jasonlai.genesyslogic@gmail.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>
Subject: Re: [PATCH 2/4] mmc: core: Prepare to support SD UHS-II cards
Date:   Fri,  2 Jul 2021 16:00:22 +0800
Message-Id: <20210702080022.11235-1-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210225170352.76872-3-ulf.hansson@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,
        You added one bit definition 'MMC_CAP2_SD_UHS2' in struct mmc_host.caps2.
        But there already had a bit definition 'MMC_CAP_UHS2' in struct mmc_host.caps.
                #define MMC_CAP_UHS2    (1 << 26)    /* Host supports UHS2 mode */

        This bit was first appearred in [RFC PATCH V3 01/21] mmc: add UHS-II related definitions in public headers.
        These 2 bits seems to be defined for the same purpose, which one should I use?

kindly regards,
Jason Lai

---
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index a001ad2f5f23..0a777caaf7f3 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -377,6 +393,7 @@ struct mmc_host {
 				 MMC_CAP2_HS200_1_2V_SDR)
 #define MMC_CAP2_SD_EXP		(1 << 7)	/* SD express via PCIe */
 #define MMC_CAP2_SD_EXP_1_2V	(1 << 8)	/* SD express 1.2V */
+#define MMC_CAP2_SD_UHS2	(1 << 9)	/* SD UHS-II support */
 #define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
 #define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
 #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)	/* Don't power up before scan */
