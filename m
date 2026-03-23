Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E242314B9D;
	Mon, 23 Mar 2026 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774292709; cv=fail; b=lQSs7Od7WxOyGfn2h00KIRMEbbEghytZ2iPWpOF9IjVnVIZQlESUS+ojAGwqHSlnqRgy1xLkiDW9UveVb3gUp2BUSoP0hi+7emgVq2W9VYyzZQrn2RxgZVvHiEh/RFUUWKAlClSY0qxoMGxxG2fHWE8vY24ABVPiu3h2CuBffyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774292709; c=relaxed/simple;
	bh=GZpAK9atlZAKaSxkIZhGQ65IgLVizOaKalB+OAPTLXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EKlv7Sc7vq6REYK5RGBxxd4qHhWPMMjSICV7pUN46lb1Mh7BvoSDlV6inUxgO7NjLHrwsYjIeJBgRxdd4x3hCvUAGmwDGHPeExjGFCajv+3Y0mJNtj5+p+tNNxp/j9MjijQntqS/BXiJMg3xinaZgb3vGDHegclvD/gv7znPSns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EpHMQOjp reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EpHMQOjp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQvnjwxX+DB78AZkC0luykAqPf+rq/UTELrXctGM0fWRPDR01VsXc63mRh6icZFUFTbCQdJqBmHqGggyxsm31BBkct3hUpQ2bGEXmf5eNhMICCvBhdLybifTGJ7k78qXvGXudYwZSyI+xTZsZogJyFCh5abMRJMNz00lv01sd6pJEe4k3CJH0kb67W4SZEeCMvtERDsJKxCKUjs61+lYJOMVqEF4QFBz+SFH5/I0aLPSOrpmDUPUhYstEXOTtyOyd4whffatPCfTomK+qNAzo00rNyz8FAIdSb+hkconbnmhzmOssny0L5b/pxnQ8rsiJqK8MVKi5vL/WjU1tSzDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx/D5anR5ikl9tr6Tog19sQv184r1nnFG0hzhk5U5WE=;
 b=r2TLTTwCvwgk9AC4YinjOgqJi2sMwRqz13LiJcHHfZjyfp7Wqb2CYN2vzJTXbc3PgZiJAv/EHEaTlWEVnNqkwGxkgsgYyTvwfmK2J+lvqFcivQNF3OUzUbkH3UwhXbhl1tvnI9MqcrDmy3llEoEjMebyx9oE+Ao0/4IPGZPg8qJBTgO0os/pKVPqonLuXnH8AAQkw0NNdbbd1iHQFv60TrYC7T0HHYwfRMn5IbFtjpAHUCmeCJRIqBoKTbSWqt5qKPfFh3A+Rc4+K/udLU/EvoblBVSYnJM64HvkJLvhVW7hsHCuLPxfHJq0rJFJsatD09x/6tp8vIF+mkqSbLOcSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx/D5anR5ikl9tr6Tog19sQv184r1nnFG0hzhk5U5WE=;
 b=EpHMQOjpqvCasg5aM9DJQMCxKINhl+YgzikEHvwE5WAXRksTRephubL8BeywcKoQRCoTWXjVE+LDMxb4C0dQX6b0Hx8Yawg6Gzv040lKcopakvqY9uBMSDJU21O0IFrhMdqVPw+wwosuOET4MkgQyMAkCs5db9ftwFrluvDudcuT2crQser30oE3De0jYAlHWszz/oulDMd7JZIrd9jCWti1yjIy/brKF4yYcemxLzk8gBiRQ43422DpUITERBQrEYbJsuPbZ+GYJAONsgE5sM9/UoIY2++riLCMk12E4hDHek4bc9h6E3kQivGEU1NFn8wZmS3oB8nQBaBaCqz/jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB9662.eurprd04.prod.outlook.com (2603:10a6:102:260::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Mon, 23 Mar
 2026 19:05:00 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 19:04:57 +0000
Date: Mon, 23 Mar 2026 15:04:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?Q?Adri=E1n_Garc=EDa?= Casado <adriangarciacasado42@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Haibo Chen <haibo.chen@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v6] mmc: sdhci-esdhc-imx: remove redundant mx25 handling
 and consolidate soc data
