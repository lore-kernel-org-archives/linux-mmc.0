Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEB5C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Feb 2021 08:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6857C64DA5
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Feb 2021 08:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBVIQF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Feb 2021 03:16:05 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:39307 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhBVIQD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Feb 2021 03:16:03 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210222081519epoutp01da4e1da257e46759eef4536091453d46~mA9Kd2PR91679416794epoutp01s
        for <linux-mmc@vger.kernel.org>; Mon, 22 Feb 2021 08:15:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210222081519epoutp01da4e1da257e46759eef4536091453d46~mA9Kd2PR91679416794epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613981719;
        bh=YoUlv36H2rILg+JTXk1la+doFVImFBaKXU7o06vDG50=;
        h=From:To:Cc:Subject:Date:References:From;
        b=gIfpll40eCjW4JJZit2vl8gUJA+zQL913SqqsExzznUGM7C/MpRtyPUA8P+oD1mNR
         fzwZo0LRnBTMwODCB0GzkzaAhkEgT7n3tBLhglGuLhpLFiAXuXbgx+aXAA84O/38me
         RFAjx4xxBIa11zl2mbJNA73Xo7b8leU4WBP7iLQ0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210222081518epcas1p3dbf9ad9271838002cfeea1cde9379012~mA9JzY2j00598905989epcas1p3A;
        Mon, 22 Feb 2021 08:15:18 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.159]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DkZjx69vmz4x9QR; Mon, 22 Feb
        2021 08:15:17 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.9D.10463.51863306; Mon, 22 Feb 2021 17:15:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210222081517epcas1p37fef998684dc9eae0bcd2764a3f82fb1~mA9IVP9bm0598905989epcas1p31;
        Mon, 22 Feb 2021 08:15:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210222081517epsmtrp27d655bb8c526952c3c5405340743680f~mA9ITYSJA0340803408epsmtrp2l;
        Mon, 22 Feb 2021 08:15:17 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-10-60336815c38a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.F0.13470.51863306; Mon, 22 Feb 2021 17:15:17 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.71]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210222081516epsmtip20c6a4c6591c85c63e46cf5513b5fceae~mA9ICvqNU1132911329epsmtip2T;
        Mon, 22 Feb 2021 08:15:16 +0000 (GMT)
From:   Seunghui Lee <sh043.lee@samsung.com>
To:     ulf.hansson@linaro.org, pali@kernel.org, huyue2@yulong.com,
        tiantao6@hisilicon.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, junwoo80.lee@samsung.com,
        jangsub.yi@samsung.com, cw9316.lee@samsung.com,
        sh8267.baek@samsung.com, wkon.kim@samsung.com,
        Seunghui Lee <sh043.lee@samsung.com>
