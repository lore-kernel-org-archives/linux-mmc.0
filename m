Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A0C199D8
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 22:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820138; cv=fail; b=bx3FUBCpzpzn+0CwCSqe7uzZvg8wkw8mZyicj1QTpV8JIBlDfgT4priO8B6K1QD8OwXTsoFQn0xrRp+QF9C2/nv3PfvzBE4Pkep1Simy0OGP4PlwHxTz7CZAi/JWZJFFjZ5JTsutoLpoalGoqbpt9w3txC0EyeeKLF2cIDaOQGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820138; c=relaxed/simple;
	bh=bMusO0O1UUpTFVC7g7FoXZ127t2nxwFQ2E6y569lWjk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ugKwwIHIcVanvAh9c5h6Jtli3RwLpBowCdQ9LrpAqFPh7ojFymCOBzcN0OYSXb4vh87TRgAeG/A46XsjvQtsLlxGMK2G9FtdzEpmy+YQFZNVD6FXUqkSEhq3oNr2VxkWogugXl56ZHd6sY1l2L5EgmsmcwgVRrjTwzj7sKw1D9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=lc5pcw41; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=klDkh7CS; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="lc5pcw41";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="klDkh7CS"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65ILrlKK410591;
	Thu, 18 Jun 2026 17:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=hn6oU1U3Yx9k7
	gwdKxa534K566TzaJubQjM2I4BNGZQ=; b=lc5pcw41bElyty3xVQpahICbhoNGB
	rjsagT+2j7HxrHD+/LZOxO5bFiKS3WXD0HyIsq2b10/EbGiDhNB8fiv7l5o3y5L8
	MEXAADH5oyqRSRXc9dKZTMqmZyo0x0F70a5J2NE1yXSfiBl2R11b8eD1JE+oJAhA
	REG+yTDXLsNJUsn6kekCSUUdGTL/5T2KGSIFXOW44ZqU6JARAEJU7k8UNs4+Uqw/
	vLqtdCCkpvlo6fYcqN2qJBEH4zeNYAH66yRamhPVpopXGAFhTt4tgr08F5kojQRY
	CUc/V7KLnKKgH0wSVNFpBrgeRv6n2Y2xV27DXCjXdghNvlPF/mLuK4HBA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012070.outbound.protection.outlook.com [40.93.195.70])
	by m0384305.ppops.net (PPS) with ESMTPS id 4evfmmc2ef-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 17:02:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgZODYhWEVv+3IU2xP3gXRy+SmMYuek6fUAYmTTv1I8rv7UyVzTi4gfeuLA2eixE9s6lYEqF0dasBg2mr1wweFgzpQ9OF6ceuZ/ACoxTX82RFLHoROdarUObzbqLxmSdfCx5Z91nocLFNpM7xFwhouWDmfc+6xup3JhGlXlxMRKHLFs5HdZ8fkFPEgQTkzqzmLBAcVMP+E/F2w3BUpQtdb/FAmg174aKu4e52pdw9BuWF+fYR1V3/P0UCoEl5vwTz3AopxYMb6VWkkp6XKgUO8GvwKChmn+xb2LHedAYGfmORNXnOboeLras4zION+xAhaEsi1EvjTqskvrAMhn+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hn6oU1U3Yx9k7gwdKxa534K566TzaJubQjM2I4BNGZQ=;
 b=pi+mt8vLo/zKFJotYLe7xMzgehotUZN9ZuVaS15bmVaeCPirxxdU70eaVT9nP+26bg648e86HRahOflEog6x24u3novrW+l+eVz5unA2QD2m6L970YpMfl6sq08mikRYZMcNTs1mwcro2B6V4WxJTLDXs4RdKP1m8syBbVeAg+qo+K93hsKyacqsPEZSLTag3jrW95NpfeL2eSVzhO3zm+DCw+pZuOHM+G5xym/tl76aqQr+3M1ja9sODWtehFLwr60gQtoa89xYLZl/pcBO3jBj7KN0XZgl/Wr+8hsMWNRaG45vqdahKs3OZGbTbXbctPwlMg2+SX94u6/mMGm3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn6oU1U3Yx9k7gwdKxa534K566TzaJubQjM2I4BNGZQ=;
 b=klDkh7CSxIlxYGxo24yUuzP9nFCzsbDYFwr3/3AB+88xlRn3cXw57fy6oVjjTktyU+JBofIgW6tFmQwmM0nIXeQPC2Dpbwdo0/1dqiXbQO4aoKg+FfkwEcMhCyBLu2thqOPZfBeLscCnHl+kL+rB/LEVgt4OwlpfGl/SioGakDs=
