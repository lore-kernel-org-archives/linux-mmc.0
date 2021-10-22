Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D009C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 06:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F3760F50
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 06:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhJVGlv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Oct 2021 02:41:51 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:36528 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhJVGlu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2021 02:41:50 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211022063931epoutp036d04dfa9ba7c1949dfdd094b68a89dfe~wRwm9toMm2166421664epoutp03k
        for <linux-mmc@vger.kernel.org>; Fri, 22 Oct 2021 06:39:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211022063931epoutp036d04dfa9ba7c1949dfdd094b68a89dfe~wRwm9toMm2166421664epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634884771;
        bh=LkFPqrQa+YT41CfhU97akjcr79eXsXgMnGQruTJ1HIs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CB3V3qnc5NioVLVYYi2ZKzPxjKVpFsy9MRN30XqkUYk/9U9CNN6W4JLImlV3LiRC7
         ItyZrEc7ojS+UHi6H83RXtxU2Lc8NGIEDD/rTfB6TTAHVpoKvES7TDThkJ1g+YP3tl
         hT0TJcHGJZtaA94yW5eBmRf4ebw9Z7wVvct9hsvg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211022063931epcas1p39555326907bf3396430fb4754b45ce14~wRwmsYjYo2325323253epcas1p3D;
        Fri, 22 Oct 2021 06:39:31 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.243]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4HbF7j47c1z4x9Q0; Fri, 22 Oct
        2021 06:39:29 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.BD.09592.1AC52716; Fri, 22 Oct 2021 15:39:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211022063928epcas1p28a32be208929f9905c80e655736b7a7d~wRwkNB9-K1434414344epcas1p28;
        Fri, 22 Oct 2021 06:39:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211022063928epsmtrp1dd8ba207920fe9104e9c65fe3eaef5a2~wRwkIM-Az0281702817epsmtrp1c;
        Fri, 22 Oct 2021 06:39:28 +0000 (GMT)
X-AuditID: b6c32a37-28fff70000002578-47-61725ca173af
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.10.08902.0AC52716; Fri, 22 Oct 2021 15:39:28 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.98.193]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211022063928epsmtip10c52a65d505e3f4807a537c3bf7d97fb~wRwj6Q9Mp1451514515epsmtip1T;
        Fri, 22 Oct 2021 06:39:28 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huijin Park <bbanghj.park@gmail.com>,
        Huijin Park <huijin.park@samsung.com>
Subject: [PATCH 1/2] mmc: core: adjust polling interval for CMD1
Date:   Fri, 22 Oct 2021 15:39:19 +0900
Message-Id: <20211022063920.2145-1-huijin.park@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmvu7CmKJEg39tQhYv9x5itui46GJx
        edccNosj//sZLY6vDXdg9dg56y67x51re9g8+rasYvT4vEkugCUq2yYjNTEltUghNS85PyUz
        L91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKuSQlliTilQKCCxuFhJ386mKL+0
        JFUhI7+4xFYptSAlp8CsQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj8XfNguuCFYfPvmZqYDzI
        18XIySEhYCLxd8UC1i5GLg4hgR2MEqcX3GAHSQgJfGKUuHJRGCLxjVHi+KEdLDAds298hira
        yygxvU8dogio4eaGZYwgCTYBbYnra7eC2SICGhJ7Hp5nBbGZBbqAim45gNjCAg4Sd07+ZQKx
        WQRUJe427QWq4eDgFbCWOPIpAWKXvMTMS9/BdvEKCEqcnPmEBWKMvETz1tnMIHslBHaxSyx+
        280O0eAi0fjgFSuELSzx6vgWqLiUxMv+Nii7XGLXhKtQzQ2MEn1rv0M1GEu8e7uWGeQIZgFN
        ifW79CHCihI7f89lhFjMJ/Huaw/YnRICvBIdbUIQJaoSi69+hJoiLXHowV1GCNtD4n7DWjZI
        WMVKTFmxiG0Co/wsJO/MQvLOLITFCxiZVzGKpRYU56anFhsWGMOjNDk/dxMjONlpme9gnPb2
        g94hRiYOxkOMEhzMSiK8uyvyE4V4UxIrq1KL8uOLSnNSiw8xmgLDdyKzlGhyPjDd5pXEG5pY
        GpiYGZlYGFsamymJ836WK0wUEkhPLEnNTk0tSC2C6WPi4JRqYEru1bT4MunWkhM5Ln2iqw4o
        h9w5sor7ijr/Q4u/Rsazz3xJ1Hb9N8Myd6t3aBeHwrt3qn8a4y6odORP1ZvtXbHT6a2HQpCB
        rJqTdbBF2Wcb/Xw/AQun91rfdq91+RdU8CzCpj/s+B7zG0xHN7+62JOjWasYpxD4iE1m2Rcl
        V5Um05gMNx6xaXOjr7RFh8TdE+H7/7Fb/0F1gMzjs0rX/+WavTA4dlnM/kDfhmUGh3IaV2t+
        Za13nefJzXZiS30Gh+CJC8bfHsy88DZnusURLtfEG18jr+4Jyf9utfrColfNp3iLKz5t943/
        nLrK+prkB00N97sLIwN/XUrOOBXgF7Uob3/rfh2JfLPXJgqFSizFGYmGWsxFxYkAOB2xDP8D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsWy7bCSnO6CmKJEg4+t2hYv9x5itui46GJx
        edccNosj//sZLY6vDXdg9dg56y67x51re9g8+rasYvT4vEkugCWKyyYlNSezLLVI3y6BK+Px
        d82C64IVh8++ZmpgPMjXxcjJISFgIjH7xmd2EFtIYDejxLazhhBxaYl3O6+zdjFyANnCEocP
        F3cxcgGVfGCUuL1xChNIDZuAtsT1tVsZQWwRAQ2JPQ/Ps4LYzAJ9jBKdv7JAbGEBB4k7J/+C
        1bMIqErcbdoLNpNXwFriyKcEiFXyEjMvfQc7gVdAUOLkzCcsEGPkJZq3zmaewMg3C0lqFpLU
        AkamVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwcGnpbmDcfuqD3qHGJk4GA8xSnAw
        K4nw7q7ITxTiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qB
        adKbA75Vz/7sZOVgDv16P1CbmdFOv792zXn1+dbSvV9ClnVfN528XSpQ/IxmbUbp80/aW6s9
        OpzZTZXm2VtUsB3zfdW7VUbu4PXylRatzVZztW7lfbhdvfTTzAVnuhfffTC3UzXwbp3+JafL
        sxLM9FK+vpTbeYz1+HXdVJtXM90kfpjvzvg3OVbv1Ps5ZapeIYHqs0++eLFRQ9OdN371lk1r
        pCZVMf5revTq7Kp7Qn4xu/RmHhfZ4M/6qkVy++kotdAl6XPr/q5ZOmkng7PchJyPDqtLJtf9
        mZK3rFdsfc5EpUdM7+si8zdP//xs/aI1ujfN/D5NU3/KwbrM4LzKOmHZJ6Ezxa//a9qgzvj+
        Xb0SS3FGoqEWc1FxIgCHJkzOrQIAAA==
