Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFCB1C6BD;
	Fri, 31 May 2024 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184286; cv=fail; b=qejkTdIfXOnpGbO4if14Zfk2U7kS1/W2qcDimEmryqDLh5/UOiKZfbo+WmWeCSd+RpmX/RM2JE4gdloSa4XVn53Ns/jlyOmIhICRQ8cwzuZ6vNh58RhJAq4ThgNEPaaBsvWmZcAolkzo9zE/zAL73mVT4TLtW/GDDS3V0yZR40A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184286; c=relaxed/simple;
	bh=b5qLBBkJ+SvPVJNI4gFw4nBxckfFpiJotHgfHQx1i00=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Azrnom3NpcBIAwdnRGvddbRe8TvPynR04/kB7jFnUokpG3mFgZsAqecm0i/xF1PbXOlifgUYdRHFdfjRbmJ2DFA1Y8oMSCHXayzIg1hvpsUm4HCUTqCT/fzfgUIpSEsdvQRLpKFMcGnlVx/7qBmVIqu4/EVximsZrss8a7HW/4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=R4LqesnC; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R4LqesnC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ru053B+zEGnLwgBjlChxEN7eLiZyXUwI47aprielt1uzGQnemUzQfTDt3xRY8G6QVvXvnEcmKDbwsvT/fwCj+J7Ur66yU9M56RkJwYVEamGYddgM8Qs/MoxKr+y7k84dh6DgxPiPxTy7Zp5Lkrfj8KOWCu783GzAudoWBFOlx7UyCo2Z3E17KZFxUYBs4pKDWZBI7lI86l+U2LyOCgnPdXkAucKGd+Uy28RzgNdWsLSsnmf5PhYo+LXyZ4geBmLjEalCctatcmqK/89Xp+IEc7uWGRbYwzcD9ALIBi8VgVZjlKrGJMHx/e+B5kWwENeaw7vNmrwJxSgmAJRpV9vPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvo8YjzHqpXZCUtF7QAcDJNfyWDpFyzDZ/VtAgqOG+I=;
 b=Mc2yutHMBSvM0o/fXY22C5Jm/VXokjUCnC05DVL05ctZxE4WqMu86ntbENH149YwnR5HuejOW5Sg4by8RmLfelbV7786s1fcebRvMzY+fsu5FzLrVhOS5XfOf5/Px6WYGYU6Nl/z0blj53/b3jwGWbs4aXMFo9xf91N9hUwmHmX+7IYA9XtZ8c+DfZ9YzJ1rjh/O4sijxLkOqP0AtvxApju1H0s5kwDHYiMPuacYnhPsQPJSTFIu/eUfcKb84fYu6mIM/ULNFvELyiwnA/IRwDHeZnaOiuvWoICn5n8yS0tyLodqy0wZz+aL7PS+VAySslY0yXi84kTdeYN9B95Obw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvo8YjzHqpXZCUtF7QAcDJNfyWDpFyzDZ/VtAgqOG+I=;
 b=R4LqesnCXK9Nwyn6U8p+QTT7oZwjUBJYTXIA8EKToIfJAtcED+maJ/NNFDAzxNg32KI7N7msqVQA781RUll/A7ahLRMi8AfRS5qO71w7nxTq9NI0uwoUcIESzfMXwLnUdIZFmqGoV2O0NOlqrS/hT9kd6xSRPQm1lBtX1rHD0qc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9679.eurprd04.prod.outlook.com (2603:10a6:102:23d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 19:38:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 19:38:01 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: mmc: Convert fsl-esdhc.txt to yaml
Date: Fri, 31 May 2024 15:37:44 -0400
Message-Id: <20240531193745.1714046-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b095422-695a-40a5-8d7c-08dc81a92e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NTDYMZ0dNnJ3pZfsoBi1qxHscjQeXlSil55PcZSQQzoCNbQ3Nr7I87cQinB3?=
 =?us-ascii?Q?EHDFv5YoC0EaFG2mZPzgVFL74QNeYZzuYUXj8TVeBI+QUbok6WPm9U0l7j5E?=
 =?us-ascii?Q?/Q8taK/e5B1o3PsB370wupCFRZNhedL0WGqLwIqDdkB1OtMsHJfF7ralDNfs?=
 =?us-ascii?Q?aO86dcqDU4ZHRVVrqU7c3gW7iVtNsK43gZJJXTfkIKj3yizQFuGgBzwmy3v8?=
 =?us-ascii?Q?SUtkQ9BSYSRi8PgaRYbZs9yciqc4DochXJO490efE8HN+nuwPrQyrblbxTIo?=
 =?us-ascii?Q?nBdhpX3wbXkZCblAokTT3gOB98TI5jCLg/MEmS5M3EKm1yUtWr505GZoyf0X?=
 =?us-ascii?Q?n5MRoX0HitFU6KADNn+LrBlcDNRUFMUzDbTv288eMP3LZltJHjvrDaPPLf2b?=
 =?us-ascii?Q?2ckCq9xBXlCWT6xry2V6NPdE9UlfIfrSoxgPBuWP0epnYRPj521NgFAf0/ZJ?=
 =?us-ascii?Q?LxdQUAa5jqIbMWHzSknHnuWpZAfvC3wIU7Za/Ow14gWOKKtZLTvv+GNyAgh5?=
 =?us-ascii?Q?33hwqCva8JC7Xnvem3W1bWEojSHAgTLK873++7FGiGkr1LnwfdmWRvc3BwiE?=
 =?us-ascii?Q?+H5oGqhKBD3RyLX7jooyC6pXr42T+42CnFGlBZnYbEAHwC84ef0k1akMRVs1?=
 =?us-ascii?Q?leT0ONYPTU8HhOI24OQ41TEXpDmQdHxfaVwmG9Pv5Lj0cahSyrrzwgiUe2cY?=
 =?us-ascii?Q?93wj+FcdmB/FwZ8IgfqmwgGozQLW9m+gSb5yytsK5TSg7H8bfS+h1zIGc7i3?=
 =?us-ascii?Q?elMOA3xp3pLXjn08BdX+dQbBU7I6adlfrHU9f4HSRiUyLERvtDcqozF5rtgy?=
 =?us-ascii?Q?jzvtvg508eNEULBOFwf+PZuM2p2i8DcL+ULEECDeYDwlnQwIiwc0aFkvrkP6?=
 =?us-ascii?Q?0Gp/ZhCzWI2se3aUjkUz9QXNHbltODYxV7S0WGtV7qMpDwX4O1Zk82jl2ivR?=
 =?us-ascii?Q?f7rxUlzOOyITk1DNTjEfCcWqJvPi6djq1X8G9HMEy6eIJqD9K4zd/0mQuPxQ?=
 =?us-ascii?Q?PPoxqqGw2u1Hlq9Hb1GJH15njrc/6oZFB0/peFn/G+/6zu96j2Cd07GgpUHw?=
 =?us-ascii?Q?1ETRFEF1S5HYPUKN+mkC78l/LpIm34yGURDwX1u+bSOaRswpe8p1XhReMcdt?=
 =?us-ascii?Q?rofDXJWswGGdAwK54vKV7if3iTjXKxJCqtrJtx9hE+uBEx869gEpIgSc6YgT?=
 =?us-ascii?Q?P8JUI56W4/kHJJI9RI9zd98TN6gjD1ZtFSCOAuVyjtNFCsshXaCy5LmQkFL4?=
 =?us-ascii?Q?SRtzhCTkEKLf79qwRB65SRS8V3jcQkM4Jfwamlc8k8BgdYC1yWWL7hQ3Yb4l?=
 =?us-ascii?Q?FNg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c0LEX8vLNLkdxi9ucUmf6pVU4Iq2didbCsz88H+wnh1K5qWApgh+wsChz8mD?=
 =?us-ascii?Q?42nN+7Tb4XC1GLERF6o2okqys+/8dC4/T3Yu71fgwamhZNvvHp0nTXMjBrQh?=
 =?us-ascii?Q?1PsRhJPY99ehSysNImOkgcp0hR3eSc38xFnk7zCSt5pkVuWxARCRorcdqvZW?=
 =?us-ascii?Q?aTWCFftBoQA6UrgYXtULq9DSPYJV150arVL0IqPzg9RW7LQ47IR7HHzI47id?=
 =?us-ascii?Q?hrJMJapcYFIxU/5XrhZ4XEIcNVRgRkKtDMq9KEASGKnGH4nfaOpxtEo6pR5D?=
 =?us-ascii?Q?qAwbZeTilu2YhFgrBtmSbot+3od3SGwxtX5JSIScwirFUjMtd0ohTWpusM/W?=
 =?us-ascii?Q?Yt1/0CuQuwu0tetrJIqNbChxT5Wa8o3T3yS4ibhfEF1LoZU17FTLLLTBSvrM?=
 =?us-ascii?Q?b1cFDayD0C9rjeYzCTYmHA3rQrXOBk4Motmh9HSbqii61wY/VVCzuvpbfi2v?=
 =?us-ascii?Q?EKt4heuHUQobJegRkiijJHr20lNdHXFUuMLwZ1AkfmUXd12UgRAPmoU4jKKX?=
 =?us-ascii?Q?2H+TzIkv17t/pjyJ+fInzGg6NmAjYVmfD8eCeFwNGBReKWkkfLao5n+QCP3S?=
 =?us-ascii?Q?mx/XaY1Cn6mPfOyZP0GyjYT/9dQxGf+LkxQIEzu7ZDqS4BpWH65IfCNMM8bf?=
 =?us-ascii?Q?FQ6E59XUFe9k7kahq24ynJyjW/96ee7iFXjedExfaE7xV0e2PK4j03FNqR2w?=
 =?us-ascii?Q?qZQ4kyvnAhEwommzPHjeEcjH5h4Ag5/75o5lsAh8pfWW9SaGx1xwUztVAxJa?=
 =?us-ascii?Q?WMVpIp4yvgt7tfpQDl2Siv+K69901EfqPHhra5/CBzm2NTRISVYS44b4fKTx?=
 =?us-ascii?Q?8UYB2PELz9TfcAiXqFUDcZv5Riv5uAvqxF4Ggj+9OKhg2CxXvPOL9hKeNQo/?=
 =?us-ascii?Q?bR7w6tqYobFcoCSUsOzI6HbpgDPAXajvRXsdZmY+MkNP6ae1Qq7/HSGpDBjd?=
 =?us-ascii?Q?DDvhWiFvYWUpQ0F1rf1kf33Ea11HxwZRw2CsuxQ1iNa+Y1sqzQrjILC+/AiR?=
 =?us-ascii?Q?EjynHcbJ5Nf0+VIOa1OMNmq5VECnn8Jg0TQk18Rah8/6yT/zww3KolQhbETh?=
 =?us-ascii?Q?S1La4pj2azlbRQuoY79/rHxJscPC4xUwKfOpK+qrbp/S0/++tR2KB0W5gKpm?=
 =?us-ascii?Q?Yv43WM1zOiAHIUcPNyn2g1Onu1c20AdT7KSy9piNQT/W1sDrosb2zCRBPjfg?=
 =?us-ascii?Q?A48YbC+kyZOhLoWVj+CFcz+WasSA0PpfDIjntMUb3Yao64iSIvNjmt6jW5Zz?=
 =?us-ascii?Q?3mhTjB/bxygCGRcC+/NXlEUAHFCa8n50Z1Cu4EJ9xCzAQlS0sx6q67Uxe8cB?=
 =?us-ascii?Q?xNVVv9ho5swLUzx3/kclnOW2EEgs770Ft6xld8K42ImAFzgQfslV/NDK5fHy?=
 =?us-ascii?Q?n1MZAL2VkWb61AU7Hw39Y5I4/ULuUIxKiD6lATRMWU/DCtSZ3gZsjSxeWw2F?=
 =?us-ascii?Q?4OhKDcpkmg1g9wCEi1Xl3M/+ad3NF0X7ZCcwwLqmvcOB7l8B1lJmBrIHtqli?=
 =?us-ascii?Q?+DYj/Bs0WcSfoQHuGg/VyUuf9zHwT2bxuizgFipvyf0awhuvmlD+E/Ymmav+?=
 =?us-ascii?Q?E16OA3x0xFQIYUcRWhPA2thzxQNqxl8KMdrc+PwG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b095422-695a-40a5-8d7c-08dc81a92e7b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 19:38:01.0553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWsGQhUWwc2x5cUZMgYWhQKuj4QOF02GdLQr7P4agS0ghaK5XJypRrB5d1JvqvcliTpJS+wLrYAUOF6IhgMAfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9679

Convert layerscape fsl-esdhc binding doc from txt to yaml format.

Addtional change during convert:
- deprecate "sdhci,wp-inverted", "sdhci,1-bit-only".
- Add "reg" and "interrupts" property.
- change example "sdhci@2e000" to "mmc@2e000".
- compatible string require fsl,<chip>-esdhc followed by fsl,esdhc to match
most existed dts file.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    pass dt_binding_check
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl-ls-esdhc.yaml
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      CHKDT   Documentation/devicetree/bindings
      LINT    Documentation/devicetree/bindings
      DTEX    Documentation/devicetree/bindings/mmc/fsl-ls-esdhc.example.dts
      DTC_CHK Documentation/devicetree/bindings/mmc/fsl-ls-esdhc.example.dtb

 .../devicetree/bindings/mmc/fsl-esdhc.txt     | 52 ----------
 .../devicetree/bindings/mmc/fsl-ls-esdhc.yaml | 98 +++++++++++++++++++
 2 files changed, 98 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl-ls-esdhc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
deleted file mode 100644
index edb8cadb95412..0000000000000
--- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* Freescale Enhanced Secure Digital Host Controller (eSDHC)
-
-The Enhanced Secure Digital Host Controller provides an interface
-for MMC, SD, and SDIO types of memory cards.
-
-This file documents differences between the core properties described
-by mmc.txt and the properties used by the sdhci-esdhc driver.
-
-Required properties:
-  - compatible : should be "fsl,esdhc", or "fsl,<chip>-esdhc".
-    Possible compatibles for PowerPC:
-	"fsl,mpc8536-esdhc"
-	"fsl,mpc8378-esdhc"
-	"fsl,p2020-esdhc"
-	"fsl,p4080-esdhc"
-	"fsl,t1040-esdhc"
-	"fsl,t4240-esdhc"
-    Possible compatibles for ARM:
-	"fsl,ls1012a-esdhc"
-	"fsl,ls1028a-esdhc"
-	"fsl,ls1088a-esdhc"
-	"fsl,ls1043a-esdhc"
-	"fsl,ls1046a-esdhc"
-	"fsl,ls2080a-esdhc"
-  - clock-frequency : specifies eSDHC base clock frequency.
-
-Optional properties:
-  - sdhci,wp-inverted : specifies that eSDHC controller reports
-    inverted write-protect state; New devices should use the generic
-    "wp-inverted" property.
-  - sdhci,1-bit-only : specifies that a controller can only handle
-    1-bit data transfers. New devices should use the generic
-    "bus-width = <1>" property.
-  - sdhci,auto-cmd12: specifies that a controller can only handle auto
-    CMD12.
-  - voltage-ranges : two cells are required, first cell specifies minimum
-    slot voltage (mV), second cell specifies maximum slot voltage (mV).
-    Several ranges could be specified.
-  - little-endian : If the host controller is little-endian mode, specify
-    this property. The default endian mode is big-endian.
-
-Example:
-
-sdhci@2e000 {
-	compatible = "fsl,mpc8378-esdhc", "fsl,esdhc";
-	reg = <0x2e000 0x1000>;
-	interrupts = <42 0x8>;
-	interrupt-parent = <&ipic>;
-	/* Filled in by U-Boot */
-	clock-frequency = <0>;
-	voltage-ranges = <3300 3300>;
-};
diff --git a/Documentation/devicetree/bindings/mmc/fsl-ls-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-ls-esdhc.yaml
new file mode 100644
index 0000000000000..cafc09c4f1234
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/fsl-ls-esdhc.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/fsl-ls-esdhc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Enhanced Secure Digital Host Controller (eSDHC)
+
+description:
+  The Enhanced Secure Digital Host Controller provides an interface
+  for MMC, SD, and SDIO types of memory cards.
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,mpc8536-esdhc
+          - fsl,mpc8378-esdhc
+          - fsl,p2020-esdhc
+          - fsl,p4080-esdhc
+          - fsl,t1040-esdhc
+          - fsl,t4240-esdhc
+          - fsl,ls1012a-esdhc
+          - fsl,ls1028a-esdhc
+          - fsl,ls1088a-esdhc
+          - fsl,ls1043a-esdhc
+          - fsl,ls1046a-esdhc
+          - fsl,ls2080a-esdhc
+      - const: fsl,esdhc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: specifies eSDHC base clock frequency.
+
+  sdhci,wp-inverted:
+    $ref: /schemas/types.yaml#/definitions/flag
+    deprecated: true
+    description:
+      specifies that eSDHC controller reports
+      inverted write-protect state; New devices should use the generic
+      "wp-inverted" property.
+
+  sdhci,1-bit-only:
+    $ref: /schemas/types.yaml#/definitions/flag
+    deprecated: true
+    description:
+      specifies that a controller can only handle
+      1-bit data transfers. New devices should use the generic
+      "bus-width = <1>" property.
+
+  sdhci,auto-cmd12:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      specifies that a controller can only handle auto CMD12.
+
+  voltage-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: specifies minimum slot voltage (mV).
+        - description: specifies maximum slot voltage (mV).
+
+  little-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If the host controller is little-endian mode, specify
+      this property. The default endian mode is big-endian.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: sdhci-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@2e000 {
+        compatible = "fsl,mpc8378-esdhc", "fsl,esdhc";
+        reg = <0x2e000 0x1000>;
+        interrupts = <42 0x8>;
+        interrupt-parent = <&ipic>;
+        /* Filled in by U-Boot */
+        clock-frequency = <0>;
+        voltage-ranges = <3300 3300>;
+    };
-- 
2.34.1

