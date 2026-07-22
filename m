Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E30432313;
	Wed, 22 Jul 2026 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753834; cv=fail; b=DrbYNygkDGuHNEWaJpA7eg6g+G/+ejStJY0DpGprE9kB5aiItNkGeaWF2k2t5MqE8QT5vI4wiFUfWbY96qWEv9XdOFuL2QQyfgw8zCPEIR2uKUdBqfcv5hDQOjYw9yLVEqrZh3/UZfESog8N1q/bPHDQK+jyKUhCdOfCTCC2IhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753834; c=relaxed/simple;
	bh=FGgfRlcqMAjOFYwWivQGMVrxmGx2zdsSIUu6h6hv35g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UBR1MwrA9gywysS9gb+Pz5/Z25SNEajIvL8adyPRUe+bL9Qv98Rn3m7CfRaVfO2ccXmgalMeWsqFAcQja90cDA2Y+6UCuNzSwgmS2ZhDm39FlpjBHsP5uddAK9q17N8bkMYVwjXKZ3TMmqRFpe2QYNcVwNkzwUsNXbnEiJ5PA8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=qPk9LtJN; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=F+b4iCKJ; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="qPk9LtJN";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F+b4iCKJ"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66MHnEDt197064;
	Wed, 22 Jul 2026 15:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=bqzzCHvwULizs
	Dpyvzr7NLmjMIljZN2QKt4Es49B/Kw=; b=qPk9LtJNh8T1EZAA9Q14qSlfZCE9X
	0GOcazeKILTXg1GjSuYE/mkd7dzQscx/xwVhydrSsGktSjJw4MU3nNtGtQrs1NgM
	iNWL3QA7w59E5piUwIWRyhU0XPVsRtrZ5vCdkp5MWiYMdI+kYmU+3KsDqyP13Tg0
	TkrLsRNBHHlT/heNHdd95vngSBQPFQCWnwViUJtDzZ7J1IXSq01Di2VCEjvC6F2H
	HwluFxVI+ZuUkzHhLtQ7pRSGebVGaalIkoEl4rgJXKhSv90C6FYnnOpn+6MseHeG
	EY3k0d/oz5K6LRr+6KTFM4RaUzPR6lGkP4hJShDGjVJNgWkRynDM8GZ0g==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fjw54b782-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 15:57:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Re+CH4KaQUqR447D5HNW34MRE/b/kYaXkZXzTQghjmmS3aC3Hm7MiG0a8wsNKXwgzORs6VO459118glLXo1pOn49dvEAuXO6vktVseDmyMOD4W1GdfCgiNvknnZuVQgfj5lbWzJWYKuxotIo1E8l7/tN0d4s7pacR4pLOY8qoTcPao8sj51Anp1CmIcTZJAOldVCZ2R7xeslH87rfxfprS+0GLmBM0Zecr3G0Ykxi7DhylUWXp1R5npk13/OeZIalBeprwgEj40qlwzVcFw8ulOjLvvJsI3Y3Q3g1KxBQlwfgFCmHQEP+IkSVywL5iMIykonfQY9u2B0Oiy7m+LVZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqzzCHvwULizsDpyvzr7NLmjMIljZN2QKt4Es49B/Kw=;
 b=N1dd2eBTDWsCkMkYkce9TLZEossla9SPb1+Bvpog+jnaAOypZ6wQfnyYaS8Hd+jsgPuHUtbW9J3cJrXW0LtTE/uSYGkd+6LfL93RcjxPiB+6tvvadCKbSDmt57urehGAfGOdwJ49+e7FqXQWepEn533Ylq1R4ZJV20MJRckefIvhWPG29bPtjwuP5KoGSAOyXqgbmWuZ3gjSkNGDDUqjJ/KYdWsANy/KKaMGbSPfd6vUCQUzwGj9Jaw+LEHwPcWy/h6s3pBgXBHIIXOtSr8FkbtIGZ0tRoKv4TtzAmjf5rveCGNyOTc17uKPiEanuNtbqE+B0jgJJpIapZBC5StQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqzzCHvwULizsDpyvzr7NLmjMIljZN2QKt4Es49B/Kw=;
 b=F+b4iCKJc+NvUF2g85Qiw2cyTi+0b/DdegDSelq9vA1wfrOGp6/vFCVupk5+XX7LPXS9xTHoQ7GBQvGY/IkNOU5gXAmGuW+S/AeyiAYAfMrYF5HBVE+EVS4a09TY07TjSejnZ7OlOZtj/kFbhNL+3XyKT3IybHMdyNEVrJ3suvc=