X-CMS-MailID: 20211022063928epcas1p28a32be208929f9905c80e655736b7a7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211022063928epcas1p28a32be208929f9905c80e655736b7a7d
References: <CGME20211022063928epcas1p28a32be208929f9905c80e655736b7a7d@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In mmc_send_op_cond(), loops are continuously performed at the same
interval of 10 ms.  However the behaviour is not good for some eMMC
which can be out from a busy state earlier than 10 ms if normal.

Therefore, this patch adjusts the waiting interval time. The interval
time starts at 1 ms, but doubles until the range reaches 10 ms for
each loop.

The reason for adjusting the interval time is that it is important
to reduce the eMMC initialization time, especially in devices that
use eMMC as rootfs.

Test log(eMMC:KLM8G1GETF-B041):

before: 12 ms (0.439407 - 0.427186)
[0.419407] mmc0: starting CMD0 arg 00000000 flags 000000c0
[0.422652] mmc0: starting CMD1 arg 00000000 flags 000000e1
[0.424270] mmc0: starting CMD0 arg 00000000 flags 000000c0
[0.427186] mmc0: starting CMD1 arg 40000080 flags 000000e1<-start
[0.439407] mmc0: starting CMD1 arg 40000080 flags 000000e1<-finish
[0.439721] mmc0: starting CMD2 arg 00000000 flags 00000007

after: 4 ms (0.431725 - 0.427352)
[0.419575] mmc0: starting CMD0 arg 00000000 flags 000000c0
[0.422819] mmc0: starting CMD1 arg 00000000 flags 000000e1
[0.424435] mmc0: starting CMD0 arg 00000000 flags 000000c0
[0.427352] mmc0: starting CMD1 arg 40000080 flags 000000e1<-start
[0.428913] mmc0: starting CMD1 arg 40000080 flags 000000e1
[0.431725] mmc0: starting CMD1 arg 40000080 flags 000000e1<-finish
[0.432038] mmc0: starting CMD2 arg 00000000 flags 00000007

Signed-off-by: Huijin Park <huijin.park@samsung.com>

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 0c54858e89c0..61b4ffdc89ce 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -177,6 +177,7 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 {
 	struct mmc_command cmd = {};
 	int i, err = 0;
+	int interval = 1, interval_max = 10;
 
 	cmd.opcode = MMC_SEND_OP_COND;
 	cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
@@ -198,7 +199,9 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 
 		err = -ETIMEDOUT;
 
-		mmc_delay(10);
+		mmc_delay(interval);
+		if (interval < interval_max)
+			interval = min(interval * 2, interval_max);
 
 		/*
 		 * According to eMMC specification v5.1 section 6.4.3, we
-- 
2.17.1

