Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022109.outbound.protection.outlook.com [52.101.53.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23630FC11;
	Mon, 22 Dec 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393139; cv=fail; b=cJtfOfSgrJkU0eNJMpvCbpsC3XrU/b5BJbvYzEHv7iU/F4CSSV3ydgexmH2Tt7Ifo2PDqik0dbabZ+o+k41pZ/mL5B+E6fLhv8RNIwMkkot6YQDmGSefR/sgOW2GMn10AEmMEOHqfjHqgWF0ol9oAWnBQIKbRBP+YvDqcASzh3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393139; c=relaxed/simple;
	bh=pMFJu7kVIw05IhwAo2TgmvjGlVLGIx60vZAOe2uICiU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DwIaGYLEM4aF8Zl+IcndkqrGp+BoARUsQmN6aODQqEQpD+KQw5yDc1uBp9/VtzZVoRNNFqvvwKiaYqRVE2LdyV55XtgbafMcRi2EC0GnLXh4L1kgWhS3cDfCEh0Mggk9qCdm21P8M/wKEQlH9/Arp+58bKo51FiyYGrZNG2+/JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=gSz0aH8j; arc=fail smtp.client-ip=52.101.53.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="gSz0aH8j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUdSwOUsdKZ+kT2s19XshgIsGQhFovzh4ztnwtVHpXnbVGJ9aW82I8rPlLnN6pPLO8gONqUrmWr25sAUAIggIwQitVndA1xjdK44C2LES1dl6jy1X8M9nNG4YcvwmMe3ztn/pkPfKQ2rMsz6ilfjLSDluKHxsO+Xk79VpZ6nZzMwY0r6BJf3/HTAyWgrWSTqcf/1rwtb4sYD5+8r3IQKW41DsK/YVejPX1IdBOdLjM3LU9CTSn57KdHLGPaig3t/tTRWyGwxOZU478YXFkNmpb0U9nNOjdsDG8Y+GVYT9yEu+Ee7kCcA0W/zlHlHs+qNY3JRAE/yNT9AAuEd2bUOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsBP5PHjG2j7Asgtrld/kjyEV8S8WM3T1GwOgTJR3DM=;
 b=SHFFR2QqsO/CTdmu43odAR3YzHKbwbrn9jAq+XEBYN9D8yKEuAR/oFIySqQCfYB0nIEIPclBFxvxRbW35pIaI6F8yrc2tolzr+1WwAKNMIOGQguLqHqdVjp12Qj/GiY1RqgSo8dxt8MnxnKckiFRh+XIJNYuw0d3m6ryX6YuJDf5E26OfW8RkMKTRVCmK40p4menplSFkqYcTEFuJtOLZAVitFi4lfhWw147uA9gLVbs069evnQqW5FyfyTwN2hx4ZO8Q9efK3p6fNzfFpJ9Dcv+Rh0+FFIX623i8D3CL+JTJHBbO4TdVKueka5ouU9vyLFNqfg4wcu5GSkgs0fv2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 4.227.125.105) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsBP5PHjG2j7Asgtrld/kjyEV8S8WM3T1GwOgTJR3DM=;
 b=gSz0aH8jyQN6d+EH0k7tgHa6XgnPl8BMPIz9iIwXaunnLqd9w9LeTm5Bq1h53xOY3fhi+D0mCntj1+WpInWwS+agYGYlhuzDuQpdS36Wbt3ImVR4hGl4Z73v7mk69M6bYFvjSKEMY0cf5zYxPHq8KlIjINbgUi0JqyLAeZ4DAZY5vACDV79uYu9cV1mkQ25g5T8Rwg1f9zSC1ZixC7qeglBqjAf1Mrz2POlpeZKWljL1ZNa0eVwZrVV3Q/6XP6Pud/X00gdbK+Nnwpkgxc0DJwdD2Sfpb1KrFSt3AXZYsipadORCzpQHg7UxBz7yVU3jr+cJbmGXyjLfRF4phi4UPA==
Received: from PH8P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::10)
 by MN0PR18MB6013.namprd18.prod.outlook.com (2603:10b6:208:4bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 08:45:32 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::e2) by PH8P220CA0019.outlook.office365.com
 (2603:10b6:510:345::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 08:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 4.227.125.105)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 4.227.125.105 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.227.125.105; helo=[127.0.0.1];
Received: from [127.0.0.1] (4.227.125.105) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.9
 via Frontend Transport; Mon, 22 Dec 2025 08:45:30 +0000
