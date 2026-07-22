Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D0238888E;
	Wed, 22 Jul 2026 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753832; cv=fail; b=GKIkq5nfvBP/2Z/Pibpq0Ok/AzW1NiPyxMQjlUB0/TsuBw28q+qxFZVwNbwn1wVM/xTnACgHE0VSMWXGPAcFKKSLc/ySeVy7MwLEaWNujg0vb5H+GOZ4FDFQZK4gLdUnGL2HzRoH02QSADhft0GOd9BNTV3PtqQ2oKU1RvhqG6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753832; c=relaxed/simple;
	bh=nQzhs0QScvnVdPs1yqsMh8hwalFF9rAe613SCDdoxgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdHu11aCdmsbnQ9eMu5D14sNQAi0b+LMUg5/OZ+TFgCo1wUt4Zqg5z1z37dRAzuv8gMBl7yg/pFSgGPA0E3N9eDB6jBuw6zeh6KoeQ6QLBr1Z4KrGWMKdM9ysP4Mh+nn7pDWu+5OH/DxDPgjkhrYALdpxFkqgOb1Q4wnrndz/TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=HJtOjI0h; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ht1D687F; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="HJtOjI0h";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ht1D687F"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66MHnKMF2309835;
	Wed, 22 Jul 2026 15:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=LqPxHuuc/FdBiHHZDHDn/SHXBOVFmI7rTwuNHpffv
	kg=; b=HJtOjI0h3UtXucW9DczmHtWD8oZB2iRSlcHVK5Qf74nBmvYLCaOc81Nie
	/wZO4x2Nf/Xdc0Uzkjp/T1O1SZcgf1Q3rFD1OJUUaA/60fsc8IWcVI70AU8/xAw6
	enxsetcwOEptW0oyT0zkkPVrLclFplvM6FgwuODRqUqBdgLQuB9zxYE1S80FBwQf
	eGth7mn5l4eMvjC/vkKqCHGZHqDRhgDdtHct/1n9X5DDK/e5TZsdpqTlw2YDioBP
	12Ouh72v2lfeb6mB3Kx3AWZSgQtwZQACBfrb0zfs84O3sOv1GtAv5CNpftcUTJwX
	FDH6S6WeO5UuLMMSVXgBcb0ucGrxg==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fjw4jk782-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 15:57:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1XJlZ/8+QNZhIdeaoOef0xky9WxvNmGhm7nv7ibQawROVLmgtn1YkU/FGSoVm5+XU+vAp3vSWouiWlIRZhmKB088Dv+r63HuLB4OfV/tZE7rPQOkbLiFEutp/BrpzO60q328zQXa+KgKF/gT4xc7GW01kA5CErMbFghxFztZGq86Uohj3SxlvSvo3zTtBcQkKa2wH2bqrmGul19ccVZvT0RjDIggzHYVZni810hPv3Ws1FHAjEVlP0MgfyB/sDA1KBNvpkCajNBgWVKrKUAVYaOVUwNHBLG7sFAUoxnM3PItKAxT6p/mw80QXvdLz0tpDxx13MczVjhNNZJf1wKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqPxHuuc/FdBiHHZDHDn/SHXBOVFmI7rTwuNHpffvkg=;
 b=Z5rYpQy5nk4pefWfpfc6HbrUzPGQPDZNc9kdyG/u4qiMqmnTyz/A94CjG/nO3Emgm8wCNXzXxcD8YFylSCHEgmZgg4/MD+hMHqcLGQEzbtMr68rcyLVCZIHgCpn0TmZ0jZyKPlGb0Ng4/tmuUU1GDKtIsYVDf7bHXr1AYilBryGbszPT8geMqnvbOgMp1JR4OoQrKzlcb3Xi/DDE7lRno9zCwvrLTlgg06ytji68pCRBgmTybwN04zW4073CM/6fjcFqky9bv/S7zfWtEu4LZK7JHfLUcLIbG8kbkhouoI4CBHDJE2Rs3P/8E1OLH6MgiyS637NrryWfz6Htpi6TcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqPxHuuc/FdBiHHZDHDn/SHXBOVFmI7rTwuNHpffvkg=;
 b=Ht1D687F0yMvRG8qhxEVqCkumHi1/B9tME2Dd8puSMJttEogqvm9fcS7Ox3r2U9dHvgZWmFx25BqGYVU67Gt+hAycDK/RMXkWMKdYiypvcccrRpA+E9lsYKMCUGt8viejKpd+MJKaKFl2aXPN7YuU1OdPGx7mJLN67mFw1IT04M=
