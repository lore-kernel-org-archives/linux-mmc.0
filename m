Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F132E68D;
	Fri,  9 Oct 2026 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512110; cv=fail; b=OlHlWk/jzqHSzvAu/6i1vJGd5m+ZYqRlrMd5pxNxcZsaWZePm0GwhPY69JRgmU3vvGZuculskWI60UZVl+8Tx28ImeCmVfK75+ld2HBNXGk9Q8rsqAFfiJSsp1Zv1+96BlLAmJn0X0pfEO3xmAesJnRBa0b9wREiHWRg3791fz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512110; c=relaxed/simple;
	bh=eU8xVB23j5mSAgHsgiNmsNFeLVPTMIdkY9tn/OXfIu4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UZGRJBG486xufsR3zdMX5UxBQ782/IP9GAAMRLtz8bMsqzjlDtDVxMD5K1PkdxxGhFjYC3INc4loGQFj1LwuYJ2f4BnZI9J5Gvm2vrYk1w2UvJMEF5h0mfBuz1IP1pk6fzMKRqpKm6G8yIniSmjEHtEFWllxMQeDjl9wXXQscO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=h+nqL/nf; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="h+nqL/nf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qye8FgDcY/NclNxZFq+l2d9XPLFctipdAMTKhttPYM8UVNvXKPBcd3ypw+vDzfi6Py41mQ7uzRrqCU1WQeCLPpzC/PXMHZiCEv+zWBX1sicHfSI5uhrOVPALBCw4Py9lq+89sBibnV88hxrlqCNInvIw4/6IMKdd9V5XJ7muaaUG0YcrvWo4CUcOBWuABJVGGCQzJamHDtItjwlDem6n/1joJGw0e+fja/5tAVOcXBeQ6MzKKxqCHkhsIszJDpsFfXrNVtpkoZTSAredJAezA9EVqRpEp7hMT0izYnNGZvBfsJZwy+tvTMPznZEsqkkS1X3hkye9/GN4VrNP1s6JQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBneJQnPJAZF7XYlYgRahZJKs2jOqSOAapVrrd9toQE=;
 b=xMsxxO2K+YwaICTEClKQPF1v/uJp78Jvs3O5yM+VEVV/vZdhEsTAeR+diM2cjBqIL7WWblrrDNxwwh4c6ZDUyiNmIftHvvLT2pflqb0GPavkrAI4DD3Odt10I73ksTEJ6InnE6HRbzueediFrW5PU7g2cG5c0cB8vMh9rdcmq7gbadIlDcz6D40SFEvlyus6zWvK2d6fi5Nm4XLwBKdMFJw20hx6t8EqrPpvn+l2aaKLV5wnq8f9lfif31OyNU1UQKAlX4EWnhx/sEBsHueA2VAlM47ZgOF7xs4Twa9GONhrzCLhgimsaDZC06kZGWaH3gbASyyev6M69rkmUJmVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBneJQnPJAZF7XYlYgRahZJKs2jOqSOAapVrrd9toQE=;
 b=h+nqL/nfc+w0klAupUtNd01yQOYsXYfyxld4IgdDw0ctPyAhJXqZg7s2fksctoLiwu+9aT0NAdROEMRWmJQ5/nhEbkWFvA9XxRefiLGY1yhmgJzhcaOyNGG4ljNC71Oc7mLlqK1cn/MptOGHUTk3E0aVJi5BGV3nVhCulnUIotDLjWUgZwU2jIu8GTBzm4o6iqoevdnGX3+ys2WKL40gc5mChhZAICgqrdB2YXKXzGxxBUGBYMgdKaY/UgAXbmKUC5VeytsKNntMYvEI4ZYYe4fJGz5iVn6HcufPjr7DNmPtDFPchuPGXUHmq2u+dXDIxWUp7fiT/dEWH3L3DbM6tw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by IA3PR03MB8407.namprd03.prod.outlook.com (2603:10b6:208:540::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 02:15:06 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 02:15:05 +0000
From: tze.yee.ng@altera.com
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: mmc: cdns,sd6hc: add SD6HC DDR50 read-path tuning
Date: Fri,  9 Oct 2026 10:14:50 +0800
Message-ID: <5ea5d406b527cb9b7015693191c9bdeb9202a1bc.1791459448.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1791459448.git.tze.yee.ng@altera.com>
References: <cover.1791459448.git.tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::16) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|IA3PR03MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: dc232a92-6280-4751-99bd-08df25ab220e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|3023799007|22082099003|18002099003|55112099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Ywr2gBdI0yRi12ravaWBGWxzbznafXpOnc7lk9U0jRijlie9th0m+Ab/gALfUXL/dpb+OBsFcTV0T37AW840ZgqHSe6XJ0rdLVcyHNoXq9g534YSiL/ruVCRMsVVyRCtMQjSkcv9NLfeVXzeHMp9foXDTl247+VPiVVoiQCAl2QpBFI2UG2SHgWYQerV3eF56j+TT39moszNvE1XHvgnJItabxc9pAYLDEph+YVVVLuuRzxzC35Bz2y73a4iHvhIiMRTb4uEa81ohN/S3oPJZ+Cl0dVp1c31nQlLIipqWSpG6iGQOtV2qVl1r2+rbSdoMQHGK4O07GBmserO1JVWpfZA/dL6YHLgKK7jmpO3s9xf/MimGID9TYHkm2KWc4m19yrOWjC8pDve+eQ8ySNpTTSgDR+Dbh7qWIHjPzt8z4vriCy5XOXd/nFDeR/OyVSVjajqQTEh91gqy8wsRMIjmRqakP26prAMQFKzFYMpAAAIOIywMWFkl0Rut6qoT5Kif1p50F+uHeLNIzTMi3NWeDyKHE4D7h+GDtXmG795An8Dn3n6mQLfB/1b08eWaUNiznFyanDtTtrV+kj+rj/C0YZfSXXulvEuta4zUSRgzfTBp57pgRlidZlbisOZFduBEKHKIElFM3Kyr1rQrS3ScyGB3uaHdl6ga0TL4s0wQuE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NG5qRy93MKvGrzQb6T+gTSzWLJ7IAlFsjZDmRLr29kAoa4mEjizFL2rN6yLT?=
 =?us-ascii?Q?Eu4ci1af9eagl5DA2TlKE29QGi6NlaygRu8Gu87OkfKFY/HWJDczWJMrDVS/?=
 =?us-ascii?Q?MP1bjcyhr+BxiiZwNqpynuWvG5GC1eDcXNiwJBR34pzpPfUCok4eXTuP04OI?=
 =?us-ascii?Q?JH63VqHR4EzSZPOiD3C4VNU4k2kcXMMQbOuOlRctDuwQXXUN//f2/3uormw/?=
 =?us-ascii?Q?soXlmxkXs5EuFyaEfj3GQZ3+DFcuc+7oAiYM9/qiqw4izShRxMc76WKRQJbh?=
 =?us-ascii?Q?9fU3060NoG0TI8TgCU4Al66Qz9i/eG/l1GhKp4Towxgp3mZ5hTvL9wUnnCKj?=
 =?us-ascii?Q?CtrsBKH7JhKroiXzCcdOl+WnOuYOm+j6SzB33byji5EBozU2ZtrChOwsGtu9?=
 =?us-ascii?Q?B1tHJ30X1RINBaEyFWtpKcjtoNVjxhpw4MdXv/pCWjTNmtodG08sOOu9Xz4e?=
 =?us-ascii?Q?H8VV1+MaR0hBt/oL7pd30NmTZ3qQ+i6HN7vZ5YsTPHbGVTEvV8LC4NsIFLO6?=
 =?us-ascii?Q?gqarRXiXNmbpQxYrYyA8Z0A1AkG+byGra1B7UtQsKBchbkWr50cfEq1JtA6q?=
 =?us-ascii?Q?eOMZN9wJIDKNARKdSRNb02RK7XEkiF4QydN34NoFNmqGoGnJKOQ+u9YZ6McS?=
 =?us-ascii?Q?Qb/qJF2X6DXdAcpLy+cn8IYTHwGBLitpgAHDmz+Y1WPjDjDdllFWDn4tYy+h?=
 =?us-ascii?Q?vzMfE3YFlE/I7NaBAD/C1lnz3iVViRXOl4vO0byFoDls6i2k/kR/brF6ZUSF?=
 =?us-ascii?Q?mLuf65oXCyCp6uoZJNTc2G1a55RZsMiyp6Wd7rv3dl01g01trnq69Cn0wCCt?=
 =?us-ascii?Q?doPwABoDQxJNqX5AGdnM/E5zopv+yD2qGgds5K5EPPCPqA2CKu9Fo3VA41bd?=
 =?us-ascii?Q?Y2PzlFvfgQ9FV3PObog76qOuXxrXMX+Fz2hujPcX8KvoyRV6Al++gNJXIZMS?=
 =?us-ascii?Q?O+7aaIZyUp+bXU8hMPNeNnBDHMaUQibbmcGjnC0yrcz7vJWfy/2iRYIF6UKZ?=
 =?us-ascii?Q?KVLRQax1ZALLA9Ac81FlBUP70x0C3LnEkJBwA5A+MbVEdtgaXTz1WmPFw7vv?=
 =?us-ascii?Q?GIy2ZzLlnOKcUqOYnfr6xSnSHnEJDLiD3jbrrwUZA2ppr4Ve6NJ/TNugC6mE?=
 =?us-ascii?Q?xp3UofZH9bOjKA0OXMWJJ/w1NjT/ztkIAKf1kwW8PnndSYzRqNTvbLL3SQ6p?=
 =?us-ascii?Q?FfTjlFGsBX8supM47FOi34Lrm6RmXh+ihqTX50zapTrojUUmLFJNyQctVN9L?=
 =?us-ascii?Q?/nfTBZC6FoGZCbCSJKvB8w1tCRZGY8wl1q9ElqeUfZo0B33GZO6V4PyoNyHH?=
 =?us-ascii?Q?jKZyjr/JCzGTuklx1zaz6SuyqfpGdIEllgpoj6BBBEI7QnA8dnt2gGLuS2Wv?=
 =?us-ascii?Q?gOBBRSIiJTNCOaQZ8j1OMWuRauo8gTd2yMV0PSnAeogt002kZKtxu9OTjQK5?=
 =?us-ascii?Q?wRLBQ8UezWKnHMsmJB8lZZftKbE2i4B3xmi1UVcty7udd7wFka4/wB5zajyG?=
 =?us-ascii?Q?M4m7NZx0SxXO10ivuyjfn6JcE1TMNXpNWG2hrBdhog4KxASg2dcGokSyZQPj?=
 =?us-ascii?Q?HXBTglhdTQBg3NoaloVIFurIMbGNa2x1CFhHSiZ1/n2Wkw1X8otAdPaWUO5H?=
 =?us-ascii?Q?d2xUMOja2hpHpRFDS2J7r5tQUVGFsIr8M8bhnXRq6BdMIIUKsQkhkc9Qgi42?=
 =?us-ascii?Q?NeQczTmgbFjGct3U89v40SlU9Is2grZwFvgudsDIJ2hyWKQciv+oRmYDd2Gn?=
 =?us-ascii?Q?HpizUMiveg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc232a92-6280-4751-99bd-08df25ab220e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 02:15:05.3686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82zr2xBAmEm1IB0tTp11dxdhzP10Fa0JxDoo78wyyIt4HBeuH0OIl6zW4MjPz4QY5hR5SGmAx/ansMp1t8i9Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB8407

