Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7DDC4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 07:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645B961183
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 07:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhHXHrk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 03:47:40 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:45081 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbhHXHrj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 03:47:39 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210824074654epoutp027779e28edbffadc0699da5f123db3879~eLnl_7G2v1325313253epoutp02b
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:46:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210824074654epoutp027779e28edbffadc0699da5f123db3879~eLnl_7G2v1325313253epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629791214;
        bh=tuxFvzdU1KPojEc11Y0mpRn20+di5IHcqdwp/lNK8j8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=B9YDRisu8kZjHWxPeMq6Rl/Q87VaBmWlvfP01xFkVpnWHvLvL/2tdZySnpciFe4Jn
         2GV2nUV3/Gjuq38YsxXzW40qMnohgAN6pYeOOlgokLh7LX6YIrpq131EwH9+8V3qe/
         Uc9BSE8wKr58BsH6hIBbcth+yfw5I4z+Cmqzl03c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210824074653epcas1p3b04ab06af77f483edfa9fdfe00a0195d~eLnlTk_bw2845228452epcas1p3M;
        Tue, 24 Aug 2021 07:46:53 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.240]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Gv1Qg6RY2z4x9Qh; Tue, 24 Aug
        2021 07:46:51 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.07.10095.BE3A4216; Tue, 24 Aug 2021 16:46:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210824074651epcas1p3b6965040fa6a4660a31192f96125c374~eLnjG-FxE2840828408epcas1p3L;
        Tue, 24 Aug 2021 07:46:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210824074651epsmtrp27f8cc0079d76e63291939ccaaaf371f6~eLnjF7gTu3158831588epsmtrp23;
        Tue, 24 Aug 2021 07:46:51 +0000 (GMT)
X-AuditID: b6c32a38-691ff7000000276f-17-6124a3eb332b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.A7.08750.BE3A4216; Tue, 24 Aug 2021 16:46:51 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210824074651epsmtip2fc6cc2f39fa74824d58649f25d8b088c~eLni32Dkb1954019540epsmtip2n;
        Tue, 24 Aug 2021 07:46:51 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        cw9316.lee@samsung.com, colyli@suse.de, axboe@kernel.dk,
        ebiggers@google.com, pcc@google.com, porzio@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
