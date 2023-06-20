Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACF8EB64D8
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 10:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjFTKry (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjFTKrs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 06:47:48 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA94197
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:47:47 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A4CDE86354;
        Tue, 20 Jun 2023 12:47:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1687258066;
        bh=psHkjDcuH/noI1mwgUE/rgdIDb1uLlAZknH9j+hekS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NgIEWLzldTAhanCHOawX2ApLBOqbzUVFPKVqVTFxbSbeK+5M5/RcC2mdEKBFDdlu/
         YqItZturcuh26UKNcxf9cpwBwJATAWoRqWGcNaGWPpAcqC4qvtlrD1KBqnpNOSA1Gf
         AO2f//Mp0c9vhszA+2GzdYSr812ij5ppWgzwsd2epuf0LGgBecNuA/ulu6el/aehro
         AsSrPsc6Hg8fhnu8bFNuWDRJ1gxoW53Fso3VwLmI3RqrwZjpHbY76tJaE5EVH5Yrvt
         1ddV/OQiTRvyOVP8umPKpO1eBEGUjsSud4vbQWXx6Zk2D93O/dglee67Q21di7GP3m
         oJbg/iSGtb9SA==
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>, Bo Liu <liubo03@inspur.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pierre Ossman <pierre@ossman.eu>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 10/11] mmc: vub300: Use BIT() macro
Date:   Tue, 20 Jun 2023 12:47:21 +0200
Message-Id: <20230620104722.16465-10-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230620104722.16465-1-marex@denx.de>
References: <20230620104722.16465-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use the BIT(n) macro instead of (1<<n), no functional change.
Regex 's@(1 \?<< \?\([0-9A-Z_]\+\))@BIT(\1)' .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Bo Liu <liubo03@inspur.com>
Cc: Deren Wu <deren.wu@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/vub300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 9ec593d52f0fa..4216d57262dc3 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -323,7 +323,7 @@ struct vub300_mmc_host {
 	struct sdio_register sdio_register[16];
 	struct offload_interrupt_function_register {
 #define MAXREGBITS 4
-#define MAXREGS (1<<MAXREGBITS)
+#define MAXREGS BIT(MAXREGBITS)
 #define MAXREGMASK (MAXREGS-1)
 		u8 offload_count;
 		u32 offload_point;
-- 
2.39.2

