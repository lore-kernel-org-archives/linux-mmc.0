Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EBEC433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Mar 2022 14:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348987AbiCKOG5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Mar 2022 09:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345358AbiCKOG4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Mar 2022 09:06:56 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22141C57EE
        for <linux-mmc@vger.kernel.org>; Fri, 11 Mar 2022 06:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=kFdhMnLTV2ifT7oE+XI6CZcKBne
        hksTlKi9UbaXxpik=; b=FxcZ09R7olkMo/kouNfYagiFTCKrxwP/xYEeRIeyRbd
        Kzct4R21d6LFfUZ5F8eLa1C4/3ZcgQGuUKFC8jn0o6c6wrhWx+Muo9uChixhHuP7
        /pe96jKcCDeQ5qSs8XLMn4v71oXPtpK6IcvYmZ1BsUwfXIMOkud/PxtVVG3icTAo
        =
Received: (qmail 1105134 invoked from network); 11 Mar 2022 15:05:48 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Mar 2022 15:05:48 +0100
X-UD-Smtp-Session: l3s3148p1@rmTb0/HZ7pQgAQnoAGBOAABRt5Igy74F
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: tmio: remove outdated members from host struct
Date:   Fri, 11 Mar 2022 15:05:42 +0100
Message-Id: <20220311140542.5407-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The wrappers are gone for two years now but they have still pointers
reserved in the tmio_mmc_host struct. Remove them.

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Fixes: f22084b662e5 ("mmc: tmio: remove superfluous callback wrappers")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index f936aad945ce..e754bb3f5c32 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -186,10 +186,6 @@ struct tmio_mmc_host {
 	void (*fixup_request)(struct tmio_mmc_host *host, struct mmc_request *mrq);
 	unsigned int (*get_timeout_cycles)(struct tmio_mmc_host *host);
 
-	void (*prepare_hs400_tuning)(struct tmio_mmc_host *host);
-	void (*hs400_downgrade)(struct tmio_mmc_host *host);
-	void (*hs400_complete)(struct tmio_mmc_host *host);
-
 	const struct tmio_mmc_dma_ops *dma_ops;
 };
 
-- 
2.30.2

