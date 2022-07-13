Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D924C43334
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jul 2022 03:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiGMDE5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 23:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiGMDE3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 23:04:29 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B2D57210
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 20:04:24 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220713030422epoutp03b078d45e6799e1a9373c0beeb3a3bc1f~BRIHTFOy72022320223epoutp03Y
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 03:04:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220713030422epoutp03b078d45e6799e1a9373c0beeb3a3bc1f~BRIHTFOy72022320223epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657681462;
        bh=/lB8NfEWPcoDNoFFwCscjqrRZBR6b9QVHmnewa2rWjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwevCYYewyQ7rpp4aPZK69bhx6F+NIabdyvA9ZiQhvUoakpilCcUEJW9bCkF2pV/9
         t9LaA8gHgRwSflUGOF2EIlDmfJCLw+2AWn4CSJpnGF84/0Oy/g92odoisecWzEd9uV
         tngCxICUB+3AMvroDKKhewkvF4HYPKCa5Ld9XiPE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220713030421epcas1p110f34975c48afa5d1d2470cd1017f7b4~BRIHEAo7D1616916169epcas1p1j;
        Wed, 13 Jul 2022 03:04:21 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.248]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LjMsd4NBBz4x9Py; Wed, 13 Jul
        2022 03:04:21 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.57.09633.5363EC26; Wed, 13 Jul 2022 12:04:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220713030421epcas1p36f8328bdaa0c60488ce8c30adb7eda65~BRIGVqYWf2834128341epcas1p33;
        Wed, 13 Jul 2022 03:04:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220713030421epsmtrp29f8eb74466222e51e019f40eb434ba56~BRIGU-sOD1624216242epsmtrp2V;
        Wed, 13 Jul 2022 03:04:21 +0000 (GMT)
X-AuditID: b6c32a36-05fff700000025a1-7e-62ce363526d3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.2E.08905.5363EC26; Wed, 13 Jul 2022 12:04:21 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.71]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220713030421epsmtip153ef357715ee9e696c853a2a0aaa34ee~BRIGMCjD32380823808epsmtip1g;
        Wed, 13 Jul 2022 03:04:21 +0000 (GMT)
From:   Seunghui Lee <sh043.lee@samsung.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc:     Seunghui Lee <sh043.lee@samsung.com>
Subject: [PATCH v2 1/2] mmc: core: use mmc_card_* macro and add it for
 sd_combo