Message-ID: <acGO2UGXZXyPI-jS@lizhi-Precision-Tower-5810>
References: <20260319173832.15543-1-adriangarciacasado42@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319173832.15543-1-adriangarciacasado42@gmail.com>
X-ClientProxiedBy: PH7P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: dae93b39-4cea-4429-dd6b-08de890f1355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|1800799024|366016|38350700014|18002099003|7053199007|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/VHH6/FjaBs31et9+tvkxxHQ54e75Pxs65qbd+91QBh9THQKeMBx1MbTnPd1pqJE6TjcRYS3HhmhKbvLZOIF23K+gBnTpVWkriiUsqwaU+gT4Uyln4CqgcH8/s+S6EczjUD0AkyAOkUfdEoz6KHmMAFascl/iZi8FAhfVS2sgx4IWauMDULVFMU2e6z1Vbfg5iKwSPqyyVejSZDr02+p+w4yu7ugjJKrjvGXWdKme6Ouaintvk/c3UFOzEFASRBerKPYvisOAvo9KP3eW92GXJphX27FZnwY2aqiAwkZMQM6mMmXU5D/FAjlr3Qkiy++h+JwV636o8TsTy1DQin8mZ9YY05I1yasukYVgdR2ZLe9qYlxKFfv2vjSNWF9N9+Ni9RKha/nc36kmL/RlR5ahRLGcQ+OPbJ66zRiLmkfV2Spbh53sFtJWvfG53gOeozl81trf5hpLhi5UQGZ0NUkGKnKicBR5Xuf75w42JyxjGCsjRslD4cG5+Ac/VFH/WWWMeD7f1/+En4hXo7eBVX+THaJr1dLlDoOr3fhfnQU1wd5ey/w+wc+JZ4pGturFYkx9giAdfn/gpfHTMRF992f1pKmhQeKHpS7T8RxCTzvVJfcRH/nH5OS3rM+Coryr7mJygFoUcrsv/iwDJrQTM3Cvlpr2GPYVyykDYjs6IuNEBYDiPOZQlLvzyCGJv2hPYasvrnJEbUXjH/apBtJMK8QPKJfMRpbTpvNbn2LRw3rocmMlp1tUF0tAEcXR7zz2k9XfuTm033X/86etPq2pOhIkTtiIONnHk/WcX7bvsdMiKk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(18002099003)(7053199007)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?VtmGTAfz5fNmrd28HA3QOaLGRciTcc71DD2i94JBgY449iZ2DZSVTT6tKZ?=
 =?iso-8859-1?Q?ulPKfIlS+W/+SovU1wW08VlZr3lxB+NEBpoD4+9ycBXLmxaJr2Ky5vNLgE?=
 =?iso-8859-1?Q?hnXruyVJaCw5phGZXUTQVG6w8Upg5uy+gVN3HwdDyD7R7JSf73qVThmmpL?=
 =?iso-8859-1?Q?tT+Ac1zEF/BGUY/uacTLg6OB91eLT1NUubf3SJxL75FDs2mNwU3j7UHuF1?=
 =?iso-8859-1?Q?tWny41bt2jDGPecNeNb9xP7gT0DC/PiehlMcIT5JjvLkEwZUlO6F8TxLan?=
 =?iso-8859-1?Q?LRjzOqVAMfHN0OgWlhBONWv2s25sbRpueeTQ9YIw6snE0ktFC8iGmsafge?=
 =?iso-8859-1?Q?59NEsW14LR44t5eCJZSkR29rgTm8FvEgFaAQ2hhOvi70BhNn5llhvmmSJH?=
 =?iso-8859-1?Q?G2mwPFQflfr8qB7EB4BbWaANDDO5b2mShSszb6w3Vut58PMOSR13w8BAxz?=
 =?iso-8859-1?Q?qWrVyHydPTLAc0PfNjqr5NXg9MN4y50D5HIlcUXEt8+2MA/q9woT4DHqSb?=
 =?iso-8859-1?Q?08PfeXpunZoKKTEPCRRfkZxpN505ytdRzzeoI4GsJHCx91NnSlc27MFHc8?=
 =?iso-8859-1?Q?rspSbU74SAVqx2gioE1eBx8kvlnxhqTg092shZkzpZXs/SSKj9LNa2Y1LI?=
 =?iso-8859-1?Q?vKoX31PM+OEquAqt5fQWpjAM/qjNV8NrmRoFMcuvVs9OD5RwFEVPdDUrH4?=
 =?iso-8859-1?Q?syEKuFyRZf8c2xQ5RXMHtngFnKy5bPGY0ITNktTNC2xMutIjkQegGYXbws?=
 =?iso-8859-1?Q?uIbf3KVHxDJy1nt3ASvXEj+tK/jh4cYV/tfzeQ32BP721bQ0TPjjrdTxM1?=
 =?iso-8859-1?Q?HUn2msD2LnVfKXXZ4lUPCiClPTB7HLuymdEOb7D+mYzG9mcN7OGH/brzEj?=
 =?iso-8859-1?Q?372Mu5Iv7u42L9XCCQlL4WM0PwbXywTkl0MkphL+Df0rvEG4wmu8KyH7YL?=
 =?iso-8859-1?Q?/61Pj2mGtZIS7yv9XuX66rdf90Bod+hSepTGrrB2k/KvQZ/tSyS6I+4HeV?=
 =?iso-8859-1?Q?McbFgdboeK0BPUgA5spcezHRY8hPk94rCBj6EujYdUJayX/BZmy9ZCWO1v?=
 =?iso-8859-1?Q?cCFIRs0UntuCxwyBs65/NePSz9+2xC3PXYP0pKuy8JWGAlvAmg1VXdwyNv?=
 =?iso-8859-1?Q?v6G/2GkP3KfUQ9lzWhsanQQ+fiBwVsEru5CNzdgiAHjQq2ib5jXylW2Z7v?=
 =?iso-8859-1?Q?3UxLwR/dP4a4kZaxuYNhoLFT1gRhB7JnMSLw3HpTL/wJJU6VKoK8pXaO99?=
 =?iso-8859-1?Q?jv5SXbe8cT7BB1fkNY1CAMhqoV99tJU5p7O6camXT+YSvZ4w3u5J7pOpv8?=
 =?iso-8859-1?Q?PQPBR95qcUQXw6ivOIbIPWx98GAKZeT5j74+1hYJ5tdQptLKLhGw7wunqd?=
 =?iso-8859-1?Q?QNB5vUef3hrZXnvSLp0OjkyumFgap5F5ClvqTcEvL0FT8xDuYC3HDKf81z?=
 =?iso-8859-1?Q?7wRP5Wz8EzpjKac2wPpJ2AT4n6YpQHscH9wIO1JXwMzseSHhIexTEuAh9u?=
 =?iso-8859-1?Q?ptnp1PGcxNnP4meTRPd4LDq/PZUzT+jcA6y38a1qsxA/gPfY0CnFc6QyvN?=
 =?iso-8859-1?Q?X6LQLmCysRNvS3E2XZsjcPDAx/jsAoXBcgt7Xg3WyfpgeBDqkGdadpOm/g?=
 =?iso-8859-1?Q?0Sd2U7sbbCAkw6c669P1VkygIQB0gRUFtqHVcFwj/0VEL+kUNiWdBfipoH?=
 =?iso-8859-1?Q?x75rs2FKjA+9HEdRCpT+Y4fPa6dTdNDz8ccNmFnV71qDJ5iagPJw3Hv6TB?=
 =?iso-8859-1?Q?15W30J0bcQHaXe3h2Tz3WqOIyAZZXGZ6ErBeZgnhEkSSuVOK8iXzbzwMBX?=
 =?iso-8859-1?Q?0Mqpb3i3NA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae93b39-4cea-4429-dd6b-08de890f1355
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 19:04:57.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bl2+HdXyRX6JgGe0CnT/z0doowmFch0Jb8GKVEGrxq2+dpPr48uPeUQXBgGpf9JcZnP4Iy+BUL538CHoWEh8XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9662