Received: from CH0PR03CA0411.namprd03.prod.outlook.com (2603:10b6:610:11b::27)
 by PH8PR10MB997766.namprd10.prod.outlook.com (2603:10b6:510:39f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 20:57:05 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::4f) by CH0PR03CA0411.outlook.office365.com
 (2603:10b6:610:11b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 20:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 20:57:04 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 22 Jul
 2026 15:57:01 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 22 Jul
 2026 15:57:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 22 Jul 2026 15:57:01 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66MKv1vt331261;
	Wed, 22 Jul 2026 15:57:01 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] mmc: core: Add mmc_delay_us() for microsecond precision delays
Date: Wed, 22 Jul 2026 15:57:00 -0500
Message-ID: <20260722205701.372789-3-jm@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722205701.372789-1-jm@ti.com>
References: <20260722205701.372789-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|PH8PR10MB997766:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c12d430-d070-4ce7-624f-08dee833c8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9ZEEd6UrPMaXvoqHJCy3DsFj/v6Ni6thu8ByKTilDjVso/5aMa/htdIkh9iEbFSA/cJmerMxeWchSan9O7QyMMUwwKARMd9SmZdxxhiQEdOOQQFobxdV3g/bfwAjRKOrVLY/WWBC/JfQlQCdYa4MRSFo/OTbdIdK90fnqhRFxkPWkQ34JELKB6u0nMqR+aW849l+OZ/pCKyaVY9DmA+fAGU0TC42bHq/Ozk1V9DIO+r0PogfmZJDlZivb0AyWIhhKAVyzapILm3cpfpgmSTIDdPBRlUXJ4cxUo3YG7mZqSZJiftDa7p9XgxBV0XGXMT1GxEYmQh2qruYs7F1fY5ys2Elo/SwEZJN4hVVqm0Feg4JBIbimaw9nwEps5fGw4S/lWQQtvuNACHEgt+iw1Kp3ozjJ5FANoUt+WN3OX/2F925M45Pb6KyvTFz2Xo+JXs137dWlB10HbBhIF3R7kXOzyOKvyiFjBz7WqdP83xZx+yElGGyvhFDZiIbjFlR4+CxIodHV3Yg5vcK7OADcgL5ZZWyBWreBbzBf6O4XJAbjM517C5CDrTABnt5mRFLjeYi9YDTnv+B5j/9w5NrG+1W+9eLcG/OmEyPmm+RwumIbfx7AuQSk4W9Pz9K75346exu0ubId57xHV/MB0c239ItFQnJ4YvoxFkYkLGlrjCmslYd1/DGrn0sSMbCeENUbYAT69H2ix3EJY9DkFYks8ujfA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+Yeaxe9zmjeEuuyGmUweMOdQf2SXh84XIlyjXpCrsua4wxfvnK98Ola0PtY5h5PrmG4JZT3coYzaK1QlCd+dES4toIuB/jhnH58LtMbZpQijmWDAaisp4GE5+7N780clC8zxustiAmMOVytuDU1EskRnJhSj/ip1BNnaIbTJN5fgZu4rDlFwjo/dpFQGR0Z4opmpvGhhMMKdShum2IhIw+oDkcfk5fAB8jZYAjQmjE8vh8wWmasXUOAW4PXgBxqHCZkAc5Wv2Fq5gP0RftwKQrEfNml9/oK4uJCoxAiUyrlc9TlVlpKZvgJgCz3KXGyqE+u6Mz8eEzZ92eXV9wRxwQSzgmmZaz5s81P5uuyvZgw9NZagNwWM5Ur20o0Rqgr7YkS/97X0vu9qrEClwnGOoxMgIcsCBa5IdDS8Z/xtST+EjOy44rL86+L4fXhOWz3G
X-Exchange-RoutingPolicyChecked:
	QamShfHcOanK2og1SuC6vOZSZkkSBwBBRg2V/u1MvbpeIn/IV+HE1QYLK/AH8mp0piGFJpmhoOUg8NtPb+1H+6/JVm+pIJ4Cvg8BV4K75xPhS5hDpDI8SATR+UeKSuu6bPIOn8yDvUx6UQAEuNLYCeK7Wwe8uYYkpmpO/2zwg8yW46xZFIHiSszW52O/E/4HHsZRtKDfgW3HESlHI30ZzV7dm/nwybZBY1YQnx5kOXENs84e0PUs+IOb9hVVWON0AVVB9rPMs3a1FFhpanFh4SvhX6alw6nLC4kuosuWEAMrHaKwRPWO5UEAGHwDek1KdQMK/D03zonhmBysMc1XPg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 20:57:04.1615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c12d430-d070-4ce7-624f-08dee833c8c6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB997766
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIwNyBTYWx0ZWRfX/zJP7zAdlReZ
 QQiO3vHm/7Uk3KR0DbWyzTIRq2qOepjXSOLSRqQZh+uPkiokf4TawSXdwpjzH/pL4vN/stY3wqV
 HgQYHUL4vjq9i8FGpgO8ucNNbrRUQi0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIwNyBTYWx0ZWRfX08fQaXAD/ijW
 Yg+G0UMwGIKYN0eT6juI5RjUX2pvd4qGbGuTaYxbhSxihrpjBcpIG8GFhI7dsr3uQieuyG3k9cN
 uaKXGdCIZL1n0sJaX0ArgagITvoVUGQLn1ApqYstA4/ORvDjHrg/ELewtFUS1axqFgP+GtwqQG6
 //PUaOjdgymU4BRhffU6ssKML7fdImRzmBfErg26Qz09mwelgFEfQmghZhjHOcQN2VLvPZJMhWK
 CgTzHx7LiCxopRGCVmWgmi5Bcj67eWos2hVkOWOvN+/tJaCgNPZAtUhp+Bnb/WHCT5FePYco52H
 Z0dll+uEtvQuj51gTzJQ2rviq3PK36dRQvMOCYBMv0XkkF1qNsY9EkLFdfYahYV6WMNkbripUIn
 pPP4PYSCR41HoGdLmr2eeqVEe5a9wzvMaIOgj+MZOTJqt9nxhhXe9JxCPkJjktElQeZuY5Bn1kK
 Kcb5E/auEOBOhE9+RIQ==
