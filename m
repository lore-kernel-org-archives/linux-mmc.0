Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31C3C432BE
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Aug 2021 02:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0A460F57
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Aug 2021 02:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbhH3C0G (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 29 Aug 2021 22:26:06 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:15270 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbhH3C0G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Aug 2021 22:26:06 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210830022511epoutp0310db1f909c7e6f513c7431e9e2f5f52f~f9GaQKmSF2771927719epoutp03Y
        for <linux-mmc@vger.kernel.org>; Mon, 30 Aug 2021 02:25:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210830022511epoutp0310db1f909c7e6f513c7431e9e2f5f52f~f9GaQKmSF2771927719epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1630290311;
        bh=0r3qu4CLNN9tvQl31crOG0KHQGziNPyjpHVWFAuHfzY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=vDqlT11uo3nHUellcp3xCx7tH7NkW7KAPRjumQ65cHh913h0Bu+1vEPPa+qp7/RR0
         ejY4lsnVlZGObN0e7SP2tjUW3OhsECm2mnxqZB/Py+brLoEStce93wpKGqaG9KvRUR
         LLE+Wab/NSUB4QPa7ZvDdO+R0L/lVLZ2NvZZR7Qs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210830022510epcas1p427dbdd9fc2b4e465c7f74114b7c988bc~f9GZTeJTR2695126951epcas1p4F;
        Mon, 30 Aug 2021 02:25:10 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.247]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GyZ0h3hQQz4x9QT; Mon, 30 Aug
        2021 02:25:08 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.BC.09752.4814C216; Mon, 30 Aug 2021 11:25:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210830022507epcas1p43b45563c6e36bd00e3b6160bb42605bf~f9GW0P4Jt2694726947epcas1p48;
        Mon, 30 Aug 2021 02:25:07 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210830022507epsmtrp17a9164166ddcff0aaf7b3781310ece33~f9GWzd4l21577215772epsmtrp1-;
        Mon, 30 Aug 2021 02:25:07 +0000 (GMT)
X-AuditID: b6c32a39-6a7ff70000002618-ff-612c41846dd8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.F8.08750.3814C216; Mon, 30 Aug 2021 11:25:07 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210830022507epsmtip15c3b308268a82bde7c44a7d643ce37fe~f9GWjL1lc2712027120epsmtip1I;
        Mon, 30 Aug 2021 02:25:07 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com,
        ChanWoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH] mmc: mtk-sd: Remove unused parameters
