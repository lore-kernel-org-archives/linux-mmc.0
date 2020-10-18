Return-Path: <SRS0=vWfI=DZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F1AC433E7
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Oct 2020 19:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C79207DE
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Oct 2020 19:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603050352;
	bh=H4z9I9lFOofqBONBWteLXxjLefx9H4vflLddRM0CAnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G/q2MGu03N9SLkcPkNBwq8pIdqzmwulQVMyQ5ZUJyGn3n7F432nmef42nPQtDTzFs
	 4OBQUpSvK3b5Z7ygMLH2VH3DKUUaHSwAOj59UxTB38utDhw6U86EZBUqCv+c076j3Y
	 D78Dk+obHijeHgYyzoCQxyfpqij8DNVNX+LgkZCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbgJRTps (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729914AbgJRTXA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 18 Oct 2020 15:23:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B432B207DE;
        Sun, 18 Oct 2020 19:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603048980;
        bh=H4z9I9lFOofqBONBWteLXxjLefx9H4vflLddRM0CAnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wDFmbuvSYbWgbK/fzBGnu2EaEKHZLTatK0gABNQGaguvNbp/49OVDQ4/2+nUHdc5d
         WuizXtTdc1Q624NIQyEXDZWP8J2jYrxfYMLC/+nCbzQuzlfiZ2lcV0VWTIPeJXqPMl
         IRo+j8b2etDFFJG4qei87CarEEzWoVkVQFmnfjV8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 22/80] mmc: sdio: Check for CISTPL_VERS_1 buffer size
Date:   Sun, 18 Oct 2020 15:21:33 -0400
Message-Id: <20201018192231.4054535-22-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018192231.4054535-1-sashal@kernel.org>
References: <20201018192231.4054535-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 8ebe2607965d3e2dc02029e8c7dd35fbe508ffd0 ]

Before parsing CISTPL_VERS_1 structure check that its size is at least two
bytes to prevent buffer overflow.

Signed-off-by: Pali Rohár <pali@kernel.org>
Link: https://lore.kernel.org/r/20200727133837.19086-2-pali@kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/sdio_cis.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index e0655278c5c32..3efaa9534a777 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -26,6 +26,9 @@ static int cistpl_vers_1(struct mmc_card *card, struct sdio_func *func,
 	unsigned i, nr_strings;
 	char **buffer, *string;
 
+	if (size < 2)
+		return 0;
+
 	/* Find all null-terminated (including zero length) strings in
 	   the TPLLV1_INFO field. Trailing garbage is ignored. */
 	buf += 2;
-- 
2.25.1

