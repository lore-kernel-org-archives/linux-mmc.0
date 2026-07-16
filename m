Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A173C5849;
	Thu, 16 Jul 2026 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784244415; cv=fail; b=NssTRjtuFFrtxvB1yFeJ55AopdNVhsdSYnGisCphIhB17ShihYvrCVr/2fXoj+qBlCP4VmsC1wwW3VMeSRLyslFo+Q+PY4W6oNfo2I94uj4rVNnH974KNAHepwZ5BRr5BZNE5w/rBustEV9vxfVW9OfxZoZIl+pRVPbNmqDU6oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784244415; c=relaxed/simple;
	bh=eeVcSyGjRQV8FMRReHy/Msh/+BHkPZU93leBolsJNZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cq9NOt6092/MWHPvTyrRENHk5kO3XPqPVlrBDM355xy190Rap+U/X15jE9EAEVyCYzfAOAxs6RHviTFjKzGGHUyJWxTjqXFCF3+1hcqyWiG1xH/avy4oZlAL9HfWFy/XqgVhJv2mhu44zs8wEhOZtgueimNyZypZWkjX2JNf+j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=EzgMdoVq; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kLCvdDP9; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="EzgMdoVq";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kLCvdDP9"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66GNGlQp915830;
	Thu, 16 Jul 2026 18:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Qh2/FH3+7IMGuFKt3ioV5OKpnXwVGQBL7vwkjT+lg
	cc=; b=EzgMdoVqD90xTC0GvxUB1MAewORD2vVBgXnLE4+WVQFIxsduIy5Kezjk2
	GImRbwceqisjgS4XcZrPW6S+BsLMHHJs3rhvIbJdVjOTNTjO1H+teHdWr5zlg5Ez
	tlgtjY9QhJqiasUlOC2leZOIRopRY4/GacjHfV631nffMmYfJzZDV76zGyhmkgZ5
	klYlvQxuJqZE33z/7/TL7e/q/SCfXUp++Rk0tSksSPFi7GrzqXh+vhPnQ+6KKGcX
	s7R6twwZPRZ9Ltsue8EEyKbL7NBcTbfJml5dEGTrTbXqX+884/Eg3REb7pSs7xZ8
	0b3N2Ll9zGagVv4IRBGwe6bHlteFg==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fex78bq4r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 18:26:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGU44mi+mPiLnGGvJThpPg2SLPksIsEO5HsG/cyMw8r+K5UTqMdGzbo9w+pYjewG8sw3bFh4j7cz3zVdVW/6jyu8pPEZIVlJKjLXM7WNyfDCFizhBJsp6UYP14VykVgWNr/qWb/vhbAcquIOh78tFcfLOyA0unVjGzrTViScZlA9/D+VOyJ69v7hfnROTAxel4EUsQgrHiHl0aR0AEulMlw10V4tdcZicJ2I5kvq5qxn8vEnVCPw2+pYFWw2E+5KSaQy+WPApmsozgSaPjKZpdwngeinMhXnA0eLbSyRspA8b+OrcAVuQUve+ud3ddAdfzJAS9As2j+OFqWkBh+x0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qh2/FH3+7IMGuFKt3ioV5OKpnXwVGQBL7vwkjT+lgcc=;
 b=co6PWQvEZX9TV4/DRL2X1WuugXrv4dlKjccKtf6lEi0ZfytJFqDul/Zpd3Wcsc4429zplgX8469KOT2AkiwsER2rSVmKXhzF1joG1GlnQ/17AMVC3RC1xAHMkjJAty4yznTgzjhgnrfeemKlhouKGYK0QBmu+iAmBwQrWsS+IAEl9Kta5kx5Ew+QSiKOCMPdre3tns7AAgiywIy+c7k00v4P97z4V4bVh9g9hMEyNuw2TPxhLRReP+kTx5eSnB7e6Hem1+0b5K0E/xzP04Es3iUhS5/R0/NWHw/DaRZZuifRrrB1AWlk3zeSaj1OAHnOPTK5rAEsy7dRciIYgC+xBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qh2/FH3+7IMGuFKt3ioV5OKpnXwVGQBL7vwkjT+lgcc=;
 b=kLCvdDP9TcGYQurCHAk9MOir/OvvZa5o1EGS+P3zS74PdywGedHo9Wj1LpqYCeyoO49WDeLpcmT2M4QAOylR0WTexDzxRgNdn1Gl5jvT2r9YAPP/EzEz3fh1zHeMrczzldl1K1ioD2zJocMYs2zHRWAO82LjIZtHs76zm3vbhQ4=
