Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012034.outbound.protection.outlook.com [40.107.75.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CED283FDF;
	Wed, 27 Aug 2025 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287357; cv=fail; b=k7cZOvpCmRN1vQ0URKG1xzXQv37psMECOQPtq4m8DJS/ocATutCHZv+2G+6lL2DLR5w5IC0e/+F2L+zfJhzVqBhZyONcMInTxdtomIujsKaIeQ2G+jxI7c+E6HUzggpOayIPX7kdfkz8+3FdQDkL8jv2dAtLgnEFj5O/58vByZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287357; c=relaxed/simple;
	bh=hZT4fa8nUE4gWxhESK5+H9GZ0XlUO74JHS3ZZYMX0bo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tycGth5SXU3Zfl+e9VQjMz0YmHeSYwhOrfRrUyHa1B9xfeAHp6tuNS42wgkZ/bOkc6ekYeDp6lgwUS0L13ksv8+VXb4drxj5INC5m79JZRZl1/7bWMiJkGOrUye11QDIz6TihJTFL+6t+85ZiOE3I4HEg5VRUDRzpBA44pMTIbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KLY9Tl3E; arc=fail smtp.client-ip=40.107.75.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KLY9Tl3E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYfyDwIXfUB4aALfpa+oIw6ZZhshxNmpZpg0TfcpfVA99IzX1mCbENBuey+UPCZeIl3mNCLONN83ppCT/QcLqIrKalP8YlNDGiNc5FUI6S/rK1Zu9k02pwR0vA6c4rdI5FMB9m8J0lFlZCc7ZmUbbIui4yJhJGQTm/HA2SUhblojaPdVhzFdZMu9dTADPf5Xzap58HTDZpnPIqxd+z1nd4WXZUhFQ17tJifnzyzNFNDGkg/3c0FHbuxIYzugf+FywSj+4TlXca0IZLarpPTNcHuTx+FeqhRlr1gSrYj1WidFR7/l5Dy77W5OkJZABSVM2d4V39Qy8E40MGh47inoaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1MbF2Lz7bNdNDSUGnip92PpZO/p83VjBEVxursvmkE=;
 b=j+UkLZU3MVqvejWQOyVhke7yokUGVORoEXkB2peGgGsQUau/HYmlbKSKmY73/dwymsW/E9gI519UTmGCj7qFiYu6NIkw6weItdKjQ4xdQzzMGu2yWFXgUrBJ92hEzQQmgRIhwtjURs30A5WtMpgQ0Y0u348taT7HVOou5MAhJ2EPqvy3xz+2gl+l4b3BgKCe83E8+C1Qy3bVTedUiLxK04fSbngF2SynrbpknJ0xho+UdZs+DTMtmXHd37pX/WHOSiG2X/aeqD178mQh6MhupXpKxBRxV8Xaa1JMddJwBj7nKGcJNuE6TRJSq1QPCSZ5QAtlKZ5ipkPp7cMt+N2XEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1MbF2Lz7bNdNDSUGnip92PpZO/p83VjBEVxursvmkE=;
 b=KLY9Tl3EcbBd6rqqd92jcNb8jvvW82ZzFtd9hsJyB9Hy45UWaJIk1aEc2sTWa1NDJDHOb1ENUg/jzlJ4rPDxxqiiJhVkJWJA3OuzqqIAvx5DSX+oGfJn7haa0NQ7CM58IcSIy4OF/faSkXaWLAR8Hvnudbr02L93Ggm50Tq0F01GhFzbXjQisLAN8fat/P4gnffK29YlnvQs1R0DOlMpCnhHVsm3NuPWcAhrSiGvnwLtEFx+hGSw1TAPl3vI3g3a86jFTvIINXgIK1UgliqIDkPz/+Cb10DYGr3ldLiMbzWlF2tivGDeQxhwNCE9JQJY4VrYKseQ16iMVyDVlie0cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR0601MB5656.apcprd06.prod.outlook.com (2603:1096:820:9c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Wed, 27 Aug
 2025 09:35:51 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 09:35:51 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Avri Altman <avri.altman@wdc.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ricky Wu <ricky_wu@realtek.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 0/2] mmc: rtsx: Remove redundant ternary operators
Date: Wed, 27 Aug 2025 17:35:24 +0800
Message-Id: <20250827093530.416071-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR0601MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: f1326581-788a-4625-7ae5-08dde54d1c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?52T6JjnH9PVLmRoDNv5FiaAg28nJ14ywqbpvLq2LlhHvKLaIHRpxVZwFsAnF?=
 =?us-ascii?Q?Qg/hL2D6El1dM0CubY66JfbQt38Um1gFjOiRmItbV7+248wQd/W9TGbHzKMS?=
 =?us-ascii?Q?ykDyXGEDMgkTDAYE+9fHTh2/T2K/zuFWUEwHZJmEIuaoFTOf/8uK6yJS9lVs?=
 =?us-ascii?Q?ZggmnDMmNVEJZNIj8x1+Ln/t6yyNyfIytu5LRno/2+NRBChpmvUd/Vz2kFww?=
 =?us-ascii?Q?a5EDaxyyNPOMYgT4bqBKXJ1OWIpRuPqrX+PACFX3Ftg4y0u/dtv7kFzL7pc/?=
 =?us-ascii?Q?K3depbGDOq6k3Sk1jd4AOXBjBRhvB2qZ/SVnvGeFN7BNrxMMXRaqLDteYIEF?=
 =?us-ascii?Q?4TZ4nYWBaRcBDy4m+sbftg3+nSidSCQi4Eaj5qGRgMblVQ5BfNeAg+RElmRy?=
 =?us-ascii?Q?ZgJFtjpQ7UxZiJMtzG6n0b0oiuzDYP6JWkfw140/j2p4YcQ/PcK0x7JPyJS2?=
 =?us-ascii?Q?REH/6GmQx3afRCQLHIXrV6U4SGRQZVfjR2vaI9THQZqjW7Li3tDAPQIgBkoj?=
 =?us-ascii?Q?uWXEexjKpTkSbSY2M5CynB3Ykzn8AyHwpbUw+5RQaY1yju9ufZjQK8LAbPKD?=
 =?us-ascii?Q?62+HRyDqCLmN0GD6dDDN3wTT+aMuhwt32M1VC7qo2Eq3l4OX/GLSPgxFI/4Z?=
 =?us-ascii?Q?pNTRqcKG4BZXiw2c45YeDvJMxSj2isJH6DIw1GFkE1jGceBh8O6KcYH77Wsd?=
 =?us-ascii?Q?jhBInLxKkYMTp9pjTHciKV0fH6D94/WJOmHRD6fPz/QnX0dP/B3mxPknsmjx?=
 =?us-ascii?Q?LGl7ez61094JmMlGpBV4FhAMAQ4DgRDMuctpfS/B88LDUZJHCrUywDdLTPtg?=
 =?us-ascii?Q?hQX4P1WE0CvCDXhnaX/spD+P5f6iXlmBjAgzxPHtDWz4EhytrxHflbUmFQDC?=
 =?us-ascii?Q?MirR7oqyCsxjDNQN7/+nvjPHspMBR3HY8IAaC+gYA/ClR7ZWuzrXn3Unwmo5?=
 =?us-ascii?Q?Lb+FMUfnDoc01462d5NgU69J6OBkQVQSxLH8SCvsWukwQqkIlB+u6dxQUMwm?=
 =?us-ascii?Q?3mspolptJt1xo7GoG109lslMSlEJavdyf8AKtx3xUomLWNnc3vppjBs6BANu?=
 =?us-ascii?Q?0VgOeZsiHDLXgHZwBAdw5U/2gwcRZO2cpJ7gWxPFqrRZ46GLxPcmRIgoaROH?=
 =?us-ascii?Q?7wx2015uzKDbVpwouMy8Tgi5IlDjrBMjX5uAvDdQxxDbVkTl0zaHzkBwy7HA?=
 =?us-ascii?Q?7umBKON6/dKvnA1eUHqIcuWIEkb3rkTV8ilkO/XgrjNeQS9Z2Zay61b/GNM4?=
 =?us-ascii?Q?bYA5rpPfNFIzQt7yGJTXpWZPj8OraMXgfc/Mc8BUgjPFrpd9Of0QkFztwfFO?=
 =?us-ascii?Q?G2Juzg/JF+raSWWHEKfiwZLIvBauisTJ8coGlzf48JLfu83Z95kzprcFqhcq?=
 =?us-ascii?Q?w1ADnWWCIl+N1Jk3oEPUOsznI/sDHqeSH+pbQPo7RxPvGENUO9e61mab6zeV?=
 =?us-ascii?Q?hSxKAmjk4AUDhJDDCassCVKDzoDB3qLapbwVLQ7KNflLX9BZyIqgoA+ZlDs9?=
 =?us-ascii?Q?EZugAELSRIYJc2s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cQiBCyT2Y6YPQgiQe3Wz5WqpU6MfSDXUpz3KN/bxWC4O2USt2wQar4OcUvD0?=
 =?us-ascii?Q?FUofhSOXmrxVV+oT4N2WAXWq6He0XRIzu/V+8K8Qqj1r5S3cpfgACiK0WjQv?=
 =?us-ascii?Q?0LjYdALWctJ+eGuYZRrVq3TDBmqmcWJj43HJopksF/XbE/Vbe+PP7R3jKTLB?=
 =?us-ascii?Q?UWKQ9LYzMHhpZe1x2TOx32Z/foR09M8yunp2ZBUaFVVABchP5JewPBaC1AB4?=
 =?us-ascii?Q?e7NEKJNqEEq/2vkVxBQiuLz7+0z2UPgJrmXgPAfB1/h48QdkRqYefRWLSUjx?=
 =?us-ascii?Q?n21mWX/7jje+zFflkK1JhpdZ2QFbP/ILMm7tQ692SiGBvzzMpAuMBtQ+hRs1?=
 =?us-ascii?Q?XhxZBgYW1iOtPmWOzVVG1rU/xpY3Z+WYzYX2EB6d7943JgzcuPImYsKDEFg4?=
 =?us-ascii?Q?yNIZtreJJV7X47QksKqnGKPoxSIlEy2oIQj6ned6q7rfsIyikpsML5IkgjUZ?=
 =?us-ascii?Q?eYbx235gUMUejCRiNW0wdIno6S00pGtq2qkA4JUkupyQUjQXWFyQITGYjndd?=
 =?us-ascii?Q?HKy4LsKYVlYOYl29KQhLDzeEBfFXRF6RLVFPJ4pRO29/GrhXm59NV5Lp8spb?=
 =?us-ascii?Q?RyNNSbSvw8ZkvAvnw/OVOiVXdkHs/VJX5N0DRdeAPz8U6nZhPKbZeVXi4wCJ?=
 =?us-ascii?Q?sf90wVCl719Latdl5Xz6x2HAnrpo5A9cYkUd9Y0iKiWzWQyk/aDLItnyfMB7?=
 =?us-ascii?Q?xAToPvgDW6oLxsibln1JGXnzzwWsPB0Yz5yHow/VIGR14abcP3mUAuLxA1Oi?=
 =?us-ascii?Q?Noj3lA5QBhpJM6KpjlziHBJKNYPLbb3Wmr8k4vQvQ/2wIpzH/hQTv67KdjQ9?=
 =?us-ascii?Q?29uiTRboo3P8YQMtCgozFfg4BCjqOQRLlxftBIhXreScfwyfxXJ24BSt8Ad0?=
 =?us-ascii?Q?8Z11KQ5UI6E5JHi0nGKv5954UFJ5+8yIvCGRDNTKZJ+oiys1VvoIiCtstOcH?=
 =?us-ascii?Q?tRIZgkgca3WmtUDz2FQjPLIQT31NHQ40pzLiJLBHWk6Xfv9rDZG0CFkCEKMH?=
 =?us-ascii?Q?u4EZRc6JPZKNJpg8bX5PjGi50xg1W4LaN0wUC97phsHSdrpFKDxoOGn6IQNU?=
 =?us-ascii?Q?hAQZ/MUwNgU+niLXDqDM0bH+c58J9AdFKVhWuka1HF5tXOpw8iS+OLywtRF0?=
 =?us-ascii?Q?eBmhfBstPFYNpaFSFU1Ri8kA1GIBYrLKfmBs5iq8K2tiI15buC4f4LGcb3L5?=
 =?us-ascii?Q?fv9OqOlb7giPSKZ9ubGLFcruSRpRyBMbV4gAlkO52mhXutU6IYkiNzWEQOfP?=
 =?us-ascii?Q?XfsawFYkevM763oxSsMDxn+Hz1d39dKmlH12Kpd2gq6Zjj3ujcdPLjrvYazA?=
 =?us-ascii?Q?0kmfcxd6sYZqRONj2jrp7Oc/xYp/SuRj9BD3/1XvwPlBQiSXQOXT/La/AE/g?=
 =?us-ascii?Q?gRd1nHgGgoqYxEzfk7ChCAEnFFFs5RPvE12EtleqnA4N17F1Rb6mfjljZoGl?=
 =?us-ascii?Q?FO9ltA2hfF8SMKgtkHmEyeZrr0brXbl+um0mGur6ofuRaDSUUbwIL7bHQ5St?=
 =?us-ascii?Q?AnrA75h19myvr3lG9tipHs1lzJzrTwj47DcFobA/PkfDN6yptdF6Pn0lp2Dx?=
 =?us-ascii?Q?rWRfm+uU2IE08zsEgrUDXbamH/P40y3qEXmrCX8+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1326581-788a-4625-7ae5-08dde54d1c94
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 09:35:51.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JP76ZZpEnhYtc/Od9ieOCaVVBWqb2+iFEV/iBkwpe14xVCumIsSWSf+4xd9KPWkU5OCa4alJD96IslqxKUbgZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5656

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Liao Yuanhong (2):
  mmc: rtsx_pci: Remove redundant ternary operators
  mmc: rtsx_usb_sdmmc: Remove redundant ternary operators

 drivers/mmc/host/rtsx_pci_sdmmc.c | 2 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1

