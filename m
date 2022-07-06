Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A13C43334
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Jul 2022 00:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiGFAwt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Jul 2022 20:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGFAws (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2022 20:52:48 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A4167D5
        for <linux-mmc@vger.kernel.org>; Tue,  5 Jul 2022 17:52:46 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220706005239epoutp012333d37b46b27e2e5a290281182e52d7~-F0Hi3eMA1796517965epoutp01G
        for <linux-mmc@vger.kernel.org>; Wed,  6 Jul 2022 00:52:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220706005239epoutp012333d37b46b27e2e5a290281182e52d7~-F0Hi3eMA1796517965epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657068759;
        bh=3qOA22KIZ8UnyRLyY8gpIeBzuDwAtoj/Gg7CHItBVTQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lj+MdP8wPsSFGnem87l+AEq1sHN7yXaVAwl84lWJ3O04PWwciWmyfJ4OU3m1HOGE1
         vQrrUjaplFa5bjH6UHDSNSj4UJbI26dxCbjEeiseNdIwj8cd1bxGM/tMrnKQq1v2fc
         /9/U1prNjcJXMW69KuVdKN95y3a6TpffHBGXMW2k=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220706005239epcas1p1c71a47d2791d92b198c2852c61333037~-F0HLsfEV2207322073epcas1p1J;
        Wed,  6 Jul 2022 00:52:39 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.249]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Ld1Gt6FtFz4x9Q7; Wed,  6 Jul
        2022 00:52:38 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.CD.09678.6DCD4C26; Wed,  6 Jul 2022 09:52:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220706005238epcas1p110ad467f1406cb9270e449de998090a9~-F0GfqE6T2295522955epcas1p1z;
        Wed,  6 Jul 2022 00:52:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220706005238epsmtrp2c33e478436fd5fa3f441472744cc96f8~-F0Ge6bvI1974019740epsmtrp2F;
        Wed,  6 Jul 2022 00:52:38 +0000 (GMT)
X-AuditID: b6c32a39-e67ff700000025ce-7e-62c4dcd609ce
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.10.08802.6DCD4C26; Wed,  6 Jul 2022 09:52:38 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220706005238epsmtip14b0d1dd828e4d702897284f0b4a88f51~-F0GRPzz-2298622986epsmtip1M;
        Wed,  6 Jul 2022 00:52:38 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     ulf.hansson@linaro.org, s.shtylyov@omp.ru, huijin.park@samsung.com,
        andrej.skvortzov@gmail.com, linus.walleij@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     ChanWoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH] Replace with already defined values for readability
