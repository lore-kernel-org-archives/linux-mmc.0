Return-Path: <SRS0=9Cpo=BG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB62C433E3
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 13:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6F621744
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 13:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595857136;
	bh=WBaMbqOzM7xTyiTHBeAekdobhisWTjL6P+5D2OeDLO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hGQv0afEyiTriaK3/eTjzdLh5Ce2DM3q1V+uEZvysg/lC3AarY7sZfPEVfEo3EFxw
	 dUV84gGv7G7d5koellutbRvcCbI1CI5KZydEUxm8iZ/MLsD6DjeHyGCtPQqhmoSYGX
	 wnfk1kktx/us9CZQWOhpBeGW2HSuFHadZIo7l3m4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgG0Niy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgG0Niy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Jul 2020 09:38:54 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F6312083B;
        Mon, 27 Jul 2020 13:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595857133;
        bh=WBaMbqOzM7xTyiTHBeAekdobhisWTjL6P+5D2OeDLO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j8PRSVZZK4nQHBOp3WFeCS+yLq/YvOO3h5UYIxAAvB3AqBe5k4pR+S9nrJKQbh6kv
         V+VuhISouUl85Ma8r93SRM3BMl3i/cUxwKd/ZltZBfz7t+rmwPwp/JoULGug1U9HZe
         VZdUBi5MQS4E611KayVkmIjAFmtjTEpEXIdPtUjc=
Received: by pali.im (Postfix)
        id 88D42CB0; Mon, 27 Jul 2020 15:38:51 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mmc: sdio: Parse CISTPL_VERS_1 major and minor revision numbers
Date:   Mon, 27 Jul 2020 15:38:35 +0200
Message-Id: <20200727133837.19086-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727133837.19086-1-pali@kernel.org>
References: <20200727133837.19086-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

They should indicate compliance of standard.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/mmc/core/sdio_cis.c   | 8 ++++++++
 include/linux/mmc/card.h      | 2 ++
 include/linux/mmc/sdio_func.h | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index 3efaa9534a77..44bea5e4aeda 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -23,12 +23,16 @@
 static int cistpl_vers_1(struct mmc_card *card, struct sdio_func *func,
 			 const unsigned char *buf, unsigned size)
 {
+	u8 major_rev, minor_rev;
 	unsigned i, nr_strings;
 	char **buffer, *string;
 
 	if (size < 2)
 		return 0;
 
+	major_rev = buf[0];
+	minor_rev = buf[1];
+
 	/* Find all null-terminated (including zero length) strings in
 	   the TPLLV1_INFO field. Trailing garbage is ignored. */
 	buf += 2;
@@ -60,9 +64,13 @@ static int cistpl_vers_1(struct mmc_card *card, struct sdio_func *func,
 	}
 
 	if (func) {
+		func->major_rev = major_rev;
+		func->minor_rev = minor_rev;
 		func->num_info = nr_strings;
 		func->info = (const char**)buffer;
 	} else {
+		card->major_rev = major_rev;
+		card->minor_rev = minor_rev;
 		card->num_info = nr_strings;
 		card->info = (const char**)buffer;
 	}
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 7d46411ffaa2..42df06c6b19c 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -297,6 +297,8 @@ struct mmc_card {
 	struct sdio_cis		cis;		/* common tuple info */
 	struct sdio_func	*sdio_func[SDIO_MAX_FUNCS]; /* SDIO functions (devices) */
 	struct sdio_func	*sdio_single_irq; /* SDIO function when only one IRQ active */
+	u8			major_rev;	/* major revision number */
+	u8			minor_rev;	/* minor revision number */
 	unsigned		num_info;	/* number of info strings */
 	const char		**info;		/* info strings */
 	struct sdio_func_tuple	*tuples;	/* unknown common tuples */
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index fa2aaab5e57a..478855b8e406 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -51,6 +51,8 @@ struct sdio_func {
 
 	u8			*tmpbuf;	/* DMA:able scratch buffer */
 
+	u8			major_rev;	/* major revision number */
+	u8			minor_rev;	/* minor revision number */
 	unsigned		num_info;	/* number of info strings */
 	const char		**info;		/* info strings */
 
-- 
2.20.1