Date:   Mon, 30 Aug 2021 11:17:49 +0900
Message-Id: <20210830021749.5947-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmgW6Lo06iwfPtohbXbs1ns5hxqo3V
        Yt+1k+wWv/6uZ7fY8fwMu8Wmx9dYLS7vmsNmcbn5IqPFkf/9jBZNLcYWTX/2sVgcXxvuwOOx
        c9Zddo871/aweWxeUu/RcnI/i0ffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7
        x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBdqKRQlphTChQKSCwuVtK3synKLy1JVcjILy6x
        VUotSMkpMCvQK07MLS7NS9fLSy2xMjQwMDIFKkzIzmi8fpixoI+/YtHF7cwNjFd4uhg5OSQE
        TCTebmti6WLk4hAS2MEo0b+zhx0kISTwiVHi6ypmiMRnRom+1bPZYTpOdj9hhEjsYpRY09PF
        AtHxhVHi/X6RLkYODjYBLYnbx7xBakQErjNKvG3bALaCWaCLUeLXQYgGYQEzibuTprKBNLAI
        qEqsaysHCfMKWEk0XF7PBrFMXuLP/R5miLigxMmZT8BamYHizVtng10nIfCTXWLe1b8sEA0u
        Etd/nWGCsIUlXh3fAnW1lMTL/jZ2iIZmRolTs89BOS2MEq+v3ICqMpb49PkzI8hFzAKaEut3
        6UOEFSV2/p7LCLGZT+Ld1x5WkBIJAV6JjjYhiBIViTld59hgdn288RiqxENi9Uw+SPjESmz/
        3sc6gVF+FpJ3ZiF5ZxbC3gWMzKsYxVILinPTU4sNC0zhkZqcn7uJEZxItSx3ME5/+0HvECMT
        B+MhRgkOZiUR3uw3WolCvCmJlVWpRfnxRaU5qcWHGE2B4TuRWUo0OR+YyvNK4g1NLA1MzIxM
        LIwtjc2UxHkZX8kkCgmkJ5akZqemFqQWwfQxcXBKNTBNXTVXJbfg6zS/mKpYRQGXHZf/O+62
        rVW0fGcZpvTWM+bMFI7jJ+d/XflijuNRU7X6aDmtVw9fftjPumjF7sfOvSyb5s4T7VS+Pn0a
        y8qJsnPkbzwNM1nzkOGHYNImK52CQ/9LK1YUH4/dxjhb4hd/37rmXk9mtWt3l35JjH6+//6L
        Ut2z2T2apzLk9zfFn72+l+/riS3xmx/vXvNda5LrKvcw7q+XGv2np22WtJQO386T/y4t6Nqq
        smTH8ntvTnpnPuHLfrVpb6ft6yXHM04b/v3h/Gi9LHf/VP3oz40Xa2ZuLDG1XqN17ODJ2ku8
        G0+KLg+9nhfYtcHE8t/iaPM5B++8Z3vSln9g1nZDPq7YI0osxRmJhlrMRcWJAJ6fVt4tBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSnG6zo06iQccVVYtrt+azWcw41cZq
        se/aSXaLX3/Xs1vseH6G3WLT42usFpd3zWGzuNx8kdHiyP9+RoumFmOLpj/7WCyOrw134PHY
        Oesuu8eda3vYPDYvqfdoObmfxaNvyypGj8+b5ALYorhsUlJzMstSi/TtErgyGq8fZizo469Y
        dHE7cwPjFZ4uRk4OCQETiZPdTxi7GLk4hAR2MEr8PLyXGSIhJbF7/3m2LkYOIFtY4vDhYoia
        T4wS3/63M4HE2QS0JG4f8waJiwjcZZQ49PYwO4jDLDCBUWLxlbdgg4QFzCTuTpoKNohFQFVi
        XVs5SJhXwEqi4fJ6Nohd8hJ/7vcwQ8QFJU7OfMICYjMDxZu3zmaewMg3C0lqFpLUAkamVYyS
        qQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwaGtpbWDcc+qD3qHGJk4GA8xSnAwK4nwZr/R
        ShTiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBSV7eao7/
        eznlwgnsay5zJUX7/pVrOH63uLX578Lz6p+uLjTJS1rbp9wc9kfv8gfea/L6LG3HFF1mab9Y
        vOye77X5zpGTf2xMeXsiKd75Qi5PcqDttEstnI+urWL5tq32zbPbLuLH5zPvVH5y0e9nRr9i
        fESpeIaD+Dz2y9M3/qgQW+aVu3DZRNevoqulbj/+sfTgJy/FTX+sF03RO+pjO1fiwfOnzD73
        TDkLZs+22K16mKdKy0FkzpMrV22mX8n9t+Kqz52eMrHIxLWfp1RYaogt5H2401pDeKFrV2yp
        Zt/yfw9WTLHkfbrgc6vjduXfzuuSpyyK/FnW2rx2qUyGhqhtW7F5jQwnE9tMg9X515RYijMS
        DbWYi4oTAW2I4hfcAgAA
X-CMS-MailID: 20210830022507epcas1p43b45563c6e36bd00e3b6160bb42605bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210830022507epcas1p43b45563c6e36bd00e3b6160bb42605bf
References: <CGME20210830022507epcas1p43b45563c6e36bd00e3b6160bb42605bf@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

Remove unused parameters
1. msdc_start_data() - struct mmc_request *mrq
2. msdc_track_cmd_data() - struct mmc_data *data

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/mmc/host/mtk-sd.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 4dfc246c5f95..a8736067c409 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1043,8 +1043,8 @@ static inline u32 msdc_cmd_prepare_raw_cmd(struct msdc_host *host,
 	return rawcmd;
 }
 
-static void msdc_start_data(struct msdc_host *host, struct mmc_request *mrq,
-			    struct mmc_command *cmd, struct mmc_data *data)
+static void msdc_start_data(struct msdc_host *host, struct mmc_command *cmd,
+		struct mmc_data *data)
 {
 	bool read;
 
@@ -1112,8 +1112,7 @@ static void msdc_recheck_sdio_irq(struct msdc_host *host)
 	}
 }
 
-static void msdc_track_cmd_data(struct msdc_host *host,
-				struct mmc_command *cmd, struct mmc_data *data)
+static void msdc_track_cmd_data(struct msdc_host *host, struct mmc_command *cmd)
 {
 	if (host->error)
 		dev_dbg(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
@@ -1134,7 +1133,7 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
 	host->mrq = NULL;
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	msdc_track_cmd_data(host, mrq->cmd, mrq->data);
+	msdc_track_cmd_data(host, mrq->cmd);
 	if (mrq->data)
 		msdc_unprepare_data(host, mrq->data);
 	if (host->error)
@@ -1295,7 +1294,7 @@ static void msdc_cmd_next(struct msdc_host *host,
 	else if (!cmd->data)
 		msdc_request_done(host, mrq);
 	else
-		msdc_start_data(host, mrq, cmd, cmd->data);
+		msdc_start_data(host, cmd, cmd->data);
 }
 
 static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
-- 
2.29.0

