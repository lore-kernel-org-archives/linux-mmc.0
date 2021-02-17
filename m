Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FA9C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 05:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B6A64DFF
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 05:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhBQFgN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Feb 2021 00:36:13 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:37686 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhBQFgI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2021 00:36:08 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210217053525epoutp0185cc2cc7f62626c77ca95db4033e9e3d~kcjHkXHNG2344823448epoutp01U
        for <linux-mmc@vger.kernel.org>; Wed, 17 Feb 2021 05:35:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210217053525epoutp0185cc2cc7f62626c77ca95db4033e9e3d~kcjHkXHNG2344823448epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613540125;
        bh=IhP01hyIOJgy9AB0COOkaGUvJuycWGdW5+g0OdIMY8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSYwAd2S58L70eKQRwNlsIZKAK6SURTyjOCeNZ6E7o+Rt/JAbIAMG/1Geau3MBV9p
         +jucgjmF8FxDQP7o4n6oHPtHNtyuM9sLyflYv6odbW5NZ2dpSOeW256NZPt7V+p3iP
         JQ2PSxfTayRFug3AkhEkTEG7Oj7TbCKUs6UcxDQ0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210217053523epcas1p3a6446e0bb75cf8a118a2ed57a4cf6497~kcjGVndX30867608676epcas1p3a;
        Wed, 17 Feb 2021 05:35:23 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DgRPk0C3tz4x9Pr; Wed, 17 Feb
        2021 05:35:22 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.B5.02418.91BAC206; Wed, 17 Feb 2021 14:35:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210217053521epcas1p2aa80cae5d52f30c8c8882f44abe8045c~kcjEPNufT1063410634epcas1p2d;
        Wed, 17 Feb 2021 05:35:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210217053521epsmtrp27d56e76c29d24f91f154f478718d9418~kcjEOGwsB2012920129epsmtrp2B;
        Wed, 17 Feb 2021 05:35:21 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-4b-602cab19ffc6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.B1.08745.91BAC206; Wed, 17 Feb 2021 14:35:21 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.61]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210217053521epsmtip279cb4cd4009f780691c08d108bc26bdb~kcjD68fVw0034600346epsmtip2T;
        Wed, 17 Feb 2021 05:35:21 +0000 (GMT)
From:   DooHyun Hwang <dh0421.hwang@samsung.com>
To:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, axboe@kernel.dk, adrian.hunter@intel.com,
        satyat@google.com, ebiggers@google.com, gustavoars@kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        junwoo80.lee@samsung.com, jangsub.yi@samsung.com,
        sh043.lee@samsung.com, cw9316.lee@samsung.com,
        sh8267.baek@samsung.com, wkon.kim@samsung.com,
        DooHyun Hwang <dh0421.hwang@samsung.com>
