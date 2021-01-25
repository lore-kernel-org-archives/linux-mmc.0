Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3806AC433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jan 2021 06:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC8B229C5
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jan 2021 06:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbhAYGu1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Jan 2021 01:50:27 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:51788 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbhAYGsp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jan 2021 01:48:45 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210125064732epoutp02a985b11b490226c4dbef5efbae772fee~dZshYA90n2169321693epoutp02g
        for <linux-mmc@vger.kernel.org>; Mon, 25 Jan 2021 06:47:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210125064732epoutp02a985b11b490226c4dbef5efbae772fee~dZshYA90n2169321693epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611557252;
        bh=MdJmU13+cQffQ66PN9tFmxfBKVu6PuYMV1moSX5+xe8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=D64cEimoDJ5+aFPhm5ZnXqKzpetOgzgCq3Lg0Jbr4ef5DHE1n2lnw2mrNdak49y0F
         vYvQ/KhaK/AKzftKVtTfbFvrJAX0MmnIj1ybN9alaEeiTXYnvyqPo8lm3m0z9bydmK
         5EY1U6t4dFEo83isPdCgEIhykp9003WilOz5dtzQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210125064731epcas1p29694f56ee4dbce209d49eaafda876ecc~dZsgYEte-0856108561epcas1p2W;
        Mon, 25 Jan 2021 06:47:31 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DPL5Y5fhmz4x9QJ; Mon, 25 Jan
        2021 06:47:29 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.71.09582.1896E006; Mon, 25 Jan 2021 15:47:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210125064728epcas1p3c44396f8f733463d5e0add003cc2b7eb~dZseJNaPI2442624426epcas1p3M;
        Mon, 25 Jan 2021 06:47:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210125064728epsmtrp147a106c9fd849909c25835397adfa780~dZseIWWR71301413014epsmtrp1m;
        Mon, 25 Jan 2021 06:47:28 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-67-600e6981605f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.31.13470.0896E006; Mon, 25 Jan 2021 15:47:28 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210125064728epsmtip131c763bc2294f25ba12c1a0439353e29~dZsd29NA23116731167epsmtip1W;
        Mon, 25 Jan 2021 06:47:28 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        baolin.wang@linaro.org, arnd@arndb.de, cw9316.lee@samsung.com,
        colyli@suse.de, lee.jones@linaro.org, sartgarg@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
