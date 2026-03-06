Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FFA3EF0C8;
	Fri,  6 Mar 2026 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813774; cv=fail; b=F77psO+t5Gr39kuuQIkzZxNZ07i6Ik37ewL0Qjuyr/68JDYoLQMCvRMnhEvR0moRC1nAkE+hlEi2eto/YMq/kvBPfwWP3+KHcRgzMPxdqbW9AOhSDPK+VxlVHE2r9zU3d1fy4AdW9q4Uj++9KZK1Wg7V1+lf22y3uoXkWqwlyIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813774; c=relaxed/simple;
	bh=kNosUMJ7Q9Fd4AM9znZbrGrSwpsSf/UG82QuzhDL7zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E23abnZxqv7kHqS1rXrSK439Yeu8CJjMGticR4HNgrGaxJnaF6NTBJP/2rjWHmI+7MCueAPcUhMQWeKdsKKi5/vg1KIq7I5hSTHAonC8ngPIVyFkOIa5+VW0p6Kcse2sknIj1wOkaSUqGjMf4yBnS7zhVyh9JAa8VhSGZmT5TSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cpMRVkmt; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cpMRVkmt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlliFqfWM1QizALikYEdZwz9f/AbnMQ9s+tPqau02kve9WourmRfpykUWzx3nCEHUzD0CGI4iamXZGy9UCDHuhSKSgnw/LAlo+GHSa5yDNOcjG9etjU9JhMfzd6oqX3ohvLNo0vWD/Sks1P1FfZE7eYrXm30hzv+8bV/mpO85Oj8tTfurWPG1x75rByGOCEIztnzkVsPYZ7euBeRIt/25/Jta90Nnz7Clx9Vjuw6sNrlu/PeO4Pj2juFHyBFDUWFtq4spdL+sj7tA/bgUxhQ2Hjg7IMw3AU9dBmTMYYr4mFi+8r25fy6oJqucnuiUxzsMdxxX/LBBeUrHwWCLO0VxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnYqCUntM/NX1ErrsJ9YH3zVBd+3l/01MTP4+SFTKvA=;
 b=m7dcDVn994Z0c+2vNhGT2uVq1a5WIo28Xb74DlQXxSBWR0dGz3XxQCQRCvVzpm0KYGTcHHYx12BeAOwKjPQfbT5fUsFtS1diZjyRMpUlbuTciwKKxjWls/q+B5pISiINDLdCSYbHObCZ9h581gCD3RANLur81Ix/cJIh3ie9kuhPtFva8EyOnuNog59swzgKljl2FvitP/9BMqccXOiZFDZU/cqAFiFaA347JMjjOxYLqeUmkkqGXYtWa3W6fEs3DiLXhtp+Ig3tDY/8F70D5kMKTuo7MRGapQ9YICWI/6cR/rZKeG1/L/aZVvEr2f9HNlplTTHO4iC0N6mJrdOdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnYqCUntM/NX1ErrsJ9YH3zVBd+3l/01MTP4+SFTKvA=;
 b=cpMRVkmtb9sGY1yMrcxLohSGnP1qspYJpbmWMmro7aQKh6Xbftkq2Nrq8kITsU1qk+K+6HaCRx88LSa+D7lfsD9IGKtnDfuOKCy64XQ7kG/JiW4A/P0maaStMi0CYxYBmfHlEo/v7S48nup8Vh02PwlB+k9ZxQdvJ2ew6x7/togc6g6/6I8fQ5qHDDmSD64WoGaYdFas1SKesSGfb8WxCPe0LlrvNvtptOwgb4zXTEUNo8446GUq0671BvYGZJlMTdTYJFuiF/VWb/DCzq+evbWPqzZDjuH+eFAUJd61H0E9bEWPEJw69ypcKToe9JsENFsppKvo/GSOBEJGVGqoKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB8606.eurprd04.prod.outlook.com (2603:10a6:102:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 16:16:06 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 16:16:06 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH v4 5/8] irqchip/imx-irqsteer: add NXP S32N79 support
