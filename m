Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.103
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794212320;
	b=VsDYxbMD+OTbZv1Fchi2/15wXRKpxqG1qyuDzOnQnhA2TexBQrj1sQNq6hyLFhrMDkth
	 woWfvgHVO1emEcTugegFGa2Dkn+Df1zkIf+mGgAtMWIZQZYHkiq5St/usYTmXoU0S8Q8g
	 0Z0vqnyELVaK2JM3qB8cFe5O7dgZT/qEHyekelJY8eqAoQcPqBY1Om6Hqma7MRoXZh5U5
	 G1LU+VxhDAjdl57smmhNVqG1CwfChTgkNR0bQ4gpp3K1EIutYYIa0e+SN25MXFYzAyhO1
	 sDu+qB1mlYq/mo1Gu8DmNPfybs359X+ZO2ERS8U0Xesm0b4V/idwpG5PwTr5ktvpyTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212320;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5AWF4+1wzEggnDouv+POxQT3W9ziKUuAZg13eagb39o=;
	b=1WxBLEUUn0ERqh2Lg3GBD0i2nYcSZOoeaDvufHKUNs6r66VeiJyT3bWvNQybJTUZLJVz
	 UefizCg5rjQzmR9O1NMgV0jrrDseybpCrZEfFYbNWIiTLdQhm8W3sUukU5tbieHJtUBLB
	 Grz1iJATCi/8BAWA+qXWrGichToW0JPz0JJXlD2e2FMWyBlj3gGxpExZKJLHaCxijkw/1
	 flp7DQwAi6XEG8fQmDU6X3Rc90fi+4dlr72H1oiSuAz7JOJ1SAplCMHCf4GYxpmedlOw7
	 EG2MGY2nsE5wfF/7JjnyCgETD32H6pbjjqwZ0aw8/9qE2bQGr9a4lZJpOvHbHA4zv4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.103
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2103.outbound.protection.partner.outlook.cn [139.219.17.103])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65C7606A322;
	Mon,  9 Nov 2026 08:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B65C7606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IklS4imqsnRe0XHQDpH0S3U7j49Tkww+8ra5tIL54wxxiFVbT6csNm/+JU8ijKlfNYeEWgVcqi2Ae8kkiDQGk8pXqEc7r2nLZWLFyL0HTiOtkiZwBfoAGWJz51230yZPk+plBruAjEbcfFVVae9JbaAMVBH6tlj0YrpKW1YfzpGa6ekNeue/Ni//PYGa/J4IH0p4hjblvnPb8FUxC/GoaNRZnvhQgGk2lzL7H7NjZd9Y9X/SeCoze4ItyTMLNpOK49+1dqhRVjhD5G9AVuyt/EE703iEiS7GKjC1MC2X6PxqeUAnwhjq66NNw0K63ObbNW5SzLdHj/kOH7LZUiwBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AWF4+1wzEggnDouv+POxQT3W9ziKUuAZg13eagb39o=;
 b=hA//TqXoA2UmgT/XPWOl7bKEKZG43kuB5shBh5hEPXsCVyG//wS6eqjDVmCUcBSKgMAor8/xCS/ePwt7n9inaQp6dkWZhvSrirLJvk8WjAFLGnQ0ezAqeCL+pdHbp19t7c9XfQLyLt3dL2BO7xnG5zvySXwLdpSncFkHT8yKHISOZLrs7C0dYSRT17RzFJ+KJUiN120HkTHtr8faJ5TcnUvTs0mcbJzHSQYJ8WXJ8OyEFXASdpyDo+dbCoQjPRmRU4mdhFRcu+GfFleTtlu8mzZwN53R4eEvUw3KnuQka+I3ED4BeS3axpS0LjUoX0sDb3tA6m8J38j4zdJ+Q65E4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1233.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 08:18:28 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0592.010; Mon, 9 Nov 2026 08:18:28 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v3 1/2] mmc: cqhci: Add support for setting the Send Status Command Idle Timer
