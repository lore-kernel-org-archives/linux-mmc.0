Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEACBC3815B
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 18:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BBBA2087E
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 18:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EdxLKm8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgDPSh0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgDPShZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 14:37:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3296C061A0F;
        Thu, 16 Apr 2020 11:37:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f13so5982726wrm.13;
        Thu, 16 Apr 2020 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zrr9neTYw1gwrfRxe9b60K+aHD8ESV7WJclVd1KpZR0=;
        b=EdxLKm8Tj61cPDw7eX3WTmjNlFqsh/4G6dTliuz0JdGPwTzZGO+gFZ4mRKeUi0rEL1
         6dswX7xSxLlexERENdFCbII4DKbN9xRPMGMJdGYtE5NjZzOD3sNw2GyTavGaNYp1LimS
         se1y0iKPUDnsQ6hHEE3xWGAJL9bdl/0Lxh8fByGbCtFRE9lLkRaHvFVaZBN+qZSccnGx
         z38YbcI006Hu05Njjn36eZtvM4RVrTyP1olWdDZQ5oT+KYVNa84WQeNzAj6eWizF9Yr2
         LyUK+4bZvDoTNpWjl0pwxAcUG9TbPA4JoOmzC99mG3FB1lQvDuDcGlTN8GiD9ThnROnQ
         /fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zrr9neTYw1gwrfRxe9b60K+aHD8ESV7WJclVd1KpZR0=;
        b=e2BOPeXz1dBahUbGbasdlfEt59/LjoKj8qyNncyTY++LhlM6UodGd1VSwBQj2u3j1i
         zV2SN/cLX3NaDqBPD5gfnTcKe3AakkGfkSnQtk64Bm8aC6y+pW06g+14AZxRefHlNiSr
         Fz6NpA/xKzqL+VwoZuTxYVcPJBOd1kN1ZLc5dFGemYr+NIjyNL/dusLcBxzmNmBaLt/V
         VOqjhPtn+REUBISgNnVZqpIOqS4nfp3f/lKTneUwWe5ELnIkFjpvxsIsflNIA0UsDpl7
         MyQLUtVCauRxlkk1NSNWsgwvbBS7ZarOpSoVxIIZRhngBhLeYTtHm3O3LodCDCx6NphU
         bgHg==
X-Gm-Message-State: AGi0PubvJruXVO0UEE2VlOrD9DQSoFcIuKm2OcDFLXeeyfeYFN9pbHD2
        PKNQCfaxBt4JVIZ9mt5/ZX8=
X-Google-Smtp-Source: APiQypKa30OdRL+FijHqXsK6zwF4JZSn49RjuzTTw95UCtDdcJVy+xbes81OigZhv4KTeL1jlW3xQg==
X-Received: by 2002:adf:f08b:: with SMTP id n11mr12511212wro.36.1587062243626;
        Thu, 16 Apr 2020 11:37:23 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id v131sm4626434wmb.19.2020.04.16.11.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 11:37:23 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] mmc: meson-mx-sdio: Set MMC_CAP_WAIT_WHILE_BUSY
Date:   Thu, 16 Apr 2020 20:35:12 +0200
Message-Id: <20200416183513.993763-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416183513.993763-1-martin.blumenstingl@googlemail.com>
References: <20200416183513.993763-1-martin.blumenstingl@googlemail.com>
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

Fixes: ed80a13bb4c4c9 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
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
2.26.1

