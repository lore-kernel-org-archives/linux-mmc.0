Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF67C4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 00:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D796610A3
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 00:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbhHYAlg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 20:41:36 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:17261 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbhHYAlf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 20:41:35 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210825004048epoutp04787fe6f2639946677ecad968b604f511~eZc2LeRC01688216882epoutp04v
        for <linux-mmc@vger.kernel.org>; Wed, 25 Aug 2021 00:40:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210825004048epoutp04787fe6f2639946677ecad968b604f511~eZc2LeRC01688216882epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629852048;
        bh=unTxR2PJHykOCdGTf9IQjXBkO7hDDOb5l/Ye/+bTnQk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=WY0BLvVit1Were4cRZ0Otc7mbtZjLAjv+Mv7T2dvu4bjxaRUfVbLK5ku+Ey+UsRVa
         CUpeP6+/Nn11NGM8KyHcWtyXnPeNZ+5N3ehKeErUQdjdEhRvwu/bxApLhnGMm9OdWG
         nddBKcYxdG/+/pYdM/KubC6e3VAmGOHgdkHrQ/70=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210825004047epcas1p41075151ef676e546e56554fdce7fc1e4~eZc1OJnSA0206102061epcas1p40;
        Wed, 25 Aug 2021 00:40:47 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.247]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GvRwX14yfz4x9Pr; Wed, 25 Aug
        2021 00:40:44 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.4D.09752.B8195216; Wed, 25 Aug 2021 09:40:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210825004043epcas1p33ca4a682a765e1270258bba083fe66d6~eZcxbH5s82036720367epcas1p3m;
        Wed, 25 Aug 2021 00:40:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210825004043epsmtrp1e6f7adcb57297853da7fd7b0711d7ca0~eZcxaQBAV0321603216epsmtrp1h;
        Wed, 25 Aug 2021 00:40:43 +0000 (GMT)
X-AuditID: b6c32a39-691ff70000002618-80-6125918bb7a7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.EC.09091.B8195216; Wed, 25 Aug 2021 09:40:43 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210825004043epsmtip26ce69c83e15ab0079cca7a4641b1c8b5~eZcxLZsN_0285502855epsmtip24;
        Wed, 25 Aug 2021 00:40:43 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        cw9316.lee@samsung.com, colyli@suse.de, axboe@kernel.dk,
        ebiggers@google.com, pcc@google.com, porzio@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
