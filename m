Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A2417D99;
	Sat, 29 Aug 2026 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788028990; cv=fail; b=pJA7jYz0wlqlWY37k1bCJB1/LvCoPRDlAmSo8NeSrJG596Ff9PwQ56EFxJlLgT6gVkbKSfi7YyLNd5dBmFo+AVdEBw8WCth/Py01Hx5tTjEGvaNFRiPy/m0V1h7enUDvLVdd9eKrTOXekjybJOhsWANZV8QvSSKiQTR5Q1XP9vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788028990; c=relaxed/simple;
	bh=Ss61tpp/B8brzIrAYh7nKDrlQhBjYQ59wt2kA7qawbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BGqjT9tvRoM3iMivDjw0mw/6R8UKdCEuZfpLjBBh3tTzy39KsQrc/P4b6XXBAnYmtxNmMxjr66y972VgGDujN5RJt5xBLAWcfjBIp9jU/Oi2x1fY/4hg6Ctoe5UcNqQoBeOwaP30iG9rg+dxYuauZPb6CItyoFKBZSQ0rJUtth4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=jInNj+gF; arc=fail smtp.client-ip=40.107.200.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="jInNj+gF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a05dsbK7GNhFQk+zl1l0rqQYU17jThNpOiA4zSn3VbLLYOurH4xjAAXlnUjgbQLQ3yMY+d/98XMEYYdIxOPiga6flhcPBhYQpLbyWWEhS5of3cxGQ1aXveas9e8HjhbbUWZz73fmsHm4GeHxlfnoWiWUOQ0XSOmeLEkRB+bWT5YnbhGnngyQqvKJS6rftN4BUrhKqclpcGGL+mX/WzPKo+cHUPolV2pjzlBneQMqySj/wSGVnnotkN/WjEC3EJTLc8epjj7uA8/m1Yj+rEtLkly5RFdqHUDJrgzDxeNXGmBkeCfBQq0q4IqhvAFcDgLY8ouz6V+WCabvGZqGFlsesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pibtv7kr/cneC5V63ckcEEBj2FaqqtWw/xxjXOJ5C7Y=;
 b=AylZ2ZRkZfQnisvh+35AS7WNzhkFmKu2dVNw1pIi3JJfCVmrEfl5DTuQIXX0fwloW1X83K0d3S7OXkSmC3YNYGzFaZf3HYwDm3dte4yhxbzjDtSdVV8EBlk3idOJ6vG+buJSt+jb5yImmcpqIy57VvFKc1zoAaOpt4E7lM7vx1xAhalQVV+wn/sPAI5i2GiJMaDUjhD4V5hk4CpDUuc3hcHp2dxzOckSLtfERR4QYCKhZAsG8GwMaimfzlZgXTpY/GWuWFJ/8iOR6jVYGdaES8y2c9GaGYSUODQ/AnVwaJXQ9B5WnzkDUQlxgPKSA41YrjIINi+uYRJQG0Tr/JxenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pibtv7kr/cneC5V63ckcEEBj2FaqqtWw/xxjXOJ5C7Y=;
 b=jInNj+gFjPtb2TdIJXEzDDiq57DQ2VX3QhsDmtq9YEHKwnlmHRlJOQNlScT25rrJMc/nPuQHOZYNxhkikhScAVuQ/jqiNOD4pBNjppZAdFaQOXjuTjHPO60FRX/zA7iwK9Eopdh1ZfaDpCSL6Jj8jelMPFCyyBIiGKtUfT/ZZo3CBFwxG1MOBZ1FaNRBipBVYXkT6PFaXwlEf88Rpv89lGAF8eZOcRaFq14Z53MyLKWo4LLWCUFzYGjzv7yqJP6/a5ZdCLmJ61VEOn4fi1qWf84wvbDUsI9pI24nxkHcEn90WCbHd1ZlAENhY9+4K2/evR6/uE7y8HUKDgk3FF0ckA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN2PR03MB4926.namprd03.prod.outlook.com (2603:10b6:208:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 18:43:02 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 18:43:02 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org,
	adrian.hunter@intel.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/8] arm64: dts: agilex5: add SD/eMMC host controller
