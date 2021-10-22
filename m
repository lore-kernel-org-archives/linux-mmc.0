Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DA1C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 06:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C85B60EE2
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 06:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhJVGmA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Oct 2021 02:42:00 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:42815 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhJVGmA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2021 02:42:00 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211022063941epoutp048ba51a4dd49c7ecf35c75e72444bddff~wRwvzkW9-3170331703epoutp04D
        for <linux-mmc@vger.kernel.org>; Fri, 22 Oct 2021 06:39:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211022063941epoutp048ba51a4dd49c7ecf35c75e72444bddff~wRwvzkW9-3170331703epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634884781;
        bh=GgRKhJImcsOAtS3q4YtTz2oA+8fQnxgrL56dGAuTdp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HqAwT1jFEFSkYauVnTbGfMPk+PhO2E4xMk13JkjqGHD3jMTUcSsWvhtdZXCMHeNoG
         ATHd948rbx7LJR7SPeeKxho6qak160fNpUA8OghFLAAYscf7X36Uhrb0nYAE3Cr0WO
         uP0anKwgKPiA7O4LmvM+5CnQjjfyb37ht61/SEpU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211022063941epcas1p2ef8e3070840abaaae103bcbfb6216ade~wRwvkM6-81437314373epcas1p22;
        Fri, 22 Oct 2021 06:39:41 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.242]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4HbF7v1c5rz4x9QP; Fri, 22 Oct
        2021 06:39:39 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.33.09574.5AC52716; Fri, 22 Oct 2021 15:39:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211022063932epcas1p2016e6cff9b171f9a6fedfb1e48ee8695~wRwn21_tN1434414344epcas1p2G;
        Fri, 22 Oct 2021 06:39:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211022063932epsmtrp11cb2646f33facc3be831e2e78d2f544c~wRwn2HtMz0354103541epsmtrp1C;
        Fri, 22 Oct 2021 06:39:32 +0000 (GMT)
X-AuditID: b6c32a35-1abff70000002566-9a-61725ca54767
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.9D.08738.4AC52716; Fri, 22 Oct 2021 15:39:32 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.98.193]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211022063932epsmtip1be7b3cd49607ff5ca6982b6772659c6d~wRwnsTJi51607316073epsmtip1h;
        Fri, 22 Oct 2021 06:39:32 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huijin Park <bbanghj.park@gmail.com>,
        Huijin Park <huijin.park@samsung.com>
