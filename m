Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B69CC43214
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Aug 2021 09:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83AD46109E
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Aug 2021 09:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbhH0Jjy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Aug 2021 05:39:54 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:32907 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244820AbhH0Jjt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Aug 2021 05:39:49 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210827093858epoutp029a92efe24148eb39a8ff316c562bb0fc~fIFS5oF5x3086730867epoutp02b
        for <linux-mmc@vger.kernel.org>; Fri, 27 Aug 2021 09:38:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210827093858epoutp029a92efe24148eb39a8ff316c562bb0fc~fIFS5oF5x3086730867epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1630057138;
        bh=bF2FPIkqfoDCrBEfXOkuYTk7alY50X8qdPwe7039LkA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Bhm2uh3VRPC9v/h0gPZDHq/qHxsmSXzFXQSA1F3SJ1NEwb8yTZ8GQbwwnJR7NLxlN
         iCGAchVBtzr+qtpgHRLFkmtAmqKKEGaVnXzvvf/SW+tYVi5In7uhpIXqjjAlj2sk3K
         rfKklF+QOu+NG8FMIhwt1eh0EXh4VwhzphwUGJQQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210827093857epcas1p12370a4e0ff321d51f97153be5e7cffeb~fIFSVDFBq0892308923epcas1p1Z;
        Fri, 27 Aug 2021 09:38:57 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.250]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Gwvmc1Rgtz4x9Q6; Fri, 27 Aug
        2021 09:38:56 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.EA.10095.FA2B8216; Fri, 27 Aug 2021 18:38:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210827093855epcas1p4ac8e34d779fe30de3e03bcadedcb66c8~fIFQUmXm72033020330epcas1p4X;
        Fri, 27 Aug 2021 09:38:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210827093855epsmtrp11f948ee91b7456004d861dffc77570cb~fIFQT30RY2278822788epsmtrp18;
        Fri, 27 Aug 2021 09:38:55 +0000 (GMT)
X-AuditID: b6c32a38-691ff7000000276f-df-6128b2afcefc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.03.08750.FA2B8216; Fri, 27 Aug 2021 18:38:55 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210827093855epsmtip244f62cb1f6d68bdfc64d05250cc868ff~fIFQFBXqe1769117691epsmtip2g;
        Fri, 27 Aug 2021 09:38:55 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com,
        ChanWoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH] mmc: mtk-sd: Remove unused parameters(mrq)