From: Tze Yee Ng <tze.yee.ng@altera.com>

DDR50 has no CMD19 tuning, so the SD6HC read path must be centred by
static, board/SoC-characterised PHY settings. Add three optional SD6HC
properties for the extended-read DDR modes (SD DDR50 and eMMC DDR52):

  - cdns,ddr-read-dqs-delay-ps: read-DQS delay in picoseconds that centres
    the read eye (default 0).
  - cdns,ddr-no-lpbk-dqs:       disable the loopback DQS read strobe and
    use the fabricated phony DQS instead. Loopback DQS is the recommended
    default; set this only on boards that need the phony DQS read path.
  - cdns,ddr-phony-dqs-timing:  PHY_CTRL[9:4] phony DQS assertion timing.
    The driver derives this from the RE# pulse width; this property
    overrides the computed value for boards whose flight time shifts the
    DDR data return.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v2:
- Retitled to "dt-bindings: mmc: cdns,sd6hc:". (Tanmay Kathpalia)
- Renamed cdns,ddr50-* -> cdns,ddr-*. (Tanmay Kathpalia)
- cdns,ddr-read-dqs-delay-ps is now in picoseconds. (Krzysztof Kozlowski)
- Replaced the read-DQS source selector with a cdns,ddr-no-lpbk-dqs
  boolean. (Krzysztof Kozlowski)
