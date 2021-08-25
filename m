Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8410BC4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 09:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6578261153
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 09:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbhHYJmT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Aug 2021 05:42:19 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:50410 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbhHYJmR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Aug 2021 05:42:17 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210825094130epoutp0456bb88d74047ede4edb7a4565d7f695d~eg08PjhMR1535115351epoutp04b
        for <linux-mmc@vger.kernel.org>; Wed, 25 Aug 2021 09:41:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210825094130epoutp0456bb88d74047ede4edb7a4565d7f695d~eg08PjhMR1535115351epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629884490;
        bh=MoAIQyz5Uf3JAXIkjW5sCnnu4uLDJbsFqG6pBajtU84=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MtBehLR36EIGtkdL9P6oa8f/to2IdCcS1OdmPlbHsKWWcCi/EbQF96zjqvQP2jmiQ
         9HcDtwQRUTM81HSiqGQTtJTjTEfSQ2WGMGaGFVKkIjhs3A4SN549stzNlDlvAekKbE
         ovd6kzOrPLw4ZLunkuWPNM18L6fTI3bOkFHq5CDU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210825094129epcas1p14475b00c984ba51d380facc39254020d~eg07fyhPS1578315783epcas1p1M;
        Wed, 25 Aug 2021 09:41:29 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.247]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GvgwS0X2Pz4x9Pr; Wed, 25 Aug
        2021 09:41:28 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.84.10095.74016216; Wed, 25 Aug 2021 18:41:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210825094127epcas1p26709a5004dacdb2066e7f21dc1c997f5~eg05FrfOx0977909779epcas1p2W;
        Wed, 25 Aug 2021 09:41:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210825094127epsmtrp1b1154e31dd3c5edb330c4fa29d1727b9~eg05ErpSd2830628306epsmtrp1v;
        Wed, 25 Aug 2021 09:41:27 +0000 (GMT)
X-AuditID: b6c32a38-c27d1a800000276f-c7-61261047ef6a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.BE.09091.74016216; Wed, 25 Aug 2021 18:41:27 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210825094127epsmtip2dae0e5cf002c2519f18236f036136716~eg043Ol2g0151701517epsmtip2X;
        Wed, 25 Aug 2021 09:41:27 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com,
        ChanWoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH] mmc: sdhci: Change the code to check auto_cmd23
