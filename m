Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B60C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Dec 2021 22:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbhLWWze (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Dec 2021 17:55:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34818 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbhLWWzd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Dec 2021 17:55:33 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F61C2110A;
        Thu, 23 Dec 2021 22:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640300132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=skxvEKiERuSlbQg3xOjujrW/9BRBdRyt1Whkuz5g1j4=;
        b=qxKuUJ0nZm3UC6X9f7RaGFJuUi8xCK+hwDm5eJEbRnx20B47nkF9W0i8bmNJZl/mhfwuAK
        nrrYHExDAllNIHJhCNfsVvF1vrceEdaDyENBn3VEgF5I5Gnf03CEYIkTsxkt/NNjR7/pw7
        NuzSvvdKwhSg/coK6JHGof5tRVuVU40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640300132;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=skxvEKiERuSlbQg3xOjujrW/9BRBdRyt1Whkuz5g1j4=;
        b=ugiMp7tSgi8WLYzGlr7AhX/Y0XNG7b87XDGD3S7ETYANuABgZ5EkIwEAW0iP2dngDD2wRu
        20yUMUWTkv1HQsBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3858E139FC;
        Thu, 23 Dec 2021 22:55:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8wMODGT+xGFdIAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 23 Dec 2021 22:55:32 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-mmc@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/1] dt-bindings: mmc: sdhci-msm: Add compatible string for msm8994
Date:   Thu, 23 Dec 2021 23:55:24 +0100
Message-Id: <20211223225524.9860-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Petr Vorel <petr.vorel@gmail.com>

Add msm8994 SoC specific compatible strings for qcom-sdhci controller.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
NOTE: resubmitted this single patch for linux-mmc.

Kind regards,
Petr

 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 50841e2843fc..6a8cc261bf61 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -17,6 +17,7 @@ Required properties:
 		"qcom,msm8974-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
+		"qcom,msm8994-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
 		"qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
-- 
2.34.1

