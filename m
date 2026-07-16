Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002643DA7DD;
	Thu, 16 Jul 2026 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784244422; cv=fail; b=lBPXlUza1SrfiTdEUxhaCMWuVrd1njaISxNTmmLgUdmxShm1SOjfPRx3gRW7JuzSdP3BWRcXu0MkEwWK6POIomMqq3iK3dTCfl7gjRWnlxssxjnKqOJhwIzdSET3hSY/lGeD+QqPGpXswVO2rJLI7+d3kCk1h93dDD6Qn+QsEQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784244422; c=relaxed/simple;
	bh=0b0PfpfyJZBAvl4j7BwoM9ZOZwiW6rbNc072RjA4/q4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dXOghpMt3qRBRZ7GVUMhy2JWDhME/rRNRQPfYVT1Y2t6T3/BFAItLY6fEcD9XZH8mHhfK0U8CY2BDjhqxrJ6dgCl1G5HXktv5MaofbtLbAm0MaxFwosLSU9kTptk3A9FimQ/rBqBw4vq0Ws/R542YK1a6eRkNn+DZfUYh+sTOqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=gexzJwX/; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ioki9rvZ; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="gexzJwX/";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ioki9rvZ"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNG36o879063;
	Thu, 16 Jul 2026 18:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=rM1cFEoLa+hXB
	1Keaz8ZAiFSEXDkFCuE4Ky3WXBQAFM=; b=gexzJwX/aO+eKlzTAfFTiDGVNs+JI
	cPZva3pJSXl50G7+nrRRY4y1nXbDG0fB/KcR9KwCkVICsTi2YNtEdD2Oo1UThbkh
	2GJorgmBuxpX2dRcH+ulP9Vf9fvSc2UgqFSidOwpcgHAGnh0EkYmsZD72Xh72l+w
	5e3YE0ql6Ogsy8EjF8iZ51n7MTLithPcOlTCSW/doO422CQHeeGUHskv2Z4HVcFx
	elHT8ILpgdxFnkdVCpi3quMUBQut4AeJyP8eNGehvQgH3zrv2Z6/lpn3Qse7wLGG
	zJWJv6jzrNkXk84K04AQeocf1AZEeZt/4kND6ad2faZSMxiOMxjKZt/fg==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ff1p6tend-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 18:26:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPBOGvWqyYyJgZPiPN3PJFXFGMMuhuFxUN3kohamjxAChIG1oGBtgOJdmyaub1J/opGDu5fRgY8uyCD5Oc7tMN4sMcvvjZhVau/n7Hi6gYPQVo4r6HsimuLLYTPdKYOfGd3ZjU8Thr9FjHD6QwWIdcvKbHislRanVjzAD5R0qSsvL1B/pb/tFlrPAuKsafqFAVmG7kBOYFgKoRJttC9N83D2/9zaKep5cItwLuOBGpxilrgzeC8depK2f7ytL1i3RoVF0bo80pDcTD0ovQGdxNLkccJMYEvhqEje70ygF9tyUc7i8b4/1fWS0t3F9Do8yauT4RClKQCm/eHCELeAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rM1cFEoLa+hXB1Keaz8ZAiFSEXDkFCuE4Ky3WXBQAFM=;
 b=Vooe1na5bDdUC4r1zYdl4iR1eFp8/7V8ns2Vz4GKzEAlGAF1hMy8fYNZ5dJJ78/6u6avYBzz/ytMBKdsBZcp7xMtRjwWtCx55Q0UlziixPtwFMtfOr6uKEEqC3XE+znG/saJhSu6FGZSffWDkruAEjB8/eRcRi2w3HKaHnPOk4wi3N68/3O5XawuBBHZpo4EDuGQzsj8iOcpISuM6n5vHGxSTkgWQoFi3pQsrbRDyy3YDecMglGIR4jhdGBszEKXbotoZXbJ2xb1x+Wl2LCMYBhevhwC17ph55/8iyuAEvwMQspd037REQFid/YRhPRlydURXYgXqZnsWcvgLUvrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rM1cFEoLa+hXB1Keaz8ZAiFSEXDkFCuE4Ky3WXBQAFM=;
 b=ioki9rvZqQ28P+xTWT87xn7PtTeDFx+cRSf59EhesUsLNcRD9MpZddQVJ0hWWBuGkMafA0rjrCJlLTh8BaZI7cJTY33dd/1IIoiElRMmEK9F5kOwvVpWZiHmIlnp8MuIz7S3g6ENWvnBNNdDHfpBxJgpDB187yWtKj0xmJNkbKQ=
