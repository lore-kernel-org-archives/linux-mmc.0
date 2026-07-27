Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F9F388386;
	Mon, 27 Jul 2026 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163962; cv=fail; b=JcJqvkg8MOsamT3k517RixSq9BbThgWSIkgTOWMDeP8QjC577n6jecaDBoBpPQKHjFhkZVy6zII8n2JQsfUaCDNhAEbnPu9hmUXiXv7SYaTnDsTh877q7BUdIrDbpf2+zz8YFc2qtTpe0TvjEsgnHyfzu+xXNUmGGRfzvK2rL18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163962; c=relaxed/simple;
	bh=q22gAeeJnZdbu7YRJl/nOcRmab9PkyCsQ0yTzC78Ueg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HDREDZWfgvIKgywIDvy8M4ZokeyUR/QiLvYP7XS2dkvGvwM2P1G6aZ3Nco0ntWyc019EyY/Jyunyi2WPJIQtVuu4pGsS++etjgS36elMQIlS0qfxMF1xEnxCNAMbaF1Cx4qYzXmCIuhLfaNHGl2GJqWiFRCXKLb08caytrW3tC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JFy/1xzt; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JFy/1xzt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ns7RRXlzBm0wmY47/8wpW8lf85uhv37UJ2UjotEHN8CFbV4BhuvLzkDTS9Be/Q/Kg7cTSJVG3Q1gLgut836RCFCAif8F6LoZl7MpNH/KoG98h92UubchoVCCY+vVdXpR+vtbqi7KUmi2mVzZ1+gwgSpdiLk6x0yEIiL0FizhRFRgMDzrCbZ4zUKXybueRRKrSyJIyIfcq/pT/VLrLZ+EMNTz0hpzSafj7Zo7F00VmCFNf+X1q2paTCFz1NMaL/rdW3ldHF2vT4Tio/cbNmRt1t9wUvFlK5FG7Lzwct4L61mSBe3/Pq30MLcTxOBxhHrHQr5YK0yooz5CNtVH72LLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ3vz77x+c0Ii+mJwUAKUzfACqek2mJMgxi5AJRQVC0=;
 b=nA+d1QtPrqovtHbpo/4fqdjfiTiqSY7NA2LuFkZy+bV1nXMvsJ0SZi7zeASua4ou42OEE+hc/2Kv346Sa/wnGp1MVKTVnwF8M2CnV+RYUujnYViQKp+OZHgzSrI3K59M690s6piW3zgYFcbYijfpQVcuXqldIdMJ2gH+UlPDMu4p7IVt9J+gt8Q3fnSgxYR8iFEOTqnTmodtCxbyfyESLGCbi610IqqqeoafphJMl4cGs8B8Lxwhy/hLapw9wRRY6hTwnq9Dv5NNVkX1tKvcyxehG6diJjP6AAb2TjEc2Pi065VHqwU0N98sm0eFAShfzIaak8he11Iv4UmVQcWGEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ3vz77x+c0Ii+mJwUAKUzfACqek2mJMgxi5AJRQVC0=;
 b=JFy/1xztNfqZQVZLx1vRzAnTfUYoG1gb9aUoRG9+TAXjrYidWbj4gZ0qkeAx0e4STE9oR1jjMqa4lD5bZRe91GfbwDStKBlCr3KvS5asVoXgX27l7j1NGcaCUXKnq5wLhAad95pRhxvgyft3QhGLJbfRzuKWX6dX/U4S0uMcJjAahh2n+w2fb5vvwTqn+YzQUx6nBROy2Lzgtc1xuuKMSvlDvdC5MEN18M9+8tz9+2Dzq563X3Gk99+tNy4LIQNgyPTRvcIhFb7Fv0mzeowHtgycCwn529Maok08VglGlnWer5ewDsjVilZ/UOzbN6wGr6bzP84j94flK0L50Km/6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS4PR04MB9265.eurprd04.prod.outlook.com (2603:10a6:20b:4e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:52:36 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:52:36 +0000
Date: Mon, 27 Jul 2026 09:52:28 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: haibo.chen@oss.nxp.com
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
	Yinbo Zhu <yinbo.zhu@nxp.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH] mmc: sdhci: make tuning_err a signed int
Message-ID: <amdwrKu5KP82r-Yf@SMW015318>
References: <20260727-sdhci-fix-v1-1-1a655a5d895d@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-sdhci-fix-v1-1-1a655a5d895d@nxp.com>
X-ClientProxiedBy: PH3PEPF000040A1.namprd05.prod.outlook.com
 (2603:10b6:518:1::52) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS4PR04MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b48a89-73fd-4db8-c7b0-08deebeeb284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|23010399003|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003|17002099007;