Subject: [PATCH] mmc: queue: Remove unused parameters(request_queue)
Date:   Wed, 25 Aug 2021 09:33:18 +0900
Message-Id: <20210825003318.31574-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmrm7PRNVEg9ZrzBYnn6xhs1h9t5/N
        YnrjeXaLGafaWC32XTvJbnFxdQurxa+/69ktdjw/w25xedccNosj//sZLfrvXGezeLXsIptF
        0599LBbH14Y78HnsnHWX3WPBplKPxXteMnlcPlvqcefaHjaPvi2rGD02n672+LxJLoAjKtsm
        IzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hoJYWyxJxS
        oFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BWYFecWJucWleul5eaomVoYGBkSlQYUJ2xrH2
        l4wF1zkrzn9fyN7AOI2ji5GTQ0LARGLBjsUsXYxcHEICOxgl/s+bxQrhfGKUuNj2Fcr5xihx
        clE/E0zLzUP7mSESexkl7h9rg3K+MEo82dsO5HBwsAloSdw+5g0SFxF4wCix6sAcdpBuZoEU
        iVc971hAbGEBF4mpR5pYQWwWAVWJK5NWgvXyClhLfFgZALFMXuLP/R5mEJtXQFDi5MwnLBBj
        5CWat84G2yshMJVDovXSXXaIBheJt7272CBsYYlXx7dAxaUkXva3sUM0NDNKnJp9DsppYZR4
        feUGVJWxxKfPnxlBrmAW0JRYv0sfIqwosfP3XEaIzXwS7772sIKUSAjwSnS0CUGUqEjM6TrH
        BrPr443HrBC2h8SCC+1gDwgJxEqsPPKSfQKj/Cwk/8xC8s8shMULGJlXMYqlFhTnpqcWGxaY
        wqM1OT93EyM45WpZ7mCc/vaD3iFGJg7GQ4wSHMxKIrx/mZQThXhTEiurUovy44tKc1KLDzGa
        AgN4IrOUaHI+MOnnlcQbmlgamJgZmVgYWxqbKYnzMr6SSRQSSE8sSc1OTS1ILYLpY+LglGpg
        WpttqZnG2lwS/9xZ8/AK80dfrJ5MPvjj/g3PpVy5D5MjPKcc4OXcc7Pd7ahiw0SXtyVmW360
        tE1f9UR3S+GGS13ukutOTkjlPWBTWBQoek7NdXpJTmp0o3D09Ri5Bd77Aj33flMWvro6cbev
        a0vmmYubg15ZFxxjlmfVX5syxYozZtuuT9OEPptP+GaX0VJ++qTMxC3Kb7uncIfstttyZT97
        fpNN1s53f6QOJRyNS/juPaelXmONcvutNzov3/ysEJq+fhuPHB+zdfpcjwT3lS+l4h8VfbL6
        1D97nmV/0m/GMP5bc7reFbvM/M+pl7x71kPOn2fvh6w8Fc4/92ZWnirjg2YjnkWh7/02bFmU
        qcRSnJFoqMVcVJwIAB9GjJBCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSvG73RNVEg/s3JS1OPlnDZrH6bj+b
        xfTG8+wWM061sVrsu3aS3eLi6hZWi19/17Nb7Hh+ht3i8q45bBZH/vczWvTfuc5m8WrZRTaL
        pj/7WCyOrw134PPYOesuu8eCTaUei/e8ZPK4fLbU4861PWwefVtWMXpsPl3t8XmTXABHFJdN
        SmpOZllqkb5dAlfGsfaXjAXXOSvOf1/I3sA4jaOLkZNDQsBE4uah/cxdjFwcQgK7GSV+7fjG
        BpGQkti9/zyQzQFkC0scPlwMUfOJUeLQ34ssIHE2AS2J28e8QeIiAu8YJXa8/80E0ssskCHx
        7eMJMFtYwEVi6pEmVhCbRUBV4sqklcwgvbwC1hIfVgZArJKX+HO/hxnE5hUQlDg58wkLxBh5
        ieats5knMPLNQpKahSS1gJFpFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcPhrae5g
        3L7qg94hRiYOxkOMEhzMSiK8f5mUE4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5Y
        kpqdmlqQWgSTZeLglGpgirKW8r0XWj91rt/27SJfNPbaWq1ROPrBXHz5GyvrZKG+rTVC5uvN
        33SkV9q0rnlZs8HKd/vb1EqOrPfHTZeUPtqtsbtKttAgYupN7vsrFDwFvvSUv1y5f8ndrAv/
        /vgeXa/Xw693Ys6x2UY9tzJ6OC01pp9tvLloLm+T4bnty6zmnzCfMf3NTEuta62ZbS8VZz2L
        8dk8Z3N709mt3And+fuubonzvXDQ8jqL5Js9BRrWTLffnjLy15m97MOOH9ecvLSjFHKteeIj
        2Vk2bY8qjXVZr8BvqVVkpBD1dfrUU6zbJ3i+mik9dYPyxyu6mWL8mcq5Nf/aBcsEpHWVVI8I
        b33Ssntmxsz1HeKrnNp3KLEUZyQaajEXFScCADOvghTuAgAA
X-CMS-MailID: 20210825004043epcas1p33ca4a682a765e1270258bba083fe66d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210825004043epcas1p33ca4a682a765e1270258bba083fe66d6
References: <CGME20210825004043epcas1p33ca4a682a765e1270258bba083fe66d6@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

In function mmc_exit_request, the request_queue structure(*q) is not used.
I remove the unnecessary code related to the request_queue structure.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/mmc/core/queue.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index cc3261777637..b742385361e4 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -219,7 +219,7 @@ static int __mmc_init_request(struct mmc_queue *mq, struct request *req,
 	return 0;
 }
 
-static void mmc_exit_request(struct request_queue *q, struct request *req)
+static void mmc_exit_request(struct request *req)
 {
 	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
 
@@ -236,9 +236,7 @@ static int mmc_mq_init_request(struct blk_mq_tag_set *set, struct request *req,
 static void mmc_mq_exit_request(struct blk_mq_tag_set *set, struct request *req,
 				unsigned int hctx_idx)
 {
-	struct mmc_queue *mq = set->driver_data;
-
-	mmc_exit_request(mq->queue, req);
+	mmc_exit_request(req);
 }
 
 static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
-- 
2.29.0