Date: Sat, 29 Aug 2026 11:42:44 -0700
Message-Id: <20260829184252.27644-3-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
References: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN2PR03MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e84b26-a9f2-4806-fa61-08df05fd5af6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	0RcLHjnQw0CxEgZ3pmwLZG1ebxSxr8A0RZH+RxgXFiYagESPa5S/kVbuJQ31nT4sd74nIM8iP3eb3dkVDxzgWr7Vjx0WgYmS9WYzf2bviRCXg5wOsVUatLRsAjPiuoPUUh9xbhjoPJUrqQYFhtwLMp5DYcLRnW9LyaxFFM7FhfLotnwyCinoMZaM08eX5ZFzx7VNbVyZnR8IOdsPnQYWsQ1/2OxYehRGt2UOxeH3K7AK6Y8CZitXM45/wgzjivkUsJhEiV5BUhyimrwfxcGWk2Gm9cDaekNbgpvHSBXcG2m28AIqSVi5D2I4HSkxyc04sA4sEHBkNnBnIXQMkMFwqehIP9YjqyRoWzPh1nLhawP3ACgPayLU823DOkNBJ3Cx46M4CcDv3bpg2zCY2q81yWU4rpeAScOlM9ojzaCChOTXhl5yMbPrx+l0CkzFIwcT6hXrvQk15V4PVammJhjwjVWGIcVy8cRdB6sEwsxob8S/kYddfG0JXfCctgWogxFIqa4HNcZgvXHRmKkijgjsUSL6C8u7zcbcivefoEb54ZcPKN4k03nzDQ3vl/ULjtPOdZlU3tcNePXLwcjD+SHNBkkmVqoS9S6CQcMvjysm2I5z/9UBgj27H8TLFdS+jMJlM8/NDvOU6qSI216Ml6DigA5tJYXQ7aucjrWrM+JBrTw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ta9Kg1LFTRfYQ3roHt+S+4DRsOux4YYl31m3T0fKpwkm4d+XgMgcwe5sYBn/?=
 =?us-ascii?Q?eY4427IBCS9SCbz/DOPfgm+Y1ZnBweJpLTWmshEkfkPLmTViTvTG7KzU+FCf?=
 =?us-ascii?Q?6dSlaWMaVj3gJs/quFv3nfQwHsFL7WeAgwtbmsQNriOw8Y9E74qhVy8I10pc?=
 =?us-ascii?Q?buxLi9Tl4bXLRwNfmCoTzUUu8XN9NL74+3NRwBbPueMt7UWNS++xoU2iAWiC?=
 =?us-ascii?Q?Nf3cNWyOCrg4pJIJr6HPV0xl20B1rmZme0M+a9bMRoDuy/fMjJrROaJOUqmC?=
 =?us-ascii?Q?zrObIix8cAHl8ExRJy7Xd4EduoaajClfF7wBuDIHZR+zFxoI6pbMnG+sR68z?=
 =?us-ascii?Q?VkACmUnBzQaDqS8NQpfncF176fJ2XtkYVHCEC7F0UW0dXZOPlxxuiYDgEMr/?=
 =?us-ascii?Q?RQXfFYAddKNLd+sXZ1IdXqEYPT6bPIsz5/H7dSS5cqL4guD6okOuIFB6zetK?=
 =?us-ascii?Q?6YUC1O7NND6Sq/6WrScsAPg4Xg5t77sLeBAbG3uSvL2+B0BqE7fSoFG6zM+S?=
 =?us-ascii?Q?RbDNWZWGIzoqC4ScXD41ZGTovC0toslvlxoSWaA7d0NE2aAUljC7RnhgAGcb?=
 =?us-ascii?Q?D1fB5lZ9tCEO2unNPuMa1NJa2CC8L8IMMNSutFgYMOhTgcx/AY8WwNj9c+xx?=
 =?us-ascii?Q?8iNoi6j2FxWAeCPWF58Y5m4DZXU4o2KwgvNmLs8PaZiCxBICwkjrMg7MktE6?=
 =?us-ascii?Q?Iudbsnd7ZVnR47YHkzjo7OZhtcb3s0we6ktW9/h9t3Q5xJa1vtwlXffJWv9D?=
 =?us-ascii?Q?q7FUxvDd9+KSkxffzK5trm+QHNUj3IGNwx+GkE455PZ6Wv57wEIBNfnkfejY?=
 =?us-ascii?Q?ipk6vElmZ5cLy8zI0Bluy4H8BMNmarC4drvAUH8mVUrnU8ip2xTY6mc2UToS?=
 =?us-ascii?Q?YS0d4zvXsG+L+awzAc75XwmHWaQ9Oi+8PgSbUYfCKHsqdBhPuGPiHRBf2Zfs?=
 =?us-ascii?Q?1LZdV2cUPb0f9gczv+wWETbihdCHH9+33F2qJ4Ll8rXiOwGOgBS82A3XSNon?=
 =?us-ascii?Q?xKUCMM7NzF6dD3xoC+Bb9b1ABqoB4b2t1gM+701CaieKnev3V2JAztXw+mR5?=
 =?us-ascii?Q?RQ0MJKNZ5IzmyFjbPVQx8DGRHFb7O4mbA+FAySlCbE8QwPXR+8XI1uDrPI+9?=
 =?us-ascii?Q?nX0AxCwoBGuLniL1pkMMbr5C7Vewex0BrUYGimretcyfAS3TlGuHGXMNPkw8?=
 =?us-ascii?Q?ZqlhRW9PpZTE1PMGL6F25QFtINt9x7+tTvB74GfZFSN+Y/uFU3XlpxSEnHso?=
 =?us-ascii?Q?IPz+9cqlx15mNhSrigYFpJ01X5+3MT7Hwlpeze0NH/f1he95F7OpRzhvSEzf?=
 =?us-ascii?Q?jrGdkqhXWH3u7CZwDoy70RpcxS03Jyy388/d6xoo0l4iALyNCPdvpxTZKUuL?=
 =?us-ascii?Q?Xgc7nwuVfB8Q16cuWboAcxb6WJUDYI4Nqmepsn2Hq/czgF5JBOoidqoOGeC6?=
 =?us-ascii?Q?307BCNV8Yss0xRBmwf01aK4IT3N1i5QY5JuOE6UA07RboOL/+taa7GgKl6GH?=
 =?us-ascii?Q?WnMMYns1PofHpmJNRVJtIlSlpFeOYC/Gvbo33AGxOPXFSfZQ70dS2cI3W2Ix?=
 =?us-ascii?Q?9R3FJRLn2uMe1MXdE+hamATDDURKOFlHuS3SNjUqG1iESFEkle6yIkLmMDE8?=
 =?us-ascii?Q?p2lrndy31dce3mD5OnCLPcmldzEt+C1+Cur01B8NrpwRta1iGL4TdWA6tnN0?=
 =?us-ascii?Q?N6qWr3ZHwvwygWFBTkqHbm5+hbF3zLiVuQRUETRZh8PQeaNzVhaJYeh+YRIO?=
 =?us-ascii?Q?LTiZ9lPgNKbPY4Mt0BfvrI0U+w4cNyg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e84b26-a9f2-4806-fa61-08df05fd5af6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 18:43:02.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDxOU3WgDHQbuK4Pjz5TJ5IUd6bgT/JrKcrd0lnpXFC2zjoXK9o5xN+U540vQ1+arKMq9vK/lbtaAnVEVYCut+A8yd5P5t15Jl+D9eWqsH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4926