From: Tzu-Hao Wei <twei@axiado.com>
Subject: [PATCH 0/8] Add Axiado AX3000 eMMC Host Controller Support
Date: Mon, 22 Dec 2025 16:44:59 +0800
Message-Id: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAwFSWkC/x2NQQqDQAwAvyI5N7CmFrb9Sukh7Maag+6SWBHEv
 3fxNMxl5gAXU3F4dQeYbOpalib9rYM08fIV1NwcKNCjJyLkXTmXhnsIATlnlHlOOBVfMZtuYui
 /WoutSCnFgeMY45OhBavJqPs1e3/O8w9clHZ3fAAAAA==
X-Change-ID: 20251222-axiado-ax3000-add-emmc-host-driver-support-2cc84a8f889a
To: SriNavmani A <srinavmani@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Tzu-Hao Wei <twei@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3510; i=twei@axiado.com;
 h=from:subject:message-id; bh=pMFJu7kVIw05IhwAo2TgmvjGlVLGIx60vZAOe2uICiU=;
 b=owEB7QES/pANAwAKAXgQMF3EWvHXAcsmYgBpSQUl46/b6nDQfNEsOY876lwJmzFdij6Qt6ukG
 RjH84jsl7uJAbMEAAEKAB0WIQSZyWINOowtFmDvdYF4EDBdxFrx1wUCaUkFJQAKCRB4EDBdxFrx
 11+WC/9ZYfwAb/fl6/jX1UxHwQBlanP1Vv2T4cJ1iLcNrLPAn88Wl4vmF8veNXDf58/vUR/aIcV
 gIobezQ/S57AkIcHKa0IF5WlnbDHYBOr9vKLVg8K6zqw86WhWh723G+9q4RY/oOdV6WibyFXhDy
 fq6qV40aTFmer46Xjso+3636+VQpggSGw9fF9cW9nXqxfpnPUnShL2cxHguCLFL6IJHyJC6lSia
 kTxa7PHwdENjEKDxPDIpG8k40CDL4AesIhcX+1jEweO0G1GvNh3GNlgZW7y/rLT+X9zo91K6usQ
 SEnorRwree4mHw/ZnyiRfAGqyucnRo0ZoFtdCRvVTplNe0WjBLIpzvSgfsy68mfgSSz1p7aiZpq
 EJBddbMQTU7ekcqVuKhUBukt09d9slYOJoHpYskHr3bO8/xqOP8T+xXXvTw71GHNhijBn9i0wzY
 hiMiuEtK5Y7ieqAOYmKvnCp5IVubj6+k+yQoxFUTmY2OX2t2R59Ia9C2EvJoJwZu7hfdc=
