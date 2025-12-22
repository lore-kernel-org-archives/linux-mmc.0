Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020137.outbound.protection.outlook.com [52.101.85.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CABC31064E;
	Mon, 22 Dec 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393148; cv=fail; b=eNaLAOos0+721qwFpe0+Wfr66HIme3oVYXH9Vn8Vf0WQ4vDM3nK7EM38kgu0eUiZ5EQUaNSj89wqhoWJ4tVYHCUB/7hec5oP24u9OQED3MyszKxsRplVk8su5OlCo19H1gwdDaDrZkn6u07Tg9KF1epffUknssB505YNgnxJX4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393148; c=relaxed/simple;
	bh=fg9jaFFngLS8v6ndEP4j36QPY36wXRIZmJ17G9eUfgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxpZc6Q8yYZx9+ynYNF352DitbOloOdZuOCJFRsu/z+BXmbplkx9yxOZxhoKnvyt0G1L7Ag7DHJnVxIwe4R6JitJ+GlNRDL6zdhg06Dj+yPD6hoy479s6VlfOk1UKorn9dVNNeWHja7VM13kOoCXemgbP5B1umOw1CNg2MPi/rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=ei9A6m7S; arc=fail smtp.client-ip=52.101.85.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="ei9A6m7S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdKT1gfkCUDa6A+nFZAM93XCqtZ9uKZLbRcv2r1EKi117zF6NhP7Uq0vz3NCxVKbJ9QjoOjAXJNL0Sr5mF5tdhTFsp5woo6zo7Ecppq6yGj2nSOZEfnguMYOab8bpx5biBL47qWMAxVMKqMa03k2yR18D7oQb8uZXJKWU2ArZmGzeBrz0ETzrLq1dmdl+ozFBwIprGCcWYhUFY+fpO0i6v3qBCJfIAeTbd0oh+uAjE3futg3HpS/vYGzCEW4zk67y/YgwUt776oSkPiN3WYOoipmJ8KOYR8PriU0P/IJPvctx+v/2eSrofFbT/I+VRqNJX2SPnV5M7lJC4edCWAcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wWCXQz98UCyuiqTFgm5x6OhS41AolvuX4WnElCyQvQ=;
 b=X/Njgm7X7xug4aY3Oixb44+EVLQPNCWRAitmkNtQJw1Xsz4kwrz4ee9LvBIwxgLGMFLnYWWGWGuoU6RU6wRPGKHRshXT5DCelatSvduzAB4LVP+uNISn63MEGu6BIrUjWNe5gRetmYrEszZGpk2GCYcSbLqonEeYaoZ/c3Z5Iou6JbTlgr3FTruvKyIje19tndOKC47A5EKf4KvCY0LMSQhiaUI9EODp76isKHmu7heuXNPVehjxQu/c8fEZ9/NpcjN/IgMFWaUQ0+DYrD7Uxlf0tBQVwLHP6zHX0pDpzH0ENNjr8vvT+d7QiHWnghMdOcwXHzvZ0nbOlgpYhAYW5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 4.227.125.105) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wWCXQz98UCyuiqTFgm5x6OhS41AolvuX4WnElCyQvQ=;
 b=ei9A6m7S3vKKU8Sn+3VfY1M1w3lxeY2qHS1yhLT91TNoXBMcSEjNDuXMT6Z/fRmjSHZNfB7HD4bGct38YZm3wvLHE8XVqVejfAsjeDEoNQ16YX2gqDYQt+ttsE4ZtKmRup6LRlpmxzuvkfZIKTkdvvhBVm8q5I2lXT1yi+6MGLS9RxuG+Bob+AxSKIEFWSUAG9v8XJRyWUvZqV0P+olVqfnOuWCpCXiqN3AAIhQ5ERK+HrGtbrHdsgxNWx0Ii1C/Fq+HCTfTfMjmB0CtAmcHpArzgG29J1Lowikqt7nKhB2UZRdQ4Im1nmn4qyCg0DyfXac9cZIaozbDTW1x5Gyfag==
Received: from PH8P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::26)
 by IA2PR18MB5962.namprd18.prod.outlook.com (2603:10b6:208:4b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 08:45:40 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::31) by PH8P220CA0016.outlook.office365.com
 (2603:10b6:510:345::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 08:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 4.227.125.105)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 4.227.125.105 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.227.125.105; helo=[127.0.0.1];
Received: from [127.0.0.1] (4.227.125.105) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.9
 via Frontend Transport; Mon, 22 Dec 2025 08:45:38 +0000