Date: Mon,  9 Nov 2026 00:18:12 -0800
Message-Id: <20261109081813.3846-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109081813.3846-1-changhuang.liang@starfivetech.com>
References: <20261109081813.3846-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::22) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1233:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bec0e6b-fc6b-4964-7a74-08df3e3a0890
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|52116014|366016|18002099003|22082099003|6133799003|10067099003|261102130727099003|261028144727099003|261102123227099003|261022105027099003|261022075727099003|56012099006|261021121427099003|261026140227099003|261026121527099003|261009223027099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	ZAmppp6CZPO6N75cUHKdBkY9NDqpjZaPNdf6QXwqQVOtnGxGUkw28R0lDXXCZowM2RWElcL2Q+/uYvuEji9H/AbbaU2C+zxPfzWksPZUT40PUOoutNQI1M+WlF9FAgAoxvIIJAhTpEbJJu2dQo5vkc3w6Jix7OAYlpLRGCPASZfr0osGWq/qL9Yd/bwCG6krwpFZ3+2KSc49Z3/NkgLNjrZZv2rXtqEDBFgvLY5sTDdQze4LpE0qszVuNKRMhVUJT6iYpAmGpt6Szr38XcwjZYikumJuYC5pGC79Nm0NPTjTlcNLOAxm+0Ln5ldcL7lYK80vWmAKGUm2SjUxcrL9ReBdPokF1M1dvyBvUp18YAy1z74rZ/RNYofzb2xVUzzY54rzSu2XT1Zzs9vDNqf3baYq67X/NTq/gi+52nn35bIicX4m4UPnGTI0YkR8qunYPH8jogDE2TrFvo6khB5jkwT96bFbOGdRGgxdL5fcCcoEupNhMU3UY4EwsH74i1oOd4WA4L5s5KI9IJmSEAlf/7Gjlr1SoFLrylP3PoP4iWy+CHCGa3pm7YXOA/GcWKSf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(52116014)(366016)(18002099003)(22082099003)(6133799003)(10067099003)(261102130727099003)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(56012099006)(261021121427099003)(261026140227099003)(261026121527099003)(261009223027099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KjrVidWzTBu6EG5h5xWY0hNLnlICClvMVys4n7ICgBmCSiOks/WYPP61Y/e7?=
 =?us-ascii?Q?WWfk9oC8/fswdU9TDADPui7BDhEuXPpPOQdVwZNS8BC6U6S6SVU+B71zOcDV?=
 =?us-ascii?Q?xND/lG61m21tMhr76AeRPz2uGcrG9gXcjP4D06naKgdyyFCzPNriP0dIiq5D?=
 =?us-ascii?Q?6BwQ8BQ/LcGh04DU45skqds5/xodfHib7b4bPERvmi1DmI2seCbj8NxmOiOS?=
 =?us-ascii?Q?C2pJAFNfhvmaMIUrRFdQ7tbPSceXvZTle+VPaCfrk81OeC36x25om8Fz8SsB?=
 =?us-ascii?Q?yynHC2lJBnwXVTBMaV6rXmvidyZfhjBWcNut50dP+v9SP9OVg0tANOss+iv7?=
 =?us-ascii?Q?+7PJqxSerfzb5tPovBKLZ2lVEXWJ1gdqUsfQoPTvz5WCbEdRx/zpbXB7g/jI?=
 =?us-ascii?Q?IFpvwAIDKwUafCnD0Yt1bWQXICkoH0q6CcE64Lz2229MwCMBP3OQiks38Ir+?=
 =?us-ascii?Q?ynTb4pp2+/ZMDhDS9MO/WVG9SGOE2GGJyc2BqZ0V17OIDTI8Tej7LAzdEw3+?=
 =?us-ascii?Q?CikRsYb+DCuNs1EQtYx6ZuFJtnWPJYsvKR7cYQsyorTDM00blU3tFQ6cRrNB?=
 =?us-ascii?Q?oXKeq6M1mZdpg27WUT8H+zTtlLC0o8T6JYztTx42M/h5I9PQPxlom5HRQdgA?=
 =?us-ascii?Q?/bhAtsN+2ivk5TF3LsG3Vhluh2xFw7zZi3zAyzwsOILmGBkkTnIIjhWDZ6fm?=
 =?us-ascii?Q?0kHCAOqVD0dd6KwdYcD2HGzZaKL2rv/2Yp/Iz4pjR816F0tz/2xOE/plxmLh?=
 =?us-ascii?Q?RS4rjEth782VKvVIVAbLf+iwn5xjSSXjqj7oKCx0HVc5aAQe1hEHfYi8JDXS?=
 =?us-ascii?Q?zOLlz3l0MTb8obbBcvJI4z4FYaIlKFfz4FDmANnckbtkHMyMGekwNFomQwtS?=
 =?us-ascii?Q?7J5vN1ZOjMFusp6nGY/3d2hRu987KzlWxNxJE+Ib3wtBs/lhSFum11Pq6Eho?=
 =?us-ascii?Q?yrOANdzJ0m6xjB/0v64Rkm8wBa6Pph1fM21ERxIcKyxodH+Y+R3y/4cVok3C?=
 =?us-ascii?Q?vHu+ngwyDpQukLz6Ig+QHEU49yWQ8DYJBQH6Y+OfU0p+o/UxfKtxMaDaLa13?=
 =?us-ascii?Q?SL7gXTWGzlmVptxW0+x4cDd3IIyu446jnHDIKVEEp0NpS/3Q8k9ekD6jihSl?=
 =?us-ascii?Q?f/mS1Dk6munG3kAfBfJWWyM6ftuaptCXtFnLdazFEdSjCIdRFtE6SACmlxGA?=
 =?us-ascii?Q?vyuEG0LwJkkZQQ/llFKN7ykgkhu9dthKSVNbf36G1TlDRGz6ESGjTyg5xQpQ?=
 =?us-ascii?Q?EKFL+4cenlpS6qNv0mK621bEumNWDuXq2lWJonpjueus/5KuRzyjNJrSyaOy?=
 =?us-ascii?Q?iS8f/hEezPmMZEuV5ism9pIlLzylin5QdKldM9evdnxloMkZl11A7lKvHl5d?=
 =?us-ascii?Q?WcwOfRWtgnuEWvUF7cznNn/7soBsBZ5IZNfe8yNSThl1VHY/1d5XC/tmMAim?=
 =?us-ascii?Q?gfl5eCsU1pzn1L5pS9/Hvqb0Wb7WM/9w1HcbG0ph96hj5iKooK2QCQ6VZ/N4?=
 =?us-ascii?Q?UJVMwj5H6KEpsYHBh9RmGMsCVIIdnf6CDWRZj+O1Hp5QurdrAy+Cqg3qKeu/?=
 =?us-ascii?Q?guEDw8/0FTQH+GGzHyLJ4qn0iVyNpRjb7qQILfIULSEJHPrJIcjMWK9h7utF?=
 =?us-ascii?Q?GzlEhKORUcyvJlwsDU8WPB7EkviHT2jybuPxUaM2h8c13VGxK5QxOnsFyK5e?=
 =?us-ascii?Q?MX8XCkE8lyhj4h87/ZhCf3T7hawnPXPYTGUkMbqp2hKO3N4/mCUBxcL1V+M8?=
 =?us-ascii?Q?kkFocNxo3bN9pCoyRvgSPnPhPrgNVcyfqui0Qr7XHDYUAj2XJCTI?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bec0e6b-fc6b-4964-7a74-08df3e3a0890
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:18:28.4224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDam1PdAyacttNqBAdmvbgOMtcuf3IGf5HxdYVe/S3XvXB8yPgsQZsaHzDXVBYw/gSuNUP9LwtFmVeNsuYw7PxWG8wCtH20a6wRi7dEa+8Y8dT1LMNKhPY76WDeSgVrR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1233

Add cit_ns and cit members to struct cqhci_host so that host drivers can
set the Send Status Command Idle Timer (CIT) in CQHCI_SSC1, either in
nanoseconds or directly in internal timer clock cycles.

The CIT defines how long the bus has to be idle, in internal timer clock
cycles, before the CQE issues CMD13 to poll the Queue Status Register.
Its reset value is controller specific and can be far from optimal, so
host drivers may need to tune it for their platform.

If cit_ns is non-zero, cqhci_init() converts it to cycles of the internal
timer clock frequency (ITCF) derived from the ITCFMUL and ITCFVAL fields
of the CQHCI capabilities register. The result is rounded up so that the
programmed idle time is never shorter than requested. Expressing the
time in nanoseconds lets platforms with different ITCF share the same
setting. If the ITCF is not reported or the result does not fit the
16-bit CIT field, a warning is printed and cit is left unchanged. If
both are set, cit_ns takes precedence over cit.

If cit is non-zero, program it into CQHCI_SSC1 every time the CQE is
enabled in __cqhci_enable().

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/mmc/host/cqhci-core.c | 45 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.h      | 13 ++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index a466cd88b043..58182561e14e 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -279,6 +279,14 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 	cqhci_writel(cq_host, upper_32_bits(cq_host->desc_dma_base),
 		     CQHCI_TDLBAU);
 
+	if (cq_host->cit) {
+		u32 ssc1 = cqhci_readl(cq_host, CQHCI_SSC1);
+
+		ssc1 &= ~CQHCI_SSC1_CIT_MASK;
+		ssc1 |= FIELD_PREP(CQHCI_SSC1_CIT_MASK, cq_host->cit);
+		cqhci_writel(cq_host, ssc1, CQHCI_SSC1);
+	}
+
 	cqhci_writel(cq_host, cq_host->rca, CQHCI_SSC2);
 
 	cqhci_set_irqs(cq_host, 0);
@@ -1163,6 +1171,41 @@ struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev)
 }
 EXPORT_SYMBOL(cqhci_pltfm_init);
 