Date: Fri,  6 Mar 2026 17:15:52 +0100
Message-ID: <20260306161555.9000-6-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
References: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0149.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 49498b14-414b-41f0-ed6a-08de7b9bab6b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	5boPQ07VwvrHn//2NJhzLd5oNioa3MiOe8AhyTukIYnZdsesAl6N5ma7GfGoDtwZXf0RDVZnBjpHPyOOTZoejutZBbeuHF8CcAkSJ+a2mQkaoMt9XijdkTkvbxjPD0/QVXqPWCLQIiPtOHLZ66vFWcRU/42vDX6Dkuny8GK6i0j3Bnp5078v8kUeKSJ3k3IPbgpZh+/kGU1BWN9fhpx+6LBL6spswxAqQwQz18uDYYUDXgghv4MHjx/ZHApPiRBgJv/ijRrhucoF0VCRnuZHDgt+ozxYPkUgi2LmC4kmPvaLeuzCAbauGHY5cQHOTnZu/07w+THiAk5EA06CNlCQasxl+NlAgaCXe7ZgA0DPosCrEw7lQy7zH3ZqzCCIVQI+NaCIhRTOfpzM1yOFiV1LcjpJRgOQzxmHj2Ss8XPCp9QT09JAoQUPf2fVpumo41bAmdcfdhQ4ZstgUQpPsdcYXt0CI8k8OfdZMztgwjuA9NJidUDZDq0CQSsCeg3IjiE2hgkinMXlq8QncoDAO1ZGlO/24dqk07OsMr1Ll18MzyrlhiSTe+xAzQBhdAIaVJeJmjJWETh5xEZULg5r1tcTPRm25pWJ33HXbUL1dCPmBrDm0YyCEeIn1/PTW+whrsdEH4bfWFewdlGFEstPV1Y4ue6rTtX8kNsuGtEFC3o8wg9JmKG0arwyqRlfnPTkZjr8g3odzUJ13xXz0xZvGRDH2Gbj9MB/t1JueZmYtKtHKm93v/5kq26bPw2+AiMBCkmhgHwMK2UfB+mbQlo+6BEHNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHVtYkpVVGZOL1NCb3Qxelo0bnQ5Sk8wQWtWSXpwS3d3TFlhSGxiOU9xMnAw?=
 =?utf-8?B?V2JmRUV6MGkwc3pLZnR1bmFUaEErdlFhZk5OaW43bnExS0NZL2k4QWs2R1Ru?=
 =?utf-8?B?TEVha2RvTkx6amkwSk5iWHFzd0lBQytNdldxZkg1dDZQWHZkejkwVlN4cjQ3?=
 =?utf-8?B?NVJQWnNMZUF4cTJOV1hib0E1SHRtbmtWclVjNWdDTWcwMktIOW9RdWZrdVNQ?=
 =?utf-8?B?aWw5NlhoeDRET0pqdjdrMThtNGZncUNRWCtYN2xQVWZuWTNwRHV1MnkxWWVQ?=
 =?utf-8?B?N0poMElVaytzakNGcGM4bjlRTmhMYzhnWGdGWWtJeE1qNW9ybGVrOTV3aVRy?=
 =?utf-8?B?RzJrWXo2aFdFdytyWStzRmZqQ3dyamZtQkxQeElNZ0VJdUxneld4VnJjczJz?=
 =?utf-8?B?REFySHpxekpFcTRCeGtDZ3NVRGFZNE9GbEZabmlYVERuaUdxMGpCSVdqcEhI?=
 =?utf-8?B?L0h2Q2E2OC92RVhYOFhTSWZsb3BtRUllcmludERpM3JTcWRwMnRsU3BHUDla?=
 =?utf-8?B?N3dzN044d3NMQm9jeXVOekY5dmZ4QzFMb3RxWmJBSHkyTGZFTERwOCtQZmQ3?=
 =?utf-8?B?alR3YW52b0syM3BMMmNSK01oQXhuRFFsSGdGNUh4YnBVMG9Xd0tBSXJIYzdu?=
 =?utf-8?B?aG5QVmtiYUI4cHNnNjVuVWFSMG41NTcvdHM0Ni9pVVY0bTR1WGx0dTF0eXlL?=
 =?utf-8?B?TnJSa2hLQTNyREs1WUNjcVlaelFIZ05YTXR4cGtLckJvRW4wejJQN3NwaUJF?=
 =?utf-8?B?R25NWXdJQ2pRWk9BNzMyN1loVFhxaGJkelY2emZuUWl6V1dnQzhsMUQxTW05?=
 =?utf-8?B?a1NJeWFxVGlKZGRBMnlCTlM3VEVySmdWYkM2TDJlN0ZtY0MrOXVhZjJRcjlW?=
 =?utf-8?B?ZlNOOVRjNkdVc3FtTnMyVmZkaitQYTFsdDNzbDdIY00xaXdMN043MUxpQVR5?=
 =?utf-8?B?WVpIRmxleTN1WkFPR25Ud1dXNytVSmVUQ0lmcFJBVWNjZzFHbk1mVERlVTlU?=
 =?utf-8?B?N0JjYTZIYVhjckhDTE9YbnVkYUFtNGpsd0hONUxuTFExL0orZ0JPOFFFTm5w?=
 =?utf-8?B?QzJFdWJXU0g3SVZwV1ZoR2tMMzNKT3dic0FnT0J3VmRHSVluMW4wemhQZDRM?=
 =?utf-8?B?T1MyUTRsb2diNFVLa2hNclVCSHhhVmdZZjk0cE9oUUczWDB2NE93NFpmUXVs?=
 =?utf-8?B?RVI1Y3RpaU5nL2drSUErMlpYZ0NkalVtaFYyYTJYRzBBMHN1NCtiSkFTbHov?=
 =?utf-8?B?YTBEZFpCNEtZN3RWNERvcE5CMEdUSXhQcmYvM1lWTE8vMUMyVkNmN2xuSGlj?=
 =?utf-8?B?Ni9ldFRJZWcvY2lwMHhJMmRNRHdwTjlMVDFhZU5tSjBob2drVC83RHFBUmZW?=
 =?utf-8?B?SVczbzdXc2x0eUpWWk1TS3NhcldvMFd1Zk1XUWZhc3Vpc2RSZ3NjS0w5VEo0?=
 =?utf-8?B?b2hkTzArSTZEeDIzd1FmQ29GM09MWmN3VFFycGxlZ1N0SzVHRkVsWHZldEJv?=
 =?utf-8?B?MHM0T2RSbzBpQW4relpRVDNOYm5OOWUwV2dEdUJvMERnNExCSWhDY1J5ZXg1?=
 =?utf-8?B?SkNXTk93M0NDSU94VitWQnI2QjIxdy9uT3BvdTN3QnF6bERxUUVVaXRybUl6?=
 =?utf-8?B?ZTRkd29vaEdhZmFQbEQ5NUpiRDJwWXBxY3dZbWhMUTJENU9DWjlmOFRQNHJv?=
 =?utf-8?B?K052VnZuWUw4TDE1MkxwSUFVaWE2ZG45N2U5Mk1oSERGd1d1ZitDTENXMEM0?=
 =?utf-8?B?NnJPcTVpRjdhSkYrcUZuU2tBdGdQTEJ0anFzTFRGTlNoWFNLaHA5TllCTUw2?=
 =?utf-8?B?ZnhGaGFSSk5WcHlrK29lN2J3RVN4S0FkYmJoQmlDY2Q2dDFaU0t2M3VpeTRw?=
 =?utf-8?B?NkRtbXJod3dveUpYNG1kQzBpZmZpODc5ODROTXo3RW5JL1pheVI3SlNUVFpy?=
 =?utf-8?B?M2h6RzlWczV4T3puK3FaZ0NXSGJ3dGVZRk5kOXc2ZFlKS0xMeG9rK1I5TFZS?=
 =?utf-8?B?bDUxR2JlcEhVQk5VQ29KalFZSFpEY2JZVkoxNnE4b3ZzZElWVlNhZHFlejl0?=
 =?utf-8?B?MlcxM1lJN0lwUld6SUwvNFRuQjFwbGJKZU95WTdpemRwNGxsaUxBemU3Y21l?=
 =?utf-8?B?TzZPQUw1NVBiY1hDeUJxNTlUNnF3Z2Noa0tmNERZbDFTTEZTYyt1QkZqZEpW?=
 =?utf-8?B?eXd4dmc3S3pnblhpdW5KckRxRHd6VmZ4N1dvL1l3UEhmYU8zMEZWQklubGd4?=
 =?utf-8?B?M2Q3d2IzdUJ2bmdrTEUwaExLN1kwaDN2T0tqT3hPNXlWVGkxbVVJMTNYRlJp?=
 =?utf-8?B?NjNmR1hWdW40Y3dqTDhRdDUyc0VJdktEanIzRXEwSm9WQUQ2Z2krbVF3bUo0?=
 =?utf-8?Q?ixs80zLmYyXq44RA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49498b14-414b-41f0-ed6a-08de7b9bab6b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:16:06.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1338DUx4idPiLC71PNNIsd276dbwiAixmgv/kk9CEO1dxd2yH7FJd0DF+ZpX5Jklbtvx1ZLdHljlNPT5Xte0+iom5O3gAZQ3pzpCN6X6P08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8606

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add support for the interrupt steering controller found in NXP S32N79
series automotive SoCs.