Subject: [PATCH] mmc: core: set read only with permanent write protect
Date:   Mon, 22 Feb 2021 17:31:56 +0900
Message-Id: <20210222083156.19158-1-sh043.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmga5ohnGCwZ4eA4sZp9pYLfZdO8lu
        8evvenaLPbPvMlt0bJ3MZLHj+Rl2i11/m5ksLu+aw2Zx5H8/o8WCPafZLJr+7GOxuHbmBKvF
        6tf72C2Orw232HzpG4sDv8fjuRvZPTat6mTzuHNtD5tH35ZVjB6fN8l5bF2zmDmALSrHJiM1
        MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoZCWFssScUqBQ
        QGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgaFBgV5xYm5xaV66XnJ+rpWhgYGRKVBlQk5GY/d9
        loJvHBXf/19naWCcw97FyMkhIWAicfDcQZYuRi4OIYEdjBL7jn+Gcj4xStx88Y0NwvnGKDFx
        +1Y2mJa1q5sZIRJ7GSXOPVzLDOF8ZpS4suQi2GA2AS2J6Zu2MIEkRAQmM0osO7kYbDCzwAdG
        iV99K5lAqoQF3CQe9C0Hm8sioCpx+fFUVhCbV8BK4srWq8wQ++Ql/tzvYYaIC0qcnPmEBcRm
        Boo3b50NtlpCYCqHxLovnVA/uUjM7F4NZQtLvDq+BcqWkvj8bi8bREM3o8Thl+9YIZweRonN
        i0+xQlQZS3z6/BnoPQ6gFZoS63fpQ4QVJXb+nssIsZlP4t3XHlaQEgkBXomONiGIEmWJl4+W
        MUHYkhJL2m9BPeAhcX3DXBaQciGBWIln93InMMrPQvLOLCTvzELYu4CReRWjWGpBcW56arFh
        gQlyxG5iBCddLYsdjHPfftA7xMjEwXiIUYKDWUmEl+2uUYIQb0piZVVqUX58UWlOavEhRlNg
        AE9klhJNzgem/bySeENTI2NjYwsTM3MzU2Mlcd4kgwfxQgLpiSWp2ampBalFMH1MHJxSDUyh
        tkyXM3Qvep9ZfHtp9de/wbPuHotfuejICaaL+olsrz63vX2X6hK45p3BpWduPoz6Tj9Pbpyr
        5OdtdvL2h5vszCsSjHl2llmf06vwPiOtlKT5T+vby3t5XC8YgnIVhJhDmW/FtV2SX+/9cfuO
        A5Y23CdthB1XvJYvZbqgfif2WJXB2aqjUbs/3kz+W7dhiiRDltoFjeWHls9K+7O1rVsh6dOy
        QGvDnurX3cd90x3WMXx9f/rHHh6/UNWPWcuDJhYbRp28f/vfQd2Xq8v/HisxnMinz9E7cepR
        N79y7xsv3uVvnfLa7fuyQB+O9+kzdver6FduumqTxXRavXmP2E6WAivO5wfelh8MnLEoKkBD
        iaU4I9FQi7moOBEAO6EB5kMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSvK5ohnGCQd8ETosZp9pYLfZdO8lu
        8evvenaLPbPvMlt0bJ3MZLHj+Rl2i11/m5ksLu+aw2Zx5H8/o8WCPafZLJr+7GOxuHbmBKvF
        6tf72C2Orw232HzpG4sDv8fjuRvZPTat6mTzuHNtD5tH35ZVjB6fN8l5bF2zmDmALYrLJiU1
        J7MstUjfLoEro7H7PkvBN46K7/+vszQwzmHvYuTkkBAwkVi7upmxi5GLQ0hgN6PE5dlLWSAS
        khKLHz1k62LkALKFJQ4fLoao+cgoMeP2YbBmNgEtiembtjCBJEQEZjJK7Fp2lR3EYRb4xSix
        Y+oyNpAqYQE3iQd9y8FsFgFVicuPp7KC2LwCVhJXtl5lhtgmL/Hnfg8zRFxQ4uTMJ2BXMAPF
        m7fOZp7AyDcLSWoWktQCRqZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBEaCluYNx
        +6oPeocYmTgYDzFKcDArifCy3TVKEOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJ
        anZqakFqEUyWiYNTqoFJ/4L2uxA9UZNF78u4bRK2t578uKZdZk1gzLss8XUeMR/21LkatzKe
        ObT3pbBbP/vmuxon9++0dDyeOzHmF/eSqeX83wuVDHefPX1crzNz79nchwfqNzxWOcsmUKEf
        c+KTNF/Lwdz09vMm37cUT/5qtfek7KP9tdE575/cddaboitlED+dy+yn08sZ7x0uun6c4fyp
        YP7VMzLb/fZ8e6PwKWxe6VePLSuVmCdq5HbU/4zbl9c+X2SuntlSsZ+lUgW1/gl/GPw/n3OU
        idunze5dqvU++PS3zKCjaTPiOp4pl5SHHdkXHPjcRu7kx2X774t0KYjJZ/FVJlVImqh5ijQ1
        Lz1V3L/CSKI/95i9p5sSS3FGoqEWc1FxIgA0qSED7wIAAA==
X-CMS-MailID: 20210222081517epcas1p37fef998684dc9eae0bcd2764a3f82fb1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210222081517epcas1p37fef998684dc9eae0bcd2764a3f82fb1
References: <CGME20210222081517epcas1p37fef998684dc9eae0bcd2764a3f82fb1@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some of SD cards sets permanent write protection
due to lifespan or internal problem.
Host can find out it's protected permanantly during initialization.
Once set read only during initialization,
it could prevent unnecessary write operation in it.

Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
---
 drivers/mmc/core/sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6fa51a6ed058..2c48d6504101 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -135,6 +135,9 @@ static int mmc_decode_csd(struct mmc_card *card)
 			csd->erase_size = UNSTUFF_BITS(resp, 39, 7) + 1;
 			csd->erase_size <<= csd->write_blkbits - 9;
 		}
+
+		if (UNSTUFF_BITS(resp, 13, 1))
+			mmc_card_set_readonly(card);
 		break;
 	case 1:
 		/*
@@ -169,6 +172,9 @@ static int mmc_decode_csd(struct mmc_card *card)
 		csd->write_blkbits = 9;
 		csd->write_partial = 0;
 		csd->erase_size = 1;
+
+		if (UNSTUFF_BITS(resp, 13, 1))
+			mmc_card_set_readonly(card);
 		break;
 	default:
 		pr_err("%s: unrecognised CSD structure version %d\n",
-- 
2.29.0

