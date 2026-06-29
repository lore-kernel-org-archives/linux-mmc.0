Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F133EC2F7;
	Mon, 29 Jun 2026 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726056; cv=fail; b=W8wRDUIkdrA2QkDI891czxkwU0nzgdHhRdyXVIqbjtRAxv4j8u1M1geOYdoQ3ukEGj7U15IkiKUd6ssBrV+ImbSrfFfARx+8QHz4LJ7T7hG6fxIrxZlA5/XSTXTgUMTVV0KAMm21A8N1NIWFMQx4sSi4hvYrH7V4u4xRCO4DXcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726056; c=relaxed/simple;
	bh=o0XakLKdXGBFGhEY7XUTUL8jUvqSKYXhfKerSgBn4lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PxU9kLC40zJUca/h1EbHtoy8NpViLejtLuS3lo6H71LSMR/MgRqaukt+NSqay55wTHmEMyGLxhE/ulOLX0nLZlotpqh7ihyAYeGAnhRA9vnkO3irzYozVpdCbITNB4IuwXUbH0p6SzZQSzxjdgmDuFFphtTFXfFMFMqJuuSLqIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UYLTVws2; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UYLTVws2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fv5qNWRFqEigFXw1L1ze6MfHu/mDloK2uFF/y52cqdlD+ShF7aT5VT9KdJruKfPJC7+W4kioMr7ttCZHvPZHzU6LB6NZ2b9wnWYN1bCK9YFpi+8H/JTwPeiFxYQBc9NjAMfqAcBKpAqp85BEjhycYOgGkQU4YDDEbsvwBdtT2rv7btEMCnsY7XdXk25sRAtiI/bvHNIYwq7f7Bhx6OMHyE34WDNbCt+45gumsAJXbEeISt+E9ntn0pQq+CokEi0GVCUXkZtIiaGHDbO319+rcoyaAKPSQADDp0rcBv/Ls6xkNvHap7aA7pK5tAzZAzU8oRs9r0IXbA67nT38M8TrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyQi4n1odF/iwuIjKwXTCXpiKHRPW6OjGOWZ5W5vL9o=;
 b=vshLlETSRgkk2ecNQtprTKWFUSfD8LWcHWJQFsd7hnTmtubuWtgBoOSAvy8ej7giDpNUDQRvdo8ngZ6k3h6nLB9KXEadNJ2y3iNcta3X+7sL+5tNo0kMgAj5a+Dc4AiV6dHVol08cUR2y3A2tjKEYJUphBWFq7bL62ObwKtiFBDi2KjYMyPuSpJrSrDoSxFmE5qf514TVJbHcZ03Wo0CGkx3SYPQC3GP4VOaJKrp+u88sfjmiNazJjyOx8HZlCPaXMUVZ98c2hnZVP3Et+2tWTrhJ6t6HxCVgvbXDhb4AeRwC7rj0Y6ybtvnn808ZQJJujNHQ9pd+GEfXBfkLlFpxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyQi4n1odF/iwuIjKwXTCXpiKHRPW6OjGOWZ5W5vL9o=;
 b=UYLTVws2inyFWIssxCnCG44V3GkNXwQuxAQKTRAXTJH8v6B2FOKd2BsYSeGiqb9r8g50avGrz7NqHhENcVrJiYT8d4GnIs7bNhvXvMkM6nQJvrTzTtH97h84F9bCTV3Zqjx0o6nHYRy7MdC/2dj7flBns4go5J0/0dRyz/5i9aZrvDSriy2KMN553zjx5c8xHBd6m6ASSDvT8dUhddIsTLJV4BvccGzyFisQCk9LXzb2w6MqD223TnY+w7KlojusagbHT2zaWfWvTNo6qrSO/dO51hLfCnjeRRmsu2cbZxOmWD5Ir6RPC51/52odCqnb8f34J/Ad0DGXCu+Er4TBKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by PAXPR04MB8222.eurprd04.prod.outlook.com
 (2603:10a6:102:1bd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:40:52 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:40:52 +0000
Date: Mon, 29 Jun 2026 17:35:31 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: ziniu.wang_1@oss.nxp.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, haibo.chen@nxp.com,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
	s32@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] mmc: sdhci-esdhc-imx: remove unnecessary
 mmc_card_wake_sdio_irq check for tuning save/restore
