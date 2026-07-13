Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011027.outbound.protection.outlook.com [52.101.70.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124F423A83;
	Mon, 13 Jul 2026 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954165; cv=fail; b=Rl7XOItypr7al9Zm9hzk0QQXrgjCXwqMgoL1X485DKBP8eB17Sy5Ib06uU6ZJyBv0aWNl/XQpWcrR19noJvsGts/RD0ek3Jc/kzIafV7jHJWI0RhdulwjWGzewX65REl04LIGNhxnpE8FHSv8HgZ2x3Xfe/MVbLb0wXkqhsAg4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954165; c=relaxed/simple;
	bh=hypoH2GD+5/mODcQaOdB8lGE8ZPtRX6yxILkMwIJxxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dr/13H8Y8qEINNX0aV5AjcEv6R8rpVBFxfwcr4s/lcvZ31kBMsyrbpRV8d6STaM6PA23AsK5WgPE/tOnhiThY1A539YMUyL3gLzDgpO0P7t6N9C/uqoWW8MylTW+PgkowmVKSIeHxBQ/uINx7S+gzS94jnnQryAf7YqNeiEFJ70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jnZ3HU2e; arc=fail smtp.client-ip=52.101.70.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jnZ3HU2e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+ztDZAnqDXDi0+ezmrNGELS2HJkLzoJWc79q4D5GdauShDsV+rP7aMOsv/ROZ1Xz1k7razokhI2lXbnls7g31MXPbE1Jj7YBaj4ctrvpmHtSzs1BqWO8efYTF9qxuE05RuHORYRPUm7J04gHhl5oDtWg8k5y7PQOgg9T52uEoO0QRB5VxsZwG9lMNgBteA36UTxHRouZj0n88LfWB3jXjp+/rm2nQRnW8s6FBV/1i3ab8r8/V7anrb3KRsG0khhnn6vv3QRg46dIDwckwmNlxmOEiE6HAgUBcVRBb9KAkYMR14FArlNGTMp9nlkxCIp5kmZ4vBqAkhals/TT5RsXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37olk7TgZmgsgKBTXS7kBdT6zkNU3/iUaho5x6Odejo=;
 b=x3PUzuMjAH1QNecvQhKbETqeCh3Ck+jygQ0fu1Xjg+IFwEblzMQ1tAXOQBlxNzvwUhkdHgZPqHThaxQK609CysxYY7iKc3EYy6fcNy/IzbWlwC5S8O4XoRA9QrrFHE2tnoemGQDSwW+mW5lv8QCWJyDpcf8HJQy6MTl3cneB/fyB66TK+r6QAWynV2qJ+71s/UKM2lKvkENk2u+7KRzivY1W7KVRvw6YqGVSC8OvTFtSpuZ8ggVMqW4c1eT3fZ0qI69mSsazeYfy7+UhEMhBLc2M/BnK3rMnodirleX0AlOUDTRUujPQSj6VjXifxAd1TAcAVYyfSHQ8PJVPVtPtDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37olk7TgZmgsgKBTXS7kBdT6zkNU3/iUaho5x6Odejo=;
 b=jnZ3HU2ebmHXOxJTAkR3XgG70PNypGABSsys+VzhpL/1lsZ+8Lph/tctWlDS56RFOBusyPF4uMXzwMSCo/JQZTdXorYy5q1mYUznoBxDsJ3MJg0iQcJtqBnLiDlZ69v35H45jMauBoUP5MXxiqNACJwx9/Sl/sO6/g6mWLCAuC1mJyV9UCAzOQcMmvQ8Nc9A+GOmEx4R2/gyUUzVEsN8TdXSEisPXxz5vDL+MVhXDfv9KA4BuKcpmO6fEdEuuV9uQbG//v8BXCPlaIulBJUSOVyO7nk1ruak9Zi5IHCJLwzrKEzLpxQqAyAB0Y00QxlI/FITnPbP51lYrji+Mt0fRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB8981.eurprd04.prod.outlook.com (2603:10a6:10:2e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 14:49:20 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 14:49:20 +0000
Date: Mon, 13 Jul 2026 09:49:09 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: ziniu.wang_1@oss.nxp.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, haibo.chen@nxp.com,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
	s32@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/8] mmc: sdhci-esdhc-imx: fix esdhc_change_pinstate()
 to allow default state restore
