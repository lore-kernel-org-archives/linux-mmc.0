Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13AFC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jul 2022 03:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiGMDFB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 23:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbiGMDEs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 23:04:48 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697A7599F0
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 20:04:29 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220713030424epoutp04af0d2b6968bae7f86ca31c20a015facc~BRIJy_JiU0597705977epoutp04I
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 03:04:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220713030424epoutp04af0d2b6968bae7f86ca31c20a015facc~BRIJy_JiU0597705977epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657681464;
        bh=g+jVW+uY4ffE/d60sYxS6QVCmpVdjqYsRa1CXXz9QSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LRrf4PeuX9QiJvivSbYSK3f2UGctP/uXXBuMvASyPOhyQwTHVCUgkc/VpVSl3qx3m
         w6c0+6Svzg4fnZmQuOx4j5q8NoaRwIBPhNqDrYpdarNoIQN4BDTW29YdL19OrlCI5u
         iX5XO0UKpAXU6GEU9aZL3yyWBxOdBZ3wBoF5Nc7I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220713030424epcas1p18800020f235f5d85af45149a146c0215~BRIJTjuUw1617916179epcas1p1w;
        Wed, 13 Jul 2022 03:04:24 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.243]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LjMsh219Qz4x9Q1; Wed, 13 Jul
        2022 03:04:24 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.B6.10203.8363EC26; Wed, 13 Jul 2022 12:04:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220713030424epcas1p4475c8cdab89de60e8ecb16cf117ddf93~BRII8prET0180101801epcas1p4n;
        Wed, 13 Jul 2022 03:04:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220713030423epsmtrp267ea4c0de6cc63def6efeabddf672221~BRII8DOGk1647816478epsmtrp2X;
        Wed, 13 Jul 2022 03:04:23 +0000 (GMT)
X-AuditID: b6c32a38-5adff700000027db-0f-62ce363847bc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.2E.08905.7363EC26; Wed, 13 Jul 2022 12:04:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.71]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220713030423epsmtip1063b1f7ed2abf9eff3f5e5b073c8cf6f~BRIIyT1nm2441624416epsmtip1L;
        Wed, 13 Jul 2022 03:04:23 +0000 (GMT)
