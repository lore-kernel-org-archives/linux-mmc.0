Return-Path: <SRS0=IwUb=AU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C53C433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jul 2020 09:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53282206E2
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jul 2020 09:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KFeZJr1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgGIJnr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:43:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48276 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgGIJnr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jul 2020 05:43:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0699glro009378;
        Thu, 9 Jul 2020 09:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=HG+X6OyA9h0YqjqNOUBdkxSmp0wXCsbtcAjLA47gbRQ=;
 b=KFeZJr1ZTTsKowiVRtVK0/mE82JRqibB3NC99dTUtwRcHXiuJdQB0MKGOyGBtnxGBCK+
 8zxA+n9CgDgCNFP0mWwo2suwHF5iaO5ROFpTJHCoUZt4k76788XYWvGXFSPbFTPnGqrX
 kIF992vcL0DHOZneNUhb1nWPsdn6gyUjFoGKMbPJHPaHDaOSptoQ3GliVUuldCuWZBDX
 Kt4R8EU0JWauM0ecOHw6u0bOSrKhzCVgPHFr3m78mt3XZqWYdBASvoNl48SUoipaadx4
 KDGhkQmOV0Y5jl2DgeLXDKLq7DkV5v6tDWCdX/+Eqx/rD+HXOzmsdSVapPiKHXjfqykf 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 325y0agnr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 09 Jul 2020 09:43:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0699hHgC037535;
        Thu, 9 Jul 2020 09:43:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 325k3gkre3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jul 2020 09:43:45 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0699hhUC011473;
        Thu, 9 Jul 2020 09:43:44 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jul 2020 02:43:43 -0700
Date:   Thu, 9 Jul 2020 12:43:38 +0300
From:   <dan.carpenter@oracle.com>
To:     vviswana@codeaurora.org
Cc:     linux-mmc@vger.kernel.org
Subject: [bug report] mmc: sdhci: Allow platform controlled voltage switching
Message-ID: <20200709094338.GA17926@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=717 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 phishscore=0 suspectscore=3
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=712
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090076
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Vijay Viswanath,

The patch f870b6d480d3: "mmc: sdhci: Allow platform controlled
voltage switching" from Jun 23, 2020, leads to the following static
checker warning:

	drivers/mmc/host/sdhci.c:4396 sdhci_setup_host()
	warn: potential ERR_PTR parameter dereference 'mmc->supply.vqmmc'

drivers/mmc/host/sdhci.c
  4375          if (host->caps & SDHCI_CAN_DO_HISPD)
  4376                  mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
  4377  
  4378          if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
  4379              mmc_card_is_removable(mmc) &&
  4380              mmc_gpio_get_cd(host->mmc) < 0)
  4381                  mmc->caps |= MMC_CAP_NEEDS_POLL;
  4382  
  4383          if (!IS_ERR(mmc->supply.vqmmc)) {
  4384                  if (enable_vqmmc) {
  4385                          ret = regulator_enable(mmc->supply.vqmmc);
  4386                          if (ret) {
  4387                                  pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
  4388                                          mmc_hostname(mmc), ret);
  4389                                  mmc->supply.vqmmc = ERR_PTR(-EINVAL);
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is an error pointer.

  4390                          }
  4391                          host->sdhci_core_to_disable_vqmmc = !ret;
  4392                  }
  4393  
  4394                  /* If vqmmc provides no 1.8V signalling, then there's no UHS */
  4395                  if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
                                                            ^^^^^^^^^^^^^^^^^
It is dereferenced inside the function and will crash.

  4396                                                      1950000))
  4397                          host->caps1 &= ~(SDHCI_SUPPORT_SDR104 |
  4398                                           SDHCI_SUPPORT_SDR50 |
  4399                                           SDHCI_SUPPORT_DDR50);
  4400  
  4401                  /* In eMMC case vqmmc might be a fixed 1.8V regulator */
  4402                  if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 2700000,
  4403                                                      3600000))
  4404                          host->flags &= ~SDHCI_SIGNALING_330;
  4405          }
  4406  

regards,
dan carpenter