+static void cqhci_init_cit(struct cqhci_host *cq_host)
+{
+	u32 cap, itcfmul, itcfval;
+	u64 cit;
+
+	if (!cq_host->cit_ns)
+		return;
+
+	cap = cqhci_readl(cq_host, CQHCI_CAP);
+	itcfmul = CQHCI_ITCFMUL(cap);
+	itcfval = CQHCI_ITCFVAL(cap);
+
+	/* ITCFMUL: 0 = 1 kHz, 1 = 10 kHz, ..., 4 = 10 MHz, others reserved */
+	if (itcfmul > 4 || !itcfval) {
+		pr_warn("%s: cqhci: internal timer clock frequency not available (CAP 0x%08x), CIT not set\n",
+			mmc_hostname(cq_host->mmc), cap);
+		return;
+	}
+
+	/*
+	 * ITCF in kHz is int_pow(10, itcfmul) * itcfval, so kHz * ns / 10^6
+	 * gives the number of cycles. Round up so that the idle time is never
+	 * shorter than requested.
+	 */
+	cit = DIV_ROUND_UP_ULL(int_pow(10, itcfmul) * itcfval * cq_host->cit_ns,
+			       USEC_PER_SEC);
+	if (cit > FIELD_MAX(CQHCI_SSC1_CIT_MASK)) {
+		pr_warn("%s: cqhci: CIT %u ns out of range, CIT not set\n",
+			mmc_hostname(cq_host->mmc), cq_host->cit_ns);
+		return;
+	}
+
+	cq_host->cit = cit;
+}
+
 static unsigned int cqhci_ver_major(struct cqhci_host *cq_host)
 {
 	return CQHCI_VER_MAJOR(cqhci_readl(cq_host, CQHCI_VER));
@@ -1207,6 +1250,8 @@ int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc,
 		goto out_err;
 	}
 
