Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7E0C433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Feb 2021 07:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1CD064F4A
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Feb 2021 07:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhBCHYa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Feb 2021 02:24:30 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:12029 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhBCHY1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Feb 2021 02:24:27 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210203072344epoutp03b8c31b29ebb543cb537dc34f8e2fa10f~gK-sdLPXd0872608726epoutp03M
        for <linux-mmc@vger.kernel.org>; Wed,  3 Feb 2021 07:23:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210203072344epoutp03b8c31b29ebb543cb537dc34f8e2fa10f~gK-sdLPXd0872608726epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612337024;
        bh=rdcUdgO3+bqHaLfClUljUdqQA+bIHHsJ8tMzAtJf2FQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YBikgMRcVH1uOpCaOvXvy/xXjyi7ZhDae4/75UHenqb7K/8UTwp9QMqwuRLWCDzSU
         yJfSBmX1oO1du/XePmzmCjXqOZKRN5mZL916QPsuGKq+ADGvTAS+vTiTlWqAtAfL1k
         MmszIx39OnPuNyfTPzCwjdGAHAc6gAhD3xJZjMOU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210203072343epcas1p181d235124b3d05b237e4623c22c07961~gK-rc2Bsw3208532085epcas1p1m;
        Wed,  3 Feb 2021 07:23:43 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DVtTB3Vlqz4x9Pv; Wed,  3 Feb
        2021 07:23:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.E1.02418.E7F4A106; Wed,  3 Feb 2021 16:23:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210203072341epcas1p186cca2cf8177a31d04f1ede4bb5f1ec7~gK-qbd8mf2905329053epcas1p1m;
        Wed,  3 Feb 2021 07:23:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210203072341epsmtrp2b094d30834c663d3dae1ef7f7616d56a~gK-qacDnI0619906199epsmtrp2J;
        Wed,  3 Feb 2021 07:23:41 +0000 (GMT)
X-AuditID: b6c32a35-c0dff70000010972-eb-601a4f7edcc7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.CA.13470.D7F4A106; Wed,  3 Feb 2021 16:23:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210203072341epsmtip12f0170e9a74c74c0a7fab3e801bb2dd1~gK-qLZ1Dy0638306383epsmtip1R;
        Wed,  3 Feb 2021 07:23:41 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        baolin.wang@linaro.org, arnd@arndb.de, cw9316.lee@samsung.com,
        colyli@suse.de, lee.jones@linaro.org, sartgarg@codeaurora.org,
        pcc@google.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
