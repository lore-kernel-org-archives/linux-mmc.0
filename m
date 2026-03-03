Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F923388E42;
	Tue,  3 Mar 2026 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571736; cv=fail; b=T9pPD8qME893EKJindsTJe8Wf/fshNAbZTtw95sDojueLeNTQZmxZS5CBhALJAA9uSUbUpxaKNEZgbOgmboV2o7ohU1DpTMs+dmDKh+fSyGc4R1q1JzGVUAxh0/2QLVxdcGjcVBGBR5PAItIusq3l3Z2AeWJ1sCVXEhCOANMta0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571736; c=relaxed/simple;
	bh=Yt5Xt8B4e/lCBZA293H5+zF97+PrXLXxwTchhIriUK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ky8sRnWOvUV8TrMz2UIUoh1xc/OZGUfO2ZdPUllXHMIGeh/qgtQ9EeGvzzbJBx2xcIsbIQbYpWlJeGMD3oov28vVwxhTP+VCOe8g/QIFKB8+qprB564gAYGKvUOrX6FyqQxuCDKAqjynDSrGDcRA+CxYwI3s9ujCfV+ThFf+XQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=El3gcCWx; arc=fail smtp.client-ip=52.101.84.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="El3gcCWx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2kgtoi9WV/8W/Z4XRAj4QhBbCw6yg7LJbSpAyFIZoTTPw/J262IUbmddVSf5hK04W5/ALpQ0CM+IWMqshXeyw3N/CO8JZOqfPqP3A6bJEOhqozNe21r0Fc57hJWx0V8HaPb5HkWpHOWGTFha22NYf4qb4x6ZU/cIkm2WI1C1mEIy8yY/B/5s8VjZhu0EJEQlwOtSOz3dgFQvPQcpO6GcIQCZ5mPNhkRjs9tLuJP7DopWkaHWBzjoRB7AtQ4IB6UvAQhD0bPb9LhKKtTQqQc4xXU8MOHKAzebsOrRvhGSv/gWTf+xK4w0uDC9/3bDid4paIaf5D7359suHa2hFvWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXJnPIOHXXUIv5PzWLZdBNOwG8kk6FxMRI8zVHLjeOs=;
 b=EhTTxHwN/rF3GJsXud3jnWkhVi5Us+Pkix0XbCUbWF0Z0AhJVJVzUtUIEyNmJk5iFhEUNIEUsgxUtry7Ak2Z4WnHkMteTAAtg96+EJc4xkm9SNBNRmHF5ocRFfScGn0FXUafXNNYszSMEoy/z2uWHK/5ATb/huOzo6W3RBZKdPnPC7h6k/zPduYXyjfMX9gCz3OsyyMTq91kRPorORZHSfJLz4AkgwUtXXM/Vzm4CZjYsJ4u9CAaUXQbOTmNU8Y4TZDQQIbTCEM5gtvk+hNe6ojtsQcw4Ajtd+w670Yokj2VhGIdvPn4Ijs3/AtoUucNZSb6dAjNifCqH79lrIScuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXJnPIOHXXUIv5PzWLZdBNOwG8kk6FxMRI8zVHLjeOs=;
 b=El3gcCWx4iTjBT8p9KYUFOnhh5qSJvopAEyn+uHJUHbjsl+uXlSwnABWaFLCSqv9kj0XhvUKXXuTtqN0fqBrxiCfp5s8FUa8wWN+wcSrndU/IEGl6RZ6vhpPYlZ3f1oqXsSc5rCrIxwXAfmZe2Gvj8OjS5n5mOZaLx/Ya1IFsLIonHhcwzv3wn4Z5CmCpYpNAa7HZEEHiPcqZcHMjxotMqsAPN67fov4PkMcKnCG63woXNSXaOqgXyzkLQpeZEa7Of10oV67KXB4u0/R23vKUUZrHfxJhTbfKjXdbO8eICf5QR59qR0kJ4oO/njXb/isDs/DwlBXY151eRW2LKEuqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVUPR04MB12217.eurprd04.prod.outlook.com (2603:10a6:150:33d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 21:02:12 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 21:02:12 +0000
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
Subject: Re: [PATCH v2 2/4] mmc: sdhci-esdhc-imx: add 1-bit bus width support
Date: Tue,  3 Mar 2026 16:00:59 -0500
Message-ID: <20260303210131.2966214-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303105006.989339-3-ziniu.wang_1@nxp.com>
References: <20260303105006.989339-3-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
X-MS-Office365-Filtering-Correlation-Id: 11ff85f4-e25d-4cc7-1f02-08de796823e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	vnsE+fGysO1b+NfbHUUA7S+d9Jg8EIN2OAObbnss3DHMZmIBFJTybxslI7bdCZN76j7wv/LeLkuOFnGEhHhdoUexaR/DcE3ri6wV/rq9r009vCjW7sjTQHEuLJAcrr4doE3G34JZV2sngyXpqz+LjtgmpsIW7dmly2QZmApKvc8DQwdiys/V324bPhrC+IWoVsmhVXJS4ejf+I0w+LyuzeXj+kA3RUTRp0uXawCg6nReWyNUP1QTbWyR10SXPWlZSzEkODz+raj+j35A1AlJbDenZARDCaUbqRPDLqHjlaGnydj5oLGs9kTqknIviWKDIYQpw+nhruhZB265XjiTSpbJoVu+sGSybCKrZ+qTqD1HDTmLrCoVqjMAuWNQoaso+PGuxcR0xBWT28ErBJSxy4A1ZbN7NQzvQu/8RTDrmgB2oit+LriaMKVwcGbQDfvarI5w33pyYXEcs4gNod4ZMamsNgeEZ/JmtG5PZ2O0utzVOta0/u3XA8os3WtgJsjhSQyFacgOvT2Z3m1XIneDFil6SnoYWC7+8RjEbRQ3vGcoemoc/89cvtmhydkeKi0bloEFIsL2q2ZaZjzIozCFwrAP53kqIeRWtq6M+jCtrDgqLwjs7xenXAxsNIeYG1Dg+eiiPKTLGSSKm6EALJy+0RcdIPC05qr9F5Ly1DO747nYV2MSHDcj4IdNS96Mq8na+kaiQn/5DcRsY4ppmOZA5mXREYmCzMxYuG4Ml4+/1r2bsM+R7nByqTZEYfPOhQ1AyTk8gs6BQ3j2x2kN431KwyWrr+2n1CgusmOCO3YVaT4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WuvEJzasjF8+dLg+fUPdbi5TBAPVcsTRLEV8U/DY4E09aYvakXORd4F+Dosu?=
 =?us-ascii?Q?wUEywrAxLnPVnJYVvezAD0e20v1HP7wH3RmdjlVhVITlk00nKNoDJYDLWQXl?=
 =?us-ascii?Q?eGQKojfWi1+wHf8hN8JS3yATarf2hwrIM7OcyXTfoSgVW7RZWiyab1cXZo1d?=
 =?us-ascii?Q?W/ye51myMdakBPwaYy6xKeCwkSIL+23TpGurcV8lPu1OZ1DDpsvYSvA7u+Po?=
 =?us-ascii?Q?nbGD+tGOTH4L+LK+SBCscojBZSE+KGS8nVIvvpS7uTQpH5TSUorLs0swpjVL?=
 =?us-ascii?Q?lohEyydMMYSDLLjdcvYNpZe+pYWD7Vw+vkn1wD0mKcELxG88wVm8e2m9mFlJ?=
 =?us-ascii?Q?JkT0Gd2Gk8V8CiNE3n8SHWKkNXhYlnQpUU0tO4efqxAD7EKN+q6gOhbr8xpU?=
 =?us-ascii?Q?W8vhiistc8QFWSEiCss5es6nMmsE27NjIlmZaG8HRg/msnod9w/UkNAfD46s?=
 =?us-ascii?Q?KXRCRfr1oHx3efFc/J+qTvpfgv0ximHkwruQ0D8qsg7l76hMML09ORrGXj91?=
 =?us-ascii?Q?BrPLhTAWZ1xHs+A1Zl8G74dVqTVUHIroZPkFF4V8wjUPZTx1glRgYXx0lMx7?=
 =?us-ascii?Q?ZFwLflaY+dQTFNTzTamFCSS9bei072XNSAvkUehU2h7cf+LeduMjL1tybXlQ?=
 =?us-ascii?Q?1amEHprP5fBUaLmphfw57iAqj4k2ZSk58HJD+Uf0gue0y23WMbyt51yuvqNv?=
 =?us-ascii?Q?BO1Ga/3VFF7OSaCtB2GbkWACnYIh26Umm8c+WL+oXr6YgXeHYM4aL8Apiizp?=
 =?us-ascii?Q?ItSx8okHtAu9L+Wo7FFZWIhoGvIAiOsS+9kzxZQVT2wftlgMoV9+BAiFpOkb?=
 =?us-ascii?Q?DnHFruUnv8PNuxyL8Bz8aRbPM4fKxpLGpg4NBD1pJaB6y/McHdCIt++Vj8n4?=
 =?us-ascii?Q?AAwYJ4/m5+aTQI972pMVpYYaF+krG6SaPX2ELjQnxb3xbddi7zew9hFAq9ew?=
 =?us-ascii?Q?cLvPhe65PC7cm40CqdR+1Pnuw+sOwWDaG/LPEQmjVBnFLh+HW5OsKoNv4obI?=
 =?us-ascii?Q?DPeM+XKWWYP00K2zBri0v8X4pUNxy2JlYhz3pJoCtY/tntKR5aRHiu6AYoyl?=
 =?us-ascii?Q?fU04MY4v32CZPQYzCq82lpmgRaWndM8APTKSTogFiqQzvF9mzzQqffigY80w?=
 =?us-ascii?Q?IoVWixr1DEbYGSPYrmpU4/pW49F/KcUlQb6HbKZuSR6Q0Xbe7BZxggGdCpPu?=
 =?us-ascii?Q?RsC9mmW6KW+5KkdyR9uuHXBnCp50a4CNLxKRPblCTd9P8BYq9L42FPpk+4lk?=
 =?us-ascii?Q?5UEbNlqqdEch+ZhBuxZWUBZy2jBh7rGP3JOQp8GvstOI70mi3Kz+L+Zb2h1r?=
 =?us-ascii?Q?EfMwzMnxhbNdwXYvG1MGGsPhsrhOZsi3UeVdGn+nMpD96m78BMmUEaUObfdu?=
 =?us-ascii?Q?98p7cxO/DmS6aKyXmV+CmfHOHwVGBD3nnYRsZzRd9+X8U6ax9E8V4YhMmcBh?=
 =?us-ascii?Q?mC+N8wvBc32R8ySyvRoi0O1DW3LtHyPWwl1KuSopWwO6b+vgvdOs/XSiO7L+?=
 =?us-ascii?Q?hkDvhFqLs2MF5xnJVMK74nTMvRTJas9H6bswB1J1v02U/Is+4dadMBiFK44j?=
 =?us-ascii?Q?flmtzO4xeIc4guCnPQ+MSDU6Uq4obA7onhYVR/kO6QokRZ+8/hSI7+f68l3U?=
 =?us-ascii?Q?OY97KlMR9F+HE56TxM4Kxoh/PbQvJnuWxZur3S173CjHUNVkKPn0420tCeUd?=
 =?us-ascii?Q?pTeehimS4yfy9FuKOvpnaa+64CdbxQe96Qun6b2H4qPq3IeEZFKhIWL/YGGM?=
 =?us-ascii?Q?nA2nDjqNFA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ff85f4-e25d-4cc7-1f02-08de796823e0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 21:02:12.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kms19/nmeDPCZugzDnVlggdQf/kHidLBhO8GyKQUbRq/EgB2KtM4BXh+IzSj5QXjxqtL27RCW9FHsmPdSVSbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR04MB12217

From: Frank Li (AI-BOT) <frank.li@nxp.com>

> +	sdhci_get_property(pdev);
> +

Missing argument: sdhci_get_property() expects (struct sdhci_host *host)
as second parameter, not just pdev. Check function signature in
sdhci.h.

> -	if (of_property_read_bool(np, "no-1-8-v"))
> -		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;

Removal looks correct if sdhci_get_property() truly handles "no-1-8-v"
internally. Verify this is documented in the commit message or code
comment to avoid future confusion.

> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> index 97461e20425d..b607d4ffc562 100644

Line length at hunk context appears OK (under 80 chars).

---

AI bot review and may be useless.
