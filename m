Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474A23803C7;
	Mon, 11 May 2026 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530905; cv=fail; b=FZV/O5ERFj8ssV9Gac1h4BGkahk6hWnxNDRYOys+XRta75+MSlFbiiCHwTphHBnak2wFOCP3XEr6KJgZRlDRG9mdhDpeM3+Kdnotarc6Aa3kgqHSo51SD8DOYwyNVbivb8Jsi6V0EKe81FVNP5A4irHosIKnIYR/Xc1bL625+sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530905; c=relaxed/simple;
	bh=ivEUs0+nrDSt11sSg5BW0FcNwR+zMK7FMCUresgy/GM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iJl/5QR86ajAdAJFuuYeXeSxxj0URRAQP4IU1XDSiietT8FpSUSS0koottx8ZW+wz76QVhvmE1gvNuJHvrVVGwRHSTZKbJpL1XM4fIx/NUR6tQdJsnoj0qDSjMHNLcGm+vOQj3bjqmuryzDPSUpM5Ivn/U9gEYz0swXiBVQSxq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=H2n/iwsH; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="H2n/iwsH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIq8TZQ8vb+JyWjQL8iEOGLTgVyStjVG3ECEzRjGOPK78yXAaA9d3soj1hXops9mKT2pA3uXu0JlHTPue7uO2Bws757G4cALLQOKNfE1pSZ8JS6ghOiZMF4F+0y2rJtjmq/cbji+xVGKH7T1C5AXtRDFIAjqlU0Snw+SC8Wr6sSdpm1WPjAxp0isf9W3NSRhZnkECAmfnr60qq+GvC6ICI8XJBlRpz+XH2RDfbCmWKxr/BBQaubTjbfjmiQJlc4mYVs438iivAoPYU6NdSnszIIdtN0Nb/J5CEkO03glIptJLIucGGcCtCUcbbizV1W49+9HCZl6OVoJlW7DUwJvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqfUXaZWxj9VmWeuCdoGyVU+fzWIqOxCFgQBgmGRaTc=;
 b=OoZXX4tLBVmS2xbhNtIZyZmb0m8ssj81O5nQQuc1sPVu2GytgIb4bJCocOqMbLfTmXBRxLCK+tQbUqD+Klc17qujk8EGZ2R3dUPDUvQpTXO38AsxDLmOkeUxrzQ31dQbty+s97Deako3RSvEY/aW/qb1Uixv0vHbVWoBCcEkHjj6trYzCtQklao/Ke0tihUtdSh0+Qd0nthVkEvxnH1EA/DeSeIN8DbgkBS7KnABcy37nhH5/1K0Cq56BelM9MpuhLV2cK3uaHAU+MUzl95A2pyELkEuUIAxIg5C7IrWmzJqrt1s6AF2uqvBwTvFVjY4l2Y1QqYdhQB2Y54TZuLI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqfUXaZWxj9VmWeuCdoGyVU+fzWIqOxCFgQBgmGRaTc=;
 b=H2n/iwsHi3QBKUL5btBpjPUgtKXc3760Q4O3KC3qxa7Qu28EuX3ZDijEGK4jY4J6aDyREaLus58wICtYV1dc0ibRBwMWudHQYnV9T8GayagLh0Kjaz3ZKrGHfn00mLVDYcY18mKMsk0UfGaAfL8jl9udqxeqShHQFnr65VAxTVHl3WAmBBzUuOkudmlwqS51K2OmPMUOTGEFKL0rtRlWQVxv+VGXQxJMUW/aDos6Bsi8UFvIUoXVTQR0G3JJgw+aX4hFZKLs1daktLzvtvCPXi5upTlQC00VjatDEqpXpTcHHl+vxlBj9G2fhn2NvO6g1Qm7Vq6IvvDrO1jnvloRbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS0PR03MB8296.namprd03.prod.outlook.com (2603:10b6:8:292::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 20:21:40 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 20:21:40 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/9] dt-bindings: mmc: cdns,sdhci: add SD6HC support and PHY properties
