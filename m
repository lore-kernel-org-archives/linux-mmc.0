Return-Path: <SRS0=ylMS=7J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B102DC433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 27 May 2020 11:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8231B207CB
	for <linux-mmc@archiver.kernel.org>; Wed, 27 May 2020 11:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590577751;
	bh=3diRTG4EYmBHANbsqVvKSY9n7VhyjG1AQZ7fBVDT5fw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uekt+a0nqLcB9i/7FhyyBqvgj2PDMbJla4BG+gfN2pUW7mLTYJNlFeQCPuFRLzbbw
	 ydJdEVEe9TBby8f87LjxERb4xiCUASrGFdMsPgL/tAmnhf6TAOvzfZgYTmgypYdXsc
	 rDOnqtYKxFY893+A9XyqqM+vKCHIowCC07YRHylE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388021AbgE0LJL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 May 2020 07:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387534AbgE0LJK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 27 May 2020 07:09:10 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7902E2075A;
        Wed, 27 May 2020 11:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590577750;
        bh=3diRTG4EYmBHANbsqVvKSY9n7VhyjG1AQZ7fBVDT5fw=;
        h=From:To:Cc:Subject:Date:From;
        b=mZouomnUotk3X2CsfpVxo+OBvqg04n7c9VZ4A8Iwwo6pLg8LIXuyLbHcjK0PzZIgH
         t4xujoUFhFAQMYEZ6mbg7FmTAD4S+WWgsIDhx3oAzETDGotud1HGQnYzlpaMbrv8uQ
         RgA6AbMHTUb+oXrASEw435R222pO3ASMgeebBTEI=
Received: by pali.im (Postfix)
        id CF479BF4; Wed, 27 May 2020 13:09:07 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v2 1/2] mmc: core: Do not export MMC_NAME= and MODALIAS=mmc:block for SDIO cards
Date:   Wed, 27 May 2020 13:08:57 +0200
Message-Id: <20200527110858.17504-1-pali@kernel.org>
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
Changes in V2:
* Use early returns pattern
---
 drivers/mmc/core/bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 74de3f2dd..b1cb447da 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -93,6 +93,13 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 			return retval;
 	}
 
+	/*
+	 * SDIO (non-combo) cards are not handled by mmc_block driver and do not
+	 * have accessible CID register which used by mmc_card_name() function.
+	 */
+	if (card->type == MMC_TYPE_SDIO)
+		return 0;
+
 	retval = add_uevent_var(env, "MMC_NAME=%s", mmc_card_name(card));
 	if (retval)
 		return retval;
-- 
2.20.1