Message-ID: <20260629093531.kyruw2jnz5noqubh@nxp.com>
References: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
 <20260629091954.3227151-2-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629091954.3227151-2-ziniu.wang_1@oss.nxp.com>
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|PAXPR04MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ba3ec2-2d12-4543-2510-08ded5c281f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|19092799006|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	15I69z3YruhjHpNCTxbtl2/I0xkYqmmeIZlwAt6mPe83r2+043d8QwR8KlhBlixJex4okPumyfxt34wOGGshgmBxFjFp/aEHoXzHU3s8Llq6WRmGSIviwjjkH5DzmtfAS3Qn+GwNHj+IRq1yX9yBjsJfDvK4JFx/0l2kk56sdVy0v/tomQkDpJ3av0NpJti6stQVCr+zzIfFO4XqMzcbtuwukTQJHniocEkqy3lONVNZ55Udv/fBPpS1XmHS2xGwnpqklJ9H8+yN7LtE4HWP/lPfFuemgl1KEMsoz29JF0Qnz97O4RZUVPn0dIEFCf0oeSx//pLwXTUf+pW7tNUTcxa3UVQxDfsy7COVh7J6H2YWG4zybK6ujwyYAUf4zIxw37QGGkwEi97cIDrepqCZVNTBn7UsUaTxna1IDE3tYgoLQz13hXtyxoo7j4mahg03P3lydOllAGxaBIGq8NerddwLrVA2T7hk8dEzh/fPH0yZR9YEQg+SEI7zhxFTS57o+7I71SashTnvn33CvPPsYQlqSaelHbDhk5Maut1GMSdG7zFFAmJ23ZCT+56xubjgcNFsPVKiIogPpSJkaRb4kRWNII8PRgW4TKDqdNgU/QnW9mgwm9teabJtr1/1gq5t7dY2Kpdpm9CA1Yrb2+q8ZZ/uRktvEQFgjUC9vhbCli8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SJpqlQ/mtW/9tQhdsTbPXo81l+hNCz/2xkWgR3mUyrQgZpacRDdUMLKDaUqm?=
 =?us-ascii?Q?+5RyU7Yc4kTWXKRxyQi8aYTeztOag8rcC4jkPs5SBnIBTuDu/sidvMKDm8W1?=
 =?us-ascii?Q?Xu0vOTrdqfoDkoVKbNjcfi4rbv8V9FJ5XJsqIfuwRg+P1qEXmVpIo0mGYwBW?=
 =?us-ascii?Q?9pLeGsPnieP6HoeCQv6TNaeedVqdVO/elUO4XqFsLJLizHdar07xE8WySsCi?=
 =?us-ascii?Q?o+NmVTs8ambNsy3yeIx099TGx9D+N4Fa16XBX/InZcxYF+tgI6qEFinErwvm?=
 =?us-ascii?Q?27PXw2PYs3m3gtUVjtaXRv9e26gPj00oMzYWDrZDoXcPiFW1TmMtOCpbBmzk?=
 =?us-ascii?Q?ptcZ+JY0ehGO7L112N9sqtlOswW03YxdhObJsKxS7WuqfMVaV+sJFlg6O60L?=
 =?us-ascii?Q?vd+wkOmm3QXgBXF9p9ACHC2YjoE8OtwPgcGpELWmkpUV9np108fiesTatkp5?=
 =?us-ascii?Q?yHmyVmHgpxBHuuEm2S2sXeydAWs8pc7IP4dO+ZVhvGp87d+d4gaHwqLllYUo?=
 =?us-ascii?Q?iPLK7dLztngosTZFSgWwODniDAF1bnRKJNMvQA5Y2LcPkWQiwDfF6/PnRp3h?=
 =?us-ascii?Q?gVM8dAmz5ILANkBwohqyEb3pjDxLgVlGFIQu4O5lJQH2RIgYh0cPY5q9ViFX?=
 =?us-ascii?Q?ILVveWxSUlM/7MGXcqIEnIeTi+rxiGFkwiHxUuNNrJfSBbV64yUzvP+huO/U?=
 =?us-ascii?Q?uX5Cg6/UnHhHdSRFWNZuLPIkjLpdfkHJmxcB0MzIFNjaVCIznmKVJPxWm3HJ?=
 =?us-ascii?Q?rNI1mz4sedHPFnetsAMpgPSieQmaBPyN9ut2l+Ufmu4hj20EV44wZZezYanx?=
 =?us-ascii?Q?t/yxX66Xc8x+S4+6jvB0Dh8Px6MGVDuqgLdkx3/DSlctXOz8EgkziCksiuDP?=
 =?us-ascii?Q?MqDBZrDWKdnNpfG+yi3n7nmKMvUMQ1jY+YY5FUIOV0GT+eTAKhgnOArXZ7OA?=
 =?us-ascii?Q?X4+lDAkBm9oLoRFcWlJ3XOaekicywmljr9aLESQOcSzlyz+qCU6VGqx+A5MD?=
 =?us-ascii?Q?2E0bXBeuIZK1AjLK+3l5g4sMOj86fjkUkd2fdI8fIEjwwU8Ek654HzHn8S1b?=
 =?us-ascii?Q?11RzqLoviCxzWkd1bJtQbXOHrchhYswAAQjwUEtEtn/aqi/aU3QBYdiGpewc?=
 =?us-ascii?Q?Z7azd8GeWLlg7eEFtlCNwG/uI5VmOgoji/petFdgy0j0wguQ0OcVgBsPg6ca?=
 =?us-ascii?Q?vt706sMJRrKY4fpwfJbtl5TmgzNmZmsakWBedw0oEQmtHZZbnSOotoOdhSlC?=
 =?us-ascii?Q?RHG+iJWR2scC5FvMicwJX2ACJsCrIft48khCI3ArJovGzuJPb1OqtufPdtFU?=
 =?us-ascii?Q?n5NGdwjlphUxs8/Y9FZbUsHduQ0SsdlT3hV0/VMruwu5rWSx9aqQXpd/xFnw?=
 =?us-ascii?Q?ZcibHeoxcMDzJq0b32jBrAmRTif5ZnS3XyYHZszk74BfW3a16hVjAhcEV11q?=
 =?us-ascii?Q?+e9e3A+4ORoAZTmJGTdBNzePr0Y/GfHa70hpdfcAoKg2/0Y9FhmYWjaXzOBS?=
 =?us-ascii?Q?YknC55Sc/Y009zW7tKpsFk0B1N7UHKz2+qsuPVA4vLwVqZ9DN1ggg+2dW7pF?=
 =?us-ascii?Q?2pudKJvKpx0fmCmMCbcb/dfUA1JQj9dYpVco4EgyweEFSm8M/fMQ92sy6QOT?=
 =?us-ascii?Q?tHYOwn1mPn+OSeL7Z40E8wJxvyCEgQhF12D+/oYr2Hns88WBgbUhaC8DA4jz?=
 =?us-ascii?Q?2WH/swnKGDFBfIPF3mofg9iHEXmy6k0WRwJsadPKiPBetFQIYi256wSI1wGv?=
 =?us-ascii?Q?SD/VhbpWXPEGViJiHdCR6lc2IZ18r0Qzpq3QKoybH4c1kCogzJ7D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ba3ec2-2d12-4543-2510-08ded5c281f1
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:40:52.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77TYMQos/p39Q5lE77+ms4s0FsRks7lYwXFoxazHf9eaAUjYurmCHkW3OBdhfRbGN5NogRfFy/R78bFJ2BmnbqX/jcgowMgwgd9h2G5sdoFknYblZBw5UFOK336stwbm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8222