Date:   Wed, 25 Aug 2021 18:33:45 +0900
Message-Id: <20210825093345.14706-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdljTQNddQC3RYMdGG4uTT9awWcw41cZq
        se/aSXaLX3/Xs1vseH6G3eLyrjlsFkf+9zNaNP3Zx2JxfG24A6fH4j0vmTzuXNvD5tG3ZRWj
        x+dNcgEsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6Z
        OUCnKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAr0ihNzi0vz0vXyUkusDA0M
        jEyBChOyM963b2ApuMZWcXTZC+YGxgOsXYycHBICJhKrOq4ydTFycQgJ7GCUmLXyACOE84lR
        YlFHE5TzjVHi+NQGNpiWl3cfsUEk9jJKHFw0gxnC+cIosfzeU6BhHBxsAloSt495gzSICORJ
        HDq7EmwSs0AXo8Svg10sIAlhAQeJGTsOg9ksAqoSV16vYgaxeQWsJRq6vkMdKC/x534PVFxQ
        4uTMJ2D1zEDx5q2zwRZLCFxil3j++SATRIOLROuslVCnCku8Or6FHcKWknjZ38YO0dDMKHFq
        9jkop4VR4vWVG1BVxhKfPn9mBHmBWUBTYv0ufYiwosTO33MZITbzSbz72sMKUiIhwCvR0SYE
        UaIiMafrHBvMro83HkM94CFxctFCsAeEBGIlXr1ezzKBUX4Wkn9mIflnFsLiBYzMqxjFUguK
        c9NTiw0LTODxmpyfu4kRnCC1LHYwzn37Qe8QIxMH4yFGCQ5mJRHev0zKiUK8KYmVValF+fFF
        pTmpxYcYTYEhPJFZSjQ5H5ii80riDU0sDUzMjEwsjC2NzZTEeRlfySQKCaQnlqRmp6YWpBbB
        9DFxcEo1MIlflteafXNl5eQHlSmVS78c9rE6fkiIk23ZnIDIyws3HDfd42xwYFHo9FN/Jk1q
        OMqgm1fwZnHJ45OyoSdus9+5vP3x55D1Ms3WH/IVDnoGZ7Pt5gr5d+7E7CNR6zub+7Yw6v3e
        9uFp2v5pWd73+jf/5bPlzin4P/dHq4GDVkNmyJvT2sdmNvLP9f9VXsVxY5vHr13X75WsYrlR
        e8IzS4wp4CZfzoyQpGkrT3V6uFgaTBD6+OZqC3fNx3a2ved7/i/ZtK65QVX/q5IIl8c0b9ab
        kySZvmnPWmfMfIFB/7b9la7Oo+5XdvAbT3u8tyDKxEGt9bzu2UkuE32cU//euMqyXO/4yTXr
        Oi89fOH+SXKPEktxRqKhFnNRcSIABS4PERkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvK67gFqiQetufouTT9awWcw41cZq
        se/aSXaLX3/Xs1vseH6G3eLyrjlsFkf+9zNaNP3Zx2JxfG24A6fH4j0vmTzuXNvD5tG3ZRWj
        x+dNcgEsUVw2Kak5mWWpRfp2CVwZ79s3sBRcY6s4uuwFcwPjAdYuRk4OCQETiZd3H7GB2EIC
        uxklbv3TgIhLSezefx4ozgFkC0scPlzcxcgFVPKJUeLi22dMIHE2AS2J28e8QUwRgSKJE0fL
        QEqYBSYwSiy+8pYZZIywgIPEjB2HWUBsFgFViSuvV4HFeQWsJRq6vkOdIC/x534PVFxQ4uTM
        J2D1zEDx5q2zmScw8s1CkpqFJLWAkWkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZw
        oGpp7mDcvuqD3iFGJg7GQ4wSHMxKIrx/mZQThXhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZ
        LySQnliSmp2aWpBaBJNl4uCUamC66HG1yF4pqClq7epf2S0pQYtfP+qZKxrac/K4tYvd9Edy
        9h+8vzroVuaUpvbeWcv0InNuIvthmeR//9rX+2V+utGpz2hWsayj4cHJHqMDwpPcVwUfl9Hj
        Ef/w9fj9+IqpN/NXyG6NLZukUHHyrVnCSpkFOf7nbwUeeraU2bXdasG+Xw+rPb+8joyf/C/8
        2FnhZx26pxt+aiom//1Rd8LuGpf8icYY24ufP370djRnWMPL+UcutSXTdYJP4SrVjTEsMzQn
        lyes3Hx1k8268N/9mw4HMghqNnvf6nhlyLD/CPd90zQzdqeFzFu+vFcLW55+P/uoEV/dmfpb
        rWlGz5t1n259lf/F88J9zvojIX5KLMUZiYZazEXFiQB5SsVHwwIAAA==
X-CMS-MailID: 20210825094127epcas1p26709a5004dacdb2066e7f21dc1c997f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210825094127epcas1p26709a5004dacdb2066e7f21dc1c997f5
References: <CGME20210825094127epcas1p26709a5004dacdb2066e7f21dc1c997f5@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

It is replaced with a function that is already declared.
//[1/5] mmc: sdhci: Add helpers for the auto-CMD23 flag
//20200412090349.1607-2-adrian.hunter@intel.com

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 36f15f81a6af..5782650ddf7d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3232,7 +3232,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 			  -ETIMEDOUT :
 			  -EILSEQ;
 
-		if (mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
+		if (sdhci_auto_cmd23(host, mrq)) {
 			mrq->sbc->error = err;
 			__sdhci_finish_mrq(host, mrq);
 			return;
-- 
2.29.0

