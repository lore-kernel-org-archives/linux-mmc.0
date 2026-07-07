Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011040.outbound.protection.outlook.com [40.107.130.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A593A2540;
	Tue,  7 Jul 2026 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450943; cv=fail; b=bXPX7Q46l6mdiQ9x6FR5gbeiGa1n9ypaffBPaOWZdgFK29GqwFgZjMI/FSZ7aoY2aCes4IUHgmkaP8lUiMv1nTcertAyntogt29QHHyVPP4HJ3wVESVFX6dswNxDxdrCfRtjjxH3Z59g1gsZDq24Klx+JjBgXkoNGdEBpRKgTqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450943; c=relaxed/simple;
	bh=oSj4N5+uclRGDI4L2BxkeAP5OXOZw5w4h+d8lIY5hzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mjEGOQz0os8cO17EJuvIMzIODWNzDHKjJ4VFRoN2k6iba6YLaVHlaheT2PmN6q4T0s3kx31EjRQCpIv+rw2hXU8aCuD42gpyQb6WtctiTkg1a/UneuwmwBl35vwnn5VbiE0KGvRiBya/oG7H+OnY5oBaJXguv3/M6uKL/3NPOHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=K80a47ap; arc=fail smtp.client-ip=40.107.130.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="K80a47ap"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ei0LH+AYaSFExWqcygHSxTxXlTk4XqSLcbjH79slNaxShjduSWJGlQ5M9+g016e2PcUBEaJSNyVFefLalsidh4NH0soYRHFeZim8GMDF6siUCKW/dhPOssHRYhqywS2PT0d2/eHq0+O/QqIKD3Yx9So0K80VQLmtZROddf0ucNPzhJk/wVXSIBEf4DuDgweQLGUGu3+3O0rqlOPaXUmQ5cPAmpkNiTL2pNjspFdmMWsujWM6zMum33GUeriHPtOuvfrU/bZ+fCr3yylRctTEl71h+rnZNzu6j2GeRvr1m+kSraXfvvffbz7qAG8mbAdk28EEvjsHurl2nMwSWdY1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDpioy371w1ytskGmzuN3nPzBa9MJdh6mVlnaoVmISQ=;
 b=JBVY4AZ0XPWB5hvYeRnugVaoH30LY5gcIF2fSQgOg31JgY173eChxmiRSGI8o+qGg5xGExPvoczpdeqaRY0eEB1lO/tJAUF4tYZGKVM3s0tDVTTRrQggDv+48qwaOH8HqkzwN0Xet/u87IeyJc5mckLz93Z7rbbZbPf9mhUG7KJoyjJCBhpDKYS1itWslNHnLNywsUP/pR9k2jwu8O+PG9RVB6BJlv84t25FScsMBVtvh1nPc2CQXPdvtwa7sfX1EVTQd03bYG6seNo0uJiPws8u76xvK/+3GjY+Wleq68l8AHq/+xqotqzk/KvJYWyZ+/zfTNq0jvVHwRjBw816Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDpioy371w1ytskGmzuN3nPzBa9MJdh6mVlnaoVmISQ=;
 b=K80a47apBHGYCpyIQ06w1h5pFGSHyXT+MZId1f9Dn76HE6TtLSHXYPe2dEM7SplJzQ0mEG+Qiw1K/NcTt5RPcONI2SU5qhZHTqJ6WIJi4aU60U36NU6OVgfXji6gomomQzhvqBNdof0BhxfEKg+t1mfK1tUbxCCuDQ4hncm9vNLNx6ngDwV9VA1tEQVKs+R6dFyO5OW7vIw0HsY/fhGVwR3Smm9uHd8vZN1POwGZHh4NzcTIvWfI3JJ11CsxY/eJ+N64qJ4QGfxjP24qn40sdHZAkHpGpDaThuj+FLpGixuwVNgX1Ug3IGsWo40bc6a4pWFgYvIEM1ZjpQuGdbli3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB5PR04MB12177.eurprd04.prod.outlook.com (2603:10a6:10:648::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 19:02:19 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Tue, 7 Jul 2026
 19:02:19 +0000
Date: Tue, 7 Jul 2026 14:02:09 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: ziniu.wang_1@oss.nxp.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, haibo.chen@nxp.com,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
	s32@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/8] mmc: sdhci-esdhc-imx: fix esdhc_change_pinstate()
 to allow default state restore
Message-ID: <ak1NMS43Yrfsh7CS@SMW015318>
References: <20260707110303.3779799-1-ziniu.wang_1@oss.nxp.com>
 <20260707110303.3779799-4-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707110303.3779799-4-ziniu.wang_1@oss.nxp.com>
X-ClientProxiedBy: PH7P220CA0054.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB5PR04MB12177:EE_
X-MS-Office365-Filtering-Correlation-Id: 404ac154-58f0-4029-10da-08dedc5a445f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|19092799006|1800799024|366016|11063799006|5023799004|56012099006|18002099003|22082099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	We5AA6L9CSsft23i4si38fkwHmkyPq1fvn9j1tS3Adecz8aQnrf3nzIlnwDdh7HBUi+/dUI8xIHgbF5gxZhm2cJ6hcY2Tn9KbBTaUKd+TkEfgcBAUbfPDri6ru36SpMe5R0sDrTNTMW2bpQqAiOJP4dvS4W670S/7k2YKIhFAsM00MJuDwhFEpjZe8ClZKiFlmrqxjAiANewHpk9uuwrNxxXCw6M9YxmNqPMUFhSUrmdM5GPZmYr9lV8eJN9BZaE4YOnspqEGnawGixpJ9GNlJ4K9VPIYW2G0uQNsMFB6qSXroDbWqXUWhK8bxzg8RCXbDGGTRO0UwmOlHBvs11Zaelnc1qua2Aomqs5Pry00n49baB2vO0f1JCBf+/1g2wo2GiSm52QRzuX4gWoV36ILw2DRR44eLnmjecyGhMCmRc8uPfgx92GLNv8zsyodfE9NpFHJRkvGPBli/3J1fszEbetYRvBxORjK5Z5+hXMvsiDEWRBRm1BF7TmQatkDWruICEItACKFV4dCZNvVYzR50FtIW30i9LYMFLBwnz/ZeOfPzVKlYSQwiVmW3cjc8s9BDA3H3w1qF71zOuze68R0v+Pq7/h6H15ZgtuA05RrqBIiMVTiwuEZhcQJL/NP+kS6f2YqRLaB1jAteUMRXE2JWcxSixosazzdQVArWEjYFU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fr0XF4TyRHKC/KqCdOP9sA8zVTe2r50RZH8sU4LTQSaE1Z54W2tYA0MJLIYJ?=
 =?us-ascii?Q?wQ8YOkufaV3eOYZrtYlpvUtcBXNv0cdxriKzRe+tFmmpmjLsNcZPVtkmz124?=
 =?us-ascii?Q?aTSXzNIxIsXsUdGz3gwhsLeYVDmV87U/MsMym5xW0D/EUZCZXd1k2aZgd694?=
 =?us-ascii?Q?9xlTo+aivY1Qhq5TeDI1ruPAt+Ai94u86w0kfZXej2xIiCAfvJoRARaz85vi?=
 =?us-ascii?Q?ooHQgZvhZLiKtJYlvNVEP0G0F7ZYrNC8QYeinXUnPq+8/ZsqvZauXahBBw6z?=
 =?us-ascii?Q?cbpxPZtT2gpUKZd2v7sP69ELuwoqU5du04cj5n/gjbdbsKQw9yt1G6q9irHG?=
 =?us-ascii?Q?s/Xs2ZBC0zeYLNSaXp+IWpuR0JMS1otSE454M4yd5NGB0FAH6iWNzFxhHVUt?=
 =?us-ascii?Q?nLVUXyINaa4YPFi5OdYPCRD1MIDa1f5qJUGKWlpuxarwVZZDI94v3++OpR24?=
 =?us-ascii?Q?1ttmJdXjj0/fLTg2XjxiGurCd6DJgQj6UcFw1jx+qbar2xniQi+QlRos/+jz?=
 =?us-ascii?Q?zHS96Dc+2Ela1q76JQFmoHNc13tXHGrNHVJxJ2zeRB7JWZ9c5FjmLQfzb5HE?=
 =?us-ascii?Q?US5ggbDqhXMl6rlhJzhsXlVoBYw1H0Z92jpwiFdhPLC6MfaYnsPqoL3RWibV?=
 =?us-ascii?Q?a0yKqOjB7cfa0BEpWtTpBMRJzOojBJiRwc36EdRAJzbvJoedAFiVJXirbCiK?=
 =?us-ascii?Q?nmx2+rhK6uvuVtUdPLUOxzZ9N9rVSRG7bshBaTaSJF1i5s8ZYcO81SR1T6rM?=
 =?us-ascii?Q?MbekhhMpgioqTDn84NWGcOp7ggYcU2PfWMbFn8/4QxXSAVK1UtwZRn5SAvpQ?=
 =?us-ascii?Q?ONIVnu65IFKx4Te1juUKLxmvuLxVE7YSFkCQ4fXOz8wMzb6bgunDc0Llopy6?=
 =?us-ascii?Q?icQPUK+msfQWck0h3chNbCaF0GsyJTcbC2I/FPBMm3NtjBh/0m+NIj85R6L+?=
 =?us-ascii?Q?7jl7PWVMiOt05dUuzEliEWeRQTtcmry3+llOHAoOnMjvKFIB/BsCkifMKOkJ?=
 =?us-ascii?Q?hd1DSUQcFH3CWYaQ83OH3t6zQJYZr2DkP2RoSE6YRZjqk94ScXtl1KV5yi2l?=
 =?us-ascii?Q?3bUKg/cwsaDpgSCcUHMXr1dyFGVjmkFUSXc4GzCwdWGDvB0NdfeIpa/9hqHB?=
 =?us-ascii?Q?zLHZAhqjLR6BL9kfWVeV81i+Bilo13iUQ1sQvsiS4iaZleOTmjvkDHbDjVc1?=
 =?us-ascii?Q?XiQWW7ifyQmyieaaABC5lJ9MebeHQGlGyiK6wDrmig8QIWVMcuFvM+rFH22y?=
 =?us-ascii?Q?m+oB3F+Ioykwz6SMJKni+xA3bKDqAto2G6h7yTGzcmkD5nghfYAbnEn994SG?=
 =?us-ascii?Q?egTeeNSuKLFEY8pc8vf+Hn2Sm6swtF/S8hywcUI2gZ1arwQn/RVsdBeIR1hL?=
 =?us-ascii?Q?wxOIS5/hI+GxXjhBHufOBjUWaMJKTdYD/S3InyAcKCL6EWL3Pqsww+p291Bb?=
 =?us-ascii?Q?jqXOLwmJLCBf4IchrTC+Gfu1vlQDDcgtStzJsxQz6hgGTeSLmWORaSziIoXF?=
 =?us-ascii?Q?LeD5PUD6QkXyBn2faKbpybPC5PWlkBcqtnvPFzeLH46fUXRcNpmeHxp37JLA?=
 =?us-ascii?Q?p0TJ2GcdPWuWsTAJPEiz4G7T9PJXgjhAiK/WGaDLGVixAJUqAwRoZo29mgNO?=
 =?us-ascii?Q?ZzJ85qbjFQqCI7mx16O5vR0kjKuTFUZwO6DsUG1nAf/KdORcQfXmZrIOYHO/?=
 =?us-ascii?Q?gJd37BPK/1x5aDxRluuWUkJe7kX9TGViKGrVPAK8gHCzEhCpCmeeOyJIGKA7?=
 =?us-ascii?Q?Hz0bp8GKW/zJFxycCtgQ1S6P/8W1yTQlwEoJShZ3nTG/jTydRj/g?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404ac154-58f0-4029-10da-08dedc5a445f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 19:02:19.0079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RV3tLbQR5ipD7Wg4T+6Ha+FfUI8xw6QenLNMXNh7GANtjrox/PaklbHs9jfL9puosEkKv0W6G6OeWc0oMaoDf487KR/C15OU0R3kNknL7SJBnHw9B1uCZvTwrDIAUZ7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB12177

On Tue, Jul 07, 2026 at 07:02:58PM +0800, ziniu.wang_1@oss.nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> esdhc_change_pinstate() checks for pins_100mhz and pins_200mhz at the
> top of the function and returns -EINVAL if either is not defined. This
> prevents the default case from ever being reached, which means devices
> with a sleep pinctrl state but without high-speed pin states (100mhz/
> 200mhz) can never restore their default pin configuration.
>
> Move the IS_ERR checks for pins_100mhz and pins_200mhz into their
> respective switch cases.
>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 7230d70e02ae..ead4685d621a 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1326,19 +1326,21 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
>
>  	dev_dbg(mmc_dev(host->mmc), "change pinctrl state for uhs %d\n", uhs);
>
> -	if (IS_ERR(imx_data->pinctrl) ||
> -		IS_ERR(imx_data->pins_100mhz) ||
> -		IS_ERR(imx_data->pins_200mhz))
> +	if (IS_ERR(imx_data->pinctrl))
>  		return -EINVAL;

Maybe off topic,  I suggest set pins_100mhz and pins_200mhz to
default pinctrl if not exist.

Currently driver use pinctrl_200mhz/100mhz judge if support SDR50 and HS200.
Actually it is hidden ABI.

You can save max support speed to variable after check pinctrl_200mhz
and pinctl_100mhz. then make these two variable to fallback to low frequency
one.

So you can reduce these check in code.

Is it simpler?

Frank

>
>  	switch (uhs) {
>  	case MMC_TIMING_UHS_SDR50:
>  	case MMC_TIMING_UHS_DDR50:
> +		if (IS_ERR(imx_data->pins_100mhz))
> +			return -EINVAL;
>  		pinctrl = imx_data->pins_100mhz;
>  		break;
>  	case MMC_TIMING_UHS_SDR104:
>  	case MMC_TIMING_MMC_HS200:
>  	case MMC_TIMING_MMC_HS400:
> +		if (IS_ERR(imx_data->pins_200mhz))
> +			return -EINVAL;
>  		pinctrl = imx_data->pins_200mhz;
>  		break;
>  	default:
> --
> 2.34.1
>
>