On Mon, Jun 29, 2026 at 05:19:48PM +0800, ziniu.wang_1@oss.nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> The tuning save/restore during system PM is conditioned on
> mmc_card_wake_sdio_irq(), but this check is unrelated to whether
> tuning values need to be preserved. The actual requirement is that
> the card keeps power during suspend and the controller is a uSDHC.
> 
> SDIO devices using out-of-band GPIO wakeup maintain power during
> suspend but do not set the SDIO IRQ wake flag. In this case the
> tuning delay values are not saved/restored.
> 
> Remove the unnecessary mmc_card_wake_sdio_irq() condition from both
> the suspend save and resume restore paths.
> 
> Fixes: c63d25cdc59a ("mmc: sdhci-esdhc-imx: Save tuning value when card stays powered in suspend")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Regards
Haibo Chen
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 18ecddd6df6f..6526d65538de 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2064,8 +2064,7 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  	 * to save the tuning delay value just in case the usdhc
>  	 * lost power during system PM.
>  	 */
> -	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
> -	    esdhc_is_usdhc(imx_data))
> +	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
>  		sdhc_esdhc_tuning_save(host);
>  
>  	if (device_may_wakeup(dev)) {
> @@ -2124,8 +2123,7 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	 * restore the saved tuning delay value for the device which keep
>  	 * power during system PM.
>  	 */
> -	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
> -	    esdhc_is_usdhc(imx_data))
> +	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
>  		sdhc_esdhc_tuning_restore(host);
>  
>  	pm_runtime_put_autosuspend(dev);
> -- 
> 2.34.1
> 
