Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173E4C352BE
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 18:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6C0206E9
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 18:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CQHi/uns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgDPShd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgDPSh0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 14:37:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005F7C061A10;
        Thu, 16 Apr 2020 11:37:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t14so5995187wrw.12;
        Thu, 16 Apr 2020 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C1S/+OwOPtKiEhvj9DA7M//jhqBwvQtvgsSI6UOLquM=;
        b=CQHi/unsUcvoUVzVaipedhpVjjLOdaIJ3t70EcTJiXiU3W6QWnpO4BzU9qC5wzdMS7
         NI3dBKWOPwn9LymU0i6VlQP4CQ2Q0k65AXXqCNRRR+lqoOhB8CXOAxt/4T3rvSFhruBZ
         JkMYrl8tbZBbfv+kb7tRnlMvmSMKmuNYVAgyMbLd2DvER+TvRsPJYIum1xuMZEvsc6Iq
         JX+6bTEPpwn/TWF2kB0OYFjqxnNESTZPJ+Ir5MOPavHDjVGSaYCl+VAvunsF2YdstMQJ
         65GYJyvoYhmYlSJ6jMMrWr4b4NB8guNA0rJatuQAVt2clPvB5BVvHxBCJzsWBm0cDd9F
         PLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1S/+OwOPtKiEhvj9DA7M//jhqBwvQtvgsSI6UOLquM=;
        b=r6HqzGkynBt0EBUZpdXtnxfNUeQUogXHp7W+lFPVrew/nVHP2lP43CX2gD1lE1ncQx
         CmOFbSkAUbXEt4Por05JaoycQP2GpAgwsjbDZWd430RWuzTOAdYEIe/4YHScG0lKeG3O
         oRBisFRZZrY8PTSBfanShFEkixgr4S9gmfeA7noyGBp31e6gVmewfHE4YNLUiaqPUF/q
         Hzeiq0PrJxssFfJ2BmNqNADHZRYMOqucKm+0f9dPbSufy97r0Pm04P43A0LDp5M72oaz
         0NP8alW/QCItEwH5Wsg3RbmD5yFASr1fmgu/Tm5+cuk5geFDS7DG3L/ytICDgoQhloIB
         hRDQ==
X-Gm-Message-State: AGi0Pub2NsEYnGfX8um1XxYUUzssvPJLnzAj7NHmXUAqVhq1bUAIVYzF
        CrIkU4B/xQhsvBJ+JK2TK6w=
X-Google-Smtp-Source: APiQypLrrWMR3D00/qDY9fDZ7v+GzkuuMpcELcn5wFZA6k15OY1Sa+zbngp6IolofbZP344OubtZ3w==
X-Received: by 2002:a5d:4485:: with SMTP id j5mr11941530wrq.427.1587062244619;
        Thu, 16 Apr 2020 11:37:24 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id v131sm4626434wmb.19.2020.04.16.11.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 11:37:24 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/2] mmc: meson-mx-sdio: remove the broken ->card_busy() op
Date:   Thu, 16 Apr 2020 20:35:13 +0200
Message-Id: <20200416183513.993763-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416183513.993763-1-martin.blumenstingl@googlemail.com>
References: <20200416183513.993763-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The recent commit 0d84c3e6a5b2 ("mmc: core: Convert to
mmc_poll_for_busy() for erase/trim/discard") makes use of the
->card_busy() op for SD cards. This uncovered that the ->card_busy() op
in the Meson SDIO driver was never working right:
while polling the busy status with ->card_busy()
meson_mx_mmc_card_busy() reads only one of the two MESON_MX_SDIO_IRQC
register values 0x1f001f10 or 0x1f003f10. This translates to "three out
of four DAT lines are HIGH" and "all four DAT lines are HIGH", which
is interpreted as "the card is busy".

It turns out that no situation can be observed where all four DAT lines
are LOW, meaning the card is not busy anymore. Upon further research the
3.10 vendor driver for this controller does not implement the
->card_busy() op.

Remove the ->card_busy() op from the meson-mx-sdio driver since it is
not working. At the time of writing this patch it is not clear what's
needed to make the ->card_busy() implementation work with this specific
controller hardware. For all use-cases which have previously worked the
MMC_CAP_WAIT_WHILE_BUSY flag is now taking over, even if we don't have
a ->card_busy() op anymore.

Fixes: ed80a13bb4c4c9 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index fe02130237a8..2e58743d83bb 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -357,14 +357,6 @@ static void meson_mx_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		meson_mx_mmc_start_cmd(mmc, mrq->cmd);
 }
 
-static int meson_mx_mmc_card_busy(struct mmc_host *mmc)
-{
-	struct meson_mx_mmc_host *host = mmc_priv(mmc);
-	u32 irqc = readl(host->base + MESON_MX_SDIO_IRQC);
-
-	return !!(irqc & MESON_MX_SDIO_IRQC_FORCE_DATA_DAT_MASK);
-}
-
 static void meson_mx_mmc_read_response(struct mmc_host *mmc,
 				       struct mmc_command *cmd)
 {
@@ -506,7 +498,6 @@ static void meson_mx_mmc_timeout(struct timer_list *t)
 static struct mmc_host_ops meson_mx_mmc_ops = {
 	.request		= meson_mx_mmc_request,
 	.set_ios		= meson_mx_mmc_set_ios,
-	.card_busy		= meson_mx_mmc_card_busy,
 	.get_cd			= mmc_gpio_get_cd,
 	.get_ro			= mmc_gpio_get_ro,
 };
-- 
2.26.1