Received: from BN0PR04CA0111.namprd04.prod.outlook.com (2603:10b6:408:ec::26)
 by PH0PR10MB5818.namprd10.prod.outlook.com (2603:10b6:510:140::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 23:26:42 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::74) by BN0PR04CA0111.outlook.office365.com
 (2603:10b6:408:ec::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 23:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 23:26:42 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 18:26:42 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 18:26:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 18:26:41 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66GNQfhu2435480;
	Thu, 16 Jul 2026 18:26:41 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] mmc: Add post-power-off-delay-ms support
Date: Thu, 16 Jul 2026 18:26:39 -0500
Message-ID: <20260716232641.2659710-1-jm@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|PH0PR10MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e56006e-b8fe-4672-f2d4-08dee391b1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	E88zUUNR2DzFKaomWVw/QHGgwFdEy2dyHYFhsuSW+eZalVrPJMxjpe3h5TiSE1DCoRn84tbXvL7LOXyQLpyu9mgJNMgFXSPzhFGzB1OAZc2kj1WPsaWXqlA27qoqCvTq2bNszq8UDphh0PHBbrYYWAjJQ5opDtGXMjTaZkvKk45QIyM73P3jVr0TGRIgd9btpJ+y27UHLyRTvi8TzO4a4j4vQ1TKSEHkhCJ/UBjLAazRUq01Vs1T/dv2JuiZL+BUmkiFXehelj7Hqab6l6mCf4FkRakLuLxld+KcLjiEQmso1o8x8NiZ2NrFa8Z/FQ8ALE5QSgShP5tBKzK0lcsPxjVXpXQKngtmymlE0kHkb2LWadQDMg0KgG2t+tVnBfDIy04773Dj40xayzHtkLDKn4sX8xyS++qaGAdk4aWflTJMwhMR0M5RSdB4MXDLuvLZKhVf5pDOFWpRrs5n1xfNfnbnDEysst5Y+kpuGhPo17I1PG3ZJJqzO49gqkCvsRxdKQ4LyjCYKOijrPZJoHFF5m+Pn0u5U3mDWmq53ixU4ew5F9DW+CaT0BXKMcBol7mpEbiwYtIU8IaESa3WxqNKxMiqMmaufyFfZVTZJQ8QGieaWhwcWWKdLaFvZzpP9htJFThVpclb+CrToeIFWDFWCDn4JGJJLx1wyi9onvl18m9LaG79dyF0huXCYaHAXMMTj9QoVIPES1CN3B7P0QGVfQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NKiNI1ZM/JvCvvIkQNYCPk70wwbrG6T4PowY9r4YjOLajGEcB0AzflzuFToCZt6E/9JsqvFXJvRFFDBgXc051XnyY6yHfrzU95mK/hU4Mw9cYx4N6FccTjfqsBKhqDAhal0Z+yznWGVHZ4Ohr6wfKDyLkazOOcY7F4eNlrB6fKHlS8nBMmpj3fYRJGhLVP7J1EpeKQkbsJfscgrli6r6LLXIAVeZNwMuTbrS83g2pAs4d3ZAApC3GvNH5vZtKBbp45wNWJ8LYfGuuSMTjkf1xCN1E0dOAOh7YHkmsfui/OdQpQkhXk94Y4lPUEvJB0gvH0F38qwNIeyzd4hWv2+G5cPEeN/NQ1CHwJ682qreCxQTZLuZ3nbPlJueM+i21SOvv91gisRu5kM55zzYIgwm92NuILKd1K6zoVh8Gphy0ARojt6o10UYXot86+Wnl/uA
X-Exchange-RoutingPolicyChecked:
	S+Nrr8+z2ht31NyMzO8LnEzsWHpiDDG+tzJ54C8TkvNqol7mWVAVHRmo2dN7LKpYhnusgM30a7kE/v21ly6y2OkxBwCq49C6K3HdDQSD36o8v1j9hwdJ0Gb0rclSVC+Fi+3GqFlEYy8iTQnr+jNaJws0wwCHcZtnUP66qyJ1l5O1u6JyuG1ODY/Mli8VxfpNqURxYtUWyC0pb3PJuLs7DV33Sm1DmSf35mcJU05iJB5hO3rVPz6ftt9QCzF0pdMu2ZpxBdDNxwCiQBbifPgBedWASQAJYgEwesVQNNrnRWON0nV0nTf18OEKJqHfv5Bbs9E2FBDvpeOa4Nbmg/XfrQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 23:26:42.3864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e56006e-b8fe-4672-f2d4-08dee391b1be
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5818
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIzNyBTYWx0ZWRfX1a66A4tUTHCA
 BvhKakX6HXep1yFCZoCTRci3AnDVwEZvni+pCjUrTFnNQiX5ri4pu4MFxmOK0rFSpFiYavDOUz+
 fv3Gjdh719RdfJiXRTcMiUcpoHc9lhUz2rOdV1QNgzmJF8TUkwY0vzp4sf19GccXKcbCbYWr3g+
 LHQtlRL8plaIirrz85OtpuQ7GUjZJ/QrwFX0pdokN3p5a1rN9ckVL7wju1s9woGiyqtQNBmufnQ
 hqZeeCKwN3+tqVmG3sbp87/U0ijG6KasPTFVJI2nEmfz/0F2VfFMsdQSrU/zK1NQ20ZGG0tqN7K
 Fn6d4BJn7Qi8jdK1oMKNhyXAa7vDuz1VsDHSJLonwXmoxu2lssaKxOllBr4fxLlp8QxZKo6vYiP
 F0fXD6NOkKTZItzvB30aivLi5OOaD0+D74uFEGci5SM1XSmUNRNuD7GUmpUHyiFnA/dSxjYgt3a
 A3g//XZTKko06skkObw==