On Thu, Mar 19, 2026 at 06:38:32PM +0100, Adrián García Casado wrote:
> Remove the is_imx25_esdhc check and redundant mx25-specific handling as it's no longer necessary since the new_soc initialization. Consolidate the drive data structs for imx25/35.

wrap commit message at 75 column.

Frank
>
> Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a7a5df673b0f6..3dc43f1e517aa 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -256,11 +256,7 @@ struct esdhc_soc_data {
>  	u32 quirks;
>  };
>
> -static const struct esdhc_soc_data esdhc_imx25_data = {
> -	.flags = ESDHC_FLAG_ERR004536,
> -};
> -
> -static const struct esdhc_soc_data esdhc_imx35_data = {
> +static const struct esdhc_soc_data esdhc_imx25_35_data = {
>  	.flags = ESDHC_FLAG_ERR004536,
>  };
>
> @@ -391,8 +387,8 @@ struct pltfm_imx_data {
>  };
>
>  static const struct of_device_id imx_esdhc_dt_ids[] = {
> -	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_data, },
> -	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
> +	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_35_data, },
> +	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx25_35_data, },
>  	{ .compatible = "fsl,imx51-esdhc", .data = &esdhc_imx51_data, },
>  	{ .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
>  	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
> @@ -412,10 +408,6 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
>
> -static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
> -{
> -	return data->socdata == &esdhc_imx25_data;
> -}
>
>  static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
>  {
> @@ -873,11 +865,8 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
>  		new_val = val & SDHCI_CTRL_LED;
>  		/* ensure the endianness */
>  		new_val |= ESDHC_HOST_CONTROL_LE;
> -		/* bits 8&9 are reserved on mx25 */
> -		if (!is_imx25_esdhc(imx_data)) {
> -			/* DMA mode bits are shifted */
> -			new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
> -		}
> +		/* DMA mode bits are shifted */
> +		new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
>
>  		/*
>  		 * Do not touch buswidth bits here. This is done in
>
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> prerequisite-patch-id: bf56dcdce62cb97741b7aa11b04c7a9648fb2d6a
> prerequisite-patch-id: bb57e0fd9cad8c81bcf7a6389f3cb294bbe1eb52
> --
> 2.47.3
>
