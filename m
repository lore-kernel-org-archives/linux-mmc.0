Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D70226CE05;
	Wed, 22 Jul 2026 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753842; cv=fail; b=ZHcD195juaEdwYxeABscSA8cd/DBDADPFRau75KrIXZ03dafq3SEvrSrQgWMLzpsf/sRlCfAfM8Vw5CnNBTcgKRlWawcWO+0BaNortrhJ4sgfyDqAmmOzQq/HZbgEa6liDaC1tKbx+BKfnMsTYxUMuv4Z85EG84ggBu5G2Xnl04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753842; c=relaxed/simple;
	bh=CFHM+iV4xqS63hGLlVNlB75wxM3jk8PzsLTnh3DXPgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pI2jkejL8wAS7CC2LbrYw9AwmZzssvGitOMtQcoxg6ydgtufyl8lem0A54I1jprLd+G/s/CVZ4v925ZAnwbzkwUnKv3bpwAbn1sKDJkRnzNmOn13KhLmRNQdanxqnWrWoUBzR+mcsmKOgWRI9f+u1uQUaukaWIhNNVCIsR8j8UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=QvpqgTlg; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MiyvncwS; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="QvpqgTlg";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MiyvncwS"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MHnOxC156533;
	Wed, 22 Jul 2026 15:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=FoH4bsQ2dhV/Oyiz2QMwKeW+nmWGDevn423vhar9B
	V4=; b=QvpqgTlgWnne9iqaa9hgGWnYwVv/itDTZNzppZQswuurfyGaw8/FiMoRr
	16BdSiLhbtFgUFd1kgKp7z0TIOHs6ZDWw8LRFqdNB55Io12dwy/GvFUAXUXnPR6s
	9RJyyMUf1U1nl/RJ1+x7/2w1WeSTdSNF5DeHJ1tXwNbFRC/jJl3IlHJ3LhSgcaEJ
	2LIhEWrmuK3AN8HfKL74YCnqCOS0617nJQ0sXU0etg525/akN+F6xlPy5y3dRxtz
	ZZLrCv3aJyrJQQpGS0tefQXL8ieJgZxgzzWfeW+F+1FPyq3G6d8DdOQmT+L42jDM
	JCqhMVPLMuus1Em/pGSqnbhPjUvPA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fjwjv35d6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 15:57:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SV+RjXYsftn7hlJU3t9TlW0G5n+dpe+Ag8pV0olAOHaU3tEgCtrXTUI6rmmlM3TIY0703btQ6M4iDvhwVtNycI2L1o34mEkGkTbnwUkUG+v9GxyY5dsB4xN2Lr+noT9YMNKA38jQhZMj7x+O2ZSz2inGU1smtgaoVwYXaGQEfy5lFX5LbWjSc/2N1J1oBGjrp3Vt4bY53B98cdYsWfu1QUFF1O1F5TUKvbJG9tRIF7Xqcppe9OklOVBCOj0ulMZRXoKTtqC75OCX8kpvEQM6z+muOipN2zw7eMiVPVMPxaZJSOtZlKKdvp4mTeGVPHuQvD2/PXYLZqTkBvyZqCRSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoH4bsQ2dhV/Oyiz2QMwKeW+nmWGDevn423vhar9BV4=;
 b=qr9EENYMxIIuTApxc9wsIJQwq8aAto7cKNqncUGqH+HWzeN+mxhtKYJ7ag4uG9PMSa5tSDMjt6xXafHqrCDN4nEIawjn1KFNO4mPZ8f5ku4s1O392DUd+YI0xl0MwzRl6ECtrDEa3HpJ0eNZle8doIQKa/2eoPUT+Ny3EbWMvhpdIfXP3cI+k2WWVFT4kmQrq8u8r1p3ihXAv2CbqDkqnQJVvkk2UirLiAWp+FwdqdebjE6Xc4098V+cBiWXraI41fbmc6b3V43BpE1Tu7UXJo07hmd1dfeoBy6rEJHH14dlhzvhqBXu4ZQO4RLKts7pyHNuWOt2TNObbnxRPLXQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoH4bsQ2dhV/Oyiz2QMwKeW+nmWGDevn423vhar9BV4=;
 b=MiyvncwSGPle0EuzqQ1wwmujU7oY9Wz0D2QO3KBVvF4fyktKpI/WCTVLrLsMukNnHdgKxvf22O8rwEwCmteFYuqb+wsdGDp4Jf85DH5hcCu8ZvBPnmrnZOcIad0HiyyiS7YZR0E4k6OXLBdQbMVV15epTbu/nnL4X6R/2f39VSc=
