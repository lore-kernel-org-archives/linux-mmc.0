Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2087.outbound.protection.outlook.com [40.107.103.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA951FAA;
	Fri,  4 Oct 2024 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043669; cv=fail; b=vEEih9bK2vMvmYiVZi8o/h7uBjgQSjPYvCpf7fKe4POtLfDvcLlOoKA0xJjS8JbWa5VzuLY0oKK9x4MslqUhLKHZP3mAenjeNbOFJUBQB1f1Gi7Ny0e/ndsNEwTyidfn4B5q9Wf9mjtleFOSduB0ti2BUVptqao4Y7KvCfrcvMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043669; c=relaxed/simple;
	bh=zA+8xOj5XpFM2Wvn2mGYoAxCBw2Xptl3UhwUdidTQlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EKlibjlxHvaeSN3RK+dpJA8RodSB0LY5JG6+X5ZXVGGX2M6ZDpgG8wZfM5mz1m8AdBgeQqWTQRhQ+lvO89Kl+VrgavjiMAPoy9OEACrwTDxxteAiaAsn1bPJQkzKZ1b85iWaw+UAPt5oE7ZhnDuFQ0qtnSQWOQx9xx0vHtRL6cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=ifc5V/sA; arc=fail smtp.client-ip=40.107.103.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="ifc5V/sA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/8EcFVSICFSX4jSKSyCJvj3/pvFQ4eVZwy5D/L5V2OzLIfoTmRNDjSG02h6EOlfeiI9ahg+deSgoA8Lrg3ZIrCoW/6AXuBwiY2zicQXFnidpHB361NKsiF2tMjZ/LIKs+cFZCb89V5qQ8T8JrpFUF0/nmAqCyQAAKpFzgqFPTPLyGjY8mz0n2yUHWJnDdrDR/tDVETCYc5s/I+rfP4EZAA5krEEAsY5mAzvtjkWfu+o0p3Ql4OQsAAVxlxLW0U+b4GK0YWeKF7NDiaBGlgoOoOdjSrf+3qsz7Rrojt4/ZPAXoEUFWjsUdYJM2U7czBQQ4xSLjIQf5qX6msva4b9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCUWttN/BnOXjnZLtlhpD54NykMZK0LnB4i37A0SyQk=;
 b=uiNzq2Gi/9wM4oCrfE1iXfemUkG3Di8SOcj7upe9ZouP8uuWOeM+BQWQH6BkZqJA/7ZmcJsId1+YsFzy4jBmrapvW6soHSuhZUP6lmA5im4HlyYM9noS6vryT/aZsS17WVhDRg+ecBOI6OTpncN9zHl6QqaxuJj0YIvxGv6jImEkis6rrkH5Rq4qceBkHTntmoxZzEnXir3M7nET4o6Ob0Ycytl/PEfeqU8kWDVfpPG/XmgQ1y73bjNeM9Qt6gP02yjyzGto7tMXTigkcTaBemSy4z9lfKAYGn1MBmtPBXAg+o5fOCKD9RtgDlGI16BGZotd/pLrpbgqxYaHZTtijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCUWttN/BnOXjnZLtlhpD54NykMZK0LnB4i37A0SyQk=;
 b=ifc5V/sAJqFTAOIw4X+NXlwR/5vTIxjraks+S9GFfsltRl9NEVacSVdIj9NEDlXMavo897Cfp2t4ucwvZOF5/aHTeh4kAOWrqdHgVKc5kGPZvwJzL3GslMQhdFqHLVg8uyq/eyvP137pj0fd3Qobt3sTu5FiZHsqxK0EZGRBqAo=
Received: from AS4P191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::16)
 by GVXPR06MB9226.eurprd06.prod.outlook.com (2603:10a6:150:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 12:07:42 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::2c) by AS4P191CA0030.outlook.office365.com
 (2603:10a6:20b:5d9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Fri, 4 Oct 2024 12:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 12:07:42 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Fri, 4 Oct 2024 14:07:42 +0200
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: ulf.hansson@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.felsch@pengutronix.de,
	bsp-development.geo@leica-geosystems.com,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH 1/2] dt-bindings: mmc: mmc-pwrseq-simple: add support for reset control