Date: Mon, 11 May 2026 13:21:24 -0700
Message-Id: <20260511202132.5597-3-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0066.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::43) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS0PR03MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 338a4daa-54e5-4e59-4d1d-08deaf9ae905
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|3023799003|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	KmTcp4gAUWvK5v/Ou9sWZzaSjKnOSdzybUYDQzkE4IY11zSSUCMJSH/hhPHiJcxcGK7bIteg9vnOgOqdumNevTZbST5LPf3M8Eu+K0J/INfgOorW4WSZMZ6bapUJ1utiXTka2KR2VQ5By98eHHKQmB+dbTfS+3/028LhrAXw9rjWWKaDw8cxGr6gAViyEdhPfWIr7FVj0t4cUF2V9mh+15tbFzu84j8Pu9fVNFrUf11beFEh8m3bXgGI4xNgOTBbD4QLFRWiR8vxSlEVAGXYeIHeLh9lWSVg6fKMqVTwViAgWlCBOwo8RV5tV5LsBqCVHYnneA1ws2EUzzRxNUkDP6R+n+UN8aDDg/EbFVl3uxvK+psplBPHI4d1TSWiA0/YGAeqLTpapkOdKXxUKZp1af/twWcSEaWfYa5/V3EfirfI46CD48dMarFjNLxJur9fGct+xwvO0BeBfMI1oy0Q8MrmDOQbKtueBgIrULgxH4MV4xLQKCKeh+M0veGcc3JcHR8IT+CoMArossZIRMWyLzWyhC7oCNzpvCTD5U9pKn8LsIILpPFqs3LFA04KmaavX8ZgteqCnQa8BT9Ho+Te+sk92Z94b/Ky7tL17/dtsMrbm8gAtpMYsB+dn4VJ6g9ntMMALjEPI5oalkx3hqsNGg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(3023799003)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0uKgqRTCz116PA6qJq6Ys3lCU2C/AxextBM+R2R43B6MV/dQVCHv2Ww9EhtE?=
 =?us-ascii?Q?1xaha+2r55HZESHDpaGVchjl8WlLaallSZx5LVBt37T3DXdXbJSwMfh3UIbR?=
 =?us-ascii?Q?3AEJR7f/XJ6orIvJ2VzkJaQhJdi6BCyUhaSZwILK/UDxdLDIlx7/Dmph6anY?=
 =?us-ascii?Q?NRdGTY7hFKryR5KYyK7qqg8rmM9zBR2nvJ+gn2zgCuG0Ie4NQuHdgMyZHbVk?=
 =?us-ascii?Q?nMbRhXTc0zR+R67TlTGbB2MG4NllB7rd51mT7ubh5S7AsJfpZJQTL6ZoUeOn?=
 =?us-ascii?Q?fJtgUCpgzlUILS8n4CP5awN9yL5GFnvWDOvKFly6274B+wMZlEqOEGR2yQY5?=
 =?us-ascii?Q?PFzldHd9z4daXCQUpUBbwJlZem4TiewyPwc0PdJfWvam36TP74Fc+uFMkFE6?=
 =?us-ascii?Q?XlsIVVJ5ce/0PRC0Bdc5ky/GIM18+OOmeSLdN6IRTRxxhLXmOJUDx6yN9hZK?=
 =?us-ascii?Q?4rNYn5T042BusKan5nFqimG77DCKLe7PMSGt/4ZxyrDNJ94ZJKoDZ6kBIYI0?=
 =?us-ascii?Q?F3tePpwsfnkaas5owbq/Z0TlmEEb+8Z25EBCgRzS8QiqAFmQLNAXImwN9h+J?=
 =?us-ascii?Q?AIPU1Cv3Om0AffntaL8EY5PqbP7hr884KTimo3cHevdjpCDhxD5hDcBOibky?=
 =?us-ascii?Q?DpfGtAR0xXhnruId7mFnthp48irXwb8l5Ti6ayaa3vldm97Oa9N+G2tyyGM9?=
 =?us-ascii?Q?Jgt73lSV+JxK1YdiogoUQfIoQRAqW/eQedK62BfHc0BQdzGQdWgaNr2ujaU4?=
 =?us-ascii?Q?dn0pP76IU67O8aduyELBHf4szaP8olzQhG7MPS0QfcUUNRvVBdxWC/XPiBxH?=
 =?us-ascii?Q?eSuhSdrJgkZxIt+4sRjTlvKbGZSQcWZZa06meE3auaEqd67rpwWTHr+zObev?=
 =?us-ascii?Q?AaWIEpPL0iyxCVZgiIZ73izvtlqa09PTvmM/mm1ax/LuO9HY4oAQNScEaQxi?=
 =?us-ascii?Q?cwel1QlzZKl8FA2mMF3//4s2rZ7AInN4EOlsRFEWmBAPT2Xe70jHQ9enhwXy?=
 =?us-ascii?Q?W+/5dLK4PRpmU1d7dNkO71a0ichgs5XkcsX85wa7XWJhNRY+G7eDo/yDiljV?=
 =?us-ascii?Q?5LMyChh8bB2KqBGgHlCYBetMterMgKGhJD4mEBH1+biUI2ykqxSl+iRelya6?=
 =?us-ascii?Q?OfAcjOvIFw5R02hCzoBfVYpQJD0zo8MEZDCv3nNed9xB8lTUieTThSIjxLAi?=
 =?us-ascii?Q?iZQLCw4mUb6fnAG1QRdIXdKU7JsOoEoUM2YXSHw/AVU65HRkybjPuCNkvnRy?=
 =?us-ascii?Q?K0FMvqDBhNMjJFw6lGkZT9ArA9ywAVKT2YxPrkTZR+03RKH704Voj/sT4UmT?=
 =?us-ascii?Q?7SVqmW1Y5eXW5BjQeIoya+wgqcj0JrQoC1fSWkkuCxS+swlhMvcTDVilgtaq?=
 =?us-ascii?Q?qr9zFGQW0fxZ3QzkQjPWX6szjlP5v29sl0g2iDjmT2gIf5FbbuTLDMhIrLIm?=
 =?us-ascii?Q?2WpkOpmjIm7fCkK36aCCdgPTdOAq+hEkyrcqP16MaD5U+1/RJXioRyrl0FUy?=
 =?us-ascii?Q?PQ0wttq0ILWa8uaUvY/0geUwM6Z2TakwCXH9EqwZGQm/EfoyVqHQrA8Z3C8p?=
 =?us-ascii?Q?JX+7N29OAOwh7Ntrcgk6VH+gJJbF0MUVOnMLOXMRn4tz/O3/8Z/FIKA7icdd?=
 =?us-ascii?Q?bLS2eyPvwasO2HdddoumU+7MHqi7g4Nvg/hgw5HYia7Ay7AB7VOLAQW0KZMv?=
 =?us-ascii?Q?3Z64kwpPhINqmKR2mpc/YTJNV4+7jZtZD39VqHvigmMo8VCUIvslr8ZuZN7E?=
 =?us-ascii?Q?DakTn0Y7vi3aFA2Yyf5heS+TYuYJBq4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338a4daa-54e5-4e59-4d1d-08deaf9ae905
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:21:40.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeM/NGdHSoZNk68EPtYUpLOyp7O8ydmNoYU2WNHTzM6ImlQTUcvcOzWdRfuwWEseiWWHcWddWzBdWLtcfIKu2zML3VHxO1wgN0Ox/OnYY64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8296

