Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B68BC433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 05:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E034023120
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 05:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbhAMFZa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 00:25:30 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56675 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbhAMFZa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 00:25:30 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 00B3A1AF6;
        Wed, 13 Jan 2021 00:24:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Jan 2021 00:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=NYblmrex2MNrshV7uB3UmzbuWY
        hNNNzfaDNwSbSid28=; b=IwmUZJXQej1jWnu/SuMs7ljUuuWqzbOveyhx0LLfy3
        Zj0GP1lly61wtlAG9cV7LxCpbThpaJCYjhN2N85lz416NbdmBxvls11CcpYv8367
        5ol6rykiC78hCNISxuXGlJn7flH9lxmtU9jxEsqBgBkmN3UejLWyNQxNXrctlA/c
        kgcRkAnK+eDtHizfryWYvSarh+Vmm0a4w9gMBSLs4mHItz3V2yFnGvo9X9/Vo2D/
        ottnsgDO7wDHKwRK4yNr0VhxgBT9S6wAvjym00ed581bOje97n50TKj61F1kBmIY
        usyp1QsxYFjQfoGC+F6feHSLWP/1OusBiVCdmTI4RNwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=NYblmrex2MNrshV7u
        B3UmzbuWYhNNNzfaDNwSbSid28=; b=fMDe20TiXcgXcnGK7MKK+q2mXXPXgJQ5T
        kE1VAwSlaJSwefw2bnHVCt3uSRr7FyYD635NF4EW14lWOb2TFIkXwCbb1nZDW9PT
        hQBOWiJRSGANqdLQxg+u7hx6jOzYit+eH0eZ+UbzfNyNotnwgyRa0gaCxdNmkN3f
        CfXZzNsIC3T2jbHWOtFkUMIp07O713jkwjELqoqc8uJ3h1iyJqDuZ0xy4k2fRKCc
        hT/CUSqFvP2qXuHDHaehzhdHNHKDG0eynIpWQ0Jfd7739b2X2q0Ne5Z2mvbscojB
        QDOpwHxOjDMbaIxmfmVFDl56kPjTgZcSDcSCXIWcFa53tNiMQ/2dQ==
X-ME-Sender: <xms:BoT-XzWfraRlxe-okimYn-RFu19Q_wPlnUhs8ElPGCp-Sm4lU3GnuQ>
    <xme:BoT-X7mDyB1VcLClRDOeFwkOpK7YqXeJTa8Kb3v_qyZihsGMBvHuyvIg4vf0P2wem
    P53oSguaSEwONoaAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdho
    rhhg
X-ME-Proxy: <xmx:BoT-X_ajpKiqzERbAj0rsWfyfuGkcLcZEqWDiJQ4PejCvu2VcuKDMw>
    <xmx:BoT-X-U_FHnG6FgH5ksDKhmnXDolP2Y78sktfXRl3rU5o76ayc47SQ>
    <xmx:BoT-X9m2Znh2g13nCLs9qnJ-tCeBvZKhq7KNrfzpCPOa4clsHuxUOw>
    <xmx:B4T-Xwu8eaxisBgkItFgHkfxW69AS1kZDITm2jEqfdlE5lqV9li1dg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 640CD240057;
        Wed, 13 Jan 2021 00:24:22 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH] mmc: sunxi-mmc: Ensure host is suspended during system sleep
Date:   Tue, 12 Jan 2021 23:24:21 -0600
Message-Id: <20210113052421.36553-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If the device suspend process begins before the mmc host's autosuspend
timeout, the host will continue running during system sleep. Avoid
this by forcing runtime suspend during a global suspend transition.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/mmc/host/sunxi-mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 6310693f2ac0..cfee8db7b76d 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1507,6 +1507,8 @@ static int sunxi_mmc_runtime_suspend(struct device *dev)
 #endif
 
 static const struct dev_pm_ops sunxi_mmc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(sunxi_mmc_runtime_suspend,
 			   sunxi_mmc_runtime_resume,
 			   NULL)
-- 
2.26.2

