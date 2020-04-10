Return-Path: <SRS0=BsGh=52=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA13FC2D0EC
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Apr 2020 21:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0572084D
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Apr 2020 21:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="irNfIkj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDJVaz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Apr 2020 17:30:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37939 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDJVaz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Apr 2020 17:30:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so3171733wrp.5;
        Fri, 10 Apr 2020 14:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wK7oayicow+Oht7E02uI/I6DTaomuoaw7CVzUaD0zFw=;
        b=irNfIkj8z+RIbvc8pcYIslLg7vVNd6XevVz0DH/xawFlaJVD0HkjMHb9E0XePXTa0s
         tRysnuwMaNQJxsUJEGKOxWOqaE+uC1BfNK6Nemg5kKWMR+wVXgID0uTuzziqvUR75py9
         Vo1jCACsoIjRm1riMzQ3sMBJ+GuBHKCU0DL57TNGV1MoUGKYlIyB5RQzKn2AJBaN64u7
         Je1U8AJTA10Hvb/ArOe8PW/N82d8my5NaLuR140WSUDHte0NnWG6qxdIgGGVFM9pySaY
         qKQks+sLpaeHRMCyyzRd8gzpYLSMmftg9y9TnrObiYgF78WbHqmhQ0+JXi9rkEV4jxsq
         RfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wK7oayicow+Oht7E02uI/I6DTaomuoaw7CVzUaD0zFw=;
        b=caUOBeK+EFE9Y11nCp0S0Il+6/BNsgRYYwCUAztui94Y01FFhEF29JlWF8WIy+EL/7
         cJl0uOWYSATP3bMZc+O8ZPnkO7I7NVKMy1JgilD15M9UpTKATI7H+mBarh76LpA2ULar
         jTLop+URQBLK3QlOir7iycdSmZtb8/oArY/M5ibJFi+7eHHAOY/aiKS8oBzmCx/hGmAa
         UA5OVfOZvEQAd2JwlNY7S9TDXzb1FCRQw7KmWvZLxruxVonmjbGv5EERTxhOrscW2H6j
         Y6O6bZjxW2H4aSoK+o6Cb84zHnJsV4Vt1z0Rdw08BXzQDqYOeaM6gtwyG18GNqFfNUdi
         VgdA==
X-Gm-Message-State: AGi0Pubr9HVorIU27khftCY6LC5jpWmRHE0MqlfTzvKC0AohpmaFQ+JM
        AKyYk5GR2bxpQzbpbM0XbYg=
X-Google-Smtp-Source: APiQypKuWx1zdhzfEOly6Y8HlYpRbiAGOhUn0awSbvgFIK6ZislxpRGqBXRDOz0/kdAWLKA09Fqcog==
X-Received: by 2002:a5d:460c:: with SMTP id t12mr6340769wrq.75.1586554251923;
        Fri, 10 Apr 2020 14:30:51 -0700 (PDT)
Received: from localhost.localdomain (p200300F13710ED00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3710:ed00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id v21sm4238463wmj.8.2020.04.10.14.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 14:30:51 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] mmc: meson-mx-sdio: Set MMC_CAP_WAIT_WHILE_BUSY
Date:   Fri, 10 Apr 2020 23:30:43 +0200
Message-Id: <20200410213043.1091851-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Meson SDIO controller uses the DAT0 lane for hardware busy
detection. Set MMC_CAP_WAIT_WHILE_BUSY accordingly. This fixes
the following error observed with Linux 5.7 (pre-rc-1):
  mmc1: Card stuck being busy! __mmc_poll_for_busy
  blk_update_request: I/O error, dev mmcblk1, sector 17111080 op
   0x3:(DISCARD) flags 0x0 phys_seg 1 prio class 0

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
I'm sending this as RFC because I'm not sure if this is a proper fix.
It "fixes" the issue for me but I want the MMC maintainers to double-
check this.


 drivers/mmc/host/meson-mx-sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 8b038e7b2cd3..fe02130237a8 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -570,7 +570,7 @@ static int meson_mx_mmc_add_host(struct meson_mx_mmc_host *host)
 	mmc->f_max = clk_round_rate(host->cfg_div_clk,
 				    clk_get_rate(host->parent_clk));
 
-	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
+	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY;
 	mmc->ops = &meson_mx_mmc_ops;
 
 	ret = mmc_of_parse(mmc);
-- 
2.26.0

