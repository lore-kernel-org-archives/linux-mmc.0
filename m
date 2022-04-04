Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C242C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Apr 2022 13:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiDDNIP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Apr 2022 09:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349750AbiDDNHy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2022 09:07:54 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD616DFBC
        for <linux-mmc@vger.kernel.org>; Mon,  4 Apr 2022 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=txvz60tNWKpsPCEGKMRyZr59Whs
        TSR0mtEBaqNcLHAM=; b=h/6HZh8tzP+CyUpXbxM2nbsQGqeJSigdICqFQ7xhsVc
        1pg5tIZfpw/DuhiQOXD9TysaAstOAJcXIXp0ugiU7SHq9xwwOFX4ryvzF45csB9c
        U8arAo2kjgxiAOVNge1kZVzSoZq55CwsIbXWETuRby7k/FruEScyioztRnXY2feM
        =
Received: (qmail 1876424 invoked from network); 4 Apr 2022 15:05:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Apr 2022 15:05:52 +0200
X-UD-Smtp-Session: l3s3148p1@EDa5ydPb6KUgAQnoAHNmALK3JllQBOZM
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: renesas_sdhi: remove superfluous specific M3W entry
Date:   Mon,  4 Apr 2022 15:05:51 +0200
Message-Id: <20220404130551.20209-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We don't need to specify the Gen3 compatible entry for M3W because it
will be provided by the generic Gen3 fallback.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

This should be the final of_device_id fix. Builds fine. But I can't test
because my HW is currently at a different location. Reviews from Geert
and/or Shimoda-san would be much appreciated.

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index c9585c4fd812..3084b15ae2cb 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -262,7 +262,6 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r7s9210", .data = &of_rza2_compatible, },
 	{ .compatible = "renesas,sdhi-mmc-r8a77470", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_r8a7795_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7796", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77961", .data = &of_r8a77961_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77965", .data = &of_r8a77965_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77970", .data = &of_r8a77970_compatible, },
-- 
2.30.2

