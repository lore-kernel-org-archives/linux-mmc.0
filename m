Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7345372CF;
	Tue, 22 Sep 2026 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075581; cv=fail; b=dozfFnObVSMh8qPQ/277968LDas9r1jB9Nxh6gqQz4CmWz8aVO9qtpYaKgnDCZig/nktUX5scILxe6NVlIR9d62DyTD1VDwst1WzsZswxuA9mFqcIDGQiStanwmsPhVzMdpwrZIH41vv+S/XL2obBqIxo1vA+0ZNYg75GRydhVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075581; c=relaxed/simple;
	bh=4ktrNl3JHK8bh0IKCwp7Id1V8pGEfW32j2039MV3Kg8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jvmUzyMsUlOTwCRcwuNcDKbv5PIt90KeOoPIBwbHpxLgujDhuHgajFc/abb9rGQOTKNOsy8cCqfLvWjDsx78RjzR/wKVE4qaa5D6sQuNLCGgTy7GsWMBW9eGnafyqViY9VXLcNT24zWgPv9Dy/EWVmbnd6btZ5wudl6nkx4JtDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ibvbLbOd; arc=fail smtp.client-ip=52.101.85.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ibvbLbOd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9mt8I26AJ2qbR67DNLqoqye/aRlC6j1ARO3tZkHNxT6AYaT31uZt8GOjJ4WsLQEC//KCY9YnGNtOWGqQXQxkxRoh5tHDQrR4oZ4g1Z1swwCu+ynT/5jieaCQuZMGCtVl6wtE04za5nq8X9ebbfHCketkTOY2eHaQ7ipr2UDq0XEnrw3EtfQzdvw3KCHP4Ki7YrKsbfrd4IwSFZf/bJaQ1NiUQb6PhJwo2/L1XqNyptc4KYm+zoEmI7DP+biwWM2BF4YzrPAcKhWIEh8fgvhZdCus4D24mEnqhfLYOnoz3wizQ+jhTMmbrFSVdOj0nwzV4zSz8/QjtZ3GgBCQMMJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afkjNzRj9m/tI3JoMb/i1cF57dN55zfCmccj7dvt2TQ=;
 b=f0JJB38HQSjJXaRSYYQWg1uNQECypWyPoIHXVAhy0wp0+QyPnKizb/s8loeb6IAqN+ey6vtuh7E3KNWell7pDY6yV5sBJkXvWF5wXY/QWIAcPmEIkg2xw1Z542FexLE0OG8KaS+CBD0Jf8hIdbWqMb0b5ePPn4ejG3m2/2Bzm9fIt80LtOH8G5UZ1Nb/BPYYCJFhlco+g3c2FuQRIx5A0B8XJpuuEwYeCE7XFxjaufCkvsBg5NgaMm/BtjKLAo1B9AODBDyWI4F/aqY4dolL+mZeiUGdu5JMcWWf0wzN/pRPEXGepIO+kalfHvKTIGFwG4z1AlN8BHTRjNdPZtVSPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afkjNzRj9m/tI3JoMb/i1cF57dN55zfCmccj7dvt2TQ=;
 b=ibvbLbOd4A2tz5/3CJ29hOD2KwRrv9aI3s1umoAZ5gNrZ2IgljIJ0r8SHYofZHDulHirwGvh88WAmlDMZlYoI8Kn2d7BvL/S1txvOr5OWfcIg88c6jdyZQnlkAq3GyDceBoOpOLC/ks+Eh6V+kCyLSCRt4P9kxK2TMY4SPIouAKUaBhJKVcFKCNhRUSStk58V9vzT2gXlSfa/T8RU5AiCVmPeD27RwPUCSdomhfdA8Rxjw6nyr18mmG3k/QQPmVPqda5N6ZUNhy515ZWBPhjTmN1mhoX4Y4lGXCJZlOasGCYyBcfGXuv3nSZXMqHCLWmWMYVeDZeOVQ4eHTSR3Cc8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH0PR03MB989354.namprd03.prod.outlook.com (2603:10b6:510:11a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 11:12:57 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 11:12:57 +0000
From: tze.yee.ng@altera.com
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: mmc: cdns,sdhci: add SD6HC DDR50 read-path tuning
Date: Tue, 22 Sep 2026 19:12:37 +0800
Message-ID: <25649477d9967bb04b12c6e60b0ee76443f356af.1790074790.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1790074790.git.tze.yee.ng@altera.com>
References: <cover.1790074790.git.tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|PH0PR03MB989354:EE_
X-MS-Office365-Filtering-Correlation-Id: f74308b7-9eb7-42fb-1d13-08df189a73f0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|3023799007|11063799006|10067099003|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JX3rDUQgU1jQJD9JSrau+vFIc0u0OCkWS2Yj7JO5nMEHP+cY0qKEQ1/zXZXN5YohRI1c66SZEbExO5okOPK/B6eU7EKjzZphxOI0MpeI2vY9VT+rNz0MmoY7mGiCsF9AuRtudWvu6V5YTNogsc5XJ2nz88Np/4gQ2C1ud7shhbtBxyVtTvXENynsSxaBV8jeSrkPUnnSKnJ5c2obL3uPYLxnaYWQ1eJ4w2CowMd7wT8m47wDF3NDe+7RKGa31YW2f8kvNefi1APhNpmpv1hAbZPT+ihC2ULRL7xnonSC8uijBeigRnGvo9iMdsWfUNPgrVketpNbrTY7xTToVi7imHSXsFPYQ/ZhnFD4CWHR6w8/2wGi3b7+UzKwdId3276bwGM3TlZN6u309BJShCDUra/vPhHVbNDeb8qzeHxRhE/3kf7piLgzsc+ZTT71TSISjzXIXW8Cd8oecHQWE6VBO8ztgbGB0tFCZCeQBjSSK7EBST8CeaqB1+LzEFyvFJoKGuEXCNQXfzpDnbh4UwlrI2+r7MyD/Gmcj+5jBf++Pa3TwE+HytUWeHXs3kuJPR6xsuptOG/Fqy2kC8Ekee9tvD+nzfXtB5WpvxBZ1I8P7uhwzlfpx1WaSDFoMQKgvY8NbP0yghkE6SUlbhEHLexNt4LE8Q/ozap7xultxgWdZj4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(3023799007)(11063799006)(10067099003)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jlLWYFoci15u6ditbC7xcRUSBdt4h0ONN9imPsAIfTL5s5RZuXFoNE6dZl7Q?=
 =?us-ascii?Q?+wpfWHTOTZA3FONI+jN5SGWr2+0qRmw3iiKcRaxjP4e8QmEB2f1mvun0xe2Q?=
 =?us-ascii?Q?FQCEcX/Ciw4L1csOQSM575vfbgishNStAsjbGqKjl/VRmv0Tn5D1JffRzS14?=
 =?us-ascii?Q?0rfF2tekhZ5o4BxAtU5NkQfNblPcxm24yJ6EXk73dIuzIXGYlG3MukbTxJ0p?=
 =?us-ascii?Q?wCp6s6e3FcK8T/ssBGAzLtXo0JdBEuokDczkSXdQNczE5xzIgq/jUfnx3H7q?=
 =?us-ascii?Q?YLkU1F61ndp3map3VtEYGDmiGt1vJPEwhDmmevBpQGuWKczpyUlVpl3BeUpC?=
 =?us-ascii?Q?JvgtjBdg7MAYp7Hho2ody73b6dfpmaTzFfvj3jyJd1uTnttmJ1b9Z/Bqr+z0?=
 =?us-ascii?Q?kbhbB9hDTJpRFZGfTO97xBugegZ+bCHfZ3cpOMj58xanhkoN1nCtTeh6RG6F?=
 =?us-ascii?Q?icQZJwQ2cpvUNY0ZTEQ6zO17ArhIPBvvkikVtSnNCJZ7x54dzMW2AeVeentC?=
 =?us-ascii?Q?ZvKwuZp0NbFBelvjV52NLYC3Uf1+TjlYSfn7F1T6JPT8mbHVk1PDxWx+eLD3?=
 =?us-ascii?Q?BwWQ8jng9G8dmTaq+FnKUvHOoDbZP4YeZxl6ZsUdkxF4Yi9V8omM4rZyQ6Ni?=
 =?us-ascii?Q?sqNAiuEGw+EOMzilnbp60E+HiAeFZthRmCygev5FrgjGh7RUv+Lh6M7lk1Uz?=
 =?us-ascii?Q?ra17mRxHGEG5Ar3otTR/jLx7TpqX6oD+bPTaTbqgIBxTJ5Vfk8VZKeDSW+IL?=
 =?us-ascii?Q?+QexU6HJzw/iBhTRf9vzIuUNbaqZ+PeaOTFdRudLr8BuuB2i6o2qjUtm/oqC?=
 =?us-ascii?Q?Qt/DXu5sYOA3ZvXRwxR9Nlemkeo+E1CDJeOcERe8CKp/RHRQHAxo1UCshecr?=
 =?us-ascii?Q?DfTZW8CsG3LPK/B/DH19t7gFdNgpW8BHKgIEQO+2mbX3EhY4z40o/DAqRW3L?=
 =?us-ascii?Q?6h9hEaO5z9QbR7i36MSEyQBsHOzdf68IQ6xgYkxAAn9Nu5qgA2ZhLr1A8u/i?=
 =?us-ascii?Q?6UBg6z4PcYBfSYfmtekudiOMy+UvNAHHQcaKJ6XoQhrkUzuXJtegXXEyAM5p?=
 =?us-ascii?Q?/7Dk17pllfLQj+RdA6sefDLQeLTu+VKJlQR5kRzvqKvp2/F96DNo5r7PFkTO?=
 =?us-ascii?Q?lNQHHyNauHsWp8P58kgmMyAjkeahOUu/StpFwtB2cmQo93J0vaIBQIv38ZAN?=
 =?us-ascii?Q?JSx9eMP97J7O3fAFhwAF3IjfcQw9J8gpVox8517vwlbkNZNQsDaYXXxKxSZA?=
 =?us-ascii?Q?BqcRcL9nhYzh1mB28p90T5KSgWXFW/a7G/+hoTF/oVOZRhm54BZ9HUBx9VOS?=
 =?us-ascii?Q?+R6DUrJK3JZONNxW8CBgVEnpJmCgcg53nmoIBK1G+WwXs+qKxd+ozq9c8w/7?=
 =?us-ascii?Q?ee2iwyBD4OhnxkkQh+7Z3LBBt8AxUJJiMQq7WB1gf9hFPaU8NUUBQ6V+b+rE?=
 =?us-ascii?Q?PkAmKdBUp0NN2D4qFaoJ1E/keRLG6stPlI+QCdvkZucb/NmhEXIajAeia3Ga?=
 =?us-ascii?Q?IWaz0vnmcuuKnjOYOeThk9bgvhRWEnzgIkLtep95XPXsG/TfB9vtlxybhuj7?=
 =?us-ascii?Q?Hh00Gg0Y8CRoTYzpIgkKZFGp59cMWfSkgVa+EdPr5IXXrYop9P1xYh6ghFJw?=
 =?us-ascii?Q?BbZiKtCH0hRIHOf5fgecZZNNk+LxX7wPDZnx16wZ4fqiqHUSOOzcbmsGld3P?=
 =?us-ascii?Q?Z2CTFnZx8EQ7XHT1QYWXtxTLZ6LfqR67RZe7SlZQG3zlxrOzcoKGcAwlJRP4?=
 =?us-ascii?Q?b5HLVSlw/g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74308b7-9eb7-42fb-1d13-08df189a73f0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 11:12:56.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJ3lFtiWDXFIlj24ZsAcIYPhUBz2jMT5vEoxTZQlQWYzI9qE+2sgQsIKE9jdC+cFZkcL2loONzGn5OjBXmcDpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989354

From: Tze Yee Ng <tze.yee.ng@altera.com>

DDR50 has no CMD19 tuning, so the SD6HC read path must be centred by
static, board/SoC-characterised PHY settings. Add three optional SD6HC
properties:

  - cdns,ddr50-read-dqs-delay:   DLL_SLAVE[7:0] read-DQS delay that centres
    the read eye (0-255).
  - cdns,ddr50-use-lpbk-dqs:     DQS_TIMING[21] read-DQS source
    (0 = phony, 1 = loopback).
  - cdns,ddr50-phony-dqs-timing: PHY_CTRL[9:4] phony DQS assertion timing
    (0-63) that positions the fabricated strobe relative to the returning
    DDR data; not produced by the Cadence timing calculation.

All three are disallowed for the SD4HC variant.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
index d5ea2717904b..df86872603d0 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
@@ -74,6 +74,33 @@ properties:
     maximum: 1000
     default: 24
 
+  cdns,ddr50-read-dqs-delay:
+    description: |
+      SD6HC DDR50 read-DQS delay (DLL_SLAVE[7:0]) used to centre the read
+      eye. DDR50 has no CMD19 tuning, so this is a board/SoC-characterised
+      value. If absent, the driver default is used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0xff
+
+  cdns,ddr50-use-lpbk-dqs:
+    description: |
+      SD6HC DDR50 read-DQS source (DQS_TIMING[21]): 0 = phony DQS,
+      1 = loopback DQS. If absent, the driver default is used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+  cdns,ddr50-phony-dqs-timing:
+    description: |
+      SD6HC DDR50 phony DQS assertion timing (PHY_CTRL[9:4]). Positions the
+      fabricated read strobe relative to the returning DDR data; the correct
+      value depends on the board's SD flight time and is not produced by the
+      Cadence timing calculation. If absent, the driver default
+      (REBAR_PULSE_CYCLES-1) is used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0x3f
+
 required:
   - compatible
   - reg
-- 
2.43.7

