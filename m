Return-Path: <SRS0=pl8z=67=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2C0C433DF
	for <linux-mmc@archiver.kernel.org>; Sun, 17 May 2020 22:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B3F20671
	for <linux-mmc@archiver.kernel.org>; Sun, 17 May 2020 22:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="my4ubcsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgEQW3f (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 17 May 2020 18:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgEQW3f (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 17 May 2020 18:29:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18A9C061A0C;
        Sun, 17 May 2020 15:29:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id m12so7440388wmc.0;
        Sun, 17 May 2020 15:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zBbpyoelvZMQi2sOj6TWYdOKOApt3dyMAzoTjYhpAc=;
        b=my4ubcsyz+v4QpyWlb/muucdIIfwEzKHPRDj65Ud1hff5Sw5+RL6mtJJ0tg7ZXtjaK
         eXo0Brwj/Yy+L+TQFkLy9eYTRBoFsPP9KlmatvE/StbtXirjWl591t5qIcPlJkCkXiFo
         qeTMbSv8ou2Y45QB7rOKtwrYCVaQPvhSJxs8xhlHThodFsT9SiVZ8eiYKOo3w6OeuEmk
         jb3K6S5ieYl8cvL24CcQmU3bjyzuHa+4rAVRHYg5viauNa6XwTNnk7g+1/SOdtJuQ6HN
         ZO3aoPP1UekJUSm62JwmAf3Y1icer6CxzCAmfLBclIWZG4uv+ybf4wjj9uUvket80ljP
         4g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zBbpyoelvZMQi2sOj6TWYdOKOApt3dyMAzoTjYhpAc=;
        b=S4pu3B1obrjKuWv9UybaRKO0tYhYggirPz2uqzyp3TFIslChFA4IDhB1X8eSlL+JIH
         jghjGjDZzyW0j7Z/3pWsctGz1ApXgBgpZ8bmr7O9bzsINM83e1xHoAKTDBBdHGvVjsFA
         yI2OftDusU7NncRHVvbaMwBsCiwstYRZbZ9iNu74CXUw9kbzv6NS1PMumWfQ0MSWVRjq
         RaEj2a6jGkoRq26/CAISAw51ZHht3Tkzejixo9g8rQDO4vNkNAJJKejs+Ps3TrONZXq0
         YG9X6lNSuJdWMqh3YIOkt6bYxPg25LI8pOG6weFyM8HHYzwkvqDqVdnTcLPXhCxtuEtF
         0dUQ==
X-Gm-Message-State: AOAM533JgI4TqFIfpGUTeYX8RTqV1eOI98pudwf8kb9wx2t7uX2bbvDG
        lI15+9jgEa5e3s0WHEOK8Jw=
X-Google-Smtp-Source: ABdhPJzt6T58mlmoPDLD8v56EY1rb+viEArjc61WgheODN7BSzGKeU9Rf3irgi2uWOLZsMpm1KOpcg==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr15304085wmj.3.1589754573183;
        Sun, 17 May 2020 15:29:33 -0700 (PDT)
Received: from localhost.localdomain (p200300f137132e00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b65sm14624702wmc.30.2020.05.17.15.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 15:29:32 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>
Subject: [PATCH 1/2] mmc: host: meson-mx-sdhc: fix manual RX FIFO flushing
Date:   Mon, 18 May 2020 00:29:06 +0200
Message-Id: <20200517222907.1277787-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For Meson8 and Meson8b SoCs the vendor driver follows the following
pattern:
- for eMMC and SD cards in .set_pdma it sets:
  pdma->rxfifo_manual_flush = 1;
- for SDIO cards in .set_pdma it sets:
  pdma->rxfifo_manual_flush = 0;
- before syncing the DMA read buffer is sets:
  pdma->rxfifo_manual_flush |= 0x02;

Set the second bit of MESON_SDHC_PDMA_RXFIFO_MANUAL_FLUSH without
clearing the first bit before syncing the DMA read buffer. This fixes a
problem where Meson8 and Meson8b SoCs would read random garbage from SD
cards. It is not clear why it worked for eMMC cards. This manifested in
the following errors when plugging in an SD card:
  unrecognised SCR structure version <random number>

Fixes: 53ded1b676d199 ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
Cc: Thomas Graichen <thomas.graichen@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdhc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdhc.c b/drivers/mmc/host/meson-mx-sdhc.c
index 5c00958d7754..53e3f6a4245a 100644
--- a/drivers/mmc/host/meson-mx-sdhc.c
+++ b/drivers/mmc/host/meson-mx-sdhc.c
@@ -586,10 +586,17 @@ static irqreturn_t meson_mx_sdhc_irq_thread(int irq, void *irq_data)
 		    cmd->data->flags & MMC_DATA_READ) {
 			meson_mx_sdhc_wait_cmd_ready(host->mmc);
 
+			/*
+			 * If MESON_SDHC_PDMA_RXFIFO_MANUAL_FLUSH was
+			 * previously 0x1 then it has to be set to 0x3. If it
+			 * was 0x0 before then it has to be set to 0x2. Without
+			 * this reading SD cards sometimes transfers garbage,
+			 * which results in cards not being detected due to:
+			 *   unrecognised SCR structure version <random number>
+			 */
 			val = FIELD_PREP(MESON_SDHC_PDMA_RXFIFO_MANUAL_FLUSH,
 					 2);
-			regmap_update_bits(host->regmap, MESON_SDHC_PDMA,
-					   MESON_SDHC_PDMA_RXFIFO_MANUAL_FLUSH,
+			regmap_update_bits(host->regmap, MESON_SDHC_PDMA, val,
 					   val);
 		}
 
-- 
2.26.2

