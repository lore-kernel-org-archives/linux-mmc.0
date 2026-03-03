Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D325F994;
	Tue,  3 Mar 2026 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571735; cv=fail; b=K7xhGrnLb5IAmrbXY//WjFcF0F0H2BnyugjSSDtxASp6lSy0B4XAutZuTUXgd1URDWOLh512P/zZpt7GvZWO0LVjdL89oY2iRjLJPrUoeYkDhElWLwNFxQTOd6b0gIRzmsdy9atiIHKXT5nV9wjocfo/D+U3WWnNW0m+MUjISQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571735; c=relaxed/simple;
	bh=ZSH4tdQY6DaDcy/0bEm/xvC1Ubk+l3AGfvLzSmBq6c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d9ENbHVXJHZQq0dGtovPSHrKssh96rAvLbssZrRd1xXht/6OQc8JpJ2AWpTpXNcNErdbOTyvu8uAFt8SnkDxIJnZZGAQNlviBcgyv6DxZHwYwU4uCLntm7SACtpm8aa8xbe0ZKbImnjwV3FTl4Ak/sBvRKekdrIhgeInDAGhcDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D4EgbyVu; arc=fail smtp.client-ip=52.101.84.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D4EgbyVu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aThXCsb2qtKWQEzFIOachGVHjTRbTU1Cp6qMjdHWYUh7kVpZIJOzLHK4H+Tx1NPg9O/JnDi2nnjOAA0NETe54bJjao/ntRwmYt0+f9Q41DS/chNmD+0Zkwb10mvFjho9rG5m3RTfhlUGLTlJ5keY5gm2OAo50OyeWA0TGSCIWJAYp5IRbb7CWFzmbs5zB51lbEDK8T6HC4bDt3W05DzuD0NzVAYriOaII6xlLZNkpHPVBJLdL4BdJM0DbRCg4LPhhKC5yQErXGiWC2zyhWgmmhe9Avd0uDkNw7crLtLN7s67h/4D/3uqLhNB9Mm6EbvVOcEYeU57wy6zFMEev6dT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/j+Qfuks9FpeNz1Q+hg781aA5sdGqHdRURc/ksIV4E=;
 b=X7cTrAN9uArxO659oY0i50ST2GsnOd6cUhYq22YL8KpsiEBx7ZCTLakoXd1c4fj3U4yJzLYog55cQR68gRabsg5bQc3/ZEoommfQWW7fSx9NBOxADj3fK800XSsZJUnsO7H9a/9zGMXGFNojWp53EzPQV0Cf/krihrUkqoxJOgfY46mZmWMdlm4IMXtssvguoiSKFuUEGwGDBSNeS9RzlYgriRns/AGW63xD94nowwuuC9LGKJ5KrcLyyVDWCacqxVEOvzr2NmkI48tVGasG7hxN7tjf7SERIVlxwYXhFCaEjjs6Bl3vVDKLmgvMGA5BU7mIKlevHeg0V5zpq74CwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/j+Qfuks9FpeNz1Q+hg781aA5sdGqHdRURc/ksIV4E=;
 b=D4EgbyVu9j1AWr7n7fm/s8PwbG1fkFQmMXEuEHC9FXt4xmzKM8yy6n29jrqso31os9WMlKYMmBwNnPFNtxctY4vhqxiT/fZBP3sxKK89jmOZo+nLWu4JhVU2WwdDskQiIT+wHNNMLXYhb5/YhgeqNeY6pDV1suR6QRXv7xPsiDmOD9dfF/GHGvs0xg9DuCf9pZY0VXZ93C+QcJ15YmqOppcVnjL5K+zS2PU0ZDd/0fp4DcYiS2jjihR35FnioVUp75+wOrwZa/LB0+XCYlr1Zyo0xPyx55QSbf0G8U/hT/EUOrZYoJxEiJw8xqvzutkizX8uyK0iC1nesRHAm4KWkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVUPR04MB12217.eurprd04.prod.outlook.com (2603:10a6:150:33d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 21:02:09 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 21:02:09 +0000
From: Frank Li <Frank.Li@nxp.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: Frank Li <frank.li@nxp.com>,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mmc: sdhci: fix timing selection for 1-bit bus width
Date: Tue,  3 Mar 2026 16:00:58 -0500
Message-ID: <20260303210131.2966214-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303105006.989339-2-ziniu.wang_1@nxp.com>
References: <20260303105006.989339-2-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVUPR04MB12217:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5e417f-ca94-42d5-6743-08de79682253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	USkw9NFXkJxp28zvLBPBN/aDpPpEuMTjBGPSQq1bjNiDEP5bQhyfgtYLlaGakIa3+iCQQorCSXLuuV3MWK7ZfPI3RIPSRUJra0bCFtcuFjpCj6AetdofJPyKcKybxsrLhtS3XAPW6KNNIgpuqtV10zsbW/qReHYXQvqJzH/D510UfhjRF4lQlz1eGoURrXVEeovqbpyNW0nksYLNZXTP4SjHG3O8pq9m/dyvbVDew4cE6J6Lk4CgkLhnkNpZ+WRz+okWDNKMCiylH7WrnoJiEMQkrUghyy57NI7rMPLeVYcs1/SpQng8Tp9N/W8xtwf8xVpKSbdOXyJ/2kHAorrWqmrqoHEXBa+fs/gqLjZLwy+hmfF0kzmlaAeLCvW6RZ+09F4vhILFe2JFztRUlpjirYpI8n/jUO1Ip1br0TKtx5MurKgIYpBXTSJmiV7IHzuDcAxJ1oEwlnpl69CERcSisgspSISWSeX3TFs2O8+5KcSukSgiSkOI8292lsuw65Y7xip3jeLnKskwbuFkCwDlexseqAWDBsWVwwQgUi5QjLsrzpfrJ64wvG7Uc7Yms/GbQMCFRa3XHpvq4fNFtF7aWeTx1EIwRWbm9FCIDW9eosN3U7W7tsFI1v6HfH2y/dv0T97K3LjcRQ4Kv+k+9FI33x4ALPNh+kTxpNp9wg+mEnj0UM5klP+KVvghxmxEKZwZntdCGdcDGnUBqPjefb9t1Vn42w/q25EymPhVetWQ0S/iZs9vjlN3x3Pat7cOKuy4DZ5NDJh5vjkDSVyimhbf7/gY8ufFE0YmVsW9UfD7S0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnFlQUlPdmxsUUk2Y0w3VFQ0WjVrRm1MWmhHTjlPMEFYWnd1ZXZXMHhsU3dK?=
 =?utf-8?B?SEtIOVBNV2gvZnBYeVFuUzMydm1EVS9CWHhuMDlCSVVRQnk0ME5EQkl4WmFL?=
 =?utf-8?B?S2xNcHY1d3JvL1diL3BYa0JOemFsTHc3OWIzc3pUa0U1L0t4R3lKR2tTQXU0?=
 =?utf-8?B?ZnRFejd3OWtqUzNHUkJNZ09lZS9YQzF1MUVVVU8wakU0S1VaV1pTdDQwMis1?=
 =?utf-8?B?TzkwdlU0R3UxMEw3Y20zRTdkd1BMdXNqc2hiL085emlSbmQ1bVBtSndXUFZy?=
 =?utf-8?B?YzQvdFNoenVjYWN1NTNEWi9ScGZEV0tvbkorVnhDc0VSRUdQcWExaWxOUFF2?=
 =?utf-8?B?V3AveUtBTXVzYjFiWXdvQ2REdnlySjU2cjY5N01vOGVIRWY0ZFE1WHJrdzRa?=
 =?utf-8?B?a0pDdUlZSStIVkZWSTNCYVFRQ2VUQzdjTGNrWjJpNVlHRFBrNTYxZGJQZ0pC?=
 =?utf-8?B?N2Ric0pYT2hsSFU5YVJDbzN3RTl3aDFOd296cmh6a2RHZVcxeHpSK09uTmwy?=
 =?utf-8?B?YTh0a09FeTZXZElxblJHNFVDWlhkRmpsMytMcnd2MDErSXVoNlVkcmkrbW1V?=
 =?utf-8?B?WVZOY0k2cmFTYzArWEhsT2JHd1Zsd2tiZ0V6dVFlMmtQYTBwMTNLSGlJcE8r?=
 =?utf-8?B?YUUvVTdBUlRDYktOenljRjlZaXlvcHNkaXRoN3hxRmpXUXdZdCtsVkUrSG1J?=
 =?utf-8?B?VUliTmxtSUlaZEVZQWtUN2hmMXJuNEdxUEE4L2pPenEzRHZ3VEFWcmRnK0c2?=
 =?utf-8?B?NmRabktob1U0OTFYQ29abVF1ZHNKbFNWMXU4ZVRqMTdXaGp4M0NUZDl4VlFG?=
 =?utf-8?B?SExCd0RseHRKVkx3cnVVV0UrbGtSMkg4Nmovck1Nb2dleUlGeHlBVWltZjJ3?=
 =?utf-8?B?ZnNzTlU1ZHpqdVRJK2Fuc0kzUURMNHVRS1NTSHF1ZHYrWURFRllhb1hycjJj?=
 =?utf-8?B?RDR3RjBRK1ZMVi9kZzRwcUkya0x6K1VMQm9tQ1NtTHZGeXZtVkREY3JnWUh1?=
 =?utf-8?B?L2c0OGYyTVgzb2lFVW4wWTJhbEJHZ3laS3E4WmwwVkhDSXFTV1p5MUVWWXJT?=
 =?utf-8?B?ZEEyUmFHazBtLzRjMjhjeXA0TWhWVGlrazJuZHQybEZ2T2orRlF5Qy93eWxE?=
 =?utf-8?B?RzNobkJTTEVYOTYzdE1xL0s4Y1BLYzI1R3c0ZnlOMG1LZE9ieU51NlVWbHdC?=
 =?utf-8?B?OUV3WnhTUjBHMy9vZTNaWjh2WUpjcFJWYXR5eGsxVVlycXh1Z01jZm8zMWJN?=
 =?utf-8?B?V29HeTlnUUtqVjY0SkRFdUJYU0xFK2FLNThVZ2JWN2QvTHRnNE93YTRBaXY3?=
 =?utf-8?B?QXpsWVd4cUtBS2RQenB5bWNSYS9xZFRtcFZNWGRLZ3FHLzhqaXZFSTd5OU94?=
 =?utf-8?B?SDZ1aGIrNjdINDlGVGVtR2hPOFo1QVJhRFFDZmhMT3R1eEhSKzBubkFIMlVZ?=
 =?utf-8?B?K3dpeUV3Sm1id3Y4L01hSU95L0dGQ2Jrd2hvM2dOWmZ0M1F3KzFlVXYyclUr?=
 =?utf-8?B?TFY3WUlRb0NQUGxiYXFhUXhMVWR1QlEwV1BJQTRyT0RWOWtOa3RTb1l5c0M1?=
 =?utf-8?B?bHN4clZKcFUyZTVaY2cwSVdZTlpubG9jc09oUzlxKyt6UTBOZzhGMFRrb0xw?=
 =?utf-8?B?TFpSR0ZCNUVEL1JsT0dmcHUyTmJOdGJrVmptdlllL1M3cHoyK3lmQ2tCWVBh?=
 =?utf-8?B?R2pOMjZ2bG1NVGY0OFFvVjB6dWtPaFdEZktBaGxhZnQ2T1NGZlZBV2k3czhD?=
 =?utf-8?B?bXYrQ0hYd25rc28rOUV4RkMrT1htbGpwYVd4QXQrRTFtZ0d6Vm9hTWc1ZGNl?=
 =?utf-8?B?dDdycHRSTUd1R1p1KzVIODEvUGtXWXdQa09RRTlSTkxCcGI0M1FNTjZrWUR0?=
 =?utf-8?B?cUloa2FhYWVqRi82YWJlYkhlK1VCSFQyUUtFaWV0MjltWjA1SHArY01TbEND?=
 =?utf-8?B?UEQxZXNxeFdveGpYMnZiamIyQ3FTNUp6ekNpYlhBQzRHSFJxd0kzTjZiOVQ3?=
 =?utf-8?B?RXJneWhFQ0hiRXlYUUJPeis4Rkl6NE1xbmVwSlluMytoSUFwb3R2K3lOUG5I?=
 =?utf-8?B?ZVU2WHUxcndMVGdhMVBONDA5bGtOK1I5VVQzK0N1Q01PV1hyTitFWlYxMGVj?=
 =?utf-8?B?cTZvaEhjOFluS3hqVWVrT2tmbFBTSGlaWStyZ09sMEQ3NWt3UTRCSGx6eUdU?=
 =?utf-8?B?bTA5aGR0bFFGS0lYbDN0Qkdrb01peWRzdnZMeG1sQmVENU1pOHB6K0RXUHpx?=
 =?utf-8?B?WkQxa2F1dkNTZk9wMEJBK1JidWpBUjhudXlnN1Q4OTJzR2liYitHTjVnY01i?=
 =?utf-8?B?dzRnRHpRamI5a3cwLzN6VkpzQkp4YmZSTkJTdWF5YzhqOVRFNG1Fdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5e417f-ca94-42d5-6743-08de79682253
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 21:02:09.5646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZZ+wlVvnpy/bf+mgZ82RLAesoLERo86hQDUjPlwTGhlXg1nf+x/z6ge3C8MFLtFDaLX1nmkAFTY65cebb1S0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR04MB12217

From: Frank Li (AI-BOT) <frank.li@nxp.com>

Subject: Re: [PATCH v2 1/4] mmc: sdhci: fix timing selection for 1-bit bus width

> -	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> +	if (host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA) {
> +		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
> +				 SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_HS400);
> +		mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
> +		mmc->caps &= ~(MMC_CAP_DDR | MMC_CAP_UHS);
> +	} else {
>  		mmc->caps |= MMC_CAP_4_BIT_DATA;
> +	}

The logic inversion here is correct and the fix addresses the root cause
per JEDEC spec. However, consider whether clearing MMC_CAP_UHS is
necessary—UHS modes require 4-bit width anyway, so this may be redundant
with the SDR104/SDR50/DDR50 clears. If intentional for belt-and-suspenders
safety, add a brief comment explaining why.

Also verify that mmc pointer is always valid at this point in
sdhci_setup_host(). If there's any path where mmc could be NULL, the
new code will crash.

AI bot review and may be useless.
