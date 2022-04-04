Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C565C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Apr 2022 10:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359063AbiDDLAg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Apr 2022 07:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358976AbiDDLAb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2022 07:00:31 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF90912AAF
        for <linux-mmc@vger.kernel.org>; Mon,  4 Apr 2022 03:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=BucI8btievleKbK2kz8dVtMrhRB
        7NH2KNT122rovt1A=; b=jffsrN2Ywa3fBCPdPFU94wpu/deYN3uHdDSNqzJOz0z
        6x0cXLl6LYmK5HQiszjH6Nhb0/o32ezx/JoDjsvW0UgNx5/w1o8+e6JjXpqRAaMw
        IjzjrP2EcoNkuYAwvCfwwQuDBANMjYzicEO++ML1dGzut/q/pnswx5MVGOkk0Euk
        =
Received: (qmail 1831091 invoked from network); 4 Apr 2022 12:58:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Apr 2022 12:58:33 +0200
X-UD-Smtp-Session: l3s3148p1@bZloAtLb5qQgAQnoAHNmALK3JllQBOZM
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mmc: renesas_sdhi: R-Car V3M also has no HS400
Date:   Mon,  4 Apr 2022 12:58:31 +0200
Message-Id: <20220404105831.5096-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Further digging in the datasheets revealed that R-Car V3M also has no
HS400 support.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 9dd01c220e93..2cd81d22c3c3 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -235,6 +235,7 @@ static const struct renesas_sdhi_of_data_with_quirks of_r8a77965_compatible = {
 
 static const struct renesas_sdhi_of_data_with_quirks of_r8a77970_compatible = {
 	.of_data = &of_data_rcar_gen3_no_sdh_fallback,
+	.quirks = &sdhi_quirks_nohs400,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compatible = {
-- 
2.30.2

