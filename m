Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF60FC43334
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Jun 2022 01:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiF3Bsj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Jun 2022 21:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiF3Bsh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2022 21:48:37 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8953D3630C
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jun 2022 18:48:35 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220630014829epoutp041d4167e18a25ceecbe5e3eae7b15e76f~9QtKIIP3U2375923759epoutp04P
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jun 2022 01:48:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220630014829epoutp041d4167e18a25ceecbe5e3eae7b15e76f~9QtKIIP3U2375923759epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656553709;
        bh=cBJ+pi16fXfIwI8Nm9AJ40/bPrq8Ll92HTcRio+ez4o=;
        h=From:To:Cc:Subject:Date:References:From;
        b=eUVbyD0hEsLs/uFrK2kPdwzeyOyj/HnBQvzhqaedNYgEkz0k64CV9CGZwkKXNLuhr
         W8549sdJYfV48ptAulFcpvL5M7GGeUkhTNCl2P/fe0ZAfZI8TvrMjQmS4A3cAjapxS
         pk+j7DP1VwOsbuqYU617eQdKDUVADJ8GxyvUAIP8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220630014829epcas1p2aa5bb721e7d552b1e0df4024c295567e~9QtJtXmdi1513515135epcas1p2F;
        Thu, 30 Jun 2022 01:48:29 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.222]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LYLp52ghhz4x9QG; Thu, 30 Jun
        2022 01:48:29 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.C7.09657.DE00DB26; Thu, 30 Jun 2022 10:48:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220630014828epcas1p1e780542d769ff8189bb408449624ffb4~9QtJKa2XA0393303933epcas1p1g;
        Thu, 30 Jun 2022 01:48:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220630014828epsmtrp117240d8ebb3eb93db3f71071a8daa4be~9QtJJlXCz2936629366epsmtrp1c;
        Thu, 30 Jun 2022 01:48:28 +0000 (GMT)
X-AuditID: b6c32a35-733ff700000025b9-e1-62bd00ed320b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.76.08905.CE00DB26; Thu, 30 Jun 2022 10:48:28 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220630014828epsmtip27367e7e8d1aad55062433e10e79a11cd~9QtI8ERxV1228512285epsmtip2s;
        Thu, 30 Jun 2022 01:48:28 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com,
        ChanWoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH] Add define SDHCI_POWER_OFF to improve readability
