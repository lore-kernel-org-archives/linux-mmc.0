Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2106.outbound.protection.partner.outlook.cn [139.219.146.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE03404BFF;
	Sat, 19 Sep 2026 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789811107; cv=fail; b=NuYMr/ofCea8ID5YL4Zw7ufoyooIGRaMt+UAPDv1yS5NMVNNlYRunl29aM31feNZ+obnGHC6TCDzmHvX1nfgHyncsbA2FC0c2RNrcI2XmFITtbe9j737dl5et76SKjPquFwrD4TE0Ia4Fce+f8Ad+jyT9hEvxaVxTlTxAMn/LoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789811107; c=relaxed/simple;
	bh=J9XoQO5xQ4wkqGthks34xBZXuyaI9i8TXB/fzkX/ZjM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XubaIfJ3dwXxyZn0S3riaTiy/nzJFXqDT5kC3NXuhERRQq5X4/Nh3DENgq6huUgHQoCciZh7hx0rsnGRZtqplUKCFqxZkOF0Lk67n4o3QISZ2CPwo57OYm4c3AKyUR7snBekK3dzHQjDU1qbF0ca///z2s79mMnMGRRsq9nUHiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTaq8D97PRddDZi+gUz2LSO+KA63YogE4wj2rJejLbWJmMOVBU2uT48NceOGxpe6x5D04TW+MvfEIUaohmAzGvVTObOoU+jpuKIHPWhGMohGX+08IGKz7EejWMzHqxHPBO1K3xfPI/iN4LMsYCw6EHo1vtKdDEAbDFIgpwRkcsY7lbyQMGvyeWOScMrj5MI/LpwKRh3Blmul32X918tRSAiCBPwDL5kPr3AmoKpkKVz5Zm3Ybg8UQDCA1l5xjrXL4gw+hqrS3XuOCosGtOXmRUAjYWNGe3Hhnv3gTFY2kPq/XiXXd/nBME3azT6TvUOlcawrbZaSzrcuRhnr4O+MfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqBUq4s5NuYS4VDt0/tlMujT4DZV6QeyB/ydNLRcvaE=;
 b=ednyUvmJNZhfcui9tlOuDEaWVuq9ice+XNXf8e3di7T/jlubzn+mtRapShBfwpv/vavitqRj9MYepI4jj4WukyeBKZbqxbuKHZDJ/6ubxPIxIzXGS6JimF22LIi/iBth9m8Sh96ZUuHKoTPMavIiw621SddKS+oK+oh+Np+LDdu9UPTugZ3B84MyeM+dgOa8ZT57BJiZx4wG5q0VuX3E2z2ysOAmfvIfbDKjpTuFYfOA4kxsAoOwt5IWMC+5X9u2rjU1+MSp/FZC9rWJ6sssNrbiOMqZhLcgHVbpXIUCcaXBhjTCTlKSCP3NtUS/0bIIWmXffJgHWQVFFVSRFBTEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1203.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 09:29:58 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0428.014; Sat, 19 Sep 2026 09:29:58 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <chen.wang@linux.dev>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 0/2] Add StarFive JHB100 DWCMSHC controller support