Subject: [PATCH 2/2] mmc: core: use jiffies to checking timeout for CMD1
Date:   Fri, 22 Oct 2021 15:39:20 +0900
Message-Id: <20211022063920.2145-2-huijin.park@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211022063920.2145-1-huijin.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmru7SmKJEg41rxSxe7j3EbNFx0cXi
        8q45bBZH/vczWhxfG+7A6rFz1l12jzvX9rB59G1ZxejxeZNcAEtUtk1GamJKapFCal5yfkpm
        XrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0FYlhbLEnFKgUEBicbGSvp1NUX5p
        SapCRn5xia1SakFKToFZgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGwU8/mAsmc1e87dVtYHzO
        0cXIySEhYCKx7HgvaxcjF4eQwA5GiYtzJrBDOJ8YJf5cnA2V+cwocbjvBFCGA6xlV58CRHwX
        o8ScGZvY4Dr+z9rMDDKXTUBb4vrarYwgtoiAhsSeh+dZQWxmgS5GiZu3HEAGCQt4SKye5A9i
        sgioSlz6awxSwStgLXHw2EUmiOvkJWZe+s4OYnMK2EhsfvaODaJGUOLkzCcsEBPlJZq3zmaG
        qD/HLrHhqjeE7SLxr38SG4QtLPHq+BZ2CFtK4mV/G5RdLrFrwlVmkPMlBBoYJfrWfmeFSBhL
        vHu7lhnkNmYBTYn1u/QhwooSO3/PZYTYyyfx7msPKyRIeCU62oQgSlQlFl/9CDVFWuLQg7uM
        ECUeEtvfVUECqp9R4uzHbrYJjAqzkHwzC8k3sxAWL2BkXsUollpQnJueWmxYYAiP3eT83E2M
        4BSoZbqDceLbD3qHGJk4GA8xSnAwK4nw7q7ITxTiTUmsrEotyo8vKs1JLT7EaAoM6onMUqLJ
        +cAknFcSb2hiaWBiZmRiYWxpbKYkzvtZrjBRSCA9sSQ1OzW1ILUIpo+Jg1Oqgenhwx2h0Qxb
        o+8/+tqkle565fQ2obDeJSpTJa/nO+yMMWO5++3MOf65d+8WzNXaus1rUsCDGaLv1d5++Dc7
        Yh5rMb/7zam8NaYfHQL5uPLNl6UI7JHNsudhEboTm6P6b9OhgkSV7Pb9b6Kv88puE6rKEhG1
        8xP+vHuF+cRFe3+KB858N6urZc7ft2uVg3/uPbyfMWDf9WRLFy+vNofzs2y0H8T1KEYcjiic
        +F03MfJ0U9UemUKmTOEWZiFzgfylsmtbl13kvsS0RcOk6Vfd36+Xppy5t+xCtP6ZZk7h0Jn9
        Ni/CGKdwnWIS7HadfDk25vX2yRxdzoXlQZ5Lg5e9m3kk5HrUjdyoyQcvNDy79UCJpTgj0VCL
        uag4EQC2Mf73CgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSnO6SmKJEgws79Sxe7j3EbNFx0cXi
        8q45bBZH/vczWhxfG+7A6rFz1l12jzvX9rB59G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV8bB
        Tz+YCyZzV7zt1W1gfM7RxcjBISFgIrGrT6GLkYtDSGAHo8SqXwvZuhg5geLSEu92XmeFqBGW
        OHy4GKLmA6PEg/UvwGrYBLQlrq/dyghiiwhoSOx5eJ4VxGYW6GOU6PyVBdIrLOAhsXqSP4jJ
        IqAqcemvMUgFr4C1xMFjF5kgNslLzLz0nR3E5hSwkdj87B3YdCGgmjmHT7BD1AtKnJz5hAVi
        urxE89bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4VLW0
        djDuWfVB7xAjEwfjIUYJDmYlEd7dFfmJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJI
        TyxJzU5NLUgtgskycXBKNTDJNfnM9yg9Opu/SmQmS22hvcaOZd9arBf7x0Yvq1HRVG5SOvru
        E0MO47ulS46/qDmyiMNe3NEy5Vu64I3DqsELHno7Nm2+71wYyrCH+T7P/ZAirps8y1Me7Xsl
        lWOS/2U6h7WszNTuxwbetikZG+xaMjnE+D+fe/Nw+0fpWfVvvj2qCpez5xVzk995e7uGdlMR
        /8fZv3kU5F4eOuXYIRmUv3DbocnN9dpz86erby64UWJ0f48G58eVa7pt/MKDPh72779uUFXm
        a/r4eGpS1pXLThb3F3EcPJVUfm3PCevnUpcX589b+F7Y/XbruZPMlee/flY5MCsg6cIV0Vml
        6tKOho4Btd8tXvUtE71w85cSS3FGoqEWc1FxIgDQ2e69xAIAAA==
X-CMS-MailID: 20211022063932epcas1p2016e6cff9b171f9a6fedfb1e48ee8695
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211022063932epcas1p2016e6cff9b171f9a6fedfb1e48ee8695
References: <20211022063920.2145-1-huijin.park@samsung.com>
        <CGME20211022063932epcas1p2016e6cff9b171f9a6fedfb1e48ee8695@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch uses jiffies for checking timeout instead of loop count.
Because the previous patch which is adjusting interval time changes
the timeout value. Besides using jiffies is more clearly for checking
timeout instead of counting loop.

Signed-off-by: Huijin Park <huijin.park@samsung.com>

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 61b4ffdc89ce..f48216d65d2c 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -176,14 +176,16 @@ int mmc_go_idle(struct mmc_host *host)
 int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 {
 	struct mmc_command cmd = {};
-	int i, err = 0;
+	int err = 0;
 	int interval = 1, interval_max = 10;
+	unsigned long timeout;
 
 	cmd.opcode = MMC_SEND_OP_COND;
 	cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
-	for (i = 100; i; i--) {
+	timeout = jiffies + msecs_to_jiffies(1000);
+	while (true) {
 		err = mmc_wait_for_cmd(host, &cmd, 0);
 		if (err)
 			break;
@@ -197,7 +199,12 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 				break;
 		}
 
-		err = -ETIMEDOUT;
+		if (time_after(jiffies, timeout)) {
+			pr_err("%s: Card stuck being busy! %s\n",
+			       mmc_hostname(host), __func__);
+			err = -ETIMEDOUT;
+			break;
+		}
 
 		mmc_delay(interval);
 		if (interval < interval_max)
-- 
2.17.1

