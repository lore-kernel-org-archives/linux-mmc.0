Return-Path: <SRS0=LLi2=7I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD74C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 15:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9D6206D5
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 15:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590507830;
	bh=v7086Qob1vHtxAE6q+xPniojkj/1ehVXZQDXcryapyY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lwdlFvEqEh3l+cKeSPyorT+9UDDPbiRBWd5e4ybVqnGGcLfMZ49PDZeIcGmUzOEPW
	 lhYuvzQZkcv1VynRYDomUFkQ5J4FJCxR10ZD5/xiovkIwRiuSKE4pwimpFQqY6Zhy6
	 ra3Zzw0gIPshTjxODk6zECJFIrx38A2iJMN77kaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgEZPnr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 May 2020 11:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbgEZPnq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 May 2020 11:43:46 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D24120663;
        Tue, 26 May 2020 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590507826;
        bh=v7086Qob1vHtxAE6q+xPniojkj/1ehVXZQDXcryapyY=;
        h=From:To:Cc:Subject:Date:From;
        b=rjSWVA15R2H6PzCbBynUpEF0IcpTpY9OpXyvCjdW7ifsQJu8hgxCxvvpOPgVm5j/B
         LXbmaq4ugxfz6K4TZiPvT37bFhAPgwJ98iXmWsvSlX/PUkI6BvT0PmNjThWt4cHIOH
         LPA6qYAIoEYXkMKmFs7cdJwXCcD7zSEkQhiQWMkw=
Received: by pali.im (Postfix)
        id CDB2216FA; Tue, 26 May 2020 17:43:43 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH 1/2] mmc: core: Do not export MMC_NAME= and MODALIAS=mmc:block for SDIO cards
Date:   Tue, 26 May 2020 17:43:33 +0200
Message-Id: <20200526154334.21222-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SDIO non-combo cards are not handled by mmc_block driver and do not have
accessible CID register which is used for MMC_NAME= construction.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 drivers/mmc/core/bus.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 74de3f2dd..103eea7cd 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -93,15 +93,20 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 			return retval;
 	}
 
-	retval = add_uevent_var(env, "MMC_NAME=%s", mmc_card_name(card));
-	if (retval)
-		return retval;
-
-	/*
-	 * Request the mmc_block device.  Note: that this is a direct request
-	 * for the module it carries no information as to what is inserted.
-	 */
-	retval = add_uevent_var(env, "MODALIAS=mmc:block");
+	if (card->type != MMC_TYPE_SDIO) {
+		retval = add_uevent_var(env, "MMC_NAME=%s", mmc_card_name(card));
+		if (retval)
+			return retval;
+
+		/*
+		 * Request the mmc_block device.
+		 * Note: that this is a direct request for the module it carries
+		 * no information as to what is inserted.
+		 */
+		retval = add_uevent_var(env, "MODALIAS=mmc:block");
+		if (retval)
+			return retval;
+	}
 
 	return retval;
 }
-- 
2.20.1