X-Microsoft-Antispam-Message-Info:
	ij93v/EsXg72OZS4EofGkfu0SK8fTdfad9QAE6a+SPVXceHr7esdFunHI8XfPperqzcd0keRsTziwb+iIshXmK3mpZ2ShkLaGmply6hH2g2+4ozp/H0H7cwXnWgAYt09Ba5Qd0utyj0c1NBSfELD+HYu8QSBBRpXRgbAjySncr72XrkX1yMtEluTZazxzeqxKdWXWupHVFhAixQMjprL0b9PjXuC8TsNFvyZnkSDo6TLmzZWl8x0tE66xgv/gE7/kbAJMqKBXzJ3CP2KzmvJ+n4ygcyo700o+CTC9RCZeYABTHwFDqVnyzHbfTMFLwJv4D6VV/Cg1bRJoKL62V+M3wPiKWBVUARUAbgus6RA1rxYLnCxgO1w5TsBD5mjY/zD5gB3SF5rXEeglgObOjISQ14scpCIzXU0Yn0J6fWysiKFjsWl09YdVeYy7NicwJgteGkKtZ6vgIxAEVQsrtMGRzDsZxWbj1SoKXMIEqNVYZzy9DeCEWT9u7944mn9njfc56bOlBM1e5d4rxYrI98l5zql81T8LGGrI3mvNrduCs350Tfqc75wps6RDVGX5TU3wY8XQY/8ZFa9QNQB1IiXWj+gfmVvjxMFHaOLMqr9mRc2y0CXwvBE83jMBYZzrmv7mrWmi5DJS64E2Coy0FzDug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(17002099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KdFauJJjkbF7vI3EQAILLPVDqr6DU9iWJzKgqZHs7cT7AeWVr9efe2br06O3?=
 =?us-ascii?Q?BLXBuWXL4EgOQensMRy44kZzWlIDngv7Bs9ZTnrRLnwt987wBkdiN9jkACL6?=
 =?us-ascii?Q?v/gasjfuc7Hd5nvYRVByw24G0aNHLbxVdh9mOUDnq8hW7JGuTZAMt2PKYmwA?=
 =?us-ascii?Q?FeiSK2x+7otBvFMd1w7p6mf+VoJvvlRZB7dlcm4/LFK1PemdJ5tBTtsrfYU+?=
 =?us-ascii?Q?EszslSX5cETeK3FL15gQaDmcDkoX37nEPXBVDBvTRx2H4QOiQsj110mUelZr?=
 =?us-ascii?Q?4mSfPAgzVYuNxVy3fL1KhB1FjrgsL63NCrNDTyYDlr97Bdx0BtdFGv2vr/NA?=
 =?us-ascii?Q?x7HRqLe058gqnIAFtO0ILNiwAP21VCfROxo8EgrBNEFGEgf5blUGI+GiOG6w?=
 =?us-ascii?Q?BCqX4bj0S8hK75ULHX7lmkemitUBXCyzgb9ibbrr8ehI5wiO8PzhgkMmQD7E?=
 =?us-ascii?Q?OVypp2qYinobj1gNxGTzkH7sIjh32AoUGWRmwLjMwIZFIjg/T+qPpmNNqC2g?=
 =?us-ascii?Q?hHQjPeewRMzkiXT9IZcUSzokkDyVlLiNbonckYNiJC+S7PrC6WAjsBwHdiOb?=
 =?us-ascii?Q?5vgy2rPg5wc/8H5CtIav1ussWfmFYz0fXfks6hP8nhuQ79T5iBdohKNqGjK3?=
 =?us-ascii?Q?SZiXNzyggdYoa4SjHmEYQUTHb573V22bzcvJ/f7qIOl6ieyw5wOhePP0/erN?=
 =?us-ascii?Q?/ZvYLWJ8QskNMEaGS6E10fQzbciOveDukIaXul1G3guFi9wihmN0HDYBJ1B0?=
 =?us-ascii?Q?Okk5y5Lp1DDQcFlkNotwC2XbPUy0B57xr6ZR+aI/W0fXHdeQdq9ZUQP4G8W9?=
 =?us-ascii?Q?BsWi3JUsl5UNHOeXOpJeE0B+5QTHw7IO9yNvYov0OK+Pjq9ZBWaxUgozRpmI?=
 =?us-ascii?Q?H7YVd9iRqg/ZeD8oI0lJPHt4AFDOhf3IwROGvpRcwcK0T44VfLwunafNvj4G?=
 =?us-ascii?Q?xeJviwb0Rk1NSxMb9UejljvvhZ1V+RYr2Kr7MbkVL75VxcQ8J1nyCeO/LG7s?=
 =?us-ascii?Q?e/MzByuYeHhdU+c/9ukOYCxmq5h1kTB6TKBLsHGToxvJd8mGoYT6+R0miXok?=
 =?us-ascii?Q?ViNsVWbwBDZtJieNBPSNSSfQaHBXkG8ziDqSteHrQbuk38XwicQfx9/GpH8N?=
 =?us-ascii?Q?xsMDWsIMGzPgK+phsZ/YRxIPdl7NWSwCjRd71tK2zepHYJIZQJTwSctX8JMV?=
 =?us-ascii?Q?LNad54r/zPmSijpUG7U++ChorkCVOGqvsdqM8wE5GzKEzFWHyLrEE8RWNSMH?=
 =?us-ascii?Q?b5TjJZxv0rd0L6M5tdiAbIKF+eISIDd7WvVGOtdmNJYYRmM5O2MtXrLXfHkO?=
 =?us-ascii?Q?wdrpoCzE1XvhVYX4uSiJat69zYBkk+FP0EBGjzLZMYBjisIwXCkvBIuvKp22?=
 =?us-ascii?Q?iDEZnRhoHmOkqWuLu5ZcMjZwsasm/2spWruANsCH5xo1s8GRmeW66ZdUEr1y?=
 =?us-ascii?Q?ULlKoMQ3It+HnjLEPzByEZ9z2t2tD/x1LSKY9hBnzEVAB5jnMo4y3tX2hDYD?=
 =?us-ascii?Q?9G4pG82FUGRdxD/L0oofZe5e8trU7PxBYv1d9Bzqg1g81J7+YMDkR3UWDeUW?=
 =?us-ascii?Q?ds6h858UMQ4LiOl6r951+xCb+qdCgqSdDD8X4gFW5CzX1X+iru/KOzHeOtXp?=
 =?us-ascii?Q?Zh64bMHRTT4iTmLRfLNqxCUVwnFJaR0OI8vBTkZ+BVRWCp30JtpRaimuoz30?=
 =?us-ascii?Q?sGf/XXPIRpXxqJrioXV07KHQycR2OTqkiUsK1S1FlyQjsdVNBvPlD5GiwPm1?=
 =?us-ascii?Q?70H49o2Y7OkWmf0GLcJthfK8X1jSETjAfVC4g6hYm0JKDKj6V+f4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b48a89-73fd-4db8-c7b0-08deebeeb284
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:52:36.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+a8wfLQYLTpT0dNJ687jaRjRaCsIkSGd1w48YUVcuf/I9m5lzEhe9aRk5fJnVFkKCcZvdyliNgcMnXeOgjbI0J/h/DMvBih802lBgQwyt8qZ7ThEHUZls/08twcXp5A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9265

On Mon, Jul 27, 2026 at 06:38:49PM +0800, haibo.chen@oss.nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Coverity report INTEGER_OVERFLOW for host->tuning_err.
> The tuning_err field in struct sdhci_host is used to store an error
> code for re-tuning, but it was declared as unsigned int. Several call
> sites store negative error codes into it and later compare against
> negative values:
>
>   - sdhci.c, sdhci-of-dwcmshc.c and sdhci-pci-gli.c assign it the
>     return value of __sdhci_execute_tuning()/__sdhci_execute_tuning_9750(),
>     both of which return a signed int (possibly a negative errno);
>   - sdhci-of-esdhc.c assigns host->tuning_err = -EAGAIN and later does
>     "ret = host->tuning_err; if (ret == -EAGAIN ...)";
>   - sdhci-of-dwcmshc.c prints it with the %d (signed) conversion.
>
> Storing a negative errno in an unsigned int and reading it back as a
> signed int only happens to work because of two's-complement, same-width
> integer conversions. It is misleading and triggers sign-conversion
> warnings. All users treat the value either as a signed error code or as
> a boolean (zero / non-zero), so changing the type to a signed int is
> safe and makes the intent explicit.
>
> Fixes: 7d8bb1f46e13 ("mmc: sdhci: add tuning error codes")
> Assisted-by: Cline:claude-sonnet [read_file, search_files, git]
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/mmc/host/sdhci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index b6a571d866fa53ce2aad0105cea2909abe6bce01..f0fd81409a86c6fd9120e69766fa2407c14e9048 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -659,7 +659,7 @@ struct sdhci_host {
>
>  	unsigned int		tuning_count;	/* Timer count for re-tuning */
>  	unsigned int		tuning_mode;	/* Re-tuning mode supported by host */
> -	unsigned int		tuning_err;	/* Error code for re-tuning */
> +	int			tuning_err;	/* Error code for re-tuning */
>  #define SDHCI_TUNING_MODE_1	0
>  #define SDHCI_TUNING_MODE_2	1
>  #define SDHCI_TUNING_MODE_3	2
>
> ---
> base-commit: c5e32e86ca02b003f86e095d379b38148999293d
> change-id: 20260727-sdhci-fix-13481630ae02
>
> Best regards,
> --
> Haibo Chen <haibo.chen@nxp.com>
>
>