From:   Seunghui Lee <sh043.lee@samsung.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc:     Seunghui Lee <sh043.lee@samsung.com>
Subject: [PATCH v2 2/2] mmc: host: use mmc_card_sdio macro
Date:   Wed, 13 Jul 2022 12:36:35 +0900
Message-Id: <20220713033635.28432-3-sh043.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220713033635.28432-1-sh043.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmga6F2bkkg4P9vBZH/vczWjT92cdi
        cXxtuAOzx51re9g8+rasYvT4vEkugDkq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
        0sJcSSEvMTfVVsnFJ0DXLTMHaI+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8Cs
        QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvjzefkgsesFf0b6xoYX7B0MXJySAiYSGw7/JSxi5GL
        Q0hgB6PE4QUzmUASQgKfGCUWnE6EsL8xSrzoVoRp+PFpIQtEfC+jxJfZzhDNnxkltq86CNbM
        JqAlMX3TFjBbRMBUomV3IyOIzSygIfGyYQIbiC0sYCXx/PxBsDiLgKrEohkLwOK8QPGufT8Y
        IZbJS/y538MMYnMKWEt0bXnABFEjKHFy5hMWiJnyEs1bZzODHCEhsI1dYuO+C0CDOIAcF4kb
        D6sg5ghLvDq+hR3ClpL4/G4vG4RdLNH27x8zhF0hcbDvC5RtLPHp82dGkDHMApoS63fpQ4QV
        JXb+ngv1Cp/Eu689rBCbeCU62oQgSpQlXj5axgRhS0osab8FNdFD4vWn22yQYOtjlHh4o2AC
        o8IsJM/MQvLMLITFCxiZVzGKpRYU56anFhsWmMDjNjk/dxMjOMVpWexgnPv2g94hRiYOxkOM
        EhzMSiK8f86eShLiTUmsrEotyo8vKs1JLT7EaAoM6onMUqLJ+cAkm1cSb2hiaWBiZmRiYWxp
        bKYkzts79XSikEB6YklqdmpqQWoRTB8TB6dUA5PlF9GgC886XkY7tTOfzA3r2uA+q+ONQuqM
        y/rHSt3XLk/keeHd8Kzq7Wxrdq32w+cvH3x8X8eye3U563eRiEW9Mt9Um24w6eYqtPVfXVlp
        nhkn2LPh2a39Rcvmt/3aGuIev90yIMezXffI6e5trVpf5ZLMTALr2JbmmR9ymx1c5KF1X7eL
        22jGLJMF0/+3LlLYWFeqzMQeWb/wMEfC4+8tiixvgh+El1c+4yySj7oR43TO7WjZ+xWrppwo
        KCgL6zmT2pf04eWa49pLP4WKS4m9/VrWJ/Hn7rGF+qf//o5osvCck8Kctv/6OjEdqfiu1ct3
        WKa3mnjknp9vcrGnb8mtxH0Z7k8fPPsmdXDyYSWW4oxEQy3mouJEAPXXLfH6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSnK652bkkg0sXLC2O/O9ntGj6s4/F
        4vjacAdmjzvX9rB59G1ZxejxeZNcAHMUl01Kak5mWWqRvl0CV8abz8kFj1kr+jfWNTC+YOli
        5OSQEDCR+PFpIZDNxSEksJtRon/xZlaIhKTE4kcP2boYOYBsYYnDh4shaj4ySlw5vBismU1A
        S2L6pi1MILaIgLnEw2UtzCA2s4CGxMuGCWwgtrCAlcTz8wcZQWwWAVWJRTMWgMV5geJd+34w
        QuySl/hzvwesl1PAWqJrywOwmUJANZ+mXWeEqBeUODnzCQvEfHmJ5q2zmScwCsxCkpqFJLWA
        kWkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwSGpp7mDcvuqD3iFGJg7GQ4wSHMxK
        Irx/zp5KEuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoGp
        +cly7jdrkr1PZnOcVNTePfff1ZVFpeqZZ451Hf06wXeZ4nvpk8eNuQ38ZZZ5JXvyNz+6+zzh
        8qNfP+/PiZp6pjN+T8eK7I97bl+/oybMeLvp9Ze+R0cKXYIbPzq/e1qyPr9Uz4nxsDyD7aQS
        2U45vn/RJyy5F0SpP/Hzn39siqvPP8kyXz2GepHX055ICieeXzBngZr8Id1FTw8tku4oObzm
        xNqLDN8cnzNf3vDPbmr7Jbe5BbM7JuSnti3S9PB5/1733SW+jz+W9r44oHAgQGnB6s4IuU1H
        v+SdrFCVdJTxSlY58Cfl/Y8E/cLTbgcbZf5ITGGSVP+x/fbqzlRZntX1wjO2tgW/jYpebnh6
        ohJLcUaioRZzUXEiAPwCQ3y4AgAA
X-CMS-MailID: 20220713030424epcas1p4475c8cdab89de60e8ecb16cf117ddf93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713030424epcas1p4475c8cdab89de60e8ecb16cf117ddf93
References: <20220713033635.28432-1-sh043.lee@samsung.com>
        <CGME20220713030424epcas1p4475c8cdab89de60e8ecb16cf117ddf93@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

use mmc_card_sdio macro to simplify

Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
---
 drivers/mmc/host/mxcmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 613f13306433..2cf0413407ea 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -923,7 +923,7 @@ static void mxcmci_init_card(struct mmc_host *host, struct mmc_card *card)
 	 * One way to prevent this is to only allow 1-bit transfers.
 	 */
 
-	if (is_imx31_mmc(mxcmci) && card->type == MMC_TYPE_SDIO)
+	if (is_imx31_mmc(mxcmci) && mmc_card_sdio(card))
 		host->caps &= ~MMC_CAP_4_BIT_DATA;
 	else
 		host->caps |= MMC_CAP_4_BIT_DATA;
-- 
2.29.0