Message-ID: <alT65Vje5ZZY5ykM@SMW015318>
References: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
 <20260713043904.4144172-4-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713043904.4144172-4-ziniu.wang_1@oss.nxp.com>
X-ClientProxiedBy: PH7P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ccd89e3-f466-4471-ebed-08dee0edebb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|19092799006|1800799024|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Vd/9W/arehBAd++j0XngayksVo9eBZ6g7ZlpfAjkjme1P8XyeM7igSVzonm6wG/iUGfALFTTIEqI1ppLuxknxLBANgT+jPrnHCLJAFaJLPo2mx33eD4It4QKzHKPhXjtMfxyZxDVsdvDME6t7uOlKHgY/wCuKI44NU6l3jP1NoeSGnphbhvaLqbHh/01qQbH8IuWVj33AAQIZQgUhXPvEJjj6ljB1AsqwQgHqgExJygnKKrrhP0xSOjDIOdgm1BeladUYCtgo3OTsXX19LHc9DI24QtCuTF+M1NMJQ3Pf44fySi9T59WmwV9MZCg2okvmREZA5TaRkks+BWxhOUpxIZGyNkl9Z0SYGSBWKWTlaiVSUU69EWHw7kEVh+RbWsKjyVmTocHtAZZvmSeWTOeL1MGzJDrVpyZdprSg53ozwdkqqc0jWapgCkoRGjBqe25+6Cm29vbcWyGvTH7aaXwTOZMo5YVLG9ggksxy0Rpp9j8xW/Qq+SjrotCl6EAT3nJBWGzl6nFdBmqCKaoToqvzVtzwtNhUI15+f40Xh1VzZelGZGNBlP9vtp8+J4a0dY/SyYbCmr6aUjxL7ms2F+sNL5CfuNR+nehW1MAJ7IZJxeASp0jcxz1t8OZy9WJ+O0hRLyZf0C+fGFqzlM5V2L0+38OV+jxTyIMPAW34u0gBjI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(19092799006)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oNRqZDoVbHdb0jTHSFKae17U1AJb8UL4ISXGTipaylAWsJmQSrObxdFNJFtZ?=
 =?us-ascii?Q?JJnLdFKEnf1HgN3p+MAIDxvAeKgftTu+zltu7xpq97TRjQ/JN3oyngzZy8yx?=
 =?us-ascii?Q?wjFdYUXxKTSBaDhoFmbzouAosuci6mW0Oy6+WqrD3WZP1Q7yJbRvkBb6NxmO?=
 =?us-ascii?Q?LHxdySjINLKm0fMQ+BEnBvd1bgxrlasO0W6d/+dF1B+5Tf7qMFyU/pKhx7N2?=
 =?us-ascii?Q?Rh3EpeQKBEHYRDpdqEITG36j3Wgxxdc1L37ECI+uObqjRI92m9mN6XYlBgEB?=
 =?us-ascii?Q?S/99hQNCLb6CHScfgJtguA5gbXNuZzbLNISOBLjhmrQZXbOAkoVGv3KDvmYs?=
 =?us-ascii?Q?lPSost1JAY9G4HSz0FyVzzXp16MLo0TARyft5gJ3c9AcMwoHNos2sPtjtppy?=
 =?us-ascii?Q?2khk5bmrcwiVfb/O0KpmYHxg4+Wdgk8dMiic8kp65mSFV25Dccv7wPzKNwpf?=
 =?us-ascii?Q?JWtR9bNpoBf8bz+2Il5mfNmXEEYcHjdp7IXIhd27j0dq9XK6Ntq20BbRjEWj?=
 =?us-ascii?Q?6P4tv2VvZU32Jhj5YqT1yJ63sJV/LtKGYaB5k5DdZCvOv6KfasotK/uHkhGk?=
 =?us-ascii?Q?R0xElQnM/tTfkOmsEoNA20EfJCSBz2uGvd0qfkESPEEOn2K1sgaH1Y1N1iFl?=
 =?us-ascii?Q?BSWTzU/wkrwxURhDLfBiy+kSDMvVKUHTgooT4zU4LlYmMRqJ4H428bNByhjq?=
 =?us-ascii?Q?TE4sE9hKn6ue/vBCuz+K2pUn0fIafLUo4CKW2Tx7OIgx9TkEDjC9atds9ZbV?=
 =?us-ascii?Q?+/9ALbn85l9fA5R8QbctpoYWJklAbQ2n9XX38X7IVNYgAl67ZG+d6I7Tp37d?=
 =?us-ascii?Q?yWpGXux8CEj8tD5EGd3SwUxXpQ9WEMk8nR36Ma4l53kgr8wekzk0WUTJeFcl?=
 =?us-ascii?Q?yIk+9viRiO8GwcajvVs5ze+oDLnWePNbwypD266KBoU5B+gerKGJMh2zWPOA?=
 =?us-ascii?Q?GBrkbRjxf8V64tmg3JCstx18ugIGwmxfo0B6OHY/ldENynzczDWHm2r2FNoX?=
 =?us-ascii?Q?j98bCbqZsOd8IFQye2QR8EaOIHpN8YFXGGwmFreXgZHaP93A8c+Hk4f21Dga?=
 =?us-ascii?Q?sF3krsipkZ4c/fz7QxXsl/B35p1ULbFaoqcFBNf5mXmNJwzzafgfEVdNDTJO?=
 =?us-ascii?Q?8LtZNuGoiW3w1bsSlkK1F/K8rCJRtPSfIzEP1XmfGejQs+SwdGFIXYhKbpiI?=
 =?us-ascii?Q?C82GtOz0RebSd7aJhsIOs16MBLMfO0JAGMu4S4Ybgy7a5hZWbTBQo2kk/GLg?=
 =?us-ascii?Q?fo7XR2KXr3Wr2yiHdDA4gVYMAJHvrSAU/sm+unZlGtIpcbKhcMZT31ZA5G+h?=
 =?us-ascii?Q?I92RtdG/pAFDlI7jTypECuL7rt5CPZ4R6CXcBXnZym9wllJ074c47XBf9is9?=
 =?us-ascii?Q?IlxRt1tMnA7vv9gKRMHnknVjfSBK2n3NBrjrF8pDffkAQcf39NWw3UqsrFET?=
 =?us-ascii?Q?bvJv/pVBh9Pc6Vwzw/EXbvDGQI1ZkuGFX4UmGDw2OWFMwZ9J7+RhmrG9pfzv?=
 =?us-ascii?Q?6kNpedpUsLd02mR7C0RqfTJtYz1gTdu7g7cSpRlN3/cbcVWMFiKzucH2Pohj?=
 =?us-ascii?Q?nxol8t8aSpLFKY5fUBtrx3bk6dk6X89Zf4P/sMH4Xr3npukq82T/7zBiVfKO?=
 =?us-ascii?Q?eecN4VtC4MLMrwxl9jhZjFJjApXKA8vHQyOR02wKkec1Xkw8jEYGcHYmk7F7?=
 =?us-ascii?Q?UGue7S9a/+pcXHrgqGXiQArHIksdB6p5afycRnDTAluGH0UYHg8lCn6CxGR3?=
 =?us-ascii?Q?lohiYHk7j8Vn/Fb3NbVlTauq4OVwE03jym4JfOZkUdCorAnZGcNe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccd89e3-f466-4471-ebed-08dee0edebb8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 14:49:20.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KT9geY+hXI515SEmvHtn/TKGmIPAiiyfsLJ9g5lZ7lI3E+PIlDVVKjGEw/4QOqIInbaO9p22VefVdgpiJ3mM5K1Fpix4cawjraQRcI46yLQNX2J1uCLXNMgFg0mCwYGo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8981

On Mon, Jul 13, 2026 at 12:38:59PM +0800, ziniu.wang_1@oss.nxp.com wrote:
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
> Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

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