X-Developer-Key: i=twei@axiado.com; a=openpgp;
 fpr=99C9620D3A8C2D1660EF75817810305DC45AF1D7
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|MN0PR18MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: adce92b2-f031-490c-df71-08de413676d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|36860700013|376014|7416014|1800799024|82310400026|42112799006|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1lMVGVZdlVWeSs4MGo1YWtXVHdZc1dSUS9UaXJGUytCbmpvNU8yM2NEMnNr?=
 =?utf-8?B?d093TXUxSk84RWhBanArTUdXdVdBWGYzUmsvS0pwRkJwcFRYZXo2SE85RGhm?=
 =?utf-8?B?bnJxOXV1MCtMYWFaR1VLVHhIR0I0d1NUWHRmTXBwQS92cHNnM1pZc3JNWUNy?=
 =?utf-8?B?MEh5aXJnK2FxMnJEZVJCQUxTaENLSWpOSUJOaEEyTXh3YkpEWWZXYnlYbTBH?=
 =?utf-8?B?dEJydjlhNmg3Y0dKcFI5NnQrQ3JMdWV6T0xFc0dUTEhnenI0Zm1lYy96Nzlr?=
 =?utf-8?B?emNGRVhsa2xCd2tmZ2E0Sm1RZEMzN1Q4aHBKT3hZZ2ltUzl4cWlUeTZKV0hz?=
 =?utf-8?B?cE9HZlZkQVVZbTNMRmFaVWxaWG51WCtZVHZuazZJaVFCQzFNVEtqSXI4Rk1Q?=
 =?utf-8?B?R3k5L3Y2eDVtcFQ0Y1JTVDllUUFHeXl1bEhXcTdGQ3o0Vm5zNm12VTBucUlT?=
 =?utf-8?B?VDhTdkJOVU9CNm9KQjBEN1N1YTB6SnE5bDFQYUE5dEZMb3RuTXNWRzE4Wldv?=
 =?utf-8?B?ZGhlU3JMd2VPSGJtRUdOLzVvdzZHOEt2NDRETGE5N1gxTGhWZHM3MHFKSVZC?=
 =?utf-8?B?ekpDYTliaXRxa0hZVnlvQmV1YmhOcXhsNzJEZkR0MkRYaXVGRCswRDAva2lX?=
 =?utf-8?B?QitKUHRCcmZuRDM5Q1BhR2xYVk4wTXlzZGVUNHZScXNhY2lDVTdlWFhLSXRm?=
 =?utf-8?B?VmZLRVE4aWF5UUJuUUs4NjFWTFhnTE9nK0VMcEtqMzNJbStJR0N5VTRmblBp?=
 =?utf-8?B?Q1BQYSs2YVFycmFBNkFnVWZPQm1tUTJORm5uRDI1ZlBPMTZ5ZkdxOWpSU3Ar?=
 =?utf-8?B?TTNmRms2QVNFNndmb25OazVtMWR5ekthajEyUEdRVXJTbk1PRWQxb3JsTUk5?=
 =?utf-8?B?WGtEdDdWOWR2Qm10YVFWV1JUUjgrdVh5NFZKY1BZOVAyMzJ6RURpQVlkaEZJ?=
 =?utf-8?B?MzFkQmsxN1U3UzA2YlVFbjBZRGkxcCtvenI3T0czYTJScmlMTE5yQ0szOTJs?=
 =?utf-8?B?OWltdlNQSUo3NVpYZk51VGpZMW1RS0xFU3AzY085WFJUdXQ1bWFkT0xrQ04v?=
 =?utf-8?B?ZTgrQjN6WGpVSjBRWUN6UXVaZnZMUk1MVTE3UVpzTktGRENralpieWY3dDN6?=
 =?utf-8?B?OGZuNlV2RnpNbC9XS2EzV3FVTm8veGtyOUhPTGRnUUt3b0thTmF2eHV3S3J6?=
 =?utf-8?B?ckI4OEVveFlZY0luVmwvd2djZFluN1FpSnMrM0I4Q2x2OTI3YWpDSlVWMlhY?=
 =?utf-8?B?MCs3YkVQSTJhMlVzS3IrVC95TUg0aXRETEt3cGdKYmlkRHU5UXBVU3Fac2Z4?=
 =?utf-8?B?dUhvQzRWTnNueXFpK3M3RDJoVFJLdFoySnYyZlpXQzA5NlpmYnJUTnRyREZ5?=
 =?utf-8?B?dHViN1IrWFhlOHNKazlXSmdyMkFmNnhhSWx1WHNJM0ZHZHVReVZyY2thU0tt?=
 =?utf-8?B?T1kyZDFyM2QzMEhiZ0JreEZaRDM3Qmk1NGxNdmxmeTROYS90TjRFekpyNFdy?=
 =?utf-8?B?cG9xckVhVmdwcjRtR3JsWndEQXF4YWNXRXRqczJEM1o0VTZneE9POE5jS1FG?=
 =?utf-8?B?K0ZuN3hGR2VMSEJNWWc4U1hBa01lTGk0a3BoUUVhWlRCNnFzWUdtR0V2Vm5S?=
 =?utf-8?B?VFhMY3lDNU9DN1lCb1hzL2JVYzk0QVFucGt1SUV1S3ZBbVRRVGFQYiszK3RE?=
 =?utf-8?B?dHFiUCtpeGduLzEvT1ZaS2ZNUGkvRWJ1M2R6RmpUTi9DcFV5a1F2L2l5aVFQ?=
 =?utf-8?B?YU5laDBiSUhZb0dUenRjS09aZXk4UFVqYUdQNVpabW1ZVWU5OHFGVFVCTTNv?=
 =?utf-8?B?RUFkNHdjb2poekU5Sm9nNXVuVWIweDdpRlZpM2FUSEw2N1RGMTlTZWlGVllS?=
 =?utf-8?B?QitKQ3gzR2VkN0h6djljaUMwRVEzNms0MU9aY3hLRDVJbktYaFlPZWc0aGlT?=
 =?utf-8?B?V1NaWFBGVlNROTZCaFpKVW9HWGNlNDAycmIrL04wVHF5MW9JRHl4dkloWkd6?=
 =?utf-8?B?N0JYY3FGaWZIenNDZkh1S2tFL0tJeFFpTGNzdlY2aHROdVNvWVB1VjJvcUlE?=
 =?utf-8?B?bG1Dbng4azhmb2dqOVBzdXRMV1JWK2ZwSi9ZTVc4UWRIRTNTTUhDelRPYlNo?=
 =?utf-8?Q?dhasssgoZ2qN7q5/0XM7LPV2O?=
