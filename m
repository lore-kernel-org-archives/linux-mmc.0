Return-Path: <SRS0=QsjN=AZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD1DC433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jul 2020 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C3822515
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jul 2020 14:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FeNvAFNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgGNOOZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:14:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55410 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgGNOOY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jul 2020 10:14:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EECukZ087139;
        Tue, 14 Jul 2020 14:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=J205Te7zf3BALzuMd5lnj+R/wr9ZkhVNyWmEg3xKZQY=;
 b=FeNvAFNVjuj6sduxD8LOKAGgFCyscWqkSchikKDWCZVxfPHdpAK2CQ1zG1qhzIYt3YAr
 onQiwBSQAA1ZM9l+i7Zu8SfGkdmWw8cgJsXhZYQv7iOOiACImIo8+WpiB2HejndF+PWd
 on/kL+3W7r6x124c/JjqGlGEYkOxAyVRnd6WF3v80KTgV1Sh2Xiwx5Se/Kbt+nvxLEzG
 N5BitZyo2GKn3knA5Y6Nd6BL1rEapvjkpi+glmSoFteKO1paN2WBa/+mqKUM0Z9VXUbd
 dqcHLmhqT/sXRYbewtuYx7RUyDueBGP7hLj01Oyp86aiti368/8hmszpAJB3IrphaZKV Lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3275cm5k7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jul 2020 14:14:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EE8d5D016544;
        Tue, 14 Jul 2020 14:14:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 327qbxsctf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 14:14:17 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06EEEGx7016164;
        Tue, 14 Jul 2020 14:14:16 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jul 2020 07:14:16 -0700
Date:   Tue, 14 Jul 2020 17:14:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mmc: sdhci: Fix a potential uninitialized variable
Message-ID: <20200714141410.GB314989@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140109
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Smatch complains that "ret" can be used without being initialized.

drivers/mmc/host/sdhci.c
  4383          if (!IS_ERR(mmc->supply.vqmmc)) {
  4384                  if (enable_vqmmc) {
                            ^^^^^^^^^^^^
  4385                          ret = regulator_enable(mmc->supply.vqmmc);
                                ^^^^^
  4386                          host->sdhci_core_to_disable_vqmmc = !ret;
  4387                  }

"ret" is only initialized when "enable_vqmmc" is true.

Fixes: b13099a4dea6 ("mmc: sdhci: Fix potential null pointer access while accessing vqmmc")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8db06da55602..3ad394b40eb1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4104,7 +4104,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	unsigned int ocr_avail;
 	unsigned int override_timeout_clk;
 	u32 max_clk;
-	int ret;
+	int ret = 0;
 	bool enable_vqmmc = false;
 
 	WARN_ON(host == NULL);
-- 
2.27.0