Subject: [PATCH] mmc: queue: Remove unused define
Date:   Wed,  3 Feb 2021 16:20:14 +0900
Message-Id: <20210203072014.30272-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmnm6dv1SCwa6fEhYnn6xhs/g76Ri7
        xaeGK8wW0xvPs1vMONXGarHv2kl2i19/17Nb7Hh+ht3i/tejjBaXd81hszjyv5/Rov/OdTaL
        GX3fWC2a/uxjsTi+NtyB3+P3r0mMHpf7epk8Fmwq9Vi85yWTx51re9g8+rasYvTYfLra4/Mm
        uQCOqBybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKDT
        lRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6yfm5VoYGBkam
        QJUJORkLVkxhKpjOWXH28WbGBsZb7F2MnBwSAiYSn959YgOxhQR2MEoca4vrYuQCsj8xSuxc
        +IwRwvnGKLHsagdcx7cVs1khEnuBEnvWskA4XxglFp1cDeRwcLAJaEncPuYN0iAi0MAksWlx
        KYjNLJAi8arnHQuILSxgKHHg7DqwoSwCqhJH27cxg9i8AtYSZ2Z/ZYJYJi/x534PVFxQ4uTM
        JywQc+QlmrfOZgbZKyEwk0Ni/6u5LBANLhJHrrdC2cISr45vgbpaSuLzu71sEA3NjBKnZp9j
        h3BaGCVeX7kBVWUs8enzZ0aQD5gFNCXW79KHCCtK7Pw9lxFiM5/Eu689rCAlEgK8Eh1tQhAl
        KhJzus6xwez6eOMxVImHxJJmS0jwxkp8O/mJaQKj/Cwk78xC8s4shL0LGJlXMYqlFhTnpqcW
        GxYYIkfqJkZw8tUy3cE48e0HvUOMTByMhxglOJiVRHhPTRJLEOJNSaysSi3Kjy8qzUktPsRo
        CgzgicxSosn5wPSfVxJvaGpkbGxsYWJmbmZqrCTOm2TwIF5IID2xJDU7NbUgtQimj4mDU6qB
        ad3H7ikfP6V/qN0jc+Da2QcuFVmnF/6y+bWR1Va/gVWjlDNSZt6Z34prnl//sGbx6Zi/13gU
        /zgLf23cwZJexZ3ufHC5Zwi/8vmKisZTMwU1Th/bfkr7qZhXi69lRNJtCWWHM2nLa+MqPFpi
        gxMLVTPNL/pd2B0g+EjhzEEDo8V/VLb+in6hsizsUIn8wcX1oRVbEzZkPCk8++4jY9/Js8fN
        ErxVwiqWmXRWq1meT+sTXhtfbOYUJO7YWWn3ty74uzqz+ocXAekqXz58CJ0d90KxUbomLuHS
        MZler5fHbdTfvJguJ2+p9LvIPc0s9JJ10TXftp/Lb0W4ljHEPc3VPmZwOeHhH+UbOcXpiq1K
        LMUZiYZazEXFiQDzuv9pRwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnG6tv1SCwZz5JhYnn6xhs/g76Ri7
        xaeGK8wW0xvPs1vMONXGarHv2kl2i19/17Nb7Hh+ht3i/tejjBaXd81hszjyv5/Rov/OdTaL
        GX3fWC2a/uxjsTi+NtyB3+P3r0mMHpf7epk8Fmwq9Vi85yWTx51re9g8+rasYvTYfLra4/Mm
        uQCOKC6blNSczLLUIn27BK6MBSumMBVM56w4+3gzYwPjLfYuRk4OCQETiW8rZrN2MXJxCAns
        ZpSYfv8dVEJKYvf+82xdjBxAtrDE4cPFEDWfGCW6t98Ai7MJaEncPuYNEhcR6GOSuHt2PhNI
        L7NAhsS3jyfAbGEBQ4kDZ9eBzWQRUJU42r6NGcTmFbCWODP7KxPELnmJP/d7oOKCEidnPmGB
        mCMv0bx1NvMERr5ZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjgYt
        zR2M21d90DvEyMTBeIhRgoNZSYT31CSxBCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJ
        pCeWpGanphakFsFkmTg4pRqY3O1aN9/0/7lAxs8u+Een8VaO+i51Fft7TzJMWH/tm19nqfnP
        bJ/UijOblC1K5otrnT/ndGTPmeh9og1yFbNyGG27DWwurNe6KxiVv1164RqBPbrWvPPXSP85
        Z+/Qx5y66IaebZH9xoszPhz/e7xDy9XrlmZpW+T3RiuvNpWekndzNwc/d7r9/TufrKTMqkBX
        VcfT0xT+Fu3Sa8/tuCPuJi+sckrlqP/tnbM+3PRft8mH70Zjf/iZe/l94a82RDPOMJUu4BNa
        8Weu86lpl0L+1Szp+xHFvD2mn/Hv6Sr3/pWmO/V5sw9fmrA16e26+/fjuft/px5SN3wwWUz9
        vLb8pvZLNWw5VXJPt91ezG2jxFKckWioxVxUnAgAcbkN7vUCAAA=
X-CMS-MailID: 20210203072341epcas1p186cca2cf8177a31d04f1ede4bb5f1ec7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210203072341epcas1p186cca2cf8177a31d04f1ede4bb5f1ec7
References: <CGME20210203072341epcas1p186cca2cf8177a31d04f1ede4bb5f1ec7@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

MMC_CQE_QUEUE_FULL is not set and is only cleared.
Therefore, define is unnecessary.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/mmc/core/queue.c | 2 --
 drivers/mmc/core/queue.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 002426e3cf76..9f37a8b909e8 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -33,8 +33,6 @@ void mmc_cqe_check_busy(struct mmc_queue *mq)
 {
 	if ((mq->cqe_busy & MMC_CQE_DCMD_BUSY) && !mmc_cqe_dcmd_busy(mq))
 		mq->cqe_busy &= ~MMC_CQE_DCMD_BUSY;
-
-	mq->cqe_busy &= ~MMC_CQE_QUEUE_FULL;
 }
 
 static inline bool mmc_cqe_can_dcmd(struct mmc_host *host)
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index fd11491ced9f..57c59b6cb1b9 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -81,7 +81,6 @@ struct mmc_queue {
 	int			in_flight[MMC_ISSUE_MAX];
 	unsigned int		cqe_busy;
 #define MMC_CQE_DCMD_BUSY	BIT(0)
-#define MMC_CQE_QUEUE_FULL	BIT(1)
 	bool			busy;
 	bool			use_cqe;
 	bool			recovery_needed;
-- 
2.29.0