Received: from BN9PR03CA0197.namprd03.prod.outlook.com (2603:10b6:408:f9::22)
 by DS4PR10MB997645.namprd10.prod.outlook.com (2603:10b6:8:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 23:26:48 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::38) by BN9PR03CA0197.outlook.office365.com
 (2603:10b6:408:f9::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 23:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 23:26:45 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 18:26:42 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 18:26:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 18:26:42 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66GNQfhv2435480;
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
Subject: [PATCH 1/2] dt-bindings: mmc: Add post-power-off-delay-ms property
Date: Thu, 16 Jul 2026 18:26:40 -0500
Message-ID: <20260716232641.2659710-2-jm@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716232641.2659710-1-jm@ti.com>
References: <20260716232641.2659710-1-jm@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|DS4PR10MB997645:EE_
X-MS-Office365-Filtering-Correlation-Id: bb619aa9-89c1-4c5b-aa4d-08dee391b359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|22082099003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	7BpMBEao8ejDJbYY0q4njoH84NgXfZqSt6Fu6/8ihXlURCvsjEwuxGK3Umg/lfuOkVyGi1my+vJO2/r7yYtLL9TrX81AkL9FPhhxneE5521H3HJ2OnHUpvnmxC0DI/G4fUlgAkL+bVhCHHdLMyEn8Y36o5RmjwZvmaQjWojcbidbzzeCbG26ukuSUib0FoIncplNSA95VvJ9GveFAZpuFHqIgsczgIwG/+P7jUYVBaKd+c8mX8QAgD0HjJ+7ZxggHzms/3pazMCLr3evw0faQvosDhNPHNa3PaWNYryal+mVJvx0Ua+L9RdGzVh8oZUicnjG2osdcCrX4B385mfjrpU71lVaU0QGRy4Dkae9hf6Lj9guL8PZwQp3ChbB6614NC30X9Lwq81uTBuJLMwORrV2Zt9TzuwhTSifggVp299xMOM17A0fYwzpJZTi0iwXn6PRRhgXdXrfNgmJp5E1gcngDRlS4qLFrpQ/H4sBAe9pEJoW8QNpUYk74yxehV7vs/354/LKzBX5S/lXhcpP7qMkk9PBDVNToCMfAcWbcPbWAsBMK5hLHvPJPspFRuvf/Q89fFj739B2p6eZy29K2lRWDOXQRehOqCzkOq7uKd/JH7EvvRgdkcFpVMjZU5kkoCH69I4lqYC4UfeYh9U2XHrSgpMVadpR/CLjlMfl3YfTdVb9JuISqvrKjkMxiSJv
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DNRt0SgIS4XdU63Oq+A2agTptVnssTfYrj11x5NLwOHQmNJgasDQ/5gz624q/r4v3p38aVoFQ3PZnnn/96qqKYnf2SFHXzJmMTs0YZPu1RMPH8lp6AmQc/Quh2QvDLI8VdtNcQr6kMxra57j32vYs8HeZQCcGk5BJ227PO0LrUfbNqs1V41wi5wkQt/LLx90YS4wAgUrPhi19R/NuET2PH1sbTAsKTTZdE7CVMfA+UkkSVEurMEP3IMyknz7ZH28txp0WbNSyORqlJ0BDez3iNR4NsVKBre4PKdi2pnGihO2YhHTLQYw+6DYbHGat0djGQBZKZYVqZ+M3XwBWAm6X99M8eRMYJXwp0Olhdfy4S0VJuM9QnTk7jaDXyiuTL0J6ejootOubd46eYVmKNz8IOrWp1L4nWm7YLzXhdkvIpxnWhD+ThNIkR1vbMP9Fgyr
X-Exchange-RoutingPolicyChecked:
	pf6KZ3XMb/4DXZQxoSGVzGnMWhG/5wghPFvRfbeJ8W/QiBuVGz/y8NdR10IKtLkrO9S3qeNVIQ3i7bmbF4kwvEIwJkUNDgYVXM45JHleQx34W2SGfhb/PO3TNAd5Q2CI6qDjF5tN3Inn0e04eXHu3ahbWj/VDoRR9B+6qZmpN8U1e/9ePAJpRS30EcT7g9YjTIcnTpSoFvnNoBNqXIIsZzYJ+f12IddbUlB3AuLdcWBEu465824caiPyoYfJzQLH4in6BfK7kLVcA1YlshqDxnsbatCf5cNj2nGd+QQTJ2sCf9CK1dX692nwGbISLgHkMo0a+BiUOsmIqP3G85Gwaw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 23:26:45.0832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb619aa9-89c1-4c5b-aa4d-08dee391b359
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997645
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIzNyBTYWx0ZWRfX84cy9MyEuRAA
 04cUIWouNeMBBWLL0O9fc/Vr1ExhKob2em8266uAf5t5dqhkV/nqCigKNraT11tbG3PjV1DqrH7
 8nNxooAqpjfofs9Qr8dnO/NyLcjNS/7MCDk+Ro25ZCMhStcm5ow9qZqtcFg4KKTRjZftfH++bRC
 oNFdVR4KulvehQfwDu339IwoCWRzv2pzZlqYp7NygUKJLpBeIw2dJdp2K0UMJLlZ8Mi+NBgS1yE
 QdxVOBsdBBRST4pfcAZmf6mrqiYmT2jpFPcsimbjCO2pcl0PFdmdh0dg2FCXNY+tzDRm3FnF+x4
 M06TWnJrT8s3FcQcVbmmRBWx1K09ySHimcqdPemaGhZ3ReX6Vt5Y14xcZ7R5TeVJ1KTxe0jd5PD
 dw73s0J/a4Ys5xCo3OBN+f1TQ9/b/djke3neS/LQiWPGTIyeZ0DP9UJJCtX8D07vnhoI0PG+mBY
 VQwIeWhX5de5zIcj6vA==
X-Proofpoint-GUID: d5Ud9uQmASHghx7TP-ccNC70rhhn6yxJ
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a5968bb cx=c_pps
 a=9kClBOisnrQnHM/oUG6sgA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=ZKcgmHA2f7V-F46tV0QA:9
X-Proofpoint-ORIG-GUID: d5Ud9uQmASHghx7TP-ccNC70rhhn6yxJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIzNyBTYWx0ZWRfX6iYRQwzflho7
 Zc/waKUhq3BmXxK0toF8xiLbi/fP4aG9DGahp7SrA3aLL3Z0FLiTlaQA3kOisHCN8xzKcsMku89
 t8N4Ata18UubmnED8+AyBHkAiXznvCQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160237

Add post-power-off-delay-ms property to MMC controller common.

This property shall be used to specify delay if needed after
deasserting power during MMC power cycles.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 3d7195e9461c3..3ff68d32a308f 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -275,6 +275,14 @@ properties:
       not available.
     default: 10
 
+  post-power-off-delay-ms:
+    description:
+      The presence of this property indicates that the card requires a
+      delay (in milliseconds) after power off before the next power on.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 10000
+
   supports-cqe:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.54.0