From: Tzu-Hao Wei <twei@axiado.com>
Date: Mon, 22 Dec 2025 16:45:03 +0800
Subject: [PATCH 4/8] MAINTAINERS: Update entry for Axiado eMMC PHY
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-4-5457d0ebcdb4@axiado.com>
References: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
In-Reply-To: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=twei@axiado.com;
 h=from:subject:message-id; bh=Xhsp6Uv57sSRPR7NRCZO4haA5giCEFQpAX9e5bNVj80=;
 b=owEB7QES/pANAwAKAXgQMF3EWvHXAcsmYgBpSQUnxjPiAIoTpK+MYuUmveAfCqs1866sEh2rx
 /04kTjarXWJAbMEAAEKAB0WIQSZyWINOowtFmDvdYF4EDBdxFrx1wUCaUkFJwAKCRB4EDBdxFrx
 1wDoDACitK69SWl7lEDFfSyuxkhUdKDGnpgSxX5ozY4e9DmZH9TmPIv3pOXZWW4+3wT7ZtvfXN2
 DAJOUYK+uzlwUk6zZMw4Vvt5z3ldrEvR8kpoBDNltT4uSBsUeqwtAic7UtPqbKEbhVjfEjGK7LN
 RS+Es9Jdi/pzEj8Inpn++s4zQ0mwhP5Y97mWTEHBcIsKKo/J0Bs772RCGCLKYGMeXe7r/lzPSa9
 ntRH+RrBzqD50COD01AarORkX8dt0E11cNdzPIwAYOLayA7x8CbGXUPUrC/QZpeJcpQcW4Kj1MV
 tSg/Mr+qHpoITLF4fAsLnXSylNAn+/Gyc68Bh3f/l06527MuGYkawOJuvyfBCsop/P4eFBMbPZJ
 zmNT7/0mz+yl5X0EfJW0Be+BETC5BN4v7+sy9blnHfv9JOB6w5YjxiuxzM97lZSVlBS6N6ZyEVm
 /g4wybwhh+78VdndA2PofB+yC4jZ4fIf15tq+35mb/Hy4WW6smfwPB706bCZUZcWcnMag=
