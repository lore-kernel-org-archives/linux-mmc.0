Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2C7C4320A
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Aug 2021 08:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696CE60C51
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Aug 2021 08:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbhHZIV5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Aug 2021 04:21:57 -0400
Received: from www.zeus03.de ([194.117.254.33]:43056 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232992AbhHZIV5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Aug 2021 04:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=3Gu6i8JR/0s06peGLdYE4S2lpjW
        A/fK3145DW9ZS7aA=; b=28jfpHP3GyH9x93uYlhBy/lY19t9MmhOpHtpb6UvF/O
        GG8SV34JxRXeAtJ4EPjdIYaJ/19l7wjSvIu2d5m9ncb4kz5W7oAfPfKAG/H6khRO
        Ayt0LvoaA/RNWRXAY3Ox+jUnMAUtG7sFJT2+hxkOlFLhFpUTtlUiYqdxziANp2Ws
        =
Received: (qmail 927459 invoked from network); 26 Aug 2021 10:21:09 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Aug 2021 10:21:09 +0200
X-UD-Smtp-Session: l3s3148p1@hSmIDHLKIsIgARa4RSUSAccDwLt/uLTb
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: renesas_sdhi: fix regression with hard reset on old SDHIs
Date:   Thu, 26 Aug 2021 10:21:07 +0200
Message-Id: <20210826082107.47299-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Old SDHI instances have a default value for the reset register which
keeps it in reset state by default. So, when applying a hard reset we
need to manually leave the soft reset state as well. Later SDHI
instances have a different default value, the one we write manually now.

Fixes: b4d86f37eacb ("mmc: renesas_sdhi: do hard reset if possible")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Geez, typical SDHI nastiness here...

Geert: I think this fixes the issue you saw on Koelsch. It works fine on
my Lager now at least. Can you please test and tag if all goes well?
It would be great to have this in 5.14 but it definately needs Geert's
confirmation first.

 drivers/mmc/host/renesas_sdhi_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 6fc4cf3c9dce..a4407f391f66 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -561,6 +561,8 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host)
 		/* Unknown why but without polling reset status, it will hang */
 		read_poll_timeout(reset_control_status, ret, ret == 0, 1, 100,
 				  false, priv->rstc);
+		/* At least SDHI_VER_GEN2_SDR50 needs manual release of reset */
+		sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
 		priv->needs_adjust_hs400 = false;
 		renesas_sdhi_set_clock(host, host->clk_cache);
 	} else if (priv->scc_ctl) {
-- 
2.30.2

