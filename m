Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A333CDB483
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Oct 2023 05:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjJSFq2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Oct 2023 01:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjJSFq1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Oct 2023 01:46:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AF9113;
        Wed, 18 Oct 2023 22:46:25 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J47eG1010785;
        Thu, 19 Oct 2023 05:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=lOh2h2VUuJAbBLtWT8HpptGpl3RAbbEMN0WxCz7fKz0=;
 b=gh4Zts356BjUGbpuMLBLvr+gCyWyHFKnx5TZlE/oDfsAfqRZWbl+lIuowMsP3k6RcK+t
 9bhskyU/l3NBgDN1NKiUxddR+j1BLzgEIzjsTpfPhcgRBN4HHD1LmhRoFF9+IFhq7xBs
 PRqX22GXhKs+SxDhsakFcovcUEe2xQK/mYX1IZ04JpGiBsHxERwYXOc+TUdOVimH2HpF
 9ARo+GCxLeKUT8jD7lpWV2p6CN/iDAtumxGkpaSxLsy3B5ME1Q+mF66b8GlBlPApCaYs
 ZYkwosyxzrqLX4+tZe+joHioNB34blv9/PE9yvigcFZwwQ8fNN/5ducr6KSmuisCVelU ow== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt9kjttkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 05:46:21 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39J5kI4T012573;
        Thu, 19 Oct 2023 05:46:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3tqm2mbdpb-1;
        Thu, 19 Oct 2023 05:46:18 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39J5kIYS012566;
        Thu, 19 Oct 2023 05:46:18 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-sartgarg-hyd.qualcomm.com [10.213.105.147])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 39J5kIPg012564;
        Thu, 19 Oct 2023 05:46:18 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id C33FB52E7D9; Thu, 19 Oct 2023 11:16:16 +0530 (+0530)
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com,
        kernel@quicinc.com, Sarthak Garg <quic_sartgarg@quicinc.com>
Subject: [PATCH V3 2/3] mmc: sdhci-msm: Enable MMC_CAP_AGGRESSIVE_PM for Qualcomm controllers
Date:   Thu, 19 Oct 2023 11:16:11 +0530
Message-Id: <20231019054612.9192-3-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231019054612.9192-1-quic_sartgarg@quicinc.com>
References: <20231019054612.9192-1-quic_sartgarg@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BxiRIx55k6Hlugk2aWg150woYFv5nFHl
X-Proofpoint-GUID: BxiRIx55k6Hlugk2aWg150woYFv5nFHl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_04,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=987 spamscore=0 mlxscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190049
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Enable MMC_CAP_AGGRESSIVE_PM to enable mmc runtime PM functionality for
qualcomm controllers.

Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
---
 drivers/mmc/host/sdhci-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 668e0aceeeba..93c662e28b3b 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2627,6 +2627,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	}
 
 	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
+	msm_host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
 
 	/* Set the timeout value to max possible */
 	host->max_timeout_count = 0xF;
-- 
2.17.1