Received: from SJ0PR03CA0082.namprd03.prod.outlook.com (2603:10b6:a03:331::27)
 by PH7PR10MB5700.namprd10.prod.outlook.com (2603:10b6:510:125::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 20:57:09 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::69) by SJ0PR03CA0082.outlook.office365.com
 (2603:10b6:a03:331::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 20:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 20:57:06 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 22 Jul
 2026 15:57:01 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 22 Jul
 2026 15:57:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 22 Jul 2026 15:57:01 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66MKv1vs331261;
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
Subject: [PATCH v2 1/3] dt-bindings: mmc: Add power-off-delay-us property
Date: Wed, 22 Jul 2026 15:56:59 -0500
Message-ID: <20260722205701.372789-2-jm@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|PH7PR10MB5700:EE_
X-MS-Office365-Filtering-Correlation-Id: dea9612f-8cba-40b3-a4c9-08dee833ca60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|22082099003|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Y671tWf1MaLT1hyH3hlOmrC8W5i4uc9qvWrGUuLfHeIk5tIMBTjXCIfoLQTV1YbAyuvgZ1DUUuP75NPjnQBgj/6UvNTVu4VjgIdqchodJkqZCIRRBYUMCA16oNtqafb8lZuvliqoaRqNvVIYejCrsSjGBlabiCKCFI6dhxS8c5Bmvr21cgRdoUu9MAYEa08nkf8Ketjlbx4GfJSGbaoJlmGM1It4VP4vMHh9JPkjVF0c7AxSl2Yg7PBmNr4tdE/86fe/LB2CYVav9YjTSDd1WsZTGe7JDbTmecJyo9lmndKDs1snhTrk8Bxk79CwBwY7HnZxc1bwxOa6lJ1qJirmlp8qgliaNLTfHAl6hJn7XGdj9qbLCaeW2EUFWzMZD+YbGRK9bgB0I48uGC9EOrc9lji9CukE27X6e90pNZ+qhvkB4ZlnTD7E0FswGAHAjrRaECdVBGsIAxTZyeabApYkZSbHxOMi7cTy9kAlnpYDqlKdux5NSrQpoetZYq0veKAedoXjrjDWv/2w9IPzSlRG2ckeGkfFw08XNg27ebZdVtQ7XX9zybvwNxrOOgjIS1TTLb181apQ+dNQcYuIdo8effvwpbYw1nNikYGVqivMUjxDUxZfR/+32+5Il5IGviKAfp9JzIAqola3gnqMd3ashpi8aUC5ZBImCiu6ur18TpKKXNrOHPYflbA4dSWvSLb//JsLKoY5qBrmzhHxR0uxqQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AUWAEdzRA+kYp13aUpzjG8YmAryErRULHbEfd0tVUz1YYzu1R7WcQ7GwXUgKf3yBAQIB40hC7aJW1ttg62AbVPg/MMTPUusHh6c9k/3KFoPhTsePTC6sechbS44TI6NYdzh3Ud1tsTH2c1fn+0KFxcZ7MisUqLxceRWAFHSXskgHZBOaY17S1tEkRJUMhKXA5rG6Glfm9AQU6R3wkCGO8J1ApTL4Ojqbmo4zTMF/AlpSmWn2nbQ0OGcDKvAWA4KQa09Ckbw7RncWQS/MxLOrCOJxWH7JuOiwsPViS/88iK8sgdiTBd0w6iAjZsZi4W1rg0fXnSpwfM2IqV7wOxBJ9GLkqQ8m7z+wSxLfW9kfmSoErcTMgpRt291at/l5Xwd0blcuy/VRoxl0bUO5yFXu/5EkxVCxqEsAKWnKCx1VpGgrpxoGbo7RZHZEbALQDEtd
X-Exchange-RoutingPolicyChecked:
	W+Pl8rX/5seWJ/4YIhXnSZ/Xxb4OHaOfhoDKS6GXa44zXgxtPCW7FGc0Vsqqy3Bj3/JkhfAYQqFcl/G3gM2QMmBlCQm1p01ge0w7lx87Le5b/Qldqv3ylqCLbwmoZpSAf/WaHBRhljtS10V9rH+U1xqnUn5H3F2svw5iWoeDRP1h9JS0M23PfDSD6TO8JTXxdZq2phwL0ZmaTfTmKFka4WEHXBhH+4mx+oan96txq3nEHsH0ySzRKDGSIeHvEXo8HAJMRHRhF8yvpSHKfm3cCYRHHVm5uR6N79l0k9X0II0mJIPrn1kt5Turt7JdKS9/T3+mTt+l+UxS6XxX0aKLUQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 20:57:06.8111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dea9612f-8cba-40b3-a4c9-08dee833ca60
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5700
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIwNyBTYWx0ZWRfX9JHZ2Rs7Zl8I
 6gbMmj8iGEgr4EUuSjd8Pw3Lx1Q8/dzTPwHauAenv8VyEiVehnvU4NmE429qhFJN0qzhLfwkMl3
 fXgyOgknvdZVj7bSoOWFmFmMSKyUEms=
X-Proofpoint-ORIG-GUID: NChvdCKkKIgA5leAGvyGs_tTezDX7IRc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIwNyBTYWx0ZWRfX3SHO5VW8zDJQ
 58/MbaCcB7OVJtf2UZfYtWDOJXXM9+uFra43u+6TF+L0DZAIgsY8dlaHslZKxZogGHhmp8U8Ea5
 yO0bgMcL9Pkw9GuXi/J/OJHBaw7j6d9FnCn3SRYr0nxiauZzXscHccwHFIk8QCb9UF++NN5PsQi
 SC9LttGC4732B8HDrgHUVFQ7x/cIbYnMHb7OMtZElgnNUkWAMmol0Rx/NwhRYNWPnNckEqcvB3W
 oqSC9mW34NE8/RFeMXwQRN43ppVninn9xr+xx7TTeqrW3Bpq1RyOZYHI9Jr/SIuMVUerwc69SEx
 TNZ+0sZknBDFvofxHej5nDgrw6EAacgxq0kU+66P0VWLxgRtQEqZyPy6Sameb8Ps64pqDSCriPR
 x8hyx7AqJCN+qIUrD5nK9bp4YdsuuEGaKKT+1UChslW6puBjwZAkFefW5Elq3gj+ADxEvHQL2ae
 TmzLqQ4gnPAstsq8Duw==
X-Proofpoint-GUID: NChvdCKkKIgA5leAGvyGs_tTezDX7IRc
X-Authority-Analysis: v=2.4 cv=PsyjqQM3 c=1 sm=1 tr=0 ts=6a612ea8 cx=c_pps
 a=KH9ZsF1Q5Y6vOSsawDVSsw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=yty_aEvU1UBHu3GZuGsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220207

Add power-off-delay-us property to MMC controller common.

This property shall be used to specify value of delay after
deasserting power during MMC power cycles. Default for delay
is 1000us but custom delay can be passed in to work around
hardware issues such as slow RC discharge on MMC VDD rails.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Change post-power-off-delay-ms to power-off-delay-us
- Fixup dt property description
- Fix check binding warnings and remove $ref
- Fix minimum from 0 to 1us
---
 .../devicetree/bindings/mmc/mmc-controller-common.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 3d7195e9461c3..2015292618c80 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -275,6 +275,16 @@ properties:
       not available.
     default: 10
 
+  power-off-delay-us:
+    description:
+      Delay in microseconds after card power is deasserted during a power
+      cycle to allow time for proper power discharge. Larger values can be
+      configured to work around hardware issues such as slow RC discharge
+      on MMC VDD rails.
+    minimum: 1
+    maximum: 10000000
+    default: 1000
+
   supports-cqe:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.54.0