Date:   Wed, 13 Jul 2022 12:36:34 +0900
Message-Id: <20220713033635.28432-2-sh043.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220713033635.28432-1-sh043.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmvq6p2bkkg02L5SyO/O9ntGj6s4/F
        4vjacAdmjzvX9rB59G1ZxejxeZNcAHNUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6h
        pYW5kkJeYm6qrZKLT4CuW2YO0B4lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFZ
        gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGrebfTAX9uhXvp81hb2D8qdLFyMkhIWAi8aFhHmsX
        IxeHkMAORok3f+8xQzifGCXuPPzAAuF8Y5ToPXWUGablwpazUFV7GSVet8xhB0kICXxmlJi4
        gAnEZhPQkpi+aQuYLSJgKtGyu5ERxGYW0JB42TCBDcQWFgiUOD5jCyuIzSKgKrF1zlewBbwC
        VhKTv3SwQyyTl/hzvwcszilgLdG15QETRI2gxMmZT1ggZspLNG+dDXaQhMAudondx2YxQjS7
        SEx50AY1SFji1fEtULaUxOd3e9kg7GKJtn//oD6rkDjY9wXKNpb49Pkz0BwOoAWaEut36UOE
        FSV2/p4L9QufxLuvPawgJRICvBIdbUIQJcoSLx8tY4KwJSWWtN+CmughMedLFzRA+xgl/k6+
        wDqBUWEWkndmIXlnFsLmBYzMqxjFUguKc9NTiw0LjOAxnJyfu4kRnO60zHYwTnr7Qe8QIxMH
        4yFGCQ5mJRHeP2dPJQnxpiRWVqUW5ccXleakFh9iNAUG9kRmKdHkfGDCzSuJNzSxNDAxMzKx
        MLY0NlMS51017XSikEB6YklqdmpqQWoRTB8TB6dUA1Og32ydUPvPz5nOJkpPvRjp8vPja+YD
        MRzl89gWF/CHrki9f4Cd59Luv3+XNRctmuCS7Pcg5MiJDXon0pLOdq3bYpR5ZkbqgQdTGTad
        2FKdfCu/7oT6prgTXk+KRU7zbUtg7VKMfx/tNsmgZJ77u3ucX9fGu+lN1F33w6bjKYsfZ96F
        BN+l2U+arxbe8k9qeFd1p7wt/vj/yZOq/gm+zWuz+x4qE13wblPvmnb3xrbpoiKBVfdePOX9
        d+Gl3JENH59krUpmCGxbsEitvv6xg/yBnM/zu4wZtjYGJs4z+PS43Vv/dbmvnuKqzQdt78Wy
        8hfNTorM8Yj/e2n5m0OMS1Z8vX17wUQ2jn/Sfyyn3RJSYinOSDTUYi4qTgQA7+jSQAAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSnK6p2bkkg1lP2SyO/O9ntGj6s4/F
        4vjacAdmjzvX9rB59G1ZxejxeZNcAHMUl01Kak5mWWqRvl0CV8at5t9MBf26Fe+nzWFvYPyp
        0sXIySEhYCJxYctZ5i5GLg4hgd2MEpcW9DBBJCQlFj96yNbFyAFkC0scPlwMEhYS+Mgo8e1O
        PYjNJqAlMX3TFrByEQFziYfLWphBbGYBDYmXDRPYQGxhAX+Jr2uvMILYLAKqElvnfAWr4RWw
        kpj8pYMdYpW8xJ/7PWBxTgFria4tD5ggdllJfJp2nRGiXlDi5MwnLBDz5SWat85mnsAoMAtJ
        ahaS1AJGplWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMFBqaW5g3H7qg96hxiZOBgP
        MUpwMCuJ8P45eypJiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkm
        Dk6pBiaOO51npHuCT7w32v17352Gb7JaBoK6fD2xsvOO7Nh+4/XLe/y6HUpNjovMteofF4b2
        MJgz3smeZLnw1YW3yx8oGH3x2JBysFw0/FvCbf3XOfuOeey7cEj8FGOPwPnpcw43W/53lC5N
        b+wUu/qBlcus7/YOQcWGzhTplZbzZmS0JX7qq+P2OyrsJTKBrynVRT3P/6Rxb4hrdZig5bqc
        aVtOKzUvds+8eG3doT3MwodTJ+xOkRec+9Dn4U+bSfqpTQz195ZN2Rpa9NdRQf5kDFPz7Txp
        lbqb5gmvbKY+S9gcZ3ttU9g3/8C/9tprrqbcSOj27LzXt9TwVsadurvbQyae9jFY/NPlSpAR
        U8iRu0osxRmJhlrMRcWJAM88ihO5AgAA
X-CMS-MailID: 20220713030421epcas1p36f8328bdaa0c60488ce8c30adb7eda65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713030421epcas1p36f8328bdaa0c60488ce8c30adb7eda65
References: <20220713033635.28432-1-sh043.lee@samsung.com>
        <CGME20220713030421epcas1p36f8328bdaa0c60488ce8c30adb7eda65@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

add mmc_card_sd_combo() macro for sd combo type card and
use mmc_card_* macro to simplify instead of comparing card->type

Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
---
 drivers/mmc/core/block.c |  4 ++--
 drivers/mmc/core/bus.c   |  4 ++--
 drivers/mmc/core/sd.c    |  2 +-
 drivers/mmc/core/sdio.c  | 16 ++++++++--------
 include/linux/mmc/card.h |  1 +
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index bda6c67ce93f..4d7ae8fc2901 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2987,7 +2987,7 @@ static int mmc_blk_probe(struct mmc_card *card)
 	 * Don't enable runtime PM for SD-combo cards here. Leave that
 	 * decision to be taken during the SDIO init sequence instead.
 	 */
-	if (card->type != MMC_TYPE_SD_COMBO) {
+	if (!mmc_card_sd_combo(card)) {
 		pm_runtime_set_active(&card->dev);
 		pm_runtime_enable(&card->dev);
 	}
@@ -3014,7 +3014,7 @@ static void mmc_blk_remove(struct mmc_card *card)
 		mmc_blk_part_switch(card, md->part_type);
 		mmc_release_host(card->host);
 	}
-	if (card->type != MMC_TYPE_SD_COMBO)
+	if (!mmc_card_sd_combo(card))
 		pm_runtime_disable(&card->dev);
 	pm_runtime_put_noidle(&card->dev);
 	mmc_blk_remove_req(md);
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 58a60afa650b..d8762fa3d5cd 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -85,7 +85,7 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 			return retval;
 	}
 