Extend the Cadence SDHCI binding to support the sixth-generation
SD6HC controller. Add the cdns,sd6hc and altr,agilex5-sd6hc
compatible strings, clock-names, reset-names, iommus and three
SD6HC-specific PHY timing properties.

Add per-variant conditional blocks so SD6HC and SD4HC each enforce
their own clock, reset, and PHY property constraints independently.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 107 ++++++++++++++++--
 1 file changed, 97 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 6c7317d13aa6..e483ff83cbc2 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -4,21 +4,29 @@
 $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
+title: Cadence SD/SDIO/eMMC Host Controller (SD4HC and SD6HC)
 
 maintainers:
   - Masahiro Yamada <yamada.masahiro@socionext.com>
+  - Tanmay Kathpalia <tanmay.kathpalia@altera.com>
 
 properties:
   compatible:
-    items:
-      - enum:
-          - amd,pensando-elba-sd4hc
-          - microchip,mpfs-sd4hc
-          - microchip,pic64gx-sd4hc
-          - mobileye,eyeq-sd4hc
-          - socionext,uniphier-sd4hc
-      - const: cdns,sd4hc
+    oneOf:
+      - description: Cadence SD4HC controller
+        items:
+          - enum:
+              - amd,pensando-elba-sd4hc
+              - microchip,mpfs-sd4hc
+              - microchip,pic64gx-sd4hc
+              - mobileye,eyeq-sd4hc
+              - socionext,uniphier-sd4hc
+          - const: cdns,sd4hc
+      - description: Cadence SD6HC controller
+        items:
+          - enum:
+              - altr,agilex5-sd6hc
+          - const: cdns,sd6hc
 
   reg:
     minItems: 1
@@ -28,9 +36,14 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   resets:
+    minItems: 1
+    maxItems: 3
+
+  iommus:
     maxItems: 1
 
   # PHY DLL input delays:
@@ -115,6 +128,25 @@ properties:
     minimum: 0
     maximum: 0x7f
 
+  # SD6HC PHY timing properties:
+  cdns,iocell-input-delay:
+    description: Input delay across IO cells in picoseconds
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 20000   # 20 ns
+
+  cdns,iocell-output-delay:
+    description: Output delay across IO cells in picoseconds
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 20000   # 20 ns
+
+  cdns,delay-element:
+    description: Delay element size in picoseconds
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 1000    # 1 ns
+
 required:
   - compatible
   - reg
@@ -139,6 +171,61 @@ allOf:
         reg:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: cdns,sd6hc
+    then:
+      description: SD6HC variant - use IO-cell and delay element properties
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: ciu
+            - const: biu
+        resets:
+          minItems: 3
+          maxItems: 3
+        reset-names:
+          items:
+            - const: sdhc-reset
+            - const: combophy
+            - const: sdmmc-ocp
+        cdns,phy-input-delay-sd-highspeed: false
+        cdns,phy-input-delay-legacy: false
+        cdns,phy-input-delay-sd-uhs-sdr12: false
+        cdns,phy-input-delay-sd-uhs-sdr25: false
+        cdns,phy-input-delay-sd-uhs-sdr50: false
+        cdns,phy-input-delay-sd-uhs-ddr50: false
+        cdns,phy-input-delay-mmc-highspeed: false
+        cdns,phy-input-delay-mmc-ddr: false
+        cdns,phy-dll-delay-sdclk: false
+        cdns,phy-dll-delay-sdclk-hsmmc: false
+        cdns,phy-dll-delay-strobe: false
+      required:
+        - resets
+        - clock-names
+        - reset-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: cdns,sd4hc
+    then:
+      description: SD4HC variant - use legacy DLL delay properties
+      properties:
+        clocks:
+          maxItems: 1
+        resets:
+          maxItems: 1
+        cdns,iocell-input-delay: false
+        cdns,iocell-output-delay: false
+        cdns,delay-element: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.7

