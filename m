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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24FBC6377D
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC14608FC
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhGVDVY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhGVDVX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:21:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D43C061575;
        Wed, 21 Jul 2021 21:01:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a17-20020a17090abe11b0290173ce472b8aso2384221pjs.2;
        Wed, 21 Jul 2021 21:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HCiki6s3bkhDr8HEItmgJdP7VpsDfkf2iN/pIhh62EA=;
        b=FncgS1G79piW939Bxd70JAWZ8JZOH0CifGlRy1g7+k+j3wPx3dkb3ra583JuB8oWNA
         J7B4+9TOGs2ff8msj9H1NXmaU0kVrf+8M1uYGjDo/0YBTBaD7e8nBbAVlCKU791Pe+oh
         2Dkx82WxfutR71Mrrv3bsSnxV/Tzj0ePzA9/nfpFF/Ml4D8cUrkKJa7CgcZ3NZzbbqHe
         wF9VVL9xM2M8w3vWkcLxsuQbw4xJavF0s4XAkF0ql+N1FpE0uctglb6ZPv0XANh6J71p
         CcuCpH5LnCEtxdwJtRJDOw84RqBHJFZ1LIDokeRM5Mle/PwZZphmmW7EbtBWtZ0jTxWu
         bIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HCiki6s3bkhDr8HEItmgJdP7VpsDfkf2iN/pIhh62EA=;
        b=iZ0W9qOyKICO7jeAGfb0hyZd6P4QCEo2fCbFyi/wlbX7/nqs7tSPl/CJrrsysj/tJH
         lhTfmn6noE548K8V1OZW+GmFIzkfH8CHXfPPwB2oyb4JFwgKQ+zcIunwaP3s1kWiyB7D
         O7GXgMNluqqIRovPhnnvz3QmsSmenroElcaD2WopgDLLucJ02R5A07+tIXLblkhE5ipm
         ChPrm7rk4MCGrBQ4TdmTubNs5cTGxIo9N67TpQXb6v1OWpGcw14apIEw7P7tiK3l9yFG
         zb77sgYgIMa4XbSixL7m/cwyk1gWktKX1Pbq8qe0e5KlWNZ6RJXNnL9qDvnsyJFNcSJL
         g4SA==
X-Gm-Message-State: AOAM531nRxbUjj4yngwvY6yOhzXOStaxNP5f2/CgJuPGXBHq6TrLBrqZ
        2ACRSSbYTRCRbhzI60AW9MA=
X-Google-Smtp-Source: ABdhPJypAdbwOLhqudXCRiHkNrQh4VT+ulwNpjfrp2tOc7CWFz3DRS2p0hC/oBMSjNuusZKORdVIXg==
X-Received: by 2002:a17:902:d681:b029:12b:381c:c86 with SMTP id v1-20020a170902d681b029012b381c0c86mr30345901ply.46.1626926518357;
        Wed, 21 Jul 2021 21:01:58 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:01:58 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 03/29] mmc: core: UHS-II support, skip set_chip_select()
Date:   Thu, 22 Jul 2021 12:00:58 +0800
Message-Id: <20210722040124.7573-3-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

mmc_set_chip_select() should be called only in UHS-II mode,
and not for UHS-II mode.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 722b61811f1e..3da7b7e321a0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -899,8 +899,10 @@ static inline void mmc_set_ios(struct mmc_host *host)
  */
 void mmc_set_chip_select(struct mmc_host *host, int mode)
 {
-	host->ios.chip_select = mode;
-	mmc_set_ios(host);
+	if (!(host->flags & MMC_UHS2_INITIALIZED)) {
+		host->ios.chip_select = mode;
+		mmc_set_ios(host);
+	}
 }

 /*
--
2.32.0