-	if (card->type == MMC_TYPE_SDIO || card->type == MMC_TYPE_SD_COMBO) {
+	if (mmc_card_sdio(card) || mmc_card_sd_combo(card)) {
 		retval = add_uevent_var(env, "SDIO_ID=%04X:%04X",
 					card->cis.vendor, card->cis.device);
 		if (retval)
@@ -107,7 +107,7 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 	 * SDIO (non-combo) cards are not handled by mmc_block driver and do not
 	 * have accessible CID register which used by mmc_card_name() function.
 	 */
-	if (card->type == MMC_TYPE_SDIO)
+	if (mmc_card_sdio(card))
 		return 0;
 
 	retval = add_uevent_var(env, "MMC_NAME=%s", mmc_card_name(card));
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c5f1df6ce4c0..f0186bdf2025 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -793,7 +793,7 @@ static umode_t sd_std_is_visible(struct kobject *kobj, struct attribute *attr,
 	     attr == &dev_attr_info2.attr ||
 	     attr == &dev_attr_info3.attr ||
 	     attr == &dev_attr_info4.attr
-	    ) && card->type != MMC_TYPE_SD_COMBO)
+	    ) &&!mmc_card_sd_combo(card))
 		return 0;
 
 	return attr->mode;
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 25799accf8a0..b589df1c35e0 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -335,7 +335,7 @@ static int sdio_disable_4bit_bus(struct mmc_card *card)
 {
 	int err;
 
-	if (card->type == MMC_TYPE_SDIO)
+	if (mmc_card_sdio(card))
 		goto out;
 
 	if (!(card->host->caps & MMC_CAP_4_BIT_DATA))
@@ -360,7 +360,7 @@ static int sdio_enable_4bit_bus(struct mmc_card *card)
 	err = sdio_enable_wide(card);
 	if (err <= 0)
 		return err;
-	if (card->type == MMC_TYPE_SDIO)
+	if (mmc_card_sdio(card))
 		goto out;
 
 	if (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4) {
@@ -415,7 +415,7 @@ static int sdio_enable_hs(struct mmc_card *card)
 	int ret;
 
 	ret = mmc_sdio_switch_hs(card, true);
-	if (ret <= 0 || card->type == MMC_TYPE_SDIO)
+	if (ret <= 0 || mmc_card_sdio(card))
 		return ret;
 
 	ret = mmc_sd_switch_hs(card);
@@ -441,7 +441,7 @@ static unsigned mmc_sdio_get_max_clock(struct mmc_card *card)
 		max_dtr = card->cis.max_dtr;
 	}
 
-	if (card->type == MMC_TYPE_SD_COMBO)
+	if (mmc_card_sd_combo(card))
 		max_dtr = min(max_dtr, mmc_sd_get_max_clock(card));
 
 	return max_dtr;
@@ -689,7 +689,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	    mmc_sd_get_cid(host, ocr & rocr, card->raw_cid, NULL) == 0) {
 		card->type = MMC_TYPE_SD_COMBO;
 
-		if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO ||
+		if (oldcard && (!mmc_card_sd_combo(oldcard) ||
 		    memcmp(card->raw_cid, oldcard->raw_cid, sizeof(card->raw_cid)) != 0)) {
 			err = -ENOENT;
 			goto mismatch;
@@ -697,7 +697,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	} else {
 		card->type = MMC_TYPE_SDIO;
 
-		if (oldcard && oldcard->type != MMC_TYPE_SDIO) {
+		if (oldcard && !mmc_card_sdio(oldcard)) {
 			err = -ENOENT;
 			goto mismatch;
 		}
@@ -754,7 +754,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Read CSD, before selecting the card
 	 */
-	if (!oldcard && card->type == MMC_TYPE_SD_COMBO) {
+	if (!oldcard && mmc_card_sd_combo(card)) {
 		err = mmc_sd_get_csd(card);
 		if (err)
 			goto remove;
@@ -827,7 +827,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 
 	mmc_fixup_device(card, sdio_fixup_methods);
 
-	if (card->type == MMC_TYPE_SD_COMBO) {
+	if (mmc_card_sd_combo(card)) {
 		err = mmc_sd_setup_card(host, card, oldcard != NULL);
 		/* handle as SDIO-only card if memory init failed */
 		if (err) {
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 37f975875102..156a7b673a28 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -348,5 +348,6 @@ bool mmc_card_is_blockaddr(struct mmc_card *card);
 #define mmc_card_mmc(c)		((c)->type == MMC_TYPE_MMC)
 #define mmc_card_sd(c)		((c)->type == MMC_TYPE_SD)
 #define mmc_card_sdio(c)	((c)->type == MMC_TYPE_SDIO)
+#define mmc_card_sd_combo(c)	((c)->type == MMC_TYPE_SD_COMBO)
 
 #endif /* LINUX_MMC_CARD_H */
-- 
2.29.0

