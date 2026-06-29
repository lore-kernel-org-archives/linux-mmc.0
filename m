Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010001.outbound.protection.outlook.com [52.101.84.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7C392C2A;
	Mon, 29 Jun 2026 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726831; cv=fail; b=cevZb0+BG+J9y3N4U/sKzGYGt5ENBSjPSWOhAym7KyxcizBuwJyzSQoQNciff0Ix4kE9WfZr6gwf8MUfYti7o/JLi0ygU7gHhsMjZtPb2YNMvNBx1Ytsd1pWQwif1WKyWXAP9VGuEnCheAXiWnfzYb9q3eFBVHbY9gmzz2w7npA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726831; c=relaxed/simple;
	bh=Cz3L61oFCOM5/dv0/wOk371MWchc+qO7y86GfXbGVLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dm6ZHEt62Ia2JCcHt0LhSu5QDFdCNk6G8gFspFPWAqoa7xRnztIL5r/Z4+CU0LJ8RWiw9RY1QkYaOq2kqeeftu4e1O3H77tkNUVlspXjd9rhrcPE2GD5zckByfXIfkgdSHVevl8WtIJBd2U0KVGKF37kKaD+/KSRfYcPxehEuME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mPJI8Rmq; arc=fail smtp.client-ip=52.101.84.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mPJI8Rmq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7WQis/qVEkrEItMJZjIAOYpkozCcCWiOiRBs6cidWgeG6JWo4jrTj7h8yF4vX9WTg5MdN9f9kAxadMU5tRA7tnGkHZScdPPDNr6IIsrxghipMxKxmKgbj5Nw8IeUxCOe5RAXwYT3y+mZUek/EOU+J3qZBuGnw4xSbXzqHC+C7t70eAPGv7HaQu9NM2eJ0qrQD3aHPTuQCVjTOczmcqLJX94vkj04Gu7IgAd5MRKZmxyUjgMUEKtOHDROpti3TI2XnNyqSFa+Uy7qwrmOXrsL/Z2jL+26YkY2JZCQmoRWUF2m8wfqOvasTxwHNwlzzDrtBWx4Qgp/8nUAheO1YFsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B97yP43aRaHD9LVufHney9H7VAUOs/sF14Cif0NMfY0=;
 b=KOSFMsCNBtDXxXMpsjrwk61xPaK5j7cEs/Jzl5oD42BRVTb6ka9310EtNpbiOfbQRsIzTC31gSYJzrqN2XA4kUmPRPlOZSTG/CQL9qDTGgvak+BfRCmqeWv7ykZ0ZN9LNrbLha7buGyUT8qLqGm1SECLeuPmBl4EovGNJugEt/Si4JV3cyAR0LOoCpnC00m6CbQfDM4T6B/cuFgBzvzGNCDf9QWTCP2QWsMu4vTMlRVsY5udvv2EV+aFWRyaohzWyeDkpVsYgQu65kTyMeCaEPUb/tcMng+lZeM2TZ7o7TW/AymEAQet6CQRbm/eN++lzVx0oWyaezgfVjdLO2aPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B97yP43aRaHD9LVufHney9H7VAUOs/sF14Cif0NMfY0=;
 b=mPJI8Rmqbj8PTIDKtcQVhwV+1Ljvq1u4a24GvLLvJZK9PhIweWcZqf7aKPBiB5Wbl59B9wmc7O6hScOmJS79VHEPoaoEzBdRcRZjR2MJV+YhS5QEM4j61Dtbwfjj1AxO1Xbhl5KjrPMRTysZo0D0bUAK99BRrP3j9xIbv432dBweae1UurdjfqtMeBhtwBKJM1ESzI2cKwK9S04on8lD2+q5n9thS3ZZqfYGAwPKb6faU6gvpbWaCJuuDTjWc6I/urCw81C+bjtmiI0rj0uVlFkKowDBOwZoc6vTvfEJdbPBj48tRh8lwZ1HUAUdPu+XYLsTuhg2XWh+3DDYs6H8OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by DU4PR04MB11411.eurprd04.prod.outlook.com
 (2603:10a6:10:5ed::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:53:47 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:53:47 +0000
Date: Mon, 29 Jun 2026 17:48:27 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: ziniu.wang_1@oss.nxp.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, haibo.chen@nxp.com,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
	s32@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] mmc: sdhci-esdhc-imx: restore pinctrl before
 restoring ios timing on resume
Message-ID: <20260629094827.2zpjouxjb46xpsdi@nxp.com>
References: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
 <20260629091954.3227151-4-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629091954.3227151-4-ziniu.wang_1@oss.nxp.com>
X-ClientProxiedBy: SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15)
 To PA6PR04MB11909.eurprd04.prod.outlook.com (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|DU4PR04MB11411:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5d475c-afb9-4ac3-78e9-08ded5c4505d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|19092799006|1800799024|366016|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	JDL0Ht2JvvzQMOrDVzy6GyuXPMABc2KGMWbo03cqLOXGBmGlu2FYBytWRGCGsDSLhorkEcd+eYpkiLZ7ic1naXCSX/EBkAPDISf+0qd/Nx/pz19Sq28w8QpPBEJsg6Z9p8O0WBFsHSfMd8K5aZDIbBi16yXE1ZxyXUI+e7nHCX3TejdGmLNTybwfQhYzRFcvw0AW3XM/xXtyyoUYNmrIAvR+zIL1IAkbuyZs9VS8sfRmXIT0k+2bsalVriqwLrHqqXewHAgNuoT273PAQbapJVtoEql4E0XcszWlcF7JhNWr/D7QoGTlZEE1WrBo2DhIYsXDDo1PPs9ctDswV1DyRTjYv9mG/c041/XngbPOMe09EtYfjqzPDXP4Ss56De4A0vmo8WfEm+FINjY0a8GnJgCX7HYOmiYbh/VWj+6IoKrCB4s5IXYUSfkvkcoKQfqHiorep3Tgzc5VU5M+JvuwqZFZT8DxiP7Wz45wctEOfJSvLZPLaLTWqtzudrn0hMc7xQLhxjjiCz8IG9dHv6w3CLJXjsnWevwG+v6L0kdZ8I/5q0MWL9H/U81Yq2Hx+/bd8ZdEJqnQB/3m7btjF5r1XcRlqgWMqRvw2ezjQw9miAJLPiDMSKm8WxEkvuJRSVF1qbrtVfAJu5CvFSxHCfOlf97p/0rgXFV+DNyy8yZcrUQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RZnnN/t7rbYeLurwkBQFv8boMzOtWwQlwiPCAptBby39inphlbj+M6Mgs3BU?=
 =?us-ascii?Q?ZHV4FEc/njRV2v5ffNI9dz3mf9oMjIN33SlheVoN14Ic/jkX5QVecIomzi8O?=
 =?us-ascii?Q?tKB0xII8Td5AV5Cs4cTn1bRJ5dNZF71loHj6tJTVWPq+a+/5jCrcbi4Ui9T9?=
 =?us-ascii?Q?mB8OfSEmrhM5ypHHIaFDF+kH+Fvewekf8DoQI1Xuk4endCR2gVBIq8jgse7x?=
 =?us-ascii?Q?/070duwvEd+l/1NCjKAJqthgK6FVqGSQ4W9eez0hCaQTr7kgAMXbOOEJnHqY?=
 =?us-ascii?Q?uJE84phej1mAk2NN7H5hytGF3ChXVNparLZB0V9J11lPUBLPCqqEIvjUSyYU?=
 =?us-ascii?Q?O2KSScoHTM3SqfumLjr63rA9WGz/bS5vq+yAhacq3Pb0vwozgKxhW713Trri?=
 =?us-ascii?Q?O/akDaSgRyl8dlDM0zQXH2Rb0RULGsLIdGUorcMR5vkrWMZkLG5BPnGPycAo?=
 =?us-ascii?Q?Ee15f9Dlv+So3qen95Av9psKqfrw+OnFS1njXttwVnYkD8cZdraghGEVQwSE?=
 =?us-ascii?Q?4fHvJcRdBa5X7mzVcTIYngfDZA3WFpY3kHB7hqsbFun8YZ7U7hC/+DHZqVWb?=
 =?us-ascii?Q?ufAidsVmTIBsmPQSHamwarhX/MlcSIijEC8/4BTmEVxaHyZWKBck0XPgUTVa?=
 =?us-ascii?Q?3untTmQFhZAJjx5hxzKQnuZNcRzjUDADmPask8XuGl8rQaDwfpn6hUjqcq4B?=
 =?us-ascii?Q?N+jn2B5JBWIrzTvD+7uz38rN0QqWRGef3iEaE4y0DS8HKP5LEKr+7UOHMaTN?=
 =?us-ascii?Q?6xEdFwbX2OVaUnsBAJ0MFdbkbnJA1gZH/BLh78wpoj8Ohq8Ea4HazOFXY9rM?=
 =?us-ascii?Q?sOnswV+VMG0NuyNK6H0hVlah9qhSD050m03ZeMAAKNvwXO/1YiSxU3kY1R+V?=
 =?us-ascii?Q?K/Ai7bCnxVjzVctT2PjArMmp7LaQM3r5yXjxRH7LCaqZygkizwcJMLr83jGc?=
 =?us-ascii?Q?pzqXBFfamFk7jFUGld7XRTe9JtksoiSWw5d6WdnYnwQupbYTEzt9wkln+fWS?=
 =?us-ascii?Q?mAGbdc8FxTYSSYI3tCDSHl5yF3CtLQTg6tqotnL4Q8h94TnEq3Iu1VoJ1g7+?=
 =?us-ascii?Q?0tRxtjSiX6IKG5/E3y4RcQh0UiAYANbY2h9n3tzom3AIDQP723RpfF2v1PQk?=
 =?us-ascii?Q?TJjrbHMt68+IJBsHkud80PeCgHExfzMQIqLBr/ZTUhS8kWD+IwHs1X2z48a2?=
 =?us-ascii?Q?EgdcN/ft/z4dQaabvHrLjZMKc+Eivz29PnS68V5pmoRmRzA2tBbv4656eog9?=
 =?us-ascii?Q?QQYlugJhS0o7BakKNhDBhSRe9keq1Aa5gPqy7WtVvgS2Ce/v/42AlZjt0HvB?=
 =?us-ascii?Q?teO+eXTEjjxIC+zhxcMLLdrsyxbtxvwX230SsvJisaoyd4nZ/olBGmwLQ4rT?=
 =?us-ascii?Q?SCPnSKns4AXrJFdbRsttLrHnuaj+B6d6rSE9GO//kLePg2zIRwpLdYbk56ij?=
 =?us-ascii?Q?noz7PpM8dyoANYv6/U8QteELwnyimHIegTHJMEHb3c2H9nLoEQzchF5CV5al?=
 =?us-ascii?Q?vrbztmJfce9gAdfV7aybFxHayGQVvhlnbLwWKYH0S76KiscINbRX9Fsru348?=
 =?us-ascii?Q?jj8TzRJOMnt1xwwnV6WA9JD1PIlkkHJtoEFnRHeIJeHNmmIHyrJX/Qg4l5gh?=
 =?us-ascii?Q?IBBsbOe2QORfEky6hTZlGFEWGtvLA/QwyibX/SXPM++i2Q1Ujl4eqRgv77Fb?=
 =?us-ascii?Q?FwIsAZY0JNij5a0fRhZ50LrjP39HUoo5lVjaQZHfnRZ8xi7MsSESonii5yNH?=
 =?us-ascii?Q?ScCBdOrMEHue5RRTs7kIIIuRwV0tuU9+OvfnzG5sYv+K2zqeLzTt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5d475c-afb9-4ac3-78e9-08ded5c4505d
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:53:47.3133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xjlqLjGuz6CjpyjpaD/4WJJstbK8LJWnnh1jWyxkoAoPvfknoLkeIDDWHqHh/9Z03Ox1didGZzCasGWyFBaXz7rjGcjMrfoTRlQwDdfGNXKTwDJi+O0A7xRDkOFe9cB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11411

On Mon, Jun 29, 2026 at 05:19:50PM +0800, ziniu.wang_1@oss.nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> SDIO devices such as WiFi may keep power during suspend, so the MMC
> core skips full card re-initialization on resume and directly restores
> the host controller's ios timing to match the card. For DDR mode,
> pm_runtime_force_resume() sets DDR_EN before the pin configuration is
> restored from sleep state.
> 
> This is related to the SoC IP integration: switching pinctrl setting
> (changing alt from GPIO to USDHC) impacts the internal loopback path.
> If pinctrl configures the pad to GPIO function, once DDR_EN is set, the
> DLL delay will be fixed based on the GPIO function loopback path. When
> the pinctrl is later changed to USDHC function, the internal loopback
> path changes, making the original fixed sample point no longer suitable
> for the current loopback path. This causes persistent read CRC errors on
> subsequent data transfers.
> 
> SD/eMMC running in DDR mode are unaffected as they are fully
> re-initialized from legacy timing after resume.
> 
> Fix this by restoring the pinctrl state based on current timing mode
> using esdhc_change_pinstate() before pm_runtime_force_resume(). This
> ensures the correct pin configuration (e.g., 100/200MHz for UHS modes)
> is applied before DDR_EN is set. Only restore for non-wakeup devices
> since wakeup devices kept their active pin state during suspend.
> 
> Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Regards
Haibo Chen
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a944351dbcdf..7fcaecdd4ec6 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2114,6 +2114,12 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  	int ret;
>  
> +	if (!device_may_wakeup(dev)) {
> +		ret = esdhc_change_pinstate(host, host->timing);
> +		if (ret)
> +			dev_warn(dev, "Failed to restore pinctrl state\n");
> +	}
> +
>  	pm_runtime_force_resume(dev);
>  
>  	ret = mmc_gpio_set_cd_wake(host->mmc, false);
> -- 
> 2.34.1
> 