Date:   Thu, 30 Jun 2022 10:44:25 +0900
Message-Id: <20220630014425.3643-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmnu5bhr1JBlvbRSxOPlnDZjHjVBur
        xb5rJ9ktfv1dz26x4/kZdosj//sZLZr+7GOxOL423IHDY/Gel0wed67tYfPo27KK0ePzJrkA
        lqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
        yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BWYFesWJucWleel6eaklVoYGBkamQIUJ
        2RkzTx5hLlgpXPHs427mBsZ+gS5GTg4JAROJOb1PmEFsIYEdjBLz9yR3MXIB2Z8YJZ586WSF
        cL4xSryc0sQE0/F0yj82iI69jBKPm3khir4wSnxddZqli5GDg01AS+L2MW+QGhGBAIlXK/tZ
        QGqYgXZK/DrYxQKSEBZwkjjee58RxGYRUJU4uOMz2Bm8AlYSP64dg1omL/Hnfg9UXFDi5Mwn
        YL3MQPHmrbOZQYZKCJxjl/j5+DIzRIOLxPIrKxkhbGGJV8e3sEPYUhIv+9vYIRqaGSW2fb3E
        BOF0MEpsbH0B1WEs8enzZ0aQF5gFNCXW79KHCCtK7Pw9lxFiM5/Eu689rCAlEgK8Eh1tQhAl
        KhJzus6xwez6eOMxK4TtITGnYwYTJLRiJc6eWsc4gVF+FpJ/ZiH5ZxbC4gWMzKsYxVILinPT
        U4sNCwzhsZqcn7uJEZwStUx3ME58+0HvECMTB+MhRgkOZiUR3oVndiYJ8aYkVlalFuXHF5Xm
        pBYfYjQFhvBEZinR5HxgUs4riTc0sTQwMTMysTC2NDZTEuddNe10opBAemJJanZqakFqEUwf
        EwenVAOT+zM/xlRHHbPv0+u3Ry73CZjN8fbMnEmvlh2fsGTN+W9bp5+fIc+VwvuvX5OrMCQ+
        5da3vJt9Mu9f2bb6PO+NCOJf466nIcWT3Rbvy9e+w0R9397wvVw8588d6P+6Ybt9426L5/0P
        Tj+t2Bv9+aLq1aBru57dflxtyLDA4ciDKYFWU63/ula33XOUfiB7mdmnpvDErQWd5ifXJK5+
        HiHauJSjLTdkRf7PkzFawod43ikrP1UusPV8K1Z4s/melto/2bB7333jwlxO8f4r0lfct9Lu
        +tei5Tt2NjJvVVk2V6p82lP1CvYbeUlNb2/c6omMNQk3/6yS3yWUfuPOopN590tNTvDvm8Jp
        Fr3lg5uvEktxRqKhFnNRcSIAZN1AMRIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWy7bCSvO4bhr1JBic/61qcfLKGzWLGqTZW
        i33XTrJb/Pq7nt1ix/Mz7BZH/vczWjT92cdicXxtuAOHx+I9L5k87lzbw+bRt2UVo8fnTXIB
        LFFcNimpOZllqUX6dglcGTNPHmEuWClc8ezjbuYGxn6BLkZODgkBE4mnU/6xdTFycQgJ7GaU
        eDvnCRtEQkpi9/7zQDYHkC0scfhwMUTNJ0aJG3vms4DE2QS0JG4f8wYpFxEIklj//BzYHGaB
        CYwSi6+8ZQZJCAs4SRzvvc8IYrMIqEoc3PEZLM4rYCXx49oxJohd8hJ/7vdAxQUlTs58wgJi
        MwPFm7fOZp7AyDcLSWoWktQCRqZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBIaql
        uYNx+6oPeocYmTgYDzFKcDArifAuPLMzSYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC
        6YklqdmpqQWpRTBZJg5OqQYmnf9dR5rDMkxur7KV61fseuh1ZjffigLrN0bqpjEvT2xLUQ6z
        flH89v6UzE0vDToWx78636t8Oflen+3tvxz56flFnsuT17OdmLBacOpmk3vGEae1b65OZV8S
        5lJuKR/w85nsfdbwGTtd+HX5SjxaDJbEFlvZsFmqWS226Vi5f+/xI6GxR5bkPvdcHiTL25Tj
        fsVa90eGZdD2aQHml+bM2tQ6I6lazrSxbsXRx1f25xRsfyxkUPHSTuX4g6ZjDRenxEb6edy0
        WXl1flZ8T43q9zqmt1uvdVrlNK9/se/+j2fua1YsTlpz6nR5fu7/qJg1vX4NgRnRiizhWqWf
        nJj4ea1Dmt4U//3z206g8IISS3FGoqEWc1FxIgCUEio5wAIAAA==
X-CMS-MailID: 20220630014828epcas1p1e780542d769ff8189bb408449624ffb4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220630014828epcas1p1e780542d769ff8189bb408449624ffb4
References: <CGME20220630014828epcas1p1e780542d769ff8189bb408449624ffb4@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

//sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
A value of '0' has two meanings.
 - Clear the register.   //2084 line
 - Set power off.       //2075 line

To clarify this and improve readability,
use the 'power_off' value instead of '0'.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 3 ++-
 drivers/mmc/host/sdhci.c          | 6 +++---
 drivers/mmc/host/sdhci.h          | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 622b7de96c7f..a732eec69bf8 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -584,7 +584,8 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 	if (intel_host->needs_pwr_off) {
 		intel_host->needs_pwr_off = false;
 		if (mode != MMC_POWER_OFF) {
-			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+			sdhci_writeb(host, SDHCI_POWER_OFF,
+					SDHCI_POWER_CONTROL);
 			usleep_range(10000, 12500);
 		}
 	}
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7689ffec5ad1..602fb3a088e7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2029,7 +2029,7 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
 	if (mode != MMC_POWER_OFF)
 		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
 	else
-		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+		sdhci_writeb(host, SDHCI_POWER_OFF, SDHCI_POWER_CONTROL);
 }
 
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
@@ -2075,8 +2075,8 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 
 	host->pwr = pwr;
 
-	if (pwr == 0) {
-		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+	if (pwr == SDHCI_POWER_OFF) {
+		sdhci_writeb(host, SDHCI_POWER_OFF, SDHCI_POWER_CONTROL);
 		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
 			sdhci_runtime_pm_bus_off(host);
 	} else {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 95a08f09df30..f35d6d7b8326 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -95,6 +95,7 @@
 #define  SDHCI_CTRL_CDTEST_EN	0x80
 
 #define SDHCI_POWER_CONTROL	0x29
+#define  SDHCI_POWER_OFF	0x00
 #define  SDHCI_POWER_ON		0x01
 #define  SDHCI_POWER_180	0x0A
 #define  SDHCI_POWER_300	0x0C
-- 
2.29.0