Date: Sat, 19 Sep 2026 02:29:48 -0700
Message-Id: <20260919092950.178617-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0001.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::12) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1203:EE_
X-MS-Office365-Filtering-Correlation-Id: da1f10b7-9a81-4e69-4007-08df163092c3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|52116014|366016|38350700014|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	6QASev4HiB/2CLFrf8fmFd1ky+XTjBZmlbqfJsYZj4YWoAPXSIXNrcmCOGdXmVtkMTWFq3l+ep2m8rPGXon3PMKRYnn73BDubL7Zq01pkl0NkAlIwuTFaTURkz8A1O/zPfadR+oUC93h+hWm0ZvkgJIEpibwgtfbighCkJDueO9gKQRcjfyWa5eFCFD87w01SjozvBJCm1vJw9vjhRSgVozB0+O7SDpmP2ymaeBJE0R9jG0QeZI3yBZz53Sh/fQFe9ldG0t29Qf+JcVVngJLXqqMgaUElk6lID6byXFWrnwyKeKWLz9pLOqpXbgwKzhq29Jdf+NlIcUkud4jQfR/2sUabLHHVc8LhEwrk2oN9dYz5+4TEaHDHQCU7rYx+QnfVNH/pWT5U7RLReeV0cdOfdlQncCCFfcGfG6XBjBSyAdHClrAt6PYWlZ17MIph3wEL4BPFZuhPM2lYoYlwGSzT8RS6g8U65hdbpPexWfXIVMnJITX5DazCSv0L/bp3/6VvWjdJJQxLkxuLb2OlPDxEQ6f1juaY3WAeG3EfVuWx0dUwT2tsms1UylZTHkU1JS+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xrYZlkslmD/GF6wxl8dHp2YeN5X/a4A2Q3mCh0k7M4Abudl/7sXYQhbKPpgj?=
 =?us-ascii?Q?R3iHoFsaGIWbDFwTQNXI9dIg6ILY8frfnz0Rr7NiKrQALoxEgYY45YKq7cc6?=
 =?us-ascii?Q?cOa5iUSYw2hH1WvWXOlqq75lumInVX5j2LTC7OTXDZPVIhh7zmbweDw0MGeh?=
 =?us-ascii?Q?nMolXFmoc+rbSiS0EUY0qNbIRPMjlepC0Duhp+ShsZFPNTejniAv+8vOhIgJ?=
 =?us-ascii?Q?yMiVRjr4BO1u4zCiHZertWzit451cYmT7EfctfWPKZDu/Y3bFciVU8INMtBR?=
 =?us-ascii?Q?sK/SfoCEESkaGntSqGg3cwrlcUR70O8GS2aqoLNxVpykH7mRC3/TWvDjf2iZ?=
 =?us-ascii?Q?76B6601a3xN9Dbi9A+BUAqbiWgmU0y/mm+1MDIBpZW/XJ/ISnx3e+OLhGEyC?=
 =?us-ascii?Q?saMS3BzcGpil/dsn7WQRLYJ80jSZehBeWa3Bzb6oN3811s73QUlmwLTGml8Y?=
 =?us-ascii?Q?vjWlqU7o5B9qkzttpYT0niZCu469+s9njrg/tgNNNGShN0w84kpOvJbnj2ax?=
 =?us-ascii?Q?dnYSLNEFH2JrZYlJHRD3Iuoju+2BPS9NgpE+I8ibRUaG18lFIK1SnZpgk/9r?=
 =?us-ascii?Q?IaJgo8bHRVgcOX1FFsCmmQ+ik7KrUg7EdtYHJ6KjaI6W0zZD39g9ZGy32dRQ?=
 =?us-ascii?Q?jdhT6mNkFF4hF4vtD6CUFK/IezKAAr4fdhX1J9PvJ2jScgeXHSrK6Jr/ciU2?=
 =?us-ascii?Q?liVeVjjFjGGOzjsEeMHw8axGvJdLVzcWF+Xae04Oh71iY3ZmjiaBBuiJZJ+2?=
 =?us-ascii?Q?jsujwgAULqZFebP5PWiKo3tJXyZdT/lc18XEczsAZdYZoToInl65PCwTBtJ8?=
 =?us-ascii?Q?6AwDu3u3Ajy2PohrS4Wpx2BANM/FVzzLybVn5WZC6YPDlcK4biAX5rA88otK?=
 =?us-ascii?Q?+QoRvt2Pyv0TpmfhmTdpGaNJuEUb5v3ERnk1oCzI97gI4jwuGMBsVON280dj?=
 =?us-ascii?Q?4Rqo1uwgojjIkfmn26KgUzTaPVf2T8dMSun0k4xXXndRKxOwOPcaWkpNnvmH?=
 =?us-ascii?Q?i7lvNkkPEtQj7j1q0m7q0u1e7jue0iQtfnahJCzsNYxSYEZr4A6tfV8z2H9m?=
 =?us-ascii?Q?GUlGAl6oCe4z/d/BxZXZDoYTxBZts9/I8jiCmCYqWzg5HRSr8/tj7SNtO0Id?=
 =?us-ascii?Q?IypbjQkpqSjNX9oCGURspXmKZzMyloIwy7ijzmdf1iWJhkuwVbTFhensQJ8i?=
 =?us-ascii?Q?Ay+Wsft395LKZ9CRw2mMafmwX6KwWrEaNpXbnlfnPaf2EK2Q/MFzkFBvoSxv?=
 =?us-ascii?Q?1dtoOHWOuEOP5FLRbWzv32nmstZDxI2ucKFC/1voAvuxUsqzigewcoce1p6M?=
 =?us-ascii?Q?nLyc4RN98dEyPJ3gOsJygJVerJDsG2OFg1DNkeNANUnzvbbb0lks+O3ZoR8c?=
 =?us-ascii?Q?uKJs6qJFt85hqrWnex+acBkw6Pje7JGgEPBKd0Bjv26z05JhAy1WxVH2cnMv?=
 =?us-ascii?Q?HP/KRiZuBNLZNRzxHT/Vov6zdTgJb+1U/za1sf0l2mN+F3tnG5gOkmKQDJ5W?=
 =?us-ascii?Q?U9OJWHmcnkPOFNcqiaR8OE6Z84/HSoUbOTDDFSd5hXjSAFX/iyXctvebmt6r?=
 =?us-ascii?Q?HWSRfH+v1/aNxbX0o1mM9ZyUgDG/t8ScsJtCigTOXi6xFAwgYwWn6LDm/IEZ?=
 =?us-ascii?Q?CFfSzGw0gLmVzj9/61W3GhoqmWbCrG1575cQwM+hnHd1q8Jx5OJ5HCwf3D7I?=
 =?us-ascii?Q?pwEIxKs7Ie/eObVaL+Hcv8GUEAYzQnIeXeKy47llGxTIN8o4iKvF9OHhhn7X?=
 =?us-ascii?Q?rhos6gQGAQoh79NKqESQ2n7j615d4W2/PvRMg37n2+gE/wJVv42d?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1f10b7-9a81-4e69-4007-08df163092c3
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 09:29:58.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxFF56w8nVtcYD2k1xFQpssLUIPjxjETwVfStELjf3WW5JDlnGDCXMnJ0+duP4R4MuNUfICB5ZUN1JZbqPtf9y8tmL41Vbg80IDh9lSEjtZNTSmyz5mmmtvI0U9KEEtH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1203

Add DWCMSHC controller driver for StarFive JHB100 SoC.
This series has been tested on the JHB100 EVB1 board.

Due to syscon limitations, it is necessary to use dma-ranges
to restrict the DMA address space of the eMMC controller to:
[0x400000000 - 0x4ffffffff]

bus_nioc_4g: bus_nioc_4g {
	compatible = "simple-bus";
	#address-cells = <2>;
	#size-cells = <2>;
	dma-noncoherent;
	ranges;
	dma-ranges = <0x4 0x00000000 0x0 0x40000000 0x1 0x0>,
		     <0x4 0x00000000 0x4 0x00000000 0x1 0x0>;

	emmc0: mmc@11b00000 {
		compatible = "starfive,jhb100-dwcmshc";
		reg = <0x0 0x11b00000 0x0 0x10000>;
	};
};

Changhuang Liang (2):
  dt-bindings: mmc: snps,dwcmshc-sdhci: Add starfive,jhb100-dwcmshc
  mmc: sdhci-of-dwcmshc: Add support for StarFive JHB100

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  74 +++++++-
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 158 ++++++++++++++++++
 2 files changed, 228 insertions(+), 4 deletions(-)

--
2.25.1