The S32N79 IRQ_STEER variant differs from the i.MX version by not
implementing the CHANCTRL register. To handle this hardware difference,
introduce a device type data structure with quirks field. The
IRQSTEER_QUIRK_NO_CHANCTRL quirk skips CHANCTRL register access for S32N79
variants.

The interrupt routing functionality and register layout are otherwise
identical between the two variants.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/irqchip/irq-imx-irqsteer.c | 35 +++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 4682ce5bf8d3..82e64af87c0b 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -26,6 +26,13 @@
 
 #define CHAN_MAX_OUTPUT_INT	0xF
 
+/* SoC does not implement the CHANCTRL register */
+#define IRQSTEER_QUIRK_NO_CHANCTRL	BIT(0)
+
+struct irqsteer_devtype_data {
+	u32 quirks;
+};
+
 struct irqsteer_data {
 	void __iomem		*regs;
 	struct clk		*ipg_clk;
@@ -37,8 +44,22 @@ struct irqsteer_data {
 	struct irq_domain	*domain;
 	u32			*saved_reg;
 	struct device		*dev;
+	const struct irqsteer_devtype_data *devtype_data;
 };
 
+static const struct irqsteer_devtype_data imx_data = {
+	.quirks = 0,
+};
+
+static const struct irqsteer_devtype_data s32n79_data = {
+	.quirks = IRQSTEER_QUIRK_NO_CHANCTRL,
+};
+
+static bool irqsteer_has_chanctrl(const struct irqsteer_devtype_data *data)
+{
+	return !(data->quirks & IRQSTEER_QUIRK_NO_CHANCTRL);
+}
+
 static int imx_irqsteer_get_reg_index(struct irqsteer_data *data,
 				      unsigned long irqnum)
 {
@@ -188,6 +209,10 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	data->devtype_data = device_get_match_data(&pdev->dev);
+	if (!data->devtype_data)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				"failed to match device data\n");
 	/*
 	 * There is one output irq for each group of 64 inputs.
 	 * One register bit map can represent 32 input interrupts.
@@ -210,7 +235,8 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	}
 
 	/* steer all IRQs into configured channel */
-	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
+	if (irqsteer_has_chanctrl(data->devtype_data))
+		writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
 
 	data->domain = irq_domain_create_linear(dev_fwnode(&pdev->dev), data->reg_num * 32,
 						&imx_irqsteer_domain_ops, data);
@@ -279,7 +305,9 @@ static void imx_irqsteer_restore_regs(struct irqsteer_data *data)
 {
 	int i;
 
-	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
+	if (irqsteer_has_chanctrl(data->devtype_data))
+		writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
+
 	for (i = 0; i < data->reg_num; i++)
 		writel_relaxed(data->saved_reg[i],
 			       data->regs + CHANMASK(i, data->reg_num));
@@ -319,7 +347,8 @@ static const struct dev_pm_ops imx_irqsteer_pm_ops = {
 };
 
 static const struct of_device_id imx_irqsteer_dt_ids[] = {
-	{ .compatible = "fsl,imx-irqsteer", },
+	{ .compatible = "fsl,imx-irqsteer", .data = &imx_data },
+	{ .compatible = "nxp,s32n79-irqsteer", .data = &s32n79_data },
 	{},
 };
 
-- 
2.43.0

