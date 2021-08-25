Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012F7C4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 07:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C493E610E8
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 07:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbhHYHyQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Aug 2021 03:54:16 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:37552 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238793AbhHYHyN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Aug 2021 03:54:13 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210825075321epoutp0427138d2d0bf4681fe53d3c1481442b03~efWgWvXR30346503465epoutp04A
        for <linux-mmc@vger.kernel.org>; Wed, 25 Aug 2021 07:53:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210825075321epoutp0427138d2d0bf4681fe53d3c1481442b03~efWgWvXR30346503465epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629878001;
        bh=71vWhwe2flu3e5boPEXBoFmh4b7WoTyiazdFG47+sXU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=OHuqdHK2mgTU8SFyljM55f0DQfDkwZzCCsnghcSaFpxT9PXfa3n2YecbMu+ezDj3y
         jVozmfIcp+KOZ4kTtleoBDmmJaIucO5FEfKsYDtxY8yz3gh6ebBKqZEnG0+In0HWbY
         MFmbb40fHX2/RGlPK5N0p5XHpeXqGZ05fXkgqEwQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210825075315epcas1p180e884c93b29252d4a25a37e70513500~efWbcBZlH2233722337epcas1p1l;
        Wed, 25 Aug 2021 07:53:15 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.247]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GvdWX6yDvz4x9Px; Wed, 25 Aug
        2021 07:53:12 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.EA.09752.8E6F5216; Wed, 25 Aug 2021 16:53:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210825075311epcas1p4b64d6a5a824983c91f7d5d1dc24a4cc2~efWXKr4s70097500975epcas1p4K;
        Wed, 25 Aug 2021 07:53:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210825075311epsmtrp1c5db99575b262ebe26909032f9483ef9~efWXJx-742901129011epsmtrp1E;
        Wed, 25 Aug 2021 07:53:11 +0000 (GMT)
X-AuditID: b6c32a39-6a7ff70000002618-48-6125f6e86a9c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.81.09091.7E6F5216; Wed, 25 Aug 2021 16:53:11 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210825075310epsmtip2a781ef6031c697cf1e2d23b353a8e75a~efWW3g1RD2912529125epsmtip2d;
        Wed, 25 Aug 2021 07:53:10 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        cw9316.lee@samsung.com, colyli@suse.de, axboe@kernel.dk,
        ebiggers@google.com, pcc@google.com, porzio@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
Subject: [PATCH v2] mmc: queue: Remove unused parameters(request_queue)
Date:   Wed, 25 Aug 2021 16:46:01 +0900
Message-Id: <20210825074601.8881-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmge6Lb6qJBoumWVicfLKGzWL13X42
        i+mN59ktZpxqY7XYd+0ku8XF1S2sFr/+rme32PH8DLvF5V1z2CyO/O9ntOi/c53N4tWyi2wW
        TX/2sVgcXxvuwOexc9Zddo8Fm0o9Fu95yeRx+Wypx51re9g8+rasYvTYfLra4/MmuQCOqGyb
        jNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCjlRTKEnNK
        gUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGXe6
        FrAUrBKu2LLpEGsD4zf+LkZODgkBE4mbT3cwdzFycQgJ7GCU2DBpOZTziVHi4b7fLBDON0aJ
        /1PuMcG0zDvzCKpqL6PEt5MroZwvjBIf5s8Bcjg42AS0JG4f8waJiwg8YJRYdWAOO0g3s0CK
        xKuedywgtrCAu8TN22/BprIIqEr8ezIFrIZXwEqi7c8PNoht8hJ/7vcwQ8QFJU7OfMICMUde
        onnrbLDFEgJTOSQuHP3FDNHgInH38H1WCFtY4tXxLewQtpTEy/42doiGZkaJU7PPQTktjBKv
        r9yAqjKW+PT5MyPIC8wCmhLrd+lDhBUldv6eywixmU/i3dceVpASCQFeiY42IYgSFYk5XefY
        YHZ9vPEYqsRD4lufK0hYSCBWouX7CeYJjPKzkLwzC8k7sxD2LmBkXsUollpQnJueWmxYYAqP
        1uT83E2M4JSrZbmDcfrbD3qHGJk4GA8xSnAwK4nw/mVSThTiTUmsrEotyo8vKs1JLT7EaAoM
        4InMUqLJ+cCkn1cSb2hiaWBiZmRiYWxpbKYkzsv4SiZRSCA9sSQ1OzW1ILUIpo+Jg1OqganQ
        4Cnrx6yzlelb3/p/crsxb8vhcztYpJ3PPDSX8PMqDHy0MaPUQUJJ10nme4aCe8Yfz6nXMg6r
        69y5XShTaMolM9noN7dH2Oy1/X/nLrXbVXCuak+w0Eo3Y+XeT0LnTSqdw/f1HmXN2ra453/O
        jlhnjuvnD12PzFJexRn7SCjjWsS6Zduya0WcV+zz2bmYe5H8haxZor8P7O+wzFz7/ryap+/5
        mG1L9dJk5U2/tASdzOC/2jv7kdXmyGS+9uMs19LeKyj/Oda0/EXsnb87WidJVgfN3LnztGDC
        1PzCzUeDrJQkBAtWnmP6Umh6YMrha71utu8833vYW8on7FVqerwkWV/EQE9xksC77wk6Ikos
        xRmJhlrMRcWJAL9J0ENCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSvO7zb6qJBn/3sFmcfLKGzWL13X42
        i+mN59ktZpxqY7XYd+0ku8XF1S2sFr/+rme32PH8DLvF5V1z2CyO/O9ntOi/c53N4tWyi2wW
        TX/2sVgcXxvuwOexc9Zddo8Fm0o9Fu95yeRx+Wypx51re9g8+rasYvTYfLra4/MmuQCOKC6b
        lNSczLLUIn27BK6MO10LWApWCVds2XSItYHxG38XIyeHhICJxLwzj5i7GLk4hAR2M0p8/d7K
        BJGQkti9/zxbFyMHkC0scfhwMUhYSOATUM25apAwm4CWxO1j3iCtIgLvGCV2vP8N1soskCHx
        7eMJMFtYwF3i5u23YDaLgKrEvydT2EFsXgEribY/P9ggVslL/LnfwwwRF5Q4OfMJC8QceYnm
        rbOZJzDyzUKSmoUktYCRaRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnD4a2nuYNy+
        6oPeIUYmDsZDjBIczEoivH+ZlBOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKa
        nZpakFoEk2Xi4JRqYJq5wrnu/5MHy39veSIyRZRvXsG/2Ud7L+S/ypyW5Pn+Oku03hOPCcJ+
        f5qXrBNR899/9omftNdZhtW9hgGNnultFoFNEbs+CAWlmARXy/HfSPGZMa8nelLlA4k1DHPZ
        3D+uufG/QqRYoea5nUaxckxRn6uEVUXrP9ukCZMmSgW+XGAbv/jfQfmlcVOXHZxrvO0tx684
        rd1sq9dEPl92YGr0Yh6DD2rnFP/bvt1x947MyeVzJa+dV5y3Tfw8n0Nt4EP+xwc3XX3RWPYs
        TOYhR+QEEVelqZcYGV61GN8T23zpnNmuzVKP2fM8P7nLeQp4+p4vNuCo1Lu/4880Xl4bu6m5
        QgkKGpk6ezrnxy9f2aXEUpyRaKjFXFScCACbHXkH7gIAAA==
