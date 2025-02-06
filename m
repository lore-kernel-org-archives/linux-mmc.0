Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187541DBB19;
	Thu,  6 Feb 2025 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.142.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876234; cv=none; b=U8QVJKyR1XkdBhvzFQvsf1Y9d5126Zk4TL+6f1z1VWXsjoidq2xWKXsw0BnCe69mlLGBVWU8RagxVTrn3MwwKBexYSd9PG+MTf7ukkej7v6Yva9ygnooo3Fgx0L9s01U50Er1MRBR3DEmU1DSnlP0Cauz94eVasSuoz93xgQjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876234; c=relaxed/simple;
	bh=RrLWMiyMZoy4fFtEfdeI93ZCnoboO/JrPmZYqyjYgrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZX0V9P0GRbh+EOy5axCyagRPoyZivocWY8OGDAErIniBxOoIrpQhGbaV54a3KReDvGcAbTqZAZ+T9jYGbDEQhcqJMANWNJKN5gheGqx01ITL4YDZnVg2MAB1bPiyacJEll+B/QRgwuIGDKx7il7CVTEBARqEgxONcEnn6Vwpmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=a8e4Zlei; arc=none smtp.client-ip=148.163.142.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="a8e4Zlei"
Received: from pps.filterd (m0144091.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516JfnNe015975;
	Thu, 6 Feb 2025 21:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=oaICba/RqJ8714I3emClCyshy0SN799APKvXL7xrVho=; b=a8e4Zleim4Or
	OPzU5kJp1l5n+ElICKAZD74hddyBN8V3C7bsdPwjDH168mJwF71NFWxUgy3DFG28
	haTBMBy58+hrwHwLYZiOmykaU1Kj55tFY4IddUn0DgvdU7T0HiR+j170Dckq0CVy
	mciNEf+HJhBQ1LUJSxGQEwfBquCFMRe9b3h8XQKx2oBre97lpCPDuHRzob5XH3Eq
	HjhV6CHbYYNd4ZMaeVzuXJTOCKuri6lQ2833ohDT9gTgJ5L381VceaGFQhZ3c7Sn
	CPoZ7lI/KccGrdbHGG68I7BmqxP1RXzVafBLqEiWg12BS6eTBPm5giAkADufCohN
	FQyzoqUJfw==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 44n3fe0urn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 21:09:37 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 6 Feb 2025 15:09:36 -0600
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Thu, 6 Feb 2025 15:09:36 -0600
From: Erick Shepherd <erick.shepherd@ni.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <adrian.hunter@intel.com>, <avri.altman@wdc.com>,
        <wsa+renesas@sang-engineering.com>, <quic_jjohnson@quicinc.com>,
        <andy-ld.lu@mediatek.com>, <victor.shih@genesyslogic.com.tw>,
        <keita.aihara@sony.com>, <dsimic@manjaro.org>,
        <cw9316.lee@samsung.com>, <ricardo@marliere.net>,
        Erick Shepherd <erick.shepherd@ni.com>
Subject: [RFC PATCH V2 2/2] mmc: allow card to disable tuning
Date: Thu, 6 Feb 2025 15:08:35 -0600
Message-ID: <20250206210835.2980500-2-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206210835.2980500-1-erick.shepherd@ni.com>
References: <20250206210835.2980500-1-erick.shepherd@ni.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9F-rCK_0yXv7T_jWGicM_3CPTnuofjpx
X-Proofpoint-ORIG-GUID: 9F-rCK_0yXv7T_jWGicM_3CPTnuofjpx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=857
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060167

Add a new field to the mmc_card struct to disable tuning for the card.
Currently the new field only gets set when a DDR50 card fails to tune,
which indicates the card does not support tuning.

Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
---
 drivers/mmc/core/core.c  | 3 +++
 drivers/mmc/core/sd.c    | 1 +
 include/linux/mmc/card.h | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5241528f8b90..ee91d53c45d5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -934,6 +934,9 @@ int mmc_execute_tuning(struct mmc_card *card)
 	u32 opcode;
 	int err;
 
+	if (card->disable_tuning)
+		return 0;
+
 	if (!host->ops->execute_tuning)
 		return 0;
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index cc757b850e79..dd65485c61d8 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -676,6 +676,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 		if (err && card->host->ios.timing == MMC_TIMING_UHS_DDR50) {
 			pr_warn("%s: ddr50 tuning failed\n",
 				mmc_hostname(card->host));
+			card->disable_tuning = true;
 			err = 0;
 		}
 	}
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 526fce581657..f9733c7ce430 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -332,6 +332,7 @@ struct mmc_card {
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
+	bool			disable_tuning;	/* Disables tuning for the card */
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
-- 
2.43.0