Received: from BN9P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::17)
 by SJ2PR10MB7038.namprd10.prod.outlook.com (2603:10b6:a03:4c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Thu, 18 Jun
 2026 22:02:10 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::81) by BN9P221CA0009.outlook.office365.com
 (2603:10b6:408:10a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Thu,
 18 Jun 2026 22:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.0 via Frontend Transport; Thu, 18 Jun 2026 22:02:10 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 17:02:09 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 17:02:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 17:02:09 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65IM29rV727868;
	Thu, 18 Jun 2026 17:02:09 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, Moteen Shah <m-shah@ti.com>
Subject: [PATCH] MAINTAINERS: Add myself to maintain TI AM654 SDHCI host drver
Date: Thu, 18 Jun 2026 17:02:09 -0500
Message-ID: <20260618220209.211875-1-jm@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|SJ2PR10MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f8a779-ed14-4200-d369-08decd853ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ooXq1BSSkH2x9lQEE7DuEQOnCrlaK5oEPJ9JIlp8f9+W130WxGW0TxB4r0Y8uSBs2IPNud1wJrXznfKAdMVxcqYT/R60OICoK1l/zybp2+dWSPHyNxf3u0anc/vpgoU3i1+vH47V33GI6++o2K5oqBuo52I+ZyqnBxiF+onqcgbqMGwMpHyhlb5F5Rm7GzachPTa5Rg1anAeTyhK4H0Me+ORi30sD73w9x5uASklV0YyCH8RulNsykfA00MCateWDNFMjXUfgPVuvP68uKCp52FZMrmj5fVCLCb/In3EVmw927xhwkmXmdpLKwFhbs3fx0cyo8a6lcyZgIRCkb16bMYUD/+yF8KR5+5JqMfTRES9+zn6n/RYfAMzACgnDyyKZuXJV/Pt4korpmg9Q24DkhkT0/NW2O5Fttqr0Lke4r6H/1+yEznhvIH3NbHith7ojZP0KFONl+JLjHIJ2bYpyw4xFOltP5beiM2K7Y2DxcBzFPFRwBSY7THxmy/6bc0cvq227zxXSgdTUkcA8fEh9d0Ytd02c4ohy0oJRR2+75l3110RMLtXZTSMY6/dtE9HN7piVFTdyxinXMMn2cPJMtw2l/Vg3/jlST+lhGs0SMX33wnvoM6ZjKANypFmiXl8bqd5bIuiVU11OJ4vhF2VlR89Wn1ekRfoSfCWg1o4crYheexqe2149BTED4XluUQRKqoLVQkFNBLaIbYHEkNdlg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OLVV4AQRmOi/u5uNmGfaMn97Um8C6oTjWyTR2apyr3Spgk9yqleTSFVU/ad9DWXKl8NcxRmHwbBlzwCJFid7s3O4seEKeIkSCmWVWOt+KMqDeIKpMbqyHGUM+rB9rbs+ZruB61kA98vVyc9cKtd0Zok3OfnG75aluEynEeJdLnJIAFSsl7jksqcd/K02nXCvRg3yFmjnun2pJ96J9ZOEvsNuONbQrlSNaYLykru+te5VqfcjHeIcMxNXaJobOI1RWmffZtdvidJm9zyOkUZU/qffrvnVS+94Z/xw4J07aV1fQLX9Vivy4o30cFcQDPjpakgsluC3orBA9RofvPWRQfFvL3d5OuFcfwPPDZHSJxBPvP9TGat8nnPf0yjGdL9yMBW1VPwtYEOCxZqUheeqpumSXHc5pfK/XE6nVy20Kb8SVCyrLDcFw2wNtnEVsrHJ
X-Exchange-RoutingPolicyChecked:
	l/UATObmMvoBO0MMksJe5Sm+cJm4D2mS+XidBck3oe1oQlimXZzBBUBIX4A9eRni6E8QHHjTPKSc2faVkoHkbZv9SfGi7Qrv0/oRufPZy+E9t/z4BuOU/NVyEAhuuoLLW4AZB3cBnVQkfGgUr6JXkXNrK/K5aG+FhsCKjIO0L4th/QE7GxX+Bv8nKv3L1ddh1YBGXGYt1vlvFOdv6SApBI7APxej1yrEVuUwrogQHyJpvz+uSeRZB59pYsqi5cTXqqTO6Etlb/rJHMJEDHoCHWefPQFwNdZxqtei9iptdX1uhPvgljpz7oezQ0tRi+1MqNzoIHqTtsCjUSN7qPVFEg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 22:02:10.1930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f8a779-ed14-4200-d369-08decd853ee3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7038
X-Proofpoint-GUID: QXZwsHWJMbbWujZ4p875gz17F9M3YSX1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDIwMCBTYWx0ZWRfXwrYfmRzLYr4z
 GOVn2p0ya+aGxl1g4zdUNRzfFG3PJXgsR7IOamWY4j6C39g2ed7ccxtQRfHuv0atPDCRMH14qS5
 5KOH17RBJYKv4gzE3AewxnrKHhPuwtsPUTf8sVmkyrHwvhuwN6X1L+c7ImqLJ7i9jHguSZMEIJS
 IQX+tvo7slh8e5bgcguPTghXAq8elrFL9mFYR7cGV5qYL5zm7YhE2VuPECOX2uY9mPfg+iAV3Zx
 JlU0u3gPzBgS2ecWpEu0SpnHQ0usPzE71Mhz2kFXRvXh3CL8wc5hkoPTayyfqodZZN/183947pg
 uhZtmTJAZNZniszB8H9fAtYZYR7KsfIYTooHlTTKFoc5hWRJZT8WedEM1Pen0qpNj9eRhFfahq8
 l7+ruPs8R3l7hcG7GzP15QiDPyHk7LzbrR0QjTC0m5ZUy8rwxtwKJKsZNe8sn0P295jriWPxcE2
 EarvQc8UMTEqgikIcQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDIwMCBTYWx0ZWRfXxkY5/ONow5NK
 w/oqPUQ49IAHTPK7RfJeWNKIx3MR43ql8vwX5DF5RiOmchj+uzuAvxv5bzNuJreQcgFEwZJ//F6
 WnB79Ey3r/hsz8U7qWO1LeR3vrBRoi0=
X-Proofpoint-ORIG-GUID: QXZwsHWJMbbWujZ4p875gz17F9M3YSX1
X-Authority-Analysis: v=2.4 cv=Z//c2nRA c=1 sm=1 tr=0 ts=6a346ae6 cx=c_pps
 a=bGC7MwCPNpf+Sn14ocfQJQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=xq3W2uTSAAAA:8 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=ybBMsZoa-KATjd-4Vz8A:9 a=P5L7wpMTXyg1GfFA3Gwx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180200

Since actively working on TI AM654 SDHCI driver, adding myself
as a maintainer of this driver.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2040011a3865..97b9b01275729 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26640,6 +26640,13 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/mhadli/v4l-dvb-davinci_devices.git
 F:	drivers/media/platform/ti/am437x/
 
+TI AM654 SDHCI DRIVER
+M:	Judith Mendez <jm@ti.com>
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
+F:	drivers/mmc/host/sdhci_am654.c
+
 TI BANDGAP AND THERMAL DRIVER
 M:	Eduardo Valentin <edubezval@gmail.com>
 M:	Keerthy <j-keerthy@ti.com>
-- 
2.54.0