X-CMS-MailID: 20210825075311epcas1p4b64d6a5a824983c91f7d5d1dc24a4cc2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210825075311epcas1p4b64d6a5a824983c91f7d5d1dc24a4cc2
References: <CGME20210825075311epcas1p4b64d6a5a824983c91f7d5d1dc24a4cc2@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

In function mmc_exit_request, the request_queue structure(*q) is not used.
I remove the unnecessary code related to the request_queue structure.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

---
v1->v2:
 * Put the code directly into mmc_mq_init_reuqest()/mmc_mq_exit_request().
---
 drivers/mmc/core/queue.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index cc3261777637..5526e4ca2834 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -199,27 +199,23 @@ static unsigned int mmc_get_max_segments(struct mmc_host *host)
 					 host->max_segs;
 }
 
-/**
- * mmc_init_request() - initialize the MMC-specific per-request data
- * @mq: the request queue
- * @req: the request
- * @gfp: memory allocation policy
- */
-static int __mmc_init_request(struct mmc_queue *mq, struct request *req,
-			      gfp_t gfp)
+static int mmc_mq_init_request(struct blk_mq_tag_set *set, struct request *req,
+			       unsigned int hctx_idx, unsigned int numa_node)
 {
 	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
+	struct mmc_queue *mq = set->driver_data;
 	struct mmc_card *card = mq->card;
 	struct mmc_host *host = card->host;
 
-	mq_rq->sg = mmc_alloc_sg(mmc_get_max_segments(host), gfp);
+	mq_rq->sg = mmc_alloc_sg(mmc_get_max_segments(host), GFP_KERNEL);
 	if (!mq_rq->sg)
 		return -ENOMEM;
 
 	return 0;
 }
 
-static void mmc_exit_request(struct request_queue *q, struct request *req)
+static void mmc_mq_exit_request(struct blk_mq_tag_set *set, struct request *req,
+				unsigned int hctx_idx)
 {
 	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
 
@@ -227,20 +223,6 @@ static void mmc_exit_request(struct request_queue *q, struct request *req)
 	mq_rq->sg = NULL;
 }
 
-static int mmc_mq_init_request(struct blk_mq_tag_set *set, struct request *req,
-			       unsigned int hctx_idx, unsigned int numa_node)
-{
-	return __mmc_init_request(set->driver_data, req, GFP_KERNEL);
-}
-
-static void mmc_mq_exit_request(struct blk_mq_tag_set *set, struct request *req,
-				unsigned int hctx_idx)
-{
-	struct mmc_queue *mq = set->driver_data;
-
-	mmc_exit_request(mq->queue, req);
-}
-
 static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 				    const struct blk_mq_queue_data *bd)
 {
-- 
2.29.0