Date: Fri,  4 Oct 2024 14:07:39 +0200
Message-Id: <20241004120740.2887776-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Oct 2024 12:07:42.0411 (UTC) FILETIME=[03C9B1B0:01DB1656]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5D:EE_|GVXPR06MB9226:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d854b761-5f60-48de-de58-08dce46d2666
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TjLXER6F2Hwl5ThEbhTctIgBJbbj5FZcO+zoQynxQyYN7yhg+oFTw2LVvTRO?=
 =?us-ascii?Q?4UdUrUAUFVI+ihldHOHGY/Jab0lUGPTL/hqmMbqvpJWxNNWjY/trlMy1NaAJ?=
 =?us-ascii?Q?d9PUuGwPE3gh+0IkvS3BOYLemv4P9DtaEwAUCuMFRKRy8zVFBDsh2tcxKn7k?=
 =?us-ascii?Q?BrYHqBrHMfbJmK8uYJyCHQweFWKkRS7FlftQ/tNTgFk/ZMrDtTeOECYEtmHX?=
 =?us-ascii?Q?U0ZcURs/jJ9aMqMbgf96apOQHY5Lsp1CyiBW5rO1xh/0YxcVNHz/Mtb7D7YN?=
 =?us-ascii?Q?jg9riMngZzXMMPXWUpUzpb5L1drhqiSPGA4UnFrPcDrD2DXMDSiXHFXj/Xfl?=
 =?us-ascii?Q?Yv7HZW+PCTEp56Y0yWqqcx+oAz+fLZvyWI8KC7WaycKBdIbhyMkevTJ/UqgC?=
 =?us-ascii?Q?xSwqYx/CImK3QxbtlSl/FoYXbVTkw+qUOJWTdE6WZpGFnLGazLtUCZHmkw3p?=
 =?us-ascii?Q?NlOxTi2zyQ4KGqC77fjNlv2INBW+ejAjWBAnH0cmRv3dAx3WGBA323JhzbKK?=
 =?us-ascii?Q?Jg/IngKSX3ZQGslAX+iBtZZDMu4YlFWNlNcwgq3jWHP28NbS3r7qWAPXVTda?=
 =?us-ascii?Q?qJdweUMgKeEMTMC5n80r08w71M0ZmqeqOBBbFI9FGmIU11dQRNPxtyHlXo4V?=
 =?us-ascii?Q?1ono93tX5GuwpsY1vhq2S/7GulYmuW2WETDlbCkDef1sLpUBx1UTuuDGwcr/?=
 =?us-ascii?Q?8ajX54Fsp7y8/pAYKs7a7nW8Cm+fekstA1OyMKX70099s2qF9gB23lDuWli5?=
 =?us-ascii?Q?9HrpUzNgxzT8NcVeawXqusxEEH1feAMPtKBJSaXNcnAASE+y5Oix++ahWCnh?=
 =?us-ascii?Q?7FXFoWa+0cJSMhRz4H2uhgKFgtEDMsNnUjQApSkqIDK/Df5+LCUAW0/3els8?=
 =?us-ascii?Q?NtKpDKBbqhvEACt+eZDT0xJVlgFKzoPpq64PN2lf2cy4HH9LAWE5N9p6MWBz?=
 =?us-ascii?Q?gI+sDdxJdSREIkJYuAAzviVAqqogXP8f7+Nv0Yszf65oLKyaFva2oNnKNHP7?=
 =?us-ascii?Q?Fbvn612lxBrDYVG7mmw2wE3EoDZU0ON3mhY8zzEdBTdP8IhAVxrIopO/muep?=
 =?us-ascii?Q?JrI0bTXWNO9VB1IBWDgyvEoUp3TRnJYagcPjgZAQ9V4H9CKASasf6Hg4iCaz?=
 =?us-ascii?Q?HUwo5iachRHwY3ZdXITEjN3c2ZwNGiZZWM+0oUX5LrpMutUuSyGSc0oWgKxa?=
 =?us-ascii?Q?GE0nv6ENZqc+MnM8ilExmID9ixqN++ODgyq0WOaCpWMMdqq8dDfoi0ZBHvv3?=
 =?us-ascii?Q?dlKhNfYprthTMmKemTTY8C/uT2W9QOi/BOgl7VSHSzCyRymkOULiH4PkAb3V?=
 =?us-ascii?Q?C3QfHGoSOgtJAz25X4HgTzANwskFIaAKeGC7xgfFzZ5van2wlQjF0iF8gK8u?=
 =?us-ascii?Q?Ho9A1owTfcMm2NzdglxcX+pvSLpT?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:07:42.5674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d854b761-5f60-48de-de58-08dce46d2666
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9226

Add compatible value "mmc-pwrseq-simple-reset" to support reset control
instead of gpios. Reset controls being refcounted, they allow to use
shared resets or gpios across drivers. Support of reset control is
limited to one single reset control.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 .../bindings/mmc/mmc-pwrseq-simple.yaml       | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
index 00feaafc1063..da218260af01 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
@@ -16,12 +16,13 @@ description:
 
 properties:
   compatible:
-    const: mmc-pwrseq-simple
+    enum:
+      - mmc-pwrseq-simple
+      - mmc-pwrseq-simple-reset
 
   reset-gpios:
     minItems: 1
     # Put some limit to avoid false warnings
-    maxItems: 32
     description:
       contains a list of GPIO specifiers. The reset GPIOs are asserted
       at initialization and prior we start the power up procedure of the card.
@@ -50,6 +51,22 @@ properties:
 required:
   - compatible
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mmc-pwrseq-simple-reset
+    then:
+      properties:
+        reset-gpios:
+          maxItems: 1
+    else:
+      properties:
+        reset-gpios:
+          maxItems: 32
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

