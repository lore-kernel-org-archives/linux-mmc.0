Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E71DC433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 05:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518FB64DEC
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 05:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhBQFdg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Feb 2021 00:33:36 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:43749 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhBQFda (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2021 00:33:30 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210217053247epoutp02f2c24f64a79bce4aa211f00fd361f85a~kcg0_prnx2188121881epoutp02W
        for <linux-mmc@vger.kernel.org>; Wed, 17 Feb 2021 05:32:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210217053247epoutp02f2c24f64a79bce4aa211f00fd361f85a~kcg0_prnx2188121881epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613539967;
        bh=IhP01hyIOJgy9AB0COOkaGUvJuycWGdW5+g0OdIMY8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=suvkcY9HMZf6Gr98BgmPCLncoS1ue3XJwSZsuThK9ow3SL7201dXq5e+qfZbAZsPq
         DxVvBZxXMumcGuu4r/2MKVduhZiQ7mls/xOkW2kemWOrLMma65sD2XwLrsxlIrWUGh
         inI3SCOnbphMOo1E9S/HF0xF9Fbt9g5JU7ep8cBQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210217053245epcas1p2e807844a7bad5a8d11c230defb81a2ce~kcgy7Voiu1240712407epcas1p2i;
        Wed, 17 Feb 2021 05:32:45 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DgRLh4BZqz4x9QB; Wed, 17 Feb
        2021 05:32:44 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.07.63458.C7AAC206; Wed, 17 Feb 2021 14:32:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210217053242epcas1p426e4bdc44270bb6b98eb18f33e66023d~kcgv62xAF1120111201epcas1p44;
        Wed, 17 Feb 2021 05:32:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210217053242epsmtrp2d5b70b67564238fa71765d693699458f~kcgv4z9Hw1885418854epsmtrp2J;
        Wed, 17 Feb 2021 05:32:42 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-b3-602caa7c681c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.CE.13470.A7AAC206; Wed, 17 Feb 2021 14:32:42 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.61]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210217053241epsmtip112d24a6203f82048dc5a89d0dfa050b0~kcgvo2BVV2826528265epsmtip1k;
        Wed, 17 Feb 2021 05:32:41 +0000 (GMT)
From:   DooHyun Hwang <dh0421.hwang@samsung.com>
To:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, axboe@kernel.dk, adrian.hunter@intel.com,
        satyat@google.com, baolin.wang@linaro.org, ebiggers@google.com,
        gustavoars@kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        junwoo80.lee@samsung.com, jangsub.yi@samsung.com,
        sh043.lee@samsung.com, cw9316.lee@samsung.com,
        sh8267.baek@samsung.com, wkon.kim@samsung.com,
        DooHyun Hwang <dh0421.hwang@samsung.com>
