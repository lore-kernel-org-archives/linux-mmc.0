Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3E5C636D0
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Jan 2023 14:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbjA3OM2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Jan 2023 09:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbjA3OMY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2023 09:12:24 -0500
Received: from mail6.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092083BDAE
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2023 06:12:16 -0800 (PST)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 9DEDA222850
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2023 14:11:45 +0000 (UTC)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 89D8622284C
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2023 14:11:45 +0000 (UTC)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx.dmz.swissbit.com [10.181.10.103])
        by mail6.swissbit.com (Postfix) with ESMTPS
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2023 14:11:45 +0000 (UTC)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "drzeus@drzeus.cx" <drzeus@drzeus.cx>,
        "david-b@pacbell.net" <david-b@pacbell.net>
Subject: RE: [PATCH] mmc: mmc_spi: fix error handling in mmc_spi_probe()
Thread-Topic: [PATCH] mmc: mmc_spi: fix error handling in mmc_spi_probe()
Thread-Index: AQHZNKr2jZD2eAZ8tkqouEMpwCVcDK627n8A
Date:   Mon, 30 Jan 2023 14:12:13 +0000
Message-ID: <b28fd5f063014da8bba7c052a8eaf4e9@hyperstone.com>
References: <20230130130106.3484864-1-yangyingliang@huawei.com>
In-Reply-To: <20230130130106.3484864-1-yangyingliang@huawei.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27418.000
X-TMASE-Result: 10--7.106100-10.000000
X-TMASE-MatchedRID: 0aps3uOmWi7UL3YCMmnG4szWN98iBBeG+E++6LGPqmRjtMlSv+S5nC3w
        Thqd/g1IbyyQoXSHdt9MTA0fFM5czLqIXLlnBtioEhGH3CRdKUUfimmlcABuN1EASThysOn65ax
        aw7fIL5GcrQThtVmcVmQqylF9cRUmBXY0oXpqJ14ReM8i8p3vgEyQ5fRSh265ReOJg/1Upn2Pbq
        UoH8TMoTfOsXMjy5EBeMBfrfcAaKdiRyRv3W9D/s36paW7ZnFofS0Ip2eEHnyBQ/4Wfo3oppOr4
        vkrxj4B2AyqvQSyt/c7AFczfjr/7EA+oLG0mqjraO5cberARX7JPHouwpMdtHFWRA90puGbl7AF
        YYjxu2Y=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: bd650b4d-43da-4a19-8728-0ad59c21c8df-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

fail_gpiod_reuqest has a typo, apart from that it looks reasonable.


-----Original Message-----
From: Yang Yingliang <yangyingliang@huawei.com> 
Sent: Montag, 30. Januar 2023 14:01
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org; drzeus@drzeus.cx; david-b@pacbell.net; yangyingliang@huawei.com
Subject: [PATCH] mmc: mmc_spi: fix error handling in mmc_spi_probe()

If mmc_add_host() fails, it doesn't need to call mmc_remove_host(), or it will cause null-ptr-deref, because of deleting a not added device in mmc_remove_host().

To fix this, goto label 'fail_glue_init', if mmc_add_host() fails, and change the label 'fail_add_host' to 'fail_gpiod_reuqest'.

Fixes: 15a0580ced08 ("mmc_spi host driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mmc/host/mmc_spi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c index 75778ffd6cd4..3959c454ce48 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1437,7 +1437,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 
 	status = mmc_add_host(mmc);
 	if (status != 0)
-		goto fail_add_host;
+		goto fail_glue_init;
 
 	/*
 	 * Index 0 is card detect
@@ -1445,7 +1445,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 	 */
 	status = mmc_gpiod_request_cd(mmc, NULL, 0, false, 1000);
 	if (status == -EPROBE_DEFER)
-		goto fail_add_host;
+		goto fail_gpiod_reuqest;
 	if (!status) {
 		/*
 		 * The platform has a CD GPIO signal that may support @@ -1460,7 +1460,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 	/* Index 1 is write protect/read only */
 	status = mmc_gpiod_request_ro(mmc, NULL, 1, 0);
 	if (status == -EPROBE_DEFER)
-		goto fail_add_host;
+		goto fail_gpiod_reuqest;
 	if (!status)
 		has_ro = true;
 
@@ -1474,7 +1474,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 				? ", cd polling" : "");
 	return 0;
 
-fail_add_host:
+fail_gpiod_reuqest:
 	mmc_remove_host(mmc);
 fail_glue_init:
 	mmc_spi_dma_free(host);
--
2.25.1



Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