- Reworded the phony-dqs-timing text. (Krzysztof Kozlowski, 
  Tanmay Kathpalia)
- Dropped the SD4HC note. (Tanmay Kathpalia)
- Scope the new properties to the extended-read DDR modes (DDR50 and
  DDR52). (Tanmay Kathpalia)
---
 .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
index d5ea2717904b..911ce58f8dab 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
@@ -74,6 +74,36 @@ properties:
     maximum: 1000
     default: 24
 
+  cdns,ddr-read-dqs-delay-ps:
+    description: >
+      Read-DQS delay (DLL_SLAVE[7:0]) in picoseconds that centres the read
+      eye in the extended-read DDR modes (SD DDR50, eMMC DDR52), which have
+      no CMD19 tuning. The PHY runs the DLL bypassed in these modes, so the
+      driver converts this to delay elements (divided by
+      cdns,delay-element-ps). The 8-bit field holds at most 255 elements;
+      larger values are clamped to that limit.
+    minimum: 0
+    default: 0
+
+  cdns,ddr-no-lpbk-dqs:
+    description: >
+      Disable the loopback DQS read strobe and use the fabricated (phony)
+      DQS instead in the extended-read DDR modes (SD DDR50, eMMC DDR52).
+      Loopback DQS is the recommended default; set this only on boards that
+      require the phony DQS read path.
+    type: boolean
+
+  cdns,ddr-phony-dqs-timing:
+    description: >
+      Phony DQS assertion timing (PHY_CTRL[9:4]) for the extended-read DDR
+      modes (SD DDR50, eMMC DDR52). The driver computes this from the RE#
+      pulse width per the Cadence PHY guide; set it only to override that
+      value on boards whose DDR data returns shifted (e.g. longer flight
+      time on modular/SoM layouts). If absent, the computed value is used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0x3f
+
 required:
   - compatible
   - reg
-- 
2.43.7