Subject: [PATCH 2/2] mmc: core: Add no single read retries
Date:   Wed, 17 Feb 2021 14:19:39 +0900
Message-Id: <20210217051939.13695-3-dh0421.hwang@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210217051939.13695-1-dh0421.hwang@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmvm7NKp0Eg+Vt8hYnn6xhs1h9t5/N
        4lPDFWaLGafaWC3mHznHarHv2kl2i4urW1gtfv1dz27x6+I0VouOrZOZLHY8P8NusetvM5PF
        5V1z2CyO/O9ntGjde4Tdon/1XTaLpj/7WCyunTnBanF8bbjF5kvfWBxEPBZsKvVYvOclk8fl
        s6Uem1Z1snncubaHzaNvyypGj8+b5ALYo3JsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4DeUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQU
        GBoU6BUn5haX5qXrJefnWhkaGBiZAlUm5GTc3T6VtaBDqKK1azlbA+MPvi5GTg4JAROJD4eb
        mUFsIYEdjBIvl1R2MXIB2Z8YJabtXsQI4XxjlFjT/4kJpuPz0nesEIm9jBITNkyCqvrMKDFn
        5m5WkCo2AT2JPb2rwKpEBLqYJO7+PcQG4jALfGSUWHjrNRtIlbCAlcS+1d1Aczk4WARUJa7M
        sAIJ8wrYSqxbP4cZYp28xJ/7PWA2p4CdRO/nt6wQNYISJ2c+YQGxmYFqmrfOZgaZLyFwhUOi
        +8ADNpCZEgIuEhN3l0LMEZZ4dXwLO4QtJfH53V42CLubUaL/kB1E7wRGicvHe6ASxhKfPn9m
        BJnDLKApsX6XPkRYUWLn77mMEHv5JN597WGFWMUr0dEmBFGiJrH433egEnYgW0aikRsi6iHx
        eP8VaLhNZJQ4uOkq4wRGhVlInpmF5JlZCHsXMDKvYhRLLSjOTU8tNiwwQo7gTYzg5K1ltoNx
        0tsPeocYmTgYDzFKcDArifCyf9ZKEOJNSaysSi3Kjy8qzUktPsRoCgzpicxSosn5wPyRVxJv
        aGpkbGxsYWJmbmZqrCTOm2jwIF5IID2xJDU7NbUgtQimj4mDU6qBySq04MNFw6Cdl2deUJp9
        MW9zhMwttRlK8/qZl3wLurp985Q+qYdzZnAlnH3dkX7PIVZNvt3hefSsO/01V1d6dDuraAi3
        vglXFLDSlC76b6R4wGlhbeObGdbHvfSvCt59/yahfMpTZ/a2gNN/fol2CuZaP3Z3W3fzJ3+U
        2fQVfbUx2kkqVzn/HLWZeHrLuX0rmm/626hzt1zwi5TOVnu9cmn17vsf1815pfx1gvmE61WL
        pyns3FFn3dp2cnUj94O5vQfLqqzdfNVzpp5bLr/aQ+y0+Tue7jq11JYprbMqF2+rumx1V+R9
        36ljHH5tksf3um84M1N17bXNTEYZP+oWOl0VDas473Czfd3PbwvZnyixFGckGmoxFxUnAgA8
        xG3tZwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTrdqlU6CwYt2DouTT9awWay+289m
        8anhCrPFjFNtrBbzj5xjtdh37SS7xcXVLawWv/6uZ7f4dXEaq0XH1slMFjuen2G32PW3mcni
        8q45bBZH/vczWrTuPcJu0b/6LptF0599LBbXzpxgtTi+Ntxi86VvLA4iHgs2lXos3vOSyePy
        2VKPTas62TzuXNvD5tG3ZRWjx+dNcgHsUVw2Kak5mWWpRfp2CVwZd7dPZS3oEKpo7VrO1sD4
        g6+LkZNDQsBE4vPSd6wgtpDAbkaJ5htpEHEZie77e9m7GDmAbGGJw4eLIUo+MkocnSEJYrMJ
        6Ens6V0F1MrFISIwg0ni0OEn7CAOs8BvRolJP5rZQaqEBawk9q3uZgIZxCKgKnFlhhVImFfA
        VmLd+jnMELvkJf7c7wGzOQXsJHo/v4W6x1bi7PyPLBD1ghInZz4Bs5mB6pu3zmaewCgwC0lq
        FpLUAkamVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwTGmpbmDcfuqD3qHGJk4GA8x
        SnAwK4nwsn/WShDiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomD
        U6qBacbkz6Jc3Mf+ed3vXqT4nFn59bUPc3IObF+9uvxRmKH47tmnrq/iM+C0L1cszryb8bsz
        9cM0RiU3a7tqiQexofeLHWa/2/yy8pXZr3nKH7p33f048Yah6q/Dk57PL8pYqPPBQUHKoKts
        wQ4biaTSEIPeiSL5S1LTjPae9b9b/4vdOeQ0p6r790OH7RJfuc96dWInz925vFfUbtlF7Jwx
        1ajIafWV+ar8frNCPoh/f92pxPdVU3j+1gf+D34cWLW2oOOhq3XZooWfD0h+lDh39eqqtxaz
        O7IZdLs29t+T2Lhs57eMBXNnsNwKS3Dg7ewPu7t5Ur7mtJ9P2Xv2dTiwLzB68PZXsiXDwr0t
        zILMcWFKLMUZiYZazEXFiQAWGHatIAMAAA==
X-CMS-MailID: 20210217053242epcas1p426e4bdc44270bb6b98eb18f33e66023d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210217053242epcas1p426e4bdc44270bb6b98eb18f33e66023d
References: <20210217051939.13695-1-dh0421.hwang@samsung.com>
        <CGME20210217053242epcas1p426e4bdc44270bb6b98eb18f33e66023d@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This makes to handle read errors faster by not retrying
multiple block read(CMD18) errors with single block reads(CMD17).

On some bad SD Cards that have problem with read operations,
it is not helpful to retry multiple block read errors with
several single block reads, and it is delayed to treat read
operations as I/O error as much as retrying single block reads.

Signed-off-by: DooHyun Hwang <dh0421.hwang@samsung.com>
---
 drivers/mmc/core/block.c | 3 ++-
 drivers/mmc/core/host.c  | 6 ++++++
 include/linux/mmc/host.h | 3 +++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index d666e24fbe0e..e25aaf8fca34 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1809,7 +1809,8 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
 
 	/* FIXME: Missing single sector read for large sector size */
 	if (!mmc_large_sector(card) && rq_data_dir(req) == READ &&
-	    brq->data.blocks > 1) {
+	    brq->data.blocks > 1 &&
+	    !card->host->no_single_read_retry) {
 		/* Read one sector at a time */
 		mmc_blk_read_single(mq, req);
 		return;
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 9b89a91b6b47..3bf5b2fc111b 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -352,6 +352,12 @@ int mmc_of_parse(struct mmc_host *host)
 	if (device_property_read_bool(dev, "no-mmc"))
 		host->caps2 |= MMC_CAP2_NO_MMC;
 
+	if (device_property_read_bool(dev, "no-single-read-retry")) {
+		dev_info(host->parent,
+			"Single block read retrying is not supported\n");
+		host->no_single_read_retry = true;
+	}
+
 	/* Must be after "non-removable" check */
 	if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
 		if (host->caps & MMC_CAP_NONREMOVABLE)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 26a3c7bc29ae..faec55035a63 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -502,6 +502,9 @@ struct mmc_host {
 	/* Host Software Queue support */
 	bool			hsq_enabled;
 
+	/* Do not retry multi block read as single block read */
+	bool			no_single_read_retry;
+
 	unsigned long		private[] ____cacheline_aligned;
 };
 
-- 
2.29.0