Subject: [PATCH] mmc: queue: Match the data type of max_segments
Date:   Tue, 24 Aug 2021 16:39:34 +0900
Message-Id: <20210824073934.19727-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTVxjO6W1vLyxtbotzZ9UB3tUfgNAW2u6iQFx02gR/dDGLxoThHdy0
        BGjv+uHQJQsIaw0gaGajQ7o0wOQbk4rIp+NjKl9KAOcYK7Ctbmx1ErCgGUpYy4XNf8/znOd9
        n/Oe82KIuAWVYFkGC20yUDkEGsptG4iKjX1SLaXky9/Gk0OPm1CycaYcJS8XjPHJK8M2Hnn7
        0RCfHG8s4pGra9f5ZPv8KJ+c7KxEye/XywFZ7vkRJX3XxlHy7KvbXPJe87H9Qk1HxQxf43Jb
        NdXdf3E0k/etGs+jblRT1toANDdGPtf43eFa7ER2kp6mMmlTJG3IMGZmGXTJROrR9APpKrVc
        EatIJN8jIg1ULp1MHDyijT2UlRO4NBF5isqxBiQtZTYTspQkk9FqoSP1RrMlmaCZzBxGzcSZ
        qVyz1aCLM9CWvQq5PF4VMJ7M1q83jwKmRZg34G3h5oPv3igGIRjElfDK73fRYhCKifF2AJ8O
        LvFY8gzAb6bb+CzxAzi0/jfYKnH85OKyB50ArtQ4OSxZBnDd9wNSDDAMxaPhz3dTg/o2/BcA
        G3or+cFqBM+EvtIFbhCH4fuh+9fZja5cfDf01F1DgliA74PNrQUImxYBX82VbuoiOPT1Yy7b
        JwIW3ry66XFg0OYSBXMhfhBOlzKsHAZ991r5LJZA/0LPxpwQLwRw+OoDPkuKAHzycGrTlQCf
        +f0g2AjBo+D1Thkr74IdL52AzRXChZVSHpslgOdsYtYihZXFD9CtrKUpL4/FGjjSM7ihi/E0
        WNBv510AERWvTVPx2jQV/we7ANIAttOMOVdHmxWM8r9fzTDmusHG4kaT7cD5dDGuH3Aw0A8g
        hhDbBGucdymxIJM6fYY2GdNN1hza3A9Ugfe9iEjezDAGNt9gSVcoE+VKdbySTEhMUBNvCYBv
        JyXGdZSFzqZphjZt1XGwEEk+J/fLHWXPSXkPqX//wgfHq/bUhafcSqtdu3Sp+phk8rPf8Jsr
        uy1J7bPnTo80krV2ma2kqeRlXsyR8zLtCXuLw7FjPj7+nfsjo/KmRLunoe/o27VRnkmP7vlJ
        6A2bETr8UfU67krvolGUN0GsxuydG0zZyUSBPjCuBsjw4uE6baHoQ+yj2S84H0u7ylHvktDZ
        MTWmvHNLdXbALftTdagp9VORqWqVCXkBx/JjbuwhkiKm67VCZ+jyH9I0yT9t+/I6zxStzX0i
        P1/2VUzXZbV0F9rtmq/pffjCVnKq6k44tTZ2sW37RF9vR+oBdX3JRNyIvTK/QdaVVuMVupUM
        PE5wzXpKEY2YzNS/Tdu60kEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSvO7rxSqJBi/+CVmcfLKGzWL13X42
        i+mN59ktZpxqY7XYd+0ku8XF1S2sFr/+rme32PH8DLvF5V1z2CyO/O9ntOi/c53N4tWyi2wW
        TX/2sVgcXxvuwOexc9Zddo8Fm0o9Fu95yeRx+Wypx51re9g8+rasYvTYfLra4/MmuQCOKC6b
        lNSczLLUIn27BK6M/2vPMBas46s4/HgdSwPjfu4uRk4OCQETiak3F7B0MXJxCAnsYJTomH6Q
        DSIhJbF7/3kgmwPIFpY4fLgYouYTo8SetQdZQeJsAloSt495g8RFBN4xSux4/5sJpJdZIEPi
        28cTYLawgIPEpof3GEFsFgFViTsrljGD2LwC1hJrtzQyQ+ySl/hzvwcqLihxcuYTFog58hLN
        W2czT2Dkm4UkNQtJagEj0ypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOAI0NLawbhn
        1Qe9Q4xMHIyHGCU4mJVEeP8yKScK8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1
        OzW1ILUIJsvEwSnVwKS3LiyyKmrugceVtgr6G4Vz5CYaMUi+nnSoX0RCo3nxwz/L0sID0mdE
        v7yaFf+b0dWg+8yN/a/PlfUXhmlt2cLivssuWS5t342Wf19jna5VtCr9Df932mPv1L3/jMTS
        Nm70Vu2c/qMio0jIbNPvNtOdl4uKDPdKLBV4l8nMtOkb5/czMo+cUjUu3VcwFzu+VnrGoRWK
        csmzRVLPfLzcN//VqqJPC6bOVnK0D3BY35CtoXS0bv/8/0zXy6q0o/aeS+OefMXGs5Rrrva9
        TaWX103UsTsveOM8r5z5SSXF6JREpokR+10jf4sIz6/ZcnuGdPJx/jPaMlvf1D4z+PZw5ZPH
        hQHvT2qLM9qGaHt+2qPEUpyRaKjFXFScCAClLP3C7wIAAA==
X-CMS-MailID: 20210824074651epcas1p3b6965040fa6a4660a31192f96125c374
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210824074651epcas1p3b6965040fa6a4660a31192f96125c374
References: <CGME20210824074651epcas1p3b6965040fa6a4660a31192f96125c374@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

Each function has a different data type for max_segments,
Modify to match unsigned short(host->max_segs).
* unsigned short          max_segs;       /* see blk_queue_max_segments */

1) Return type : unsigned int
static unsigned int mmc_get_max_segments(struct mmc_host *host)
{
       return host->can_dma_map_merge ? MMC_DMA_MAP_MERGE_SEGMENTS :
                                         host->max_segs;
}

2) Parameter type : int
 mmc_alloc_sg(mmc_get_max_segments(host), gfp);
   -> static struct scatterlist *mmc_alloc_sg(int sg_len, gfp_t gfp)

3) Parameter type : unsigned short
 blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
   -> void blk_queue_max_segments(struct request_queue *q,
                                        unsigned short max_segments)

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/mmc/core/queue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index cc3261777637..48304bcf963c 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -163,7 +163,7 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
 	blk_mq_run_hw_queues(q, true);
 }
 
-static struct scatterlist *mmc_alloc_sg(int sg_len, gfp_t gfp)
+static struct scatterlist *mmc_alloc_sg(unsigned short sg_len, gfp_t gfp)
 {
 	struct scatterlist *sg;
 
@@ -193,7 +193,7 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
 }
 
-static unsigned int mmc_get_max_segments(struct mmc_host *host)
+static unsigned short mmc_get_max_segments(struct mmc_host *host)
 {
 	return host->can_dma_map_merge ? MMC_DMA_MAP_MERGE_SEGMENTS :
 					 host->max_segs;
-- 
2.29.0

