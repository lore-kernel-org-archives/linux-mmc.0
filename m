Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BFCC74A5B
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Mar 2023 18:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCUSBM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCUSBI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Mar 2023 14:01:08 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF597244BB
        for <linux-mmc@vger.kernel.org>; Tue, 21 Mar 2023 11:01:06 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 3F7B22003E0;
        Tue, 21 Mar 2023 19:01:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1679421665;
        bh=7jcxLZYZVIxLt/99tnslGBZy06mzJRUXDK5eV7UVG4w=;
        h=Date:To:Cc:From:Subject:From;
        b=uTSUPt+5ngY/UMwWdzRhQE3aZwt94Z3VI6MZ8bcJkSmM25FQRiERdzhVoVbYceTll
         T8wk5ONZvPzU35S4CZDuOJa+ReSHEGpla/O6ZhZDOA0R0hrx/9GyUGKAI1DazHVVX1
         GEQaNLzS0mVl4f0Xg0xk7nspVladvYcE1Uj9QxLCjkEgd885S8SgJUKewirGZO0piu
         hUfNwiovel1nUI4o4yVOguxGchC163ToJNmoCHNUkFB7gRLAAgNMu96ZQ0R/UNAixy
         CG0yF7DIkXKlXZ6cRAIcX4RKdPr5H4RgAKAvUYfnInmbF1Rl1Aqs8HWBhxyKer2zFN
         yvLcVK9JBjBGA==
Message-ID: <d2444591-c91b-a94d-71e2-9dedc3b6c514@free.fr>
Date:   Tue, 21 Mar 2023 19:01:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Pierre-Hugues Husson <phh@phh.me>, MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH] mmc: core: log empty non-removable slots
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

An empty non-removable slot might be the symptom of probing too early.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 drivers/mmc/core/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 426c7f66b3492..b8137baecee7c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2257,6 +2257,10 @@ void mmc_rescan(struct work_struct *work)
 			break;
 	}
 
+	if (!mmc_card_is_removable(host) && !host->card)
+		pr_info("%s: no card detected, check post-power-on-delay-ms",
+			mmc_hostname(host));
+
 	/*
 	 * Ignore the command timeout errors observed during
 	 * the card init as those are excepted.
-- 
2.25.1