X-Proofpoint-ORIG-GUID: DszjAP0EVGwp-qY2jPsODgghZlVsdJ6D
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIzNyBTYWx0ZWRfX+JzgcgyI77sv
 m/Tf93YPpcMaYkwCNQ7v4kPHKEQGk74JRMQ2xUjHyBn4ySCIUZw3DXW6X4b3or3Yr0XjPHUfooL
 hGsTo8c/RjLQ24EL4yTahNYXaz61cok=
X-Authority-Analysis: v=2.4 cv=IOoyzAvG c=1 sm=1 tr=0 ts=6a5968b6 cx=c_pps
 a=MzitxtHdenuwXKuz6QWlPg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=TKg8eoq1An13gOeU0AcA:9
X-Proofpoint-GUID: DszjAP0EVGwp-qY2jPsODgghZlVsdJ6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160237

This series adds post-power-off-delay-ms support for MMC controllers,
enabling boards to specify custom delays after MMC power off to work around
hardware issues such as slow RC circuites on MMC VDD rails.

Rather than adding host driver-specific workarounds, we abstract the
implementation into the MMC core and pickup the delay value with a device
tree property (post-power-off-delay-ms). This allows any board with slow
power off requirements to configure the necessary delay without code
changes.

Requesting comments for how big the delay should be maxed at, currently
it is set to 10000ms, but not sure if this is too high.

The solution is minimal and follows existing patterns as with
(post-power-on-delay-ms).

Judith Mendez (2):
  dt-bindings: mmc: Add post-power-off-delay-ms property
  mmc: core: Add post-power-off-delay-ms support

 .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++++
 drivers/mmc/core/core.c                                   | 8 ++++++--
 drivers/mmc/core/host.c                                   | 8 ++++++++
 include/linux/mmc/host.h                                  | 1 +
 4 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.54.0

