Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96278C43219
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Mar 2022 11:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344221AbiC3Lzl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Mar 2022 07:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345939AbiC3LzP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2022 07:55:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FFD5F9B;
        Wed, 30 Mar 2022 04:53:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32500615E7;
        Wed, 30 Mar 2022 11:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BCBC340EE;
        Wed, 30 Mar 2022 11:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648641179;
        bh=7nny6j5kBEYBzUICoO+m9vGpPqzolTOMU8x9YVcsZ3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9lA81uSg0gz5rgh8sBiB0c1zQyd7xnAE+LjplXZIN1foZfp6gQbx3sZiOwrluRsm
         rboHa+q9p3jmSNwEYZV+GX9dQalDBslRdnvi542YCJneawXUd2Ma3D7S72HzlHu/PH
         supiBmtOgxfJXo9Oys6xXYcGjpxmiR/RQ/+z1/bIgKiG47zGyAb/MI/EaeL6h9nhZL
         mX7JFuQBzbyeQdFb7ceqBEs6ypA+LIA16/hudhkcasq3C2UQVwOjWIsBXADA2EV2Dj
         iwqn+TiBaXjxiFvGS+cAC6AJChr7nofCSP9UZtkhjycXE+/HVsPnbLvM12xSB8LIPV
         UUaGs/HxBjSfQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 23/25] mmc: host: Return an error when ->enable_sdio_irq() ops is missing
Date:   Wed, 30 Mar 2022 07:52:23 -0400
Message-Id: <20220330115225.1672278-23-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330115225.1672278-1-sashal@kernel.org>
References: <20220330115225.1672278-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit d6c9219ca1139b74541b2a98cee47a3426d754a9 ]

Even if the current WARN() notifies the user that something is severely
wrong, we can still end up in a PANIC() when trying to invoke the missing
->enable_sdio_irq() ops. Therefore, let's also return an error code and
prevent the host from being added.

While at it, move the code into a separate function to prepare for
subsequent changes and for further host caps validations.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20220303165142.129745-1-ulf.hansson@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/host.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index e955f1ef2564..32801639e0be 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -497,6 +497,16 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 EXPORT_SYMBOL(mmc_alloc_host);
 
+static int mmc_validate_host_caps(struct mmc_host *host)
+{
+	if (host->caps & MMC_CAP_SDIO_IRQ && !host->ops->enable_sdio_irq) {
+		dev_warn(host->parent, "missing ->enable_sdio_irq() ops\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  *	mmc_add_host - initialise host hardware
  *	@host: mmc host
@@ -509,8 +519,9 @@ int mmc_add_host(struct mmc_host *host)
 {
 	int err;
 
-	WARN_ON((host->caps & MMC_CAP_SDIO_IRQ) &&
-		!host->ops->enable_sdio_irq);
+	err = mmc_validate_host_caps(host);
+	if (err)
+		return err;
 
 	err = device_add(&host->class_dev);
 	if (err)
-- 
2.34.1