X-Developer-Key: i=twei@axiado.com; a=openpgp;
 fpr=99C9620D3A8C2D1660EF75817810305DC45AF1D7
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|IA2PR18MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 698b35f7-f2a9-46c1-397b-08de41367c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|34020700016|42112799006|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTNDblFiSGxDMnZBYzdyU2pqcWJOQ2N1dVlpclVLWW8vQmF4eG1qWXptVkJQ?=
 =?utf-8?B?d0NNRE9GVjhMWXF0K1RKSENnZVlQdFpTZWFNUTlGc3hKL1d2cHZWWGlVbXhQ?=
 =?utf-8?B?bVllalpJSHdCK290OUxQNDRmWUE0aXE5elZLYTdHZm5UcWV2dThES3A4eEk3?=
 =?utf-8?B?VXhPbkQ0eFN0ejZHZFVEVGRUeVo0emZTY2czNWphSWw2RDA1dTRuN29OeGFU?=
 =?utf-8?B?TnYxQVZ5cXUyZEQ1NjgyVHdTRzJSOXdSSHJ4RWd2dXVkdXM2WVpEc1lJYVVv?=
 =?utf-8?B?Qmo3Q2lXcmoxN2xybGR2U0xxbDJualFMN2tnbGhUV2VBTTdtSUx1WTB5TzBV?=
 =?utf-8?B?UU8vMDFWQWMrOGt2cXQwd3RNMzUvcm9CK1dnUVFVSjFZOFphODRNdUY2V1dn?=
 =?utf-8?B?QUw1RW4xVkhOb3VNL2IrdGlyRmR3QnNUWjhWZkFCejVhSlFWTW9lUUdxREsz?=
 =?utf-8?B?YS9jcG8vSnNPWmtlVndkV2h4ZHloa0h6dmlHcUtOMk9oNlBnRSt2RFhvYzdJ?=
 =?utf-8?B?WmhGUmRIK01TQlYrT05BUVJoVU0zZks0NE9EZUVNaEpFaXh5Uy9MYkFud3Y4?=
 =?utf-8?B?bVpjdDVER0h5bnFDaE5zNHd0UEkweEVmRDFaTW9qc21YUTFoTHpQeG1Bd3lE?=
 =?utf-8?B?MTU0UHZRbDdoRUNRZTY2eGtjaWRoYVJjTEZHMVlkWDRwNTcwcjNQaU1kVTQ0?=
 =?utf-8?B?bk9oMmxGWUtkYkxvNENJM2t1c295L1owaGcxMlY2Tlo5NUlmdnBtaTBwRU1T?=
 =?utf-8?B?TFVRVU9yU2YvTWN3cWpBb3FRM3RFWWx4dTc3amwrcHJHaUJRcFlQRml3TlJ5?=
 =?utf-8?B?dTlFVks1Mnlxa2JTNmdUZU5GLzB1R0Nld3JLaFBacXovem9IbDdFUXdRMXk3?=
 =?utf-8?B?SW51RkVnNmUyMmxPT3NqeGpzNktROTJYMlJhczJIV0VBUjVUMUV5R2h5dHlQ?=
 =?utf-8?B?QTdFMnVpQVlKWmJ5cStRc1d6TDEwQ0Y4T2s3QmJnZEVFWHFxTzRKS2NQd1o1?=
 =?utf-8?B?cEpEQTcvRUJJNkhlanNXYnBITlFRV2JEekRHaVVycWtaa1ZkUFNPcWhDK3JZ?=
 =?utf-8?B?R1h4YTVaUjR4WHU2YStqNEc1YXdmNFBIU3c2K0RQYnV3R244TlZFN2M0NXVE?=
 =?utf-8?B?TVU1S3dOY28vYVhxK05STU5IS25BTXlpMFFNdVZTa2dvbUFWNmszOGxhQmRq?=
 =?utf-8?B?aTVtdUFqbEFTVldwTWhUYndCbnJKREV5OCsyc25lUXFQYSt1MVNkOFd3Q2hB?=
 =?utf-8?B?RG8vc3lLWXdXa1htNFNNciswS2kzZGpMZHpub2hRR2E0cEN0QzlNdUFzK3Qx?=
 =?utf-8?B?THkwenVoaVoyS09uYU9MVXVGSWhJVW1LdmNXTVVzNytRY1d0VFhOVVZuMXF0?=
 =?utf-8?B?NjVUeDR6S1lZaUpGYUZWY2JSdFZWTmpPdXFJRExmQ2c1QVNuenRFOGZZenpw?=
 =?utf-8?B?NG41QUVFYm1BSjc4dUZFeVplSXhUZEkybzVDS0ZDR0JpTnVoWFVUNVBRVDJl?=
 =?utf-8?B?ZVdOaXBhckhCZExka1NmTGdRWTEzaXRvNXByMmNjYlZxUEpuSmd4bTd4STZ4?=
 =?utf-8?B?cVpqL3JnQ3VsUEFIeDhBcUVjUDhaNitiU2lDZXM0ZjRxQnI0MG9lYWFUS2dT?=
 =?utf-8?B?UTY4QllGc0ZLL0k1NU9NS2o0RE9xd0VpM2x4VCtIZGVUcEt3RGNrQjlXUXh4?=
 =?utf-8?B?WGV5bktQbFBnWkRSNmkxMGMxa2FpNEZ3ZGVXY2RBMzhFbWVUck9PcUF4WXM4?=
 =?utf-8?B?OVRPYTRIWTYrb0xnVVRId0JRVW4vQ0RGdDBzb1pPaENla1N1UGlhT0wycTRt?=
 =?utf-8?B?VDBuaUU0S2QxOTkyd0lpTUY2TU1PSm1aWlNoVzRkbjNTeFNYZG05K3p6MGJV?=
 =?utf-8?B?YTJIQmVPWktzQmxITE1nS0tQaC9hN0JJUzVUWEllOWhDNEtuRnBFM2YrWGJR?=
 =?utf-8?B?QkRjc0s3L2pCam9WVzcwYzFZVUtVUE00SWdvR21yc0JRMmM4MTlFTDZieFVx?=
 =?utf-8?B?WGE0SDQyWFJTc0pqY3dWUXhVM3NvcU1FcFFrZmJwV1o0ajhKRnZtU2xGaWVx?=
 =?utf-8?B?SUwrUG9GdDZrTVhWRjVnWGo0SWpyWVl5TE9LLzdwTmtzVnRLMjRLSFF3eFB5?=
 =?utf-8?Q?IQ2oRzfvPcBcYTszRjR//eMyy?=
X-Forefront-Antispam-Report:
	CIP:4.227.125.105;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:[127.0.0.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(34020700016)(42112799006)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 08:45:38.9026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 698b35f7-f2a9-46c1-397b-08de41367c0d
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[4.227.125.105];Helo=[[127.0.0.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB5962

From: SriNavmani A <srinavmani@axiado.com>

Update the MAINTAINERS file to include the Axiado eMMC PHY driver
files. This includes the PHY driver source files, device tree
bindings, and related configuration files for the AX3000 eMMC PHY
support.

Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc731d37c8feeff25613c59fe9c929927dadaa7e..d14f2d1c94bc65879c922401366f98a812dd3ba9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4250,6 +4250,16 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
 F:	drivers/hwmon/axi-fan-control.c
 
+AXIADO EMMC PHY DRIVER
+M:	SriNavmani A <srinavmani@axiado.com>
+M:	Tzu-Hao Wei <twei@axiado.com>
+M:	Prasad Bolisetty <pbolisetty@axiado.com>
+L:	linux-phy@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/axiado,ax3000-emmc-phy.yaml
+F:	drivers/phy/axiado/Kconfig
+F:	drivers/phy/axiado/phy-axiado-emmc.c
+
 AXI SPI ENGINE
 M:	Michael Hennerich <michael.hennerich@analog.com>
 M:	Nuno Sá <nuno.sa@analog.com>

-- 
2.48.1