Date:   Fri, 27 Aug 2021 18:31:19 +0900
Message-Id: <20210827093119.32481-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmvu6GTRqJBu8WMVlcuzWfzWLGqTZW
        i33XTrJb/Pq7nt1ix/Mz7BabHl9jtbi8aw6bxeXmi4wWR/73M1o0tRhbNP3Zx2JxfG24A4/H
        zll32T3uXNvD5rF5Sb1Hy8n9LB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
        HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
        Vim1ICWnwKxArzgxt7g0L10vL7XEytDAwMgUqDAhO+NJz332gqmcFR+v/WBrYNzD3sXIySEh
        YCJxYcIEpi5GLg4hgR2MEttmPGSGcD4xSly6c5QVpEpI4DOjxOoTTjAda1duhiraxSixbsoC
        KOcLo8S5xzcZuxg5ONgEtCRuH/MGiYsIXGeUaNuwkwXEYRboYpT4dbCLBWSUsIC1xMympWCH
        sAioSvx5cBVsHS9QfN7HRUwQ6+Ql/tzvYYaIC0qcnPkErJcZKN68dTbYZgmBn+wS/zrusEA0
        uEhs+nKHEcIWlnh1fAvUp1ISL/vb2CEamhklTs0+B+W0MEq8vnIDqspY4tPnz2A/MAtoSqzf
        pQ8RVpTY+XsuI8RmPol3X3tYQUokBHglOtqEIEpUJOZ0nWOD2fXxxmNWCNtD4uzDK+yQcIyV
        aH49jXUCo/wsJP/MQvLPLITFCxiZVzGKpRYU56anFhsWmMDjNTk/dxMjOJ1qWexgnPv2g94h
        RiYOxkOMEhzMSiK8C76rJQrxpiRWVqUW5ccXleakFh9iNAWG8ERmKdHkfGBCzyuJNzSxNDAx
        MzKxMLY0NlMS52V8JZMoJJCeWJKanZpakFoE08fEwSnVwGS99HL81IfbJ95xSlkTMvebANs5
        s4dxN4WOXNbRU5qe6/Vh+c1dZ751XVY0qe/jMuK27X3lcfKqcXtZwXNmx9CIRi2bh+de/N8c
        9urueh+7iElVDDM5A6da96YZliecC32/yNmXPX/NM6sPN7ONH1/5Izhf/9jVuZuONiz7Ee2+
        9KS+/WztlX/vmU9X1T8uek5i1YVPzLt/ti3689FRX8BGclNIk1wJj1sA0xuJQ8suC21L8Hf/
        c6U6r/HFFGGp/8GRFr5yKRHrrH7aLnfs2fZRYtvWwyL5BQvLe661GS2dYRU+575rXMma278u
        /ela6GXbIL9AM9Bd9M+HgBTbwOPHzBvSroUIirgIGUwwvqbEUpyRaKjFXFScCACSkIZSMAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvO76TRqJBi8+y1tcuzWfzWLGqTZW
        i33XTrJb/Pq7nt1ix/Mz7BabHl9jtbi8aw6bxeXmi4wWR/73M1o0tRhbNP3Zx2JxfG24A4/H
        zll32T3uXNvD5rF5Sb1Hy8n9LB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CV8aTnPnvBVM6K
        j9d+sDUw7mHvYuTkkBAwkVi7cjNzFyMXh5DADkaJrv8ToRJSErv3n2frYuQAsoUlDh8uhqj5
        xChx+8ghVpA4m4CWxO1j3iBxEYG7jBJL5uxhBXGYBSYwSiy+8pYZZJCwgLXEzKalYENZBFQl
        /jy4ygpi8wLF531cxASxTF7iz/0eZoi4oMTJmU9YQGxmoHjz1tnMExj5ZiFJzUKSWsDItIpR
        MrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzi4tbR2MO5Z9UHvECMTB+MhRgkOZiUR3gXf
        1RKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYJrFZOZ+
        9nHUUul/T3hdr5U9mMLymr1ePPrl2c/v6vOmR7/rnXQuqVM3/1fzzsoPvInS785yzpvkZmW8
        vnzykbj9jx9d95hk+zXEJ47FIZL74BNRiVPzdDZqzn/97uD6sK3dt/YfnRCarXvhcraLaetN
        VjHuqezz+Y5ruF2Wz/dvzMjbNz/u4NRX5teduzn3fuHLrlO0U5m840ikiGjl55lyU7U/flAN
        TpR2bRDQDA2WO9BXZVixUvVT4DReFYW/35ctsppYfoVF9PwDs99FP7R3/X92+kK+n5Amb4tn
        hkCreIBLbktIlWzIF34zH6+9th/XHAxorr14lNn4rr1yHPebKOdbYav3FIZMUZr5WImlOCPR
        UIu5qDgRAGikdwzdAgAA
X-CMS-MailID: 20210827093855epcas1p4ac8e34d779fe30de3e03bcadedcb66c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210827093855epcas1p4ac8e34d779fe30de3e03bcadedcb66c8
References: <CGME20210827093855epcas1p4ac8e34d779fe30de3e03bcadedcb66c8@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

The mmc_request structure(*mrq) is not used. //msdc_cmd_find_resp
I remove the unnecessary code related to the mmc_request structure.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/mmc/host/mtk-sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 4dfc246c5f95..813f57f6d9cc 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -961,7 +961,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 }
 
 static inline u32 msdc_cmd_find_resp(struct msdc_host *host,
-		struct mmc_request *mrq, struct mmc_command *cmd)
+		struct mmc_command *cmd)
 {
 	u32 resp;
 
@@ -997,7 +997,7 @@ static inline u32 msdc_cmd_prepare_raw_cmd(struct msdc_host *host,
 	 * stop << 14 | rw << 13 | dtype << 11 | rsptyp << 7 | brk << 6 | opcode
 	 */
 	u32 opcode = cmd->opcode;
-	u32 resp = msdc_cmd_find_resp(host, mrq, cmd);
+	u32 resp = msdc_cmd_find_resp(host, cmd);
 	u32 rawcmd = (opcode & 0x3f) | ((resp & 0x7) << 7);
 
 	host->cmd_rsp = resp;
-- 
2.29.0

