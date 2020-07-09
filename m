Return-Path: <SRS0=IwUb=AU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A46C433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jul 2020 20:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2C9120720
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jul 2020 20:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgGIUYX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:24:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbgGIUYW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jul 2020 16:24:22 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 069JVc1F116185;
        Thu, 9 Jul 2020 15:57:09 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 325r2pr0fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 15:57:09 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 069Jo3og005672;
        Thu, 9 Jul 2020 19:57:08 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 325k1vgpmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 19:57:08 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 069Jv5TQ28508432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jul 2020 19:57:05 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BB7178066;
        Thu,  9 Jul 2020 19:57:07 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 896287805C;
        Thu,  9 Jul 2020 19:57:06 +0000 (GMT)
Received: from ghost4.ibm.com (unknown [9.163.54.227])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jul 2020 19:57:06 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, andrew@aj.id.au, joel@jms.id.au,
        ulf.hansson@linaro.org, adrian.hunter@intel.com, sboyd@kernel.org,
        mturquette@baylibre.com, eajames@linux.ibm.com
Subject: [PATCH 0/2] clk: Aspeed: Fix eMMC clock speeds
Date:   Thu,  9 Jul 2020 14:57:04 -0500
Message-Id: <20200709195706.12741-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_09:2020-07-09,2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 clxscore=1011
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=605 impostorscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090131
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There were two problems affecting clock speeds to the eMMC chip. Firstly, the
AST2600 clock was not muxed correctly to be derived from the MPLL. Secondly,
the SDHCI clock control divider was not calculated correctly. This series
addresses these problems.

Eddie James (2):
  clk: AST2600: Add mux for EMMC clock
  mmc: sdhci-of-aspeed: Fix clock divider calculation

 drivers/clk/clk-ast2600.c          | 49 +++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci-of-aspeed.c |  2 +-
 2 files changed, 42 insertions(+), 9 deletions(-)

-- 
2.24.0