Received: from PH8PR02CA0019.namprd02.prod.outlook.com (2603:10b6:510:2d0::27)
 by CO1PR10MB4738.namprd10.prod.outlook.com (2603:10b6:303:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 20:57:05 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::13) by PH8PR02CA0019.outlook.office365.com
 (2603:10b6:510:2d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 20:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 22 Jul 2026 20:57:03 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 22 Jul
 2026 15:57:01 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 22 Jul
 2026 15:57:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 22 Jul 2026 15:57:01 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66MKv1vr331261;
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
Subject: [PATCH v2 0/3] mmc: Add power_off_delay_us support
Date: Wed, 22 Jul 2026 15:56:58 -0500
Message-ID: <20260722205701.372789-1-jm@ti.com>
X-Mailer: git-send-email 2.54.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|CO1PR10MB4738:EE_
X-MS-Office365-Filtering-Correlation-Id: d522dc33-cbdf-47a6-4b80-08dee833c83f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|56012099006|10067099003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	v8x2mJRWXKh238C+PvWpGNNqykFjJv53IWtS2NqcKdqZOtw4mCmipMqB1NZRwZQ0eTHsTXcDbaQdW3zAGnGgtvkbdeyxfNpqppyjzi5y0mkIvfoVmPR4X/9uagoA6J/sx+zeIQMrMAuISAA1SqhZz7W5UVcggMZfN1NX5m2qnPcita6t1s0QpQBDV29hyJryZu8dhrUKArXqz+W+cAAZedoAki7DzgibkLcRQyqSKuJiCQc84OuxucP2CTCMYSmF+nH1UOBz++XoTFvyYo0sbi5aQsD8LY/EhoXL8pa6G99Oehpmn33rsdpcLGH/0WklE5kzpmgYlzAn+samXdpPcX7G4oblj484rO4Cw1QSRaCdH/UCQWLILTlE4O9h4NIrH2U1h8jpgndKJ6NrSKsBOg0F5AyExfKsCTwZHy2vCc8u2AmStf0gMaX8BEq9syJ7ctQxpPrU8T3Q4eUg3skqYjtkI7OoFpEHsVg3PsHhKVmrNOECXU4XYoGnkCUGAS3IVqrPCFQeCp53hinYj0YHmNI7/WIB/wN4T47o6htU6uEVwvgAYRaPoj1qN5I9AFqT9KcbTa8XYt6wEYewETFFGExKPmnmTCla5/gx4RUiKBkFdTAO8ghHdoMPCjp43bjv37fSyGIXoHf0beI6XkDG7I2HN8keocoEmdVzs+wHhza69Trlwy1JHmmIuolYnEJ18YIhhX+Ylnk7RA0gVGRx3w==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(10067099003)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DxcsXCnd6lh9sc0IHiJu5sIhZg780wgP5ZFnYF6HqwYU9rmFLgqM2EqCpR8bARK84iqfmtebjhI9VkhvmsOgc/K54/1zl/lPn+eRQ3nb7K8IE4T4Krx0nruYKIN5+PEzg3c5JcHWLTl8C8+1kTqYFRH6O6mC1zmCqSiVfaTYsv2YbLzW3WDhqDzAI1Jn2D0HVvp0raG4TW7OV6KMQrrUP7vkOLkbEGI3Cc9KEeS9wbwrZfcXiVhf+hKbZhbDMxPSyEddJINXrSZ0KOZ1Fc8UdAsFNaOHwgih30BJJcDNe43ymXYIxo3ECsoTugi3qoZQ+XbVhYuemZ/DyUWd7yMlOJPefFnC6LaM5y6u0Z0PbsUxeGSk8o99lTdRrd/Skt6/kwXMtksragWDfzv/qJPpjw2q5HYmP76Mu3z2/5siJtsnkW+rFZr2tN4bEA+WIaHj
X-Exchange-RoutingPolicyChecked:
	P4Wl54lukpiLcPB/cEkquwlpIjEuMO2Wsvj684oO9oqhBAws1tBwtLWJcGnlR9+bYbymCKDEqseZtTFJBNEYWUDCIKXH5figoXxU8xrA1oLc57qVqzShKsp9gHfp+OcB/1CIc96hHriTQFEo2uIuMBWfo8nTmTRHQL/jMfRtrRKc6fHYKHAH9xfwJgTkulStHnQiEPeaAdLlzwSRjsWFoiel412uKqlGY8fxmOjamHXt9NQGWOnMHu6S1s0qhA3ttOf2eBeHWxmj6nrm1UhMJcOwfZGAJozwBvljfDirtbC5CWcuSlrFiYSdzkxGWAt6JBI37UDJGh0yMG3rdY7rVA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 20:57:03.3303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d522dc33-cbdf-47a6-4b80-08dee833c83f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4738
X-Authority-Analysis: v=2.4 cv=S9vpBosP c=1 sm=1 tr=0 ts=6a612ea6 cx=c_pps
 a=RaQOCb/jdUlFsaPmnWcrog==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=EQlS3hUejywmHqZK5OgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIwNyBTYWx0ZWRfX63o81g5xzJXN
 ivNQ0zzFb+9Mq8qc9gVSC2QhaRNTk5iwbZqQeoZC0Ad65Fiiu8yeFhHRoq03lywqUhrI3KVct2Y
 pI5V1AhSKEZLeb1FKV7mNSDbdr1WCSQ=
X-Proofpoint-GUID: RNFblNbzMhViTsUtIOMIuPvTPj_3Elok
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIwNyBTYWx0ZWRfX5cu4WYaD3YKH
 QtzViYleI7JHn6434yaENIKNzn1/tjmoYHCNxFLi+NKYrFGireBeStbM/v006YGm2zyCaekib69
 41Cp8CYglQLrO13kz9B54bVSCQwUQ07pBXsqrv7tBw+Cw1PqYeXvRpABJ6/87kUkv7iPRTEVOIG
 uAs1nv1VnFZKTTkzp7k9UZEcWtClGH/9RvUWdbQbbsTJmnS9VkWqrmCp3qM6Firf45dHa4vBAIt
 n8wbbMHXsgYyjMUCxaT2JNGMi856kBTEuYqTD0pwQPmFoL+aEU8a+zyVEaAR98WpcdGJpJdub/S
 //bbncQ8V10wT26xiee56o+WQhoi/m53l5rkz4yoNtDFoFGBZmbuwtICq3+UyXcqycHPwp37RST
 iQRJ472TuULjoqdO5YGSAkH3t2FGV71mVC7FWxrsW5di2l6atGd4JeH1n1FEczNjVM6YlrQbxs2
 iDx50FkTOmBQpaRoT9g==
X-Proofpoint-ORIG-GUID: RNFblNbzMhViTsUtIOMIuPvTPj_3Elok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220207

This series adds power_off_delay_us support for MMC controllers,
enabling boards to specify custom delays after MMC power off to work around
hardware issues such as slow RC circuites on MMC VDD rails.

Rather than adding host driver-specific workarounds, we abstract the
implementation into the MMC core and pickup the delay value with a device
tree property (power-off-delay-us). This allows any board with slow
power off requirements to configure the necessary delay without code
changes.

The solution is minimal and follows existing patterns as with
power_delay_ms. The allowed minimum value = 1us and maximum value=
10000000us. The default value is 1000us to not deviate from the
original 1ms delay set in mmc_power_off().

Requesting comments for how big the delay should be maxed at, currently
it is set to 10000000us, but not sure if this is too high. Testing
10000000us on AM65 EVM seems to not break SD boot so going with this
value as the max allowed value for now.

Link to v1:
https://lore.kernel.org/all/20260716232641.2659710-1-jm@ti.com/

Changes since v1:
- Add mmc_delay_us()
- Switch from ms to us implementation due to switch from
  post_power_on_delay_ms to power_off_delay_us
- Update commit messages to include more coverletter descriptions

Judith Mendez (3):
  dt-bindings: mmc: Add power-off-delay-us property
  mmc: core: Add mmc_delay_us() for microsecond precision delays
  mmc: core: Add power-off-delay-us support

 .../bindings/mmc/mmc-controller-common.yaml         | 10 ++++++++++
 drivers/mmc/core/core.c                             |  2 +-
 drivers/mmc/core/core.h                             | 13 +++++++++++++
 drivers/mmc/core/host.c                             |  8 ++++++++
 include/linux/mmc/host.h                            |  1 +
 5 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.54.0