+	cqhci_init_cit(cq_host);
+
 	spin_lock_init(&cq_host->lock);
 
 	init_completion(&cq_host->halt_comp);
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 8fbbc48c3f85..7381a2104449 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -26,6 +26,8 @@
 #define CQHCI_CAP_CS			0x10000000 /* Crypto Support */
 #define CQHCI_CAP_ITCFMUL		GENMASK(15, 12)
 #define CQHCI_ITCFMUL(x)		FIELD_GET(CQHCI_CAP_ITCFMUL, (x))
+#define CQHCI_CAP_ITCFVAL		GENMASK(9, 0)
+#define CQHCI_ITCFVAL(x)		FIELD_GET(CQHCI_CAP_ITCFVAL, (x))
 
 /* configuration */
 #define CQHCI_CFG			0x08
@@ -234,6 +236,17 @@ struct cqhci_host {
 	int num_slots;
 	int qcnt;
 
+	/*
+	 * Send Status Command Idle Timer (CIT), set by host drivers before
+	 * calling cqhci_init(), either in nanoseconds via @cit_ns or directly
+	 * in internal timer clock cycles via @cit. A non-zero @cit_ns takes
+	 * precedence and is converted to @cit by cqhci_init(). If the
+	 * conversion fails, @cit is left unchanged. A zero @cit keeps the
+	 * reset default.
+	 */
+	u32 cit_ns;
+	u16 cit;
+
 	u32 dcmd_slot;
 	u32 caps;
 #define CQHCI_TASK_DESC_SZ_128		0x1
-- 
2.25.1

