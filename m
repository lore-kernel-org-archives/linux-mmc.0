Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2063.outbound.protection.outlook.com [40.107.103.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13841225793;
	Wed, 21 May 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842999; cv=fail; b=dAgUG7ZqUFFdQ0WCN5zcKQ6E0IIrKDVKOA9NivKAGdOXD3/R//fctyiuJvPIRaP/D5YIdYGbmqS46sFePPHZqPiucwAy+JHgk8q/xLeSPSwGaJvvd1UDVi6bqWqW5Vultcft3+UVi9Gm3XOEdDZgM73NVITyOTw2rSqYtp7aiic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842999; c=relaxed/simple;
	bh=l1mceNUI8XIXddxDHp/x8HIEzvQdK849ugBbMGBTRKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sxKKm0jKgnAqWd8DnFdquuRgzS2GlmZPRlGNN9Jz2InqbgJ2UzJn5nbmuVqFhcE+UsY9mb7NgggMRxnIXexlklZ3Exw1H1k0mFwpnkmi4WeFXh5F/UY5t1Ox/N9stMdPUF4esT23XWffGRExjLZmMyD1Y+K3Zh2yg72DqsUWxe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PONmxb7f; arc=fail smtp.client-ip=40.107.103.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PONmxb7f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1lj2rqD0AzA20DbDAWJg+AlWLcsYmey0EVZjlUgDE5c+BOvVdVaG20ZHAxe/qxg1xmmOXMJAi+lW7SZ+TT2Zm6eBEqeag2UfrP8JOv6YZAg6MD0E4xAcpBJqHAIEvNk5vZN7WSYWrY+nbhB2O9uzES7V0kvn5IAp3MNq9vOr3i/L2eeK1hlvvJhODw1gJNOKl/s4VCYggC74hBg0JmbbGDD9jv2Jxx12e2jamEweEQdLTSC/lg/7R1I5b4dJrl+JgMHJiCIQ2+mUEJGplmmVN/9zk9igmpVgKdPJxc9DuGYIFgQpKkk6DFTwa6wMESjpZVJ0Sfm7q8k0qX3IxGNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwwZ6bnUtHqzqaqkFrS85vk/pm3cAUfZ78V2GIixxoY=;
 b=xOP330fi2H1u8kQO2eeaLXAi7dF8ZL4o9xNccr/wtA/v5nPpgucH6S/n14l4bRwXAEt2sTTT+ed8m1WQoU+syqroCxqueMkH3/sCFrtq2SPrsEXomN0plOTkzmb8HF9Yt0xYi4p8b5mQFLkJ5v77UGi0YKl6pKxhyUUCIUt9wvBFICziJ1xELzq5pf74K8XVCD68JAvQrIOYEaGaoGdDfLVwKP5QG4TeoMa/fOMlr0wWu2hsqlBGNUhIgWaOMYvKpWullBlIkEeY/rLRJ8uWCR3PsyIhPH6ntN+RJShS7COiymPXTEDLnDm+IGSiJeBvfWJRj537bUlBtffX0kyTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwwZ6bnUtHqzqaqkFrS85vk/pm3cAUfZ78V2GIixxoY=;
 b=PONmxb7fLLPCKynbevhQx9fqSN2s800GrcE3UKj40/1htZLSkyZBBDBJcT7OK+52h4UEZZIayQqlrEne9Z7l9z4OUfGyZniTG5U/NnFjWUY43dQ01HZYRt9yukS756Lum9kf4d4kUnhiQp7XBvusdSRFEyKDIDADaAxE5V4hUiiFL5r+WbR+NlhXMgjQDGahQM3mIAi/CLl4a/8yC6g+GFC8UW00lbyqGtXKwoED6d05lyka0VpAknLLkjqcOcKR+SxVfWIcl0jr/Wnv79T4PLLtSnG9AFKm2+L9faIW7kR5vQcwPuoc5iZ6Qr8+I+ZNRl5xkkJzDH2ailF+ObhsnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9875.eurprd04.prod.outlook.com (2603:10a6:20b:652::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Wed, 21 May
 2025 15:56:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 15:56:33 +0000
Date: Wed, 21 May 2025 11:56:25 -0400
From: Frank Li <Frank.li@nxp.com>
To: ziniu.wang_1@nxp.com
Cc: haibo.chen@nxp.com, adrian.hunter@intel.com, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, s32@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: do not change pinctrl state in
 suspend if function irq is wakeup source
Message-ID: <aC33qfRFEvNbwSRn@lizhi-Precision-Tower-5810>
References: <20250521033134.112671-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521033134.112671-1-ziniu.wang_1@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9875:EE_
X-MS-Office365-Filtering-Correlation-Id: a550866d-5628-46bb-5dad-08dd98800f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Fbml1+IKV/iyN/DZoOi4auWRFkYK68TmfPDxqyNyQV8sMLsm/OvMter+utG?=
 =?us-ascii?Q?cLut/fWwIInawy94qCqTxPq2IjA5HeoZrO5Gw8zshWR6nDsoTyWv1qbxUioZ?=
 =?us-ascii?Q?kmTz+UXaeqw1SSDKWBK5+X7Q6QdgUNdirSewYFOaXMlZ1HJIW6S9enSj6EuC?=
 =?us-ascii?Q?K8tRCvSNwFr+EtZIP4MqWcnOecTNBudHjYRSwHpxPO3rURdhbbFQgfBSQGeq?=
 =?us-ascii?Q?pPD5q9RuFaHaz8TR1+0hY2vx3MtI8Iv8NzYDhWDrAJlRUM/9dogtT92HjZIM?=
 =?us-ascii?Q?PTZc+ZzK21vpRL71EEdDV/sgU+tOfFdM2bCDFoSbS+sT7NiWtonQgnRrIaBq?=
 =?us-ascii?Q?4PYc2p78H2QoJPZpbtgVA4hRnLRUagT4U8uYT9ZSEPGAkSoElY8AiPuzlhmf?=
 =?us-ascii?Q?BPiV/JQvi3zvTZvfDalogEpr4u7uT6YIR4onTq/4Esmi+gWyrJW8AZd8JBUj?=
 =?us-ascii?Q?hgYcwvfNHnHI08ZFfxKnIW8sChs4FXMfhrn8uOXs1raWchKQurUyLJm+jEKl?=
 =?us-ascii?Q?FRxB/9P0A84Nn22cG3Pmt5sSj8QSyZ/Bb4bn09qfkFU79Mx8dU8G/8ncCcsE?=
 =?us-ascii?Q?DIy0NPjF4xZ2azsiyfdXluNCYnnHSOgCvtDPJqyteau3pcWVfrB/GUIWtuz3?=
 =?us-ascii?Q?+HPaazQiK1u3WjOFl45nGiuu5+afHTNSrHtSyilPfHBBtttqeKUqJRs8C/Wt?=
 =?us-ascii?Q?a3e2TUq370hnoKF5TOPwzTds7u38dQAv4ojtC1LqCCXKuP4rSJMm32ywHUY6?=
 =?us-ascii?Q?2rx0SOpUR69+hElbcmqQpKSvou58o9VXp5wVsgSIoqDKarfODAmqbejF/1XM?=
 =?us-ascii?Q?+3F2ydhIVZGCTBHvqdiGGhOG0saqVuNcjZQU3ubTfMiiNH+NlQpVqw3OdCDK?=
 =?us-ascii?Q?QDxsPx8HaHz63fyw1r2kMk9LRn/XYSS+1/So9IGvQmJT1TAcxwoyV4nNFMH1?=
 =?us-ascii?Q?+QXVVhQ19DYpanunclwxQLlRp4Do5+MOQW219bh05QfVMsmnJuBBUGY0CB7A?=
 =?us-ascii?Q?Nn/7s9XQacajNTiMLPWUFhR1A7J3qJZZeE0dIBc0HHbzQm5Ixqy2up8LkiNp?=
 =?us-ascii?Q?9OPT3apF2Nt7049nnH2IBlPT0E2S+Faz8UfuPOl2910Ll53v5H0Pg1boKy5A?=
 =?us-ascii?Q?WWTglYNhsoHrkEpDuYTnFZkhBaq6KweUxATRS5tz6qVpRyZ5qRKfWgKSqcpW?=
 =?us-ascii?Q?CsydBYjYrRTPO/enwqFOrj5B8M6uwNwZylp4m0A9dm/l4iJ+Sf8fnoZ2V16Q?=
 =?us-ascii?Q?XNQm+NE7CgUCxtHdORyCujwMc08+bZme4PsYH33hMDEHNlsGSxup5hBrYa5A?=
 =?us-ascii?Q?fIBtkZkO75ln7Lcrt20BCVMLQhY220zcm6+KhKs3NPORMDot/GyyaE17r/M3?=
 =?us-ascii?Q?+oZ6WM6kPGbhUQuKgK+YlgecjVLBQ4LM5U24Gv9LauvDDMGZgHzw9Z8XvzG/?=
 =?us-ascii?Q?Ieq5wWtPRetsN4EBdpBQwd/mvEbcDtIDa/jCPH4VlZYXo+zg1tU7rA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lMX8hT05IvKycgE6pjcTmefXX7q03hrfCJ9ZiCme/n9td8Oq5mTMYZVhD4K7?=
 =?us-ascii?Q?nzLQThC0fkIYJpU8txXYaT2MFyfsqsWenDx3pE7k7rTLR4JlgaUWjXm6WbJ/?=
 =?us-ascii?Q?ey8DTamOT9VjFyoLeUuqfVfOi9c5u5ndSkdhhF6lyxCVNSAF/hayegJfMAAp?=
 =?us-ascii?Q?jjbzP90f+QKgfYtf05vpBHgPUg2B0rw5mekxDBA1xo82YdpI78CHCcWb+tHL?=
 =?us-ascii?Q?n6JxX+x40drsd+3UqKrAMRA+6HHoZLsfKao2LARMWoQGyFwAlz6zPpKlmAz5?=
 =?us-ascii?Q?S4nfRkx3YqzjRdjdnyj1BbW0t4YxgeLXkKpObqJR8tiuRFWyrUM36SLP5HQB?=
 =?us-ascii?Q?uCX0RqE/d675ifBUB2QwOdMo4OCjhglfWP7EnwTQc+ABK7duJkmdejOqQMnb?=
 =?us-ascii?Q?RjfHwyhTz814XHhGKYUp7Amw71xgMSeeQcO7eR7QCwG9eF2uZAqB5vO2ddO9?=
 =?us-ascii?Q?2mlKt0WULZmSKIJ45Fe4O2XuWebkt7yscwREonFSTdL2Vnor1vZSwhr7TN8U?=
 =?us-ascii?Q?ys/8s09/op6hGfDrDACeGX//jMxaGlEzQJn4Xj4pTlw5y7Wh/3l6qbpgRJif?=
 =?us-ascii?Q?HJ+RYlJHdTW2sdrfysjhmWvWpq7mSuXucCxWI+r4zhmngdwygQdRjt7QxQzC?=
 =?us-ascii?Q?REUOk2jymNAjeDxpa1s/Dj3FX4e9cs8w7YEOpRyuyUTCH/dt47IV/vmWL4Zl?=
 =?us-ascii?Q?JfH5X4yZOhdCIw+TO5oH8gmXS1c7ZX30RyzrYgr3ah2Hx1gPKxEyxOXW27Ky?=
 =?us-ascii?Q?vFRe4h2BLEGH5mequ0G8SYiCHz3RZidKXDQUFi0sq+lnhWplincjZziucT9K?=
 =?us-ascii?Q?k+voAkSM9vbhyHGN2mbKIGF/6anLHRngrLPieO/F2pwHQYTGY5SYkdn/XEa3?=
 =?us-ascii?Q?oQWIK7l0q866EW8ywgpHfKJ/hQnlJ/cMwOkKTlcBwWq8AwndWMQJ1cVAsHbr?=
 =?us-ascii?Q?HatI1f1UezcqQ+JsZtFsSMrU/GxURyG3T4/QZOVRm4M+M7SVa8lwMw62lciI?=
 =?us-ascii?Q?R7yqeO8iSfglBm7fefx59bUlk3UPnxu1n/1vu8rzYBnr8t6lgmmaOX1/BShl?=
 =?us-ascii?Q?zGj6ns4Wp+x4y6NPmx8uJPR8X1gpde3SsBUlltT3PnC7SKCFcUHWWqAEeMtZ?=
 =?us-ascii?Q?GsSNjUcUoWP/ldADBeqBXANCUqiIEHY3hJOxOCTHJWeK1cCno9+lMWoxZwdO?=
 =?us-ascii?Q?O0sw44ewGl9SYoHI/8gcrIOpWKOuPTKjRK+X5/9IIg8Ri50ltSksq2NXL2l+?=
 =?us-ascii?Q?ZOEFPoFUZ9jWgRyUc+cqXmBfvXmz9Hjly5EkGUKp5u7UPhyUJ/1hkm0BJzcK?=
 =?us-ascii?Q?ZZ4owHhltLe/EHLmwwDpembQN5YjOYFZsLM8B9hTWzhbDrkXAX8FD1H9DgoP?=
 =?us-ascii?Q?wfEDsI1oOy02QT3+9nBrWC1JPQmVJ9iDDQ2+e+3swze6pINPolzpYcSA7pVC?=
 =?us-ascii?Q?pBfbWvcDn+pJrtZeoHDjsc/ZLKQkX2TSzCJE8tpK1dnKQ2eOcKZ42PdMrO/T?=
 =?us-ascii?Q?w3xcfxm2Ba/Yc5YQp6i3tNFs4pLP63D8DUTlDXS/6Kl3jFOL70tUTPWB2cVC?=
 =?us-ascii?Q?ZQmXaGQj4sgTWkggQYA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a550866d-5628-46bb-5dad-08dd98800f50
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:56:33.8784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhAxBntl/UdmRFoW2RRc6yTmL/SLK5++eN5dsMBUHBib/PAW3d8E8vYIeD2zAJuSZbBhA4RKSQlhWxpWZP97rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9875

On Wed, May 21, 2025 at 11:31:34AM +0800, ziniu.wang_1@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> pinctrl sleep state may config the pin mux to certain function to save
> power in system PM. But if usdhc is setting as wakeup source, like
> the card interrupt(SDIO) or card insert interrupt, it depends on the
> related pin mux configured to usdhc function pad.
> e.g. To support card interrupt(SDIO interrupt), it need the pin is
> config as usdhc DATA[1] function pin.

I think it should be dts settings wrong. Does one PAD set as function
impact power much?

Frank

>
> Find the issue on imx93-11x11-evk board, SDIO WiFi in band interrupt
> can't wakeup system because the pinctrl sleep state config the DATA[1]
> pin as GPIO function.
>
> For this case, do not change the pinctrl state in suspend.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 5f1c45b2bd5d..f206b562a6e3 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2057,12 +2057,20 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  		ret = sdhci_enable_irq_wakeups(host);
>  		if (!ret)
>  			dev_warn(dev, "Failed to enable irq wakeup\n");
> +	} else {
> +		/*
> +		 * For the device which works as wakeup source, no need
> +		 * to change the pinctrl to sleep state.
> +		 * e.g. For SDIO device, the interrupt share with data pin,
> +		 * but the pinctrl sleep state may config the data pin to
> +		 * other function like GPIO function to save power in PM,
> +		 * which finally block the SDIO wakeup function.
> +		 */
> +		ret = pinctrl_pm_select_sleep_state(dev);
> +		if (ret)
> +			return ret;
>  	}
>
> -	ret = pinctrl_pm_select_sleep_state(dev);
> -	if (ret)
> -		return ret;
> -
>  	ret = mmc_gpio_set_cd_wake(host->mmc, true);
>
>  	/*
> --
> 2.34.1
>
