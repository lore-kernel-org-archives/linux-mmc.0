Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773434CFC2;
	Fri,  9 Oct 2026 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512105; cv=fail; b=qunfdwHtjuBgDpC8wky0wwfi6z8bWthuoYnEm4r7JMXXrkqsB1NZfmtUKHvZ8DvlSj+OMW+6twYq58fJXiWOHU0vMl6aUyntFRAo+59dLsPIITY4Ocm+lhuGuglvfbKd/aLiniNxNHKmoRU/es8pLb6mlou/RkbdK6WiLFHYUjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512105; c=relaxed/simple;
	bh=pooTA62CqprsI16IWDm65j50e7m3uUMJxT5aUG8X5Yc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h3ME4L8F+lkIYZYeGWc5+DUok+dBpO+UBAPS/zzr6N+F9+JZwYFPCDn1O2bp5GmX2k7JmoXDt1/tSP9QNrhZDU5EKd9iKHCj74035F6NPHUhSpO9sf1JkrrVD2PnzUZ6THGCqqL1/tMwSnjDgJHsPt1qjacFBpzWDSgvgwllc6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=AzjEDlpC; arc=fail smtp.client-ip=40.93.198.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="AzjEDlpC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJaTJl5nWcZflvezJ7GR2qmWBeIQrb/TS0EpRtRW+m5ULcWFAt06/cVIDKjHtf7lSX8jSIJyCg5nsZhoHBBZwPAvWzSk7joevxx1JGjYYvxP641pSgW6BVXO47zTUt2TKMay9eRcPFJlIPa0Ud0pwps42nUEY+wizBwE35rWL+j39yYkLWeGUx8tYCA7qpGE8cgtg4yBBACWbuHL1DD601Qpg3K+v73dXDv/wmx4mL4HOVdG+y0wlhod5/PGVu1U0eXJqVvr1ndkLjG51kuQmfWBZ6CpGeUEAeciM4VMlRmXorrB3pYm6i3idhzyyP/WLZAgm9y3zgp7nuQYUod4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fugCbZbQ76mqp5++bOMGKfyqkLIPMblRFoMxjLkBfQM=;
 b=cakbf2HC2zEdJOczUILgqPrYg0Y9I/a5MezqEcannXly4mW6YWUdMaOpzKaAxdPgPw6J6ZbKHhj0FfSTfzONLIqgowy7/P3V9H80RNioW2Mimn5ZwUDdneQLHrkz7W55TD/tQuZBlgIEHbD06oM5sDpUQd5tbuzHQuSJmyQYCbdmpOkJ/6JGASxdCkS4oeH70VVmtXKp7JfdCx3nH8TALBlS2uomuZoAq+WnLR0JYhbI9FDjWrcIA40HfAy75avMro0LFSVO1spbyVHBMG5pikhBeG5b1VT9BDtV8qmoYHnrBSynXH/CPhaPyca1KQ0tVMrzRW01mhLprVXg5w9h5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fugCbZbQ76mqp5++bOMGKfyqkLIPMblRFoMxjLkBfQM=;
 b=AzjEDlpCdyKBEOk6XDGCWT1jhvg+Z31PbdGFgz5rckBS6FotdUVM6vJk9m7Z+sPrIo33RuDpqh1DnXo7TLkB31KC8BWqixRYsk1rD75ae55/FK7lBb7Pn2ab366MSXU/AEKFxwJ9GkFOx5ZAu5302EYASDqJMcYieikPvBpA8hb78WK9VdpeCVQULChNk+D1Hiau2RkWhqxlREgIlUtjDsyUizYIL0JmAkdkaI/enjZaFniPMQUk9kW/71lrJcB0xAMm+3jct6TYkz4lL+fmtebd97rTycoK/HaHGS2tRzmAUSshcGfaoSitJNeWHBvEe7U4R2wNuIOu+JqN/IG4sQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by IA1PR03MB8063.namprd03.prod.outlook.com (2603:10b6:208:594::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 02:14:57 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 02:14:57 +0000
From: tze.yee.ng@altera.com
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/4] mmc: sdhci-cadence: SD6HC DDR50/DDR52 read-path tuning and fixes
Date: Fri,  9 Oct 2026 10:14:47 +0800
Message-ID: <cover.1791459448.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|IA1PR03MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: a5be5ea8-b271-4133-5789-08df25ab1d68
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|3023799007|11063799006|56012099006|55112099003|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ikn+aEzZWnViHPmKhUHpWdpYjg5isjRqOYTrzL7gev7aPVjO3FnRhScqZjAx51NEl4OUFdxdYp/FN3aqwWucRLjmi3EtF5EAXRhYscwTeKoHey4xutQJv/MhLtzGFgaqKxg/YPNWhwFQ9MFiFfl9jnBNbhv2uXCyt6OYBliJauIX2zpOAoUY0Qnh4ul81OFG/qsvtmCuR+YFBokZA441IFoGb9oboGbQB6AMxjs7Vp8R5DK7l5SLbMmy+8WP/t2aWvTF3XwG2VHcuPx3jD22C6APNqQiPJxW66tDRd560u7TUbg0t02NVPNPyyODJj7mvpHuEcZTHgWm0mAScebPcZhtyGtCSJWVhXf7aVhmSM5uQT30kbZVnIypTW5OlQkSUZNfVDp/ZbgJh2KFX723eaTvWfBVAjgAQPWpXVWtqSjU99zo46RwRSxvLw5SAWKms+DMXJittPY5JKdzjMV83HuQMTdo+xc/1Y69WFoaPZJaqt/xqInttjak8SzTbUEp0g9wl9SijxBtGTYXOLyyIU55XDs/VULgQcy8K3GfD43SQVs+Qwav+39t9/EHkd2Sefe1vNaqXkO4ILDFvObUxA4J1KqPQgg15zNO4CQg7I2zoGWWA5bZNpZw4d6uZD6sLnSLfDADobqq3lWiCPxLTgBvxNunDRGahnRgUtmtxF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(3023799007)(11063799006)(56012099006)(55112099003)(18002099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qfs9cHDYq+mjlkJTmWcs4wj3Et3cXE8niIlCpGKGyLqX7VxyBDlTaFZAaKMG?=
 =?us-ascii?Q?uEtT2MQ7N3QYdXYRwfVMeyT3Bf8eRWKfjGsR2fnVQi+xbKCV1B1fwNTQmWGJ?=
 =?us-ascii?Q?FSfQeJjvuknbViMmV07cTwQ3fbee/RgEjPNGC/BoxOP/cNWchef9VsgbXbPQ?=
 =?us-ascii?Q?PvsN+ag6bKaS9hdQnS1G4xs7o4+5b6w45gi+uV/ducwuQjlKxKs91kByhQjy?=
 =?us-ascii?Q?Qa2BaO8Ka+34uDa8FxGNf0h0V0xGHlmGJmED4U2mR9Y7IEqLV3ak30xVKLGb?=
 =?us-ascii?Q?WVPe8JmBZ3eG2kXdClTGLywzju5NqBk6si59RHpQdKLdY01ls4byxX+Vt6hg?=
 =?us-ascii?Q?zayu23EHxRx/wqu6sdXFw8WyLErCWQb5lunyZHE+lQptfF+Ige9jPGzwLmGn?=
 =?us-ascii?Q?Wf1N7aFP4W3BFuA+uNt7QsRSd8QvtIzNk6NrG9vtYW5SajWGlvF16q2v0xAn?=
 =?us-ascii?Q?Fv7tglVLk/5QwD0VUYDKwZOuVrGtnyfZCuex29A/LXpWSu2paina+2mk+tLU?=
 =?us-ascii?Q?eEOOaHJS5JXku6kzJIo2s06KeCrqx/GwuXJ/WflPC9CXGrpIJpYYPwLO1J/6?=
 =?us-ascii?Q?cRQ+fWzAIxKElDWLc50HcWk8mKKf6W/JoljNNL4uZ5ZOrfsje947fi+tEcXG?=
 =?us-ascii?Q?MT1i54bVgO84ot7JDPrNnUT7hW054PeIY+KAXyNYjyCRhkcDQGvrj4NRyS0V?=
 =?us-ascii?Q?0xbf6Y2KACHBAQX6BjSuvdVhSFrQErqm9ClhzNC7y5DHWYt1Xwi9eX7SfxYW?=
 =?us-ascii?Q?GeN1QWKhnY1zf1k8t0XmlOcSlLnnhCjPQb7k0UN1Hnh4HsM3I6pmja4r9ZSP?=
 =?us-ascii?Q?IqQAI4Bg550OFvULiD6HF2VLf1q2ypnhs61ccFNWEW5DdNc/XvrjSgL12hZI?=
 =?us-ascii?Q?7BMOCQOsCuwSQRsdXl3cz1DYmZED12rCpLYSEhd5vlPch7aZw9iohUaUc2Xi?=
 =?us-ascii?Q?LSL2jSrr6wKjOnd4OsuzRMQb1S3PnssZXa4S+ocHPAgBRR4LN2cASQ/aa4lc?=
 =?us-ascii?Q?8vSvGQEaDo1qLSvUPZgyAL+3Ytmg4NE/msdYjK/Bcjb3ucJQWBiz/qi8UFNl?=
 =?us-ascii?Q?wXPSfKUK++1VQmGx/izP7cn+719aK/yFB5AxbFoJUvmFDAX6VOlvD6mne7dD?=
 =?us-ascii?Q?hOxyxTmxYoSanZKXYrCOSS1lQh2E2c761er/8AZwXZLzTDspSdY5NtvjuJJ0?=
 =?us-ascii?Q?JhA8F9gDDEw7wLD2dCpIbFQr+G9lDItOY5Lywbcy9HCoqACNv2niu9dqV27y?=
 =?us-ascii?Q?uEyVlpA0jz7+HTQiCgmmEN5/QNtVXp/zgmHp3flgZfQ1DGv65HVCpn5M8UB4?=
 =?us-ascii?Q?pZHK+ANYhxcWVuGgXT0Jp5umjp1ImA6N5SIG85KKzwWjK1Q29jK0mFwzJ/ow?=
 =?us-ascii?Q?sWhibzqjLc0CN6D1WGM5HgwGr8TtZjKwFQI7yUeJRg9wzwzcSsz+A4dMDvr4?=
 =?us-ascii?Q?nmmHFjUD8n2yS9rNxuQhkk9PiazM2aq4PhO6vOWLuGftBY1xf3dXvGRbTnX5?=
 =?us-ascii?Q?Vo4XHsts8Aq5XBErUnCm0WNCWVmTNC006rukmF+Tv21tZJDpslwCejHShxED?=
 =?us-ascii?Q?zoFu0T4r/J60LW/jXD81+f+68EmiS9rn2QIUUJsBSSPYPFxKLMwn+3TNOJbM?=
 =?us-ascii?Q?WOqgEtJa8KdSD8cEnqFqeGsnFebqZZZtkwmggA4aytaS7/lNjDChuDrlnOfr?=
 =?us-ascii?Q?ruK6lL3ilvmADWcQHEG+uHuWwwvXg6K78oE32ysRh82Fa7hvoEgkbcJwWB3R?=
 =?us-ascii?Q?tUIOJYN7jQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5be5ea8-b271-4133-5789-08df25ab1d68
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 02:14:57.6292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ynjw7yBiJBijoV3VxdftDxzOUiHumXmIzIT/DMFIXw+ZpKpRkhywNKVk5XM2ACPixTFQgOPnexWamaepZ6zVfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8063

From: Tze Yee Ng <tze.yee.ng@altera.com>

This series enables the extended-read DDR modes - SD DDR50 and eMMC
DDR52 - on the Cadence SD6HC (SD/eMMC v6) PHY. Neither mode runs a host
tuning sequence (CMD19/CMD21), so the read path must be centred by
static, board/SoC-characterised PHY settings. Bringing it up on Agilex5
also exposed PHY issues affecting the existing tuned modes.

  - Patch 1: settle the PHY once after the final tuning tap, before the
    first post-tuning command (an R1b CMD6 during HS400 selection can
    otherwise time out); matches sdhci_cdns6_phy_init().
  - Patch 2: program PHONY_DQS_TIMING (left 0 in all modes); in the
    extended-read DDR modes it must be the rebar pulse width in clk_phy
    cycles minus 1, else one DDR beat is duplicated.
  - Patch 3: document three optional SD6HC read-path properties for the
    extended-read DDR modes (SD DDR50, eMMC DDR52).
  - Patch 4: read those properties at probe and apply them in DDR50 and
    DDR52, and make the DQS_TIMING update clear USE_LPBK_DQS before
    reprogramming it so the loopback/phony selection takes effect.

The new cdns,ddr-* properties are unused in this series; they will be
consumed by the socfpga_agilex5_socdk and socfpga_agilex5_socdk_emmc
device trees, submitted as a separate series.

Tested on Agilex5 SoCDK: SD DDR50 and eMMC DDR52.

Changes in v2:
  - Patch 1: moved the 5 ms PHY settle out of the per-tap tuning loop to
    a single settle after the winning tap, on the success path only, and
    rewrote the comment to explain this specific call site. (Adrian
    Hunter, Tanmay Kathpalia)
  - Patch 2: added Adrian's Acked-by; reworded the commit message to drop
    the "generic to any SD6HC-PHY SoC" framing. (Adrian Hunter)
  - Patch 3: retitled to "dt-bindings: mmc: cdns,sd6hc:"; renamed
    cdns,ddr50-* -> cdns,ddr-*; cdns,ddr-read-dqs-delay-ps is now in
    picoseconds; replaced the read-DQS source selector with a
    cdns,ddr-no-lpbk-dqs boolean; reworded the phony-dqs-timing text;
    dropped the SD4HC note. (Krzysztof Kozlowski, Tanmay Kathpalia)
  - Patch 4: renamed the properties to cdns,ddr-*; read
    cdns,ddr-read-dqs-delay-ps in ps and convert it to delay elements
    (dividing by cdns,delay-element-ps), clamping that quotient to the
    8-bit PHY field so a small delay element cannot make it wrap; read
    cdns,ddr-no-lpbk-dqs via of_property_read_bool() to opt out of the
    default loopback DQS read path; dropped the v1 per-property range
    checks and redundant FIELD_MAX() write masks; apply the overrides in
    both DDR50 and DDR52. Also retitled to "mmc: sdhci-cadence6:" since it
    touches only the v6 PHY. (Krzysztof Kozlowski, Adrian Hunter,
    Tanmay Kathpalia)

Tze Yee Ng (4):
  mmc: sdhci-cadence: add PHY settle after tuning for SD6HC
  mmc: sdhci-cadence6: program PHONY_DQS_TIMING for extended-read DDR
  dt-bindings: mmc: cdns,sd6hc: add SD6HC DDR50 read-path tuning
  mmc: sdhci-cadence6: read SD6HC DDR50 tuning from device tree

 .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 30 ++++++++
 drivers/mmc/host/sdhci-cadence-core.c         |  6 +-
 drivers/mmc/host/sdhci-cadence-phy-v6.c       | 74 ++++++++++++++++++-
 3 files changed, 108 insertions(+), 2 deletions(-)


base-commit: 2d2431cf24dda7303d59e47b7d116be8beda66b1
-- 
2.43.7