Subject: [PATCH 2/2] mmc: core: Add no single read retries
Date:   Wed, 17 Feb 2021 14:22:39 +0900
Message-Id: <20210217052239.13780-3-dh0421.hwang@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210217052239.13780-1-dh0421.hwang@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbVRjO6e39AIFdyofH4hy7upmiQEspnC3ATIamyfyBWQSzRcsVroWs
        tE1vS+ZidHx/D4iDILCxiV/QwZICGyJ0UlHEMDeow0no2CKbKIzBmuo2xmbLZcq/533e5zlv
        nvecQ2GSy4SUytWbOZOe1TGEv/jcd7KY6GesL2fKv5pDaGzuDIGsrloCNf1UiqO2kZ9xZJ8a
        I9GEtRhHD9bOkujBRCOOyvs+FqH+P8ZJNLBWJELOgVYCjTyuBahkaIREtVYXgQof2sVoavxH
        HI12ZaCeyb/Fr4SoT9ks6vbBP0Vq50WL2tZZQahnpgYJ9bHeTqB2255LIw/oknI4NpszRXL6
        LEN2rl6bzOzbr9mrUSXIFdGKXSiRidSzeVwyk/p6WvRruTpvEiYyn9VZvFQay/NMbEqSyWAx
        c5E5Bt6czHDGbJ1RITfG8Gweb9FrY7IMebsVcnmcyqvM1OW4zjfgxnLJ4ZLKL4mj4F5QJaAo
        SMfD4WGqEvhTErofwLLpHpFQ3AVw/tvyjcINYEfrVfyJo6Fgq8APAHhlsgv8J2pa+p6oBH4U
        QcfAwZpO3NcI9R01OH2B9BUYvQLg6emFdVUIvRvarVUiHxbTO+DJOy3AhwPpZDi+cH+dh/Q2
        +HC2GvNhPzoF3pmsxQRNMBz7ZE7sw5hXU9TXgvkGQPoyBX+/1UUI5lToWOwXCzgE/jXaSwpY
        Ct1LQxuaKgBrHSmCuQ5A52j1RkMJ77rdwBcao2Xw7ECsQG+HX6+eAMLgILjkqd7YSyAsL5UI
        kp2w/dE/Xgnpxc/CgqcEVg1dk2dwYVn1ADac/4asA5HNm9I0b0rT/P/cUwDrBOGckc/TcrzC
        qNh8wzaw/rSjVP2g/vZyjAOIKOAAkMKY0EDSHZUpCcxm3z/CmQwak0XH8Q6g8u66HpOGZRm8
        f0Nv1ihUcUqlEsUnJCaolMzTge/Kr2sktJY1c4c4zsiZnvhElJ/0qKhkJbs4VqzPf8/zpidV
        86Gp1TKU9PyNk0UB5369tgNfLLOpHsWVSl+Ujasrig8w8y+k1c2kHZKN/qBdu66uk/ZGdKfM
        xzrmiJvNhZSy8XbbgG35rROqZXIho6JFG/T5TJONrspc3XKcvtRYU3DsJerglXeK437jP7q/
        tjDxi3N7R7sls62kLCArImDcvqeXOpx641JExJzKnGGk78k68ID8wrBP96dbr2652dJF1ZSx
        VX2zsjH58ZGgYG7bB6dDd02ER6/s8XwB9w0PhX32uCfddU36dnf3am94W0783osNt0L5V3ve
        iA2q8DfvDJg5UuicWmQNiQc9dhScPqMnZi9sZcR8DquIwkw8+y/2r4qGYwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXldytU6Cwab/IhYnn6xhs1h9t5/N
        YsapNlaL+UfOsVrsu3aS3eLi6hZWi19/17Nb/Lo4jdWiY+tkJosdz8+wW+z628xkcXnXHDaL
        I//7GS1a9x5ht+hffZfNounPPhaLa2dOsFocXxtusfnSNxYHYY8Fm0o9Fu95yeRx+Wypx6ZV
        nWwed67tYfPo27KK0ePzJrkA9igum5TUnMyy1CJ9uwSujLvbp7IWdAhVtHYtZ2tg/MHXxcjB
        ISFgIjG1UbaLkYtDSGAHo8SC5VtYuxg5geIyEt3397JD1AhLHD5cDFHzEajm2ztmkBo2AT2J
        Pb2rWEESIgL/GCU6Z29iA3GYBX4zSkz60cwOUiUsYCWxb3U3E4jNIqAqMe/9bEYQm1fAVuLM
        659MENvkJf7c7wGbyilgJ/H+Uj+YLQRUM/vYDyaIekGJkzOfsIDYzED1zVtnM09gFJiFJDUL
        SWoBI9MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg6NLS2sG4Z9UHvUOMTByMhxgl
        OJiVRHjZP2slCPGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp
        1cB0pOU4v3OL3eSeM2Lv6zUnHLoTOaf4XZnaCysbgZV6qz9/tpUq1g1a8oBPTmDiroh75f8W
        rVuxk39V4rJbk7eunFMp/un/Pf8/rGdPn6iI+Oz94Pq8sK+Wi7bumubz5f6zP0Ic0vs+3SiY
        Pan886s34dnyHt8WvTvbkMyvYKd4qYz77tbdM77Kuc2Im2i5xYfz+CJZ/Yv12xw0OW6WpM/t
        n1xqmyDBmCa4oevW6zLeeHO99i0CjCGr9Jysvxikxh4o3JbP9HVXQ1WAvkys+4KHaaq3DYNO
        81tqmbsKznov0sv3RSH1qvav3xX2il2fnolvlrjZFfP61KQTxzZXZyTK5jdJ1tV/WquwLnWn
        7P1PSizFGYmGWsxFxYkALRaToB0DAAA=
X-CMS-MailID: 20210217053521epcas1p2aa80cae5d52f30c8c8882f44abe8045c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210217053521epcas1p2aa80cae5d52f30c8c8882f44abe8045c
References: <20210217052239.13780-1-dh0421.hwang@samsung.com>
        <CGME20210217053521epcas1p2aa80cae5d52f30c8c8882f44abe8045c@epcas1p2.samsung.com>
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