Subject: [PATCH] mmc: queue: Exclude unnecessary header file
Date:   Mon, 25 Jan 2021 15:43:55 +0900
Message-Id: <20210125064355.28545-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmnm5jJl+CwdpGJYuTT9awWfyddIzd
        4lPDFWaL6Y3n2S1mnGpjtdh37SS7xa+/69ktdjw/w25x/+tRRovLu+awWRz5389oMaPvG6tF
        0599LBbH14Y78Hn8/jWJ0eNyXy+Tx+I9L5k87lzbw+bRt2UVo8fm09UenzfJBbBH5dhkpCam
        pBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2spFCWmFMKFApI
        LC5W0rezKcovLUlVyMgvLrFVSi1IySkwNCjQK07MLS7NS9dLzs+1MjQwMDIFqkzIyXi2K7vg
        IGvFhdZZ7A2M11m6GDk5JARMJO4e+MXWxcjFISSwg1FiWe83dgjnE6PE8rsNjBDON0aJeS8a
        gco4wFpWXFWHiO9llLg0+xhUxxdGiTkXTrGCFLEJaEncPuYNEhcR+MAo8eT5TzaQfcwCKRKv
        et6B7RYWsJFonjIXzGYRUJXY2LOaFcTmFbCWaL92jQ3iPnmJP/d7mCHighInZz5hgZgjL9G8
        dTYzyAIJgV4OiWXP9rJCNLhIPDx4hAnCFpZ4dXwLO4QtJfGyv40doqGZUeLU7HNQTgujxOsr
        N6CqjCU+ff7MCPICs4CmxPpd+hBhRYmdv+cyQmzmk3j3tYcVEhS8Eh1tQhAlKhJzus6xwez6
        eOMx1D0eEi3fII4WEoiVWHdlK+sERvlZSP6ZheSfWQiLFzAyr2IUSy0ozk1PLTYsMEaO1U2M
        4GSrZb6DcdrbD3qHGJk4GA8xSnAwK4nw7tbjSRDiTUmsrEotyo8vKs1JLT7EaAoM4YnMUqLJ
        +cB0n1cSb2hqZGxsbGFiZm5maqwkzptk8CBeSCA9sSQ1OzW1ILUIpo+Jg1OqgenQzTK1sxdv
        f8rI3ZXrK92+aOmemWeYmZqmCGz6mPmNvUV2leI5kUevfVVLg5m5z9RYl9UfKO6MjBGpf698
        5cdD/hV7S3bm+F5ffP/IvweZjZzdU+Ys2pd+4NaGhAOruSWaORSYk61eue4tXyhzX/itx9IJ
        1+dfbn1xXSJnxiqnCcFf7mTNO/2XzfBX+VKLx5zabIJTUvi82iefMajo/38seu2sExOC4m99
        Zn7oFfKnIqqnOVH/3aa5v//p1SwWPXL4XfntSQ5PFPn0El0b2BQ//PlpFah3NF/X5ZmU5tKO
        bU7vf3dUO7ofPbOoN5TJ8+18kW3z159TsljpPLf17Nk52Sv4lJfuCo7fejPqiKypEktxRqKh
        FnNRcSIAUnRf4T8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSnG5DJl+CwZQr2hYnn6xhs/g76Ri7
        xaeGK8wW0xvPs1vMONXGarHv2kl2i19/17Nb7Hh+ht3i/tejjBaXd81hszjyv5/RYkbfN1aL
        pj/7WCyOrw134PP4/WsSo8flvl4mj8V7XjJ53Lm2h82jb8sqRo/Np6s9Pm+SC2CP4rJJSc3J
        LEst0rdL4Mp4tiu74CBrxYXWWewNjNdZuhg5OCQETCRWXFXvYuTiEBLYzSgxteEcexcjJ1Bc
        SmL3/vNsEDXCEocPF0PUfGKUuPZiLztInE1AS+L2MW+QuIjAH0aJS/tbmUB6mQUyJL59PAFm
        CwvYSDRPmcsCYrMIqEps7FnNCmLzClhLtF+7xgaxS17iz/0eZoi4oMTJmU9YIObISzRvnc08
        gZFvFpLULCSpBYxMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgsNeS3MH4/ZVH/QO
        MTJxMB5ilOBgVhLh3a3HkyDEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC
        1CKYLBMHp1QDU/WqqKPfi2QtJOZc28CdzOllVaEq6Rg99dsviROmaQ7yl5V3T7TIV74jorTh
        +awS04kyohqvVyzZcfpPhEv50VKDO5OL1/C2nS+44PF+/4l8Sz1eBoHbJxs+MbPPd1ZROpkn
        lt/6sevW/LJIjk9p296oHf1Y0v9N1q/ufnXMXfPS7TOv16fvjKqof+Qw53ff/CWdWw5fv9MQ
        JbI89gTbsdVr4n696eqf/13/6aIrf10m7592wd3M/NGvup/yx9LZ5yi32jjbyYpMj5o756FZ
        3E/GzCXGR/9FmzHlr5gZenChl9nNaTnJE3YrBaxUPzPj86n2T0dv+nQrKzGxsSt3PxaZuK7s
        QPOCVqZIvTc5oUosxRmJhlrMRcWJAMA2KiHqAgAA
X-CMS-MailID: 20210125064728epcas1p3c44396f8f733463d5e0add003cc2b7eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210125064728epcas1p3c44396f8f733463d5e0add003cc2b7eb
References: <CGME20210125064728epcas1p3c44396f8f733463d5e0add003cc2b7eb@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

From the 4.19 kernel, thread related code has been removed in queue.c.
So we can exclude unnecessary header file.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/mmc/core/queue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index de7cb0369c30..c7218da6f17c 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -7,7 +7,6 @@
 #include <linux/module.h>
 #include <linux/blkdev.h>
 #include <linux/freezer.h>
-#include <linux/kthread.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-mapping.h>
 #include <linux/backing-dev.h>
-- 
2.29.0

