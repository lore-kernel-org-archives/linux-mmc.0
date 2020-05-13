Return-Path: <SRS0=M0Y2=63=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50150C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 17:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1EF0205CB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589389938;
	bh=t+svHDI2LEgtKLTdSO4kWJrbAf71gAmoo+hkov3X/1o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GqnjT275Pfs7BhXXE6GimWUjliZ8EvOehTtdpeMP0bqCUg4wJGtbNBKrdNfneyVHm
	 vvqW6F49AK3q3CBH+HPpq1D1tXglyR372IrZ+uAz0ymJ/VpuBEJwi+mqw8MJ44ly40
	 8RfZsLXTIv3wzv8YaRfxrO8bvbVBXXuq2zt8U7f8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389830AbgEMRMR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 May 2020 13:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389826AbgEMRMR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 13 May 2020 13:12:17 -0400
Received: from localhost (p5486CF35.dip0.t-ipconnect.de [84.134.207.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C351205ED;
        Wed, 13 May 2020 17:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589389937;
        bh=t+svHDI2LEgtKLTdSO4kWJrbAf71gAmoo+hkov3X/1o=;
        h=From:To:Cc:Subject:Date:From;
        b=0gSVQxP3wSUdmiBR9C1XXV0cigIVKqBg2kgpi3xhmO8lNDtxgAE1OmKOEmv/8Ufzh
         Q5ZqKohzSQtvSIXG9RTukdgTfzJlkcxaRlwOJh7htAIcAd9gdeUDpC8UdAxzOlP8S6
         715562B0EBjGqR9rSOThcwTzN3aLoBLhcCn9PX6E=
From:   Wolfram Sang <wsa@kernel.org>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [RFC PATCH] mmc: tmio: properly balance RPM on remove
Date:   Wed, 13 May 2020 19:12:06 +0200
Message-Id: <20200513171206.6600-1-wsa@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Because we enabled the device with _noresume, we should disable it with
_noidle to match the ref counting of the clocks during remove().

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

I think this is the proper fix to the problem Geert reported [1]. I am
not sure about a proper Fixes-tag, though. The corresponding _noidle
call in the probe()-error-path was added with:

aa86f1a38875 ("mmc: tmio: Fixup runtime PM management during probe")

However, from my understanding this is more fitting?

1b32999e205b ("mmc: tmio: Avoid boilerplate code in ->runtime_suspend()")

But maybe my understanding of the situation is still not perfect and
even the commit message is bogus? Ulf, since both mentioned commits are
from you, could you have a look? Thanks in advance!

   Wolfram

[1] Message-ID: <alpine.DEB.2.21.2004291630090.4052@ramsan.of.borg>

 drivers/mmc/host/tmio_mmc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 9520bd94cf43..9a4ae954553b 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1235,7 +1235,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	if (host->native_hotplug)
 		pm_runtime_put_noidle(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
-- 
2.20.1