X-Forefront-Antispam-Report:
	CIP:4.227.125.105;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:[127.0.0.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(36860700013)(376014)(7416014)(1800799024)(82310400026)(42112799006)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 08:45:30.0510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adce92b2-f031-490c-df71-08de413676d3
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[4.227.125.105];Helo=[[127.0.0.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB6013

This patch series adds support for the eMMC host controller found on
the Axiado AX3000 SoC. The implementation includes support for an
external Arasan eMMC PHY that enables HS200 mode operation at 200 MHz,
significantly improving performance over the default 25 MHz operation.

Hardware Details:

Arasan eMMC host controller on AX3000 SoC
External Arasan eMMC PHY (different from internal PHY supported
by the standard sdhci-of-arasan driver)
Support for HS200 mode (200 MHz) operation
Integration with existing SDHCI framework
Implementation Overview:
The series adds support for the external eMMC PHY required for HS200
mode. The existing sdhci-of-arasan.c driver supports internal PHY
configurations, but the AX3000 uses an external PHY that requires
different configuration. The PHY driver was implemented based on the
reference code in sdhci-pci-arasan.c as recommended by the Arasan team.

This series includes:
1. Device tree bindings for the eMMC PHY
2. PHY driver implementation for the external Arasan eMMC PHY
3. Integration of PHY support into the sdhci-of-arasan host driver
4. Device tree bindings for the eMMC host controller variant
5. Device tree source files for the SoC and EVK board
6. MAINTAINERS file update

Patch series structure:
[1/8] dt-bindings: phy: axiado,ax3000-emmc-phy: add Axiado eMMC PHY document
[2/8] phy: axiado: add Arasan eMMC-PHY for Axiado
[3/8] arm64: dts: axiado: Add eMMC-PHY node support
[4/8] MAINTAINERS: Update entry for Axiado eMMC PHY
[5/8] dt-bindings: mmc: axiado: Add axiado eMMC variant
[6/8] mmc: host: axiado: add AX3000 eMMC PHY support to sdhci-of-arasan
[7/8] arm64: dts: axiado: add common sdhci host node in dtsi
[8/8] arm64: dts: axiado: enable sdhci host

The driver follows the standard Linux PHY framework and integrates
seamlessly with the existing SDHCI subsystem. The implementation
maintains compatibility with the standard Arasan host controller
driver while adding the necessary support for the external PHY.

Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
---
SriNavmani A (8):
      dt-bindings: phy: axiado,ax3000-emmc-phy: add Axiado eMMC PHY document
      phy: axiado: add Arasan eMMC-PHY for Axiado
      arm64: dts: axiado: Add eMMC-PHY node support
      MAINTAINERS: Update entry for Axiado eMMC PHY
      dt-bindings: mmc: axiado: Add axiado eMMC variant
      mmc: host: axiado: add AX3000 eMMC PHY support to sdhci-of-arasan
      arm64: dts: axiado: add common sdhci host node in dtsi
      arm64: dts: axiado: enable sdhci host

 .../devicetree/bindings/mmc/arasan,sdhci.yaml      |  18 ++
 .../bindings/phy/axiado,ax3000-emmc-phy.yaml       |  46 ++++
 MAINTAINERS                                        |  10 +
 arch/arm64/boot/dts/axiado/ax3000-evk.dts          |   8 +
 arch/arm64/boot/dts/axiado/ax3000.dtsi             |  20 ++
 drivers/mmc/host/sdhci-of-arasan.c                 |  20 +-
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/axiado/Kconfig                         |  15 ++
 drivers/phy/axiado/Makefile                        |   1 +
 drivers/phy/axiado/phy-axiado-emmc.c               | 260 +++++++++++++++++++++
 11 files changed, 393 insertions(+), 7 deletions(-)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251222-axiado-ax3000-add-emmc-host-driver-support-2cc84a8f889a

Best regards,
-- 
Tzu-Hao Wei <twei@axiado.com>