The Agilex5 HPS includes a Cadence SD6HC that drives either an SD card
or eMMC, depending on the SOCDK daughter card. It uses separate SDMCLK
(CIU) and L4_MP (BIU) clocks, and has three resets for the host
controller, Combo PHY, and SDMMC OCP bridge.

On the SOCDK OOBE card the slot is SD-only: fixed 3.3 V card supply and
a GPIO-selected 3.3 V / 1.8 V I/O supply for UHS-I signalling up to
SDR104.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 25 ++++++++++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 34 ++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index b06c6d5d60ee..5ccbd7bf2034 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -300,6 +300,31 @@ portb: gpio-controller@0 {
 			};
 		};
 
+		/*
+		 * Shared SD/eMMC controller node. On the SOCDK OOBE daughter-card
+		 * this is used for SD card operation; on the SOCDK eMMC daughter-card
+		 * it is configured for eMMC.
+		 */
+		emmc: mmc@10808000 {
+			compatible = "altr,agilex5-sd6hc", "cdns,sd6hc";
+			reg = <0x10808000 0x1000>;
+			/*
+			 * "ciu" (SDMCLK) is listed first so it is selected as the
+			 * primary clock by the SDHCI platform layer; the SD6HC PHY
+			 * timing calculations are derived from this clock rate.
+			 */
+			clocks = <&clkmgr AGILEX5_SDMCLK>, <&clkmgr AGILEX5_L4_MP_CLK>;
+			clock-names = "ciu", "biu";
+			dma-coherent;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&smmu 5>;
+			resets = <&rst SDMMC_RESET>, <&rst COMBOPHY_RESET>,
+				 <&rst SDMMC_OCP_RESET>;
+			reset-names = "sdhc-reset", "combophy", "sdmmc-ocp";
+
+			status = "disabled";
+		};
+
 		nand: nand-controller@10b80000 {
 			compatible = "cdns,hp-nfc";
 			reg = <0x10b80000 0x10000>,
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
index 57d3c5807c65..93222b199038 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
@@ -36,9 +36,37 @@ memory@80000000 {
 		/* We expect the bootloader to fill in the reg */
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
+
+	vqmmc_io_reg: regulator-1p8v {
+		compatible = "regulator-gpio";
+		gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "vqmmc-io";
+		states = <1800000 0x1>,
+			 <3300000 0x0>;
+	};
+
+	vmmc_reg: regulator-fixed-3p3v {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vcc-sd";
+	};
 };
 
-&gpio0 {
+&emmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	max-frequency = <200000000>;
+	no-mmc;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vmmc_reg>;
+	vqmmc-supply = <&vqmmc_io_reg>;
+
 	status = "okay";
 };
 
@@ -59,6 +87,10 @@ emac2_phy0: ethernet-phy@0 {
 	};
 };
 
+&gpio0 {
+	status = "okay";
+};
+
 &gpio1 {
 	status = "okay";
 };
-- 
2.43.7