X-Proofpoint-GUID: it5ASAH4iEr04iC7PCxyxipmxMZSzNLB
X-Authority-Analysis: v=2.4 cv=ONwXGyaB c=1 sm=1 tr=0 ts=6a612ea3 cx=c_pps
 a=ZegHLSctVnYqdC7w6owYpw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=mqBQSjPbZoE_d8sq_30A:9
X-Proofpoint-ORIG-GUID: it5ASAH4iEr04iC7PCxyxipmxMZSzNLB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220207

Add mmc_delay_us() to support microsecond-granularity delays needed
in MMC framework. It uses 25% margin consistent with  mmc_delay() for
timing flexibility.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- add patch 2/3
---
 drivers/mmc/core/core.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index a028b48be1644..55e9fb3bab9f7 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -73,6 +73,19 @@ static inline void mmc_delay(unsigned int ms)
 		msleep(ms);
 }
 
+static inline void mmc_delay_us(unsigned int us)
+{
+	if (us < 1000) {
+		usleep_range(us, us + (us >> 2));
+	} else {
+		unsigned int rem_us = us % 1000;
+
+		msleep(us / 1000);
+		if (rem_us)
+			usleep_range(rem_us, rem_us + (rem_us >> 2));
+	}
+}
+
 void mmc_rescan(struct work_struct *work);
 void mmc_start_host(struct mmc_host *host);
 void __mmc_stop_host(struct mmc_host *host);
-- 
2.54.0