Date:   Wed,  6 Jul 2022 09:48:40 +0900
Message-Id: <20220706004840.24812-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmge61O0eSDE4vMbaYdfk8m8WMU22s
        Fh0XXSym/FnOZHHkfz+jxZaWv0wWx9eGO7B77Jx1l93jzrU9bB47btt49G1ZxejxeZNcAGtU
        tk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0A1KCmWJ
        OaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM
        ud/+sRYs4664s6iugbGHs4uRg0NCwERi54aILkZODiGBHYwS275xdDFyAdmfGCXWzJjKApH4
        zChx80QoiA1S//95KxNE0S5GiZ6rH1ggnC+MEusev2QEmcomoCVx+5g3SFxEYDZQ0b97rCDd
        zAIaEidnPWEHsYUFXCT2v5sEFmcRUJU48Ogw2DZeAWuJZwubmSC2yUv8ud/DDBEXlDg58wkL
        xBx5ieats5lBFkgInGKXWPHmFhtEg4vE7dvfoWxhiVfHt7BD2FISn9/tZYNoaAb68+slJgin
        g1FiY+sLRogqY4lPnz+DvcAsoCmxfpc+RFhRYufvuYwQm/kk3n3tYYWEHa9ER5sQRImKxJyu
        c2wwuz7eeMwKYXtIdB85zwQJxliJ9asOsU1glJ+F5J9ZSP6ZhbB4ASPzKkax1ILi3PTUYsMC
        U3icJufnbmIEp0Ityx2M099+0DvEyMTBeIhRgoNZSYR31aSDSUK8KYmVValF+fFFpTmpxYcY
        TYEhPJFZSjQ5H5iM80riDU0sDUzMjEwsjC2NzZTEeVdNO50oJJCeWJKanZpakFoE08fEwSnV
        wFRy3SlzKb+fkQf3tdmrdb9Hb0tgbF3ZGLYwwPd3oeHSiFObnppqhFpUO2tFenTkpH7nXMJq
        ZWvq89NX5MeOsKmhCvK7Z2pW7c2sTfgk/GUxV83N5QaqFRO5XuamRLFJT1tg4/BsSeGetUxs
        tncl4vbULA25uXLt2QerZa1WeHGaVf/Z1/9NMF+7pG7OocDNiVuqN5ruXXIqS1U7OkSje0Fy
        iez+e59s7R7UnNJeEmXz6MLa5DUra9pMLy9hmn1iuu8dRS/tM2UBYnZ1ryKd2Y6sMTr7cjlj
        NrP3bqOa9wVyh0wuSQt/W6b28d/EB/khhhetNIXdBFhsORbtXqy8S6jgx/PYNz8WPsqes6Ax
        V4mlOCPRUIu5qDgRACzrKREOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSnO61O0eSDCb3iVnMunyezWLGqTZW
        i46LLhZT/ixnsjjyv5/RYkvLXyaL42vDHdg9ds66y+5x59oeNo8dt208+rasYvT4vEkugDWK
        yyYlNSezLLVI3y6BK2Put3+sBcu4K+4sqmtg7OHsYuTkkBAwkfj/vJWpi5GLQ0hgB6PE2Uk7
        mCASUhK7959n62LkALKFJQ4fLoao+cQosf36N2aQOJuAlsTtY94g5SICCxklzrdogNjMAhoS
        J2c9YQexhQVcJPa/m8QKYrMIqEoceHSYBcTmFbCWeLawGWqVvMSf+z3MEHFBiZMzn7BAzJGX
        aN46m3kCI98sJKlZSFILGJlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEh6aW1g7G
        Pas+6B1iZOJgPMQowcGsJMK7atLBJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeW
        pGanphakFsFkmTg4pRqYKhgyZ2z6pnP5h1FqnGqWQMrLY3ue+Qf5BmRI79+xKbl9jkHaL5Nn
        ffEhmlaF5rkm658vmdn0PjFCQ3bG9IoE7cWvFIomO9nJeJ8Xv6JUqeu5rqv7/OlHWwJ7r/5c
        PMFt8ksLph9u3YHS3x79endVePP1BD6mW7MPOdlem9ewt/TE/yQllsKtxZPKKnIuZwaLr9OO
        UnzTkL37LnPfLpfSl4x3l36JTnL8nC6S7smwNbyV28anVqYqPvii9sqE/ev9erJEryluK3aa
        0Fmrudn9+5X/2RvzzLPL2KYtW31SdmPQjndn6hoLUsV7/oSIGiy8s1ZyNY/aNYd5TEWi/OFq
        V9PZku94pK9h2vNzxT8lluKMREMt5qLiRAAtrvz0vAIAAA==
X-CMS-MailID: 20220706005238epcas1p110ad467f1406cb9270e449de998090a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220706005238epcas1p110ad467f1406cb9270e449de998090a9
References: <CGME20220706005238epcas1p110ad467f1406cb9270e449de998090a9@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

SD_ROCR_S18A is already defined
and is used to check the rocr value as shown below.

So, replace with already defined values for readability.

--------------------------------------------------
/sd.h
.#define SD_OCR_S18R    (1 << 24)    /* 1.8V switching request */
.#define SD_ROCR_S18A   SD_OCR_S18R  /* 1.8V switching accepted by card */

/sd.c
static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
	struct mmc_card *oldcard)
{
...
        if (rocr & SD_ROCR_S18A && mmc_host_uhs(host)) {
                err = mmc_sd_init_uhs_card(card);
}
-------------------------------------------------

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/mmc/core/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c5f1df6ce4c0..d2023837dd72 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -870,7 +870,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	 * the CCS bit is set as well. We deliberately deviate from the spec in
 	 * regards to this, which allows UHS-I to be supported for SDSC cards.
 	 */
-	if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x01000000)) {
+	if (!mmc_host_is_spi(host) && rocr && (*rocr & SD_ROCR_S18A)) {
 		err = mmc_set_uhs_voltage(host, pocr);
 		if (err == -EAGAIN) {
 			retries--;
-- 
2.29.0

