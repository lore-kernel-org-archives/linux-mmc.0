Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA3D21B18B;
	Wed, 21 May 2025 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842381; cv=fail; b=SszK/fr8XEqYEiAKJk1pbIN1fTGGQ6ohvhntya5AwZBdvIXo71vTMQ9mcSFfaYs3zqueWI/7iASKasVFo5wrmv7s/Lx9dB54jwXVdG0INkIhwtz/37WYwMacX8Plx64vQUhsXD/CMd6ROOukIIqRCpdOkfogmbJ3fGeVjw3zFtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842381; c=relaxed/simple;
	bh=pjgQOsRDeC8DTKoeeXu9vKX+PNE3PuUyiei5t2iuVMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oy/EAEZUEb5OCG6QDHPHgSIL/JOjocCBmmemB6tXR/auV/PcCPaHmlP527xRESrD8iUtD3yUg40gCa2vWNn45ZCKloHrgvIVfpQjUDLCZf04bTIb1GHBmDl9Bspn5IIpLhy9zCDJ1PDibqPyBqcf6RzCliv+2PEJnghqEqrbX9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NHEdSFd9; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NHEdSFd9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYLAtXRWOWwdyrov4oU+ijztADWowURT+YSli8hN/p2dQ6/nAhj9e1OxnwRn+DtxVKPEVVpfUYGcV/hpdA/eUf+jW8rgYCU0Ax4os1YS0qM6ka5DsSrGzYu+2Rkqfx1626kSShf/aztnToAAmfQ49ceBaFuGJsRK8GMGvEJ8EATCi6/OnblWDxGbw2f/wWDgCgzIz2Qm7hckG28xfJvOL/Vrl2k6qo1XkluIAFXuz8c4xG0NiIXqmFg9O4G3cPbOcbMP/61kJihqyMtVXitHZ4spo1gpyxTyyGI8CDVCL9Cbj+dMywgUHwZ4FbQ6pLpIyEum4wTBHMwgBmzLKLelYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNgPqmDBeMzAZxt/N4624fE1ZMVlerBvs5HHjs6qOhs=;
 b=tr/iSUZjNk3o2BMYs7Ax30gZmWKrfAWzXwneWzSaBcEp0KJY5eOcwCQ6JJG3++bIpXBtiofwSNn6J7DTnZxuy1WY/09o719BvU+IXfBmCMTI0Iq93LmRe5yS5LDAAEHjjA1kV06WR5FVJ/W2F2F80+WsIFL7rzgUbpVEc2cmds7jgtFaWC/lNGqLyUUT/Fu8nM+l+AjfkdQkTM0cw2rd5X+fQHWa3/6fwsQLgXQtXs2aIHWwtcbqPaVtvka1m2ArrEnZIXZBnL0Rk7A3LBShARMdKra2yL5nyP/Zr69hsyt3MbVxVKsRZNlBTyaIUTkPakVQAJZCRzkQJsHhloDXOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNgPqmDBeMzAZxt/N4624fE1ZMVlerBvs5HHjs6qOhs=;
 b=NHEdSFd9vFpEI3mhmaiLMRMNDi+Dp2zCH4QRITKpYILCMIAJ2gJwDGEtef977RDXrzt8LaJoe9rcH6Ac69XsnpQntA/G109Eq+it37L4Tad5V8VYB4ZvatBU9LtU6wYXJ4v+IGfJWsw0MO1BU/l2bLiI2CFggXyn4hnGNPVgpgYsqggcVmlA2PUxbLbdNp7TrZrlQJqghFkviL2JHwT/+bZOO76qfsTzf/rLsZf5jr3EJ8mGMBK1FRMxzu1VXhmQIdlqalTs95MJhcKRvbIIFO+gJ1uBRUSS49BdnHdEJQiKSrtxQdrVHhZEZwW6iOOIlvMH9GKu5yuEG+UrnN47Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9931.eurprd04.prod.outlook.com (2603:10a6:800:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 15:46:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 15:46:15 +0000
Date: Wed, 21 May 2025 11:46:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: ziniu.wang_1@nxp.com
Cc: haibo.chen@nxp.com, adrian.hunter@intel.com, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, s32@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: inherit pins_100mhz from
 pins_200mhz when unconfigured
Message-ID: <aC31QJpomsFWN++7@lizhi-Precision-Tower-5810>
References: <20250521112042.266111-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521112042.266111-1-ziniu.wang_1@nxp.com>
X-ClientProxiedBy: PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdb4787-9b7e-4559-35c1-08dd987e9edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gNYuBgPsGolYgt0h0AsVSD+AO6k/nbetKX06HMaWZnOr4CNSsGttM9ud6O/u?=
 =?us-ascii?Q?FfFO+hdcc8iZp5tec4LR8LRM47a6JwJenNWPct29d/OhO26kodSZCQfwslJu?=
 =?us-ascii?Q?2jwpjjknc6hJcjvk6x2/X5Gx/CvhQx7LdEPinL7VA7AmYEO2/8+4Zzy1A9l5?=
 =?us-ascii?Q?VELqf6FTtRE8VCSrEL9Zq88pVdteJcmBHXq4zJKR8lHzM7s0ZLYIMHct9Bwv?=
 =?us-ascii?Q?o7HOtx5TYGjwehB4PfH38K50cR32Mse6TET0n8DQTTKcwuruJvAQwfvtd4/b?=
 =?us-ascii?Q?ikqwuE3ZWLU8czKlun4fYqZoRj8F3wEdGgcqYRYcKxFJEzpikORhSsgq+nEl?=
 =?us-ascii?Q?xnlGrxRfJyb+5DmcolwfWgSWXU/UetoTSaSd/+oo0IleLcYMQTrsdd0tjhTq?=
 =?us-ascii?Q?qsGrahCR+RCvuM2qILjbEf9gUo4mdLskT9nJaGkfzOnzHt5in0h3ZBvxBaiw?=
 =?us-ascii?Q?ijAloOKjiSyjIj/jmlYKKygBjBuDOqoq5gDQu3faeI6GlbSEoncI+LQks0jk?=
 =?us-ascii?Q?uAA9QEFHHvraO0Z64xAlOqMl9koKTSNIguCh5OrtxEBlLfs/eW000l2qvKK+?=
 =?us-ascii?Q?SxsUWJB9aM+71jJ0f1l5Ii7k+X6nYLf8Dxnert1sFUn9BOSH7yeU79GHuqmH?=
 =?us-ascii?Q?dGUbEIgZYAk6sPig0VlVMzKpW2BgxqTylBiHg5y+SBDvIhrfG1JMM+0ocvL9?=
 =?us-ascii?Q?e0sF8zKczqUK7JTV7hpCz99ihXWrA7jJCTLi0LmTHvqjVidgfMoqPpUlxFDV?=
 =?us-ascii?Q?J+PMvkQPNOOlj2+sV4qdvwWiGu4WxecfUKIHCVK9zZyE42nM8tTJLzmVyVvj?=
 =?us-ascii?Q?Iw0h/Vwg6Jvg3uLo8Q6EkyI9waI+bJPgOpTPdtf1sxPukhSSWW5Wj9PUbTWf?=
 =?us-ascii?Q?26I9PYK5GW/Z9amPVsrrztccpHu3YrqIE3EK6H7Rb8VZyBCiDYE8U6lBbSbB?=
 =?us-ascii?Q?p9f3vrbbGzTPWHSQHyHBk9U2byYsCET72F/gR8EWQWB+8Is1MUbSaRg4I9tk?=
 =?us-ascii?Q?FYLyDYuUgZKapL58MRbvEEz4iotiibvf0fiWxM+3zvJ3sa6xkSVhT4mWiIgL?=
 =?us-ascii?Q?SczTw2qNt8t/B5TzhFtUshdS1oGj7Vv/thoisEKKNxG4FoXUmJZmwukqWjuw?=
 =?us-ascii?Q?KCrFSR00dAhMflP6u8ZyqF+a3IjVtOaoWzkprJTrxSS70IsrlWOev2wYG+23?=
 =?us-ascii?Q?xwWZM4suha8xw0f4eC9GfvzJn9rSladj4osKjiyfNsF4Lp/pIC1731sUCA/g?=
 =?us-ascii?Q?Mx7yl2ULTa5vJHEpfZYTUL0kU+MeijsUVQ0PfrbV0jgHgN58+2zdlkvffJKe?=
 =?us-ascii?Q?oOFuQ7P40EHiRWNzmuu79Ospg5BU+9RBsz6kvYfu5PCRUGQElx2fAlseDPwj?=
 =?us-ascii?Q?8XYhFTHf6reuGUB7jds65pWva8RWhNAOzUTaPCBve5Cpal4GTUkRdaF7kxDV?=
 =?us-ascii?Q?Frfk4z02LIQ3gakuk5P78a42Jp8J4Mp6Zgndgnue6LFlZmacI4FLIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DSHrfjX6Bcr6MxrZAXlTWR7imYihgGWiaZoitihqnGyL9FhC0oIyBWfYBt46?=
 =?us-ascii?Q?4THyr7LZU9eIweH7xwF8+B0NI88GA2+C8odGQCU8aJhk8HYUcgzyZtOtaSW1?=
 =?us-ascii?Q?PRJqAjl3jDdCtxBxlpZwK4UfzWc8IJvzGqooMHidB/FbVJ/xZlSNCkOUj9gt?=
 =?us-ascii?Q?wFwQk+GZNaABRtxeaJZRrPNYFpAIUPvx2SIoho4KDyDEXazz47IuZbYlcM47?=
 =?us-ascii?Q?ao3jNRsBVC2fHXo7NektQLAwFWwlDq3/PU4wjVucqvfnhrQlMSuJqrLSK25V?=
 =?us-ascii?Q?XTWpBdakedlh/3vE0GVIa5DU4BPpE3ymLRX9gtSJqcz/inL6bLqXBxLW+C7o?=
 =?us-ascii?Q?IANQXXpkChXvnIP1BGJTebBICaqIhV2WPvXGr093rIG7ylZ17Vil9GfpZgus?=
 =?us-ascii?Q?k+5Rb1Pd2zsb7IJH2CiLFMlBLt1cfuSdziEmq5u+cMNq2Dfp1YW6yhoXDthF?=
 =?us-ascii?Q?RBE88h5yojCxIPjKWozFChAQrB2C1u5s2D6CvNYeQhpYDf5XInerH5jFqANT?=
 =?us-ascii?Q?btLKALYHEGeZl9ygxrcT6VShi+QhVyuCE96CoFaydLzf2YDDRU2jZbA0qW/f?=
 =?us-ascii?Q?p6XE8/S4wWT6j8ywIdCc5djjnsHe/i8XLuWvMgGduGbWc3tue5UWYZVEVQEF?=
 =?us-ascii?Q?c2gtXU0Wi6vJf7o+Rzserksd1p4u+3rOmae/QvAouHWeXoGKo9eM5N3dZ+Ao?=
 =?us-ascii?Q?l3BdsbEM50Sr3o8MNZDuYYZAysxBn6iY3UtebStQ01UojkbF+CMtQfkWO/z+?=
 =?us-ascii?Q?HkXLzNjQcOnLVd5bf96BYBwPUHbpZVNzsJeZXB5n6LGpNjK4iVmQEXI6ANy+?=
 =?us-ascii?Q?BBgNRyteQifGBnTD79vcKXxqjkCKWwDennpf9NluHqH9CSDXYpnCGVCsrZvs?=
 =?us-ascii?Q?s+E5GiaAwtpEdv4TEJH8jxJ3wX5Txbcz3I3u2SC2akYUNni93r1y2Fhktwe9?=
 =?us-ascii?Q?MHRcGMH2aoSS3/rxFhLgpUalFtcrZjMi7fkWp+F2DnXgphD/35abiHVi811A?=
 =?us-ascii?Q?y/LceN0gwiz1ekD4oefvP/VY9Gz35b6dRnYZ39PAZ7kNu5yAkxagFzoJy6Hi?=
 =?us-ascii?Q?LOmCcOQhI5LWqcDVUKyh9voTVGzvRDoLsgSpEA9JXm1AWI3c0FWn4/1sOe70?=
 =?us-ascii?Q?f0HoqY9KAipzBnTtSULs2uMGedToaUGhx/ZUoqRBRIrn5WV2VLbVY1NTLTpC?=
 =?us-ascii?Q?ZHQdf7lYaAbQBOu+FVU02/knLKOz718siOGAabqd47PHt0LdV5BzJIs5PPvs?=
 =?us-ascii?Q?+1eVKu8dNC57DB+3nILI9F2jQknlTewYpIRQaxw6ICzZ3uEgzL8CFcyzQhzn?=
 =?us-ascii?Q?4eb7oR/LNOGKVs++ukOyTNf+Xx0IT+Oy/NQbMqrYt6ax/sdN+xBBPq97uzrR?=
 =?us-ascii?Q?MawSG0/OBhwdY5MiwpRao1+KV2yridMfdM9VOHUtuFxYPTT1msw2s3pzTd5s?=
 =?us-ascii?Q?1d3r0HZYVXx1kfwpRLqf3PF2I8Bv/19cf7lGL/jerMqsaR/Y1WGxsovK0xJE?=
 =?us-ascii?Q?cedOoPkbsJxv8O4bffQ9OnqICcSBQYopQOETSotnbNW/o4cox1Eb/LCEBuNl?=
 =?us-ascii?Q?/ENL+2+u097HytPUIzwXzPvhJLkFdXllmLvoq3j5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdb4787-9b7e-4559-35c1-08dd987e9edd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:46:15.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiIhBhSh5DoxvQoZIgKBTgV2XzeIdRvJz0cnjkpSW+38yBenrNHUy0MqW6k23PPsYaBHQFnmM3gmxj6K0/Vweg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9931

On Wed, May 21, 2025 at 07:20:42PM +0800, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> On some new i.MX platforms, hardware guidelines recommend using identical
> pin configurations for SDR50/DDR50 (100MHz) and SDR104/HS400 (200MHz)
> modes. But defining two identical pinctrl for 100MHz and 200MHz in dts
> creates redundancy. In this case, omit explicit 100MHz configuration,
> driver will inherit 100MHz pinctrl from 200MHz.

It is quite strange inherit low freq setting from high freq setting.

Orignal method that decide support SDR50/DDR50/SDR104/HS400 abuse the
pinctrl state usage.

Frank

>
> Preserves existing behavior if 100MHz is configured but 200MHz not (e.g,
> imx8mp-navq.dts usdhc1 supports SDR50/DDR50 but SDR104/HS400 not).
>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index f206b562a6e3..dfd8be5000c8 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1810,6 +1810,9 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  						ESDHC_PINCTRL_STATE_100MHZ);
>  		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
>  						ESDHC_PINCTRL_STATE_200MHZ);
> +
> +		if (IS_ERR_OR_NULL(imx_data->pins_100mhz))
> +			imx_data->pins_100mhz = imx_data->pins_200mhz;
>  	}
>
>  	/* call to generic mmc_of_parse to support additional capabilities */
> --
> 2.34.1
>
