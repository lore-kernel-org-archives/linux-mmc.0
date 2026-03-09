Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A62413221;
	Mon,  9 Mar 2026 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086233; cv=fail; b=f1wPrEtbk8xbgl5StVmo1niyDQXh8bOZhG3dVreHqSBt+fh1wUtHNgOs/saffUx0ZUgeLoLiQyD3M8VTkcx9HkfmH6i5kHBwIIhbogtNqvPftJzqW29YUb1eXEwcZFhraEPXGOS16kPAx7mqn6j04aTl98/QLINGwOhxVzoiuvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086233; c=relaxed/simple;
	bh=FmqkxP6mFV2I8ZzZsA9zwIuE/dELiqLT8aU7WnYY77E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A8JChqsnHzZaQb+Y922N41VPNLYCenZA9u5jICDCbrTGZ83p/WYo/YjO2J8uIV0uEbvC6ybt7LrIT7CKPQpjAeZwSHcleshtRCfYMw8YFPPpuw9FiBwQog4DSr34i6JPMNyZNMOOBNguDhUMTufxli/D+W7Q37PxBjcYyYZSFD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bspwCETX; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bspwCETX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBu59i2ojHUWGh8v6meTz3slS2GIfFTLeQ6nW8mOEVBHakYYwb42bI1x2BJ5HRlRfJRtbl7r3atX5ZW0WyYDHwWkRy3wXlhSg1lRpYyhwtJGz5YA80aGAp2smIbYrtWCWStW8Mo2xZ0mVjPUfcKJxzDNs9/yL13Hv7Q0w0gAKexMkWvoGdKXem/mw45TqGIGHgkGzBci9mKVnOA04PuUSH2t5NL+gtBjHTah/52TvlaroAIF/M0p1qil5oMoFV25ECpCFktL36xMQiX3OAAUEa7Wox10ksU4oTAi8mY+UMa0qVyx5uq6rPtFQ3bNrsGhgTwAHvYKrOoIjZhDG/9Djg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM3hDsC/HpSJnNbpk5Nv32df6R4cP/2QTwYx47DhWGY=;
 b=aop17+VOwTKe0iGCG1md/AShitsSQFMyuQSP4At5xzUJgXwKbYYRXsT9+58eZcAZK6gEO11NN4Hgqw9uYgDLEJJD7G4elBrlfT6tDeRG+RyTJ8IZD/k660h7WIRVimFQljJEWoppIN3fSNu2RNtrsOGwj8yLHlIO8N09fiIJg82kqdTvMo5dIR5ZPHVgF2SHea+cWrYsskUsVKUmrQnmfMoZUML92hXdbf/6ZD43z0Qfhri4rQr5F71wLAOSSVkJQtwk2Vj6H+eNagW7M+q7ScQEzdbFm/rZzLt76gxK6qMYgdIVveVg78svrFxl2vIRJJx76mTsver/MRILMgFHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM3hDsC/HpSJnNbpk5Nv32df6R4cP/2QTwYx47DhWGY=;
 b=bspwCETX+11L8VFEi+Vo8sDIHZ45tOS/eUBRwUaojKuqKOeYGENH1POlMsT2uu1W+VlSzlCmozgaksY+wDxjEB5kg923lI6vXq6ULFerunpVGAdNe2qodjIfFDN4+Pto0AB2w2OrhO82nNKRet6ZYMhSTaNBELQnUn4b/FtpIHvmEqSUnoyFfT2PPb6ogQrMpOiHUMzZoIdvWTMKeKtCPHAR/pz76ZFAMVNZhSYdVXGcIQ8RrVNEgp8xVq9HAEYIolZhSRd+/wNx/MVqnlKJkZkwTFGiPzOqVZQ70/EorIYZouijm2F45P4IiEoL0pvzxorQkXB2Vzl/tezS7fo9WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by AS4PR04MB9289.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:57:09 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9678.020; Mon, 9 Mar 2026
 19:57:05 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Frank Li <frank.li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH v5 5/7] irqchip/imx-irqsteer: add NXP S32N79 support
Date: Mon,  9 Mar 2026 15:56:50 -0400
Message-ID: <20260309195652.1788190-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309143411.8231-6-ciprianmarian.costea@oss.nxp.com>
References: <20260309143411.8231-6-ciprianmarian.costea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::16) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|AS4PR04MB9289:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fddb9e-eba2-4deb-d25c-08de7e1609d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	2Ep1UlH6op/LgZ2MWQKytL9V7y4q8mSaXMUwjl6oYKJAN71m7KhGhJEWRz5JXCzqaUL7DM2TGMrEkYIc3iNewWCLs7WPLuLvGigcHZZFkXCRB18ae4U9DNvTPM9CGD0s2QKiCYlWa5Jw54vdK11HYOCRX7eRUOjCx3c8loxCNDq5mnS/HVSwa2wCKpPH7rgf/5qV+cGlqhxg1XbrBIJ3O7He69lEcM41yO3D+Znj8+Lb9Ue1gmZb5QKlGdar3nkvpGOyp+Dew+B1ZhayrZJCAXPveZbtNR9QBAX8jGZMq9NwHgccGp3RnkO35HCxGdfcf3AIBtU7KTxlvAF94OoYgKZlU3V/ZDOk1hPQ+9ZgNVLaYJduV6rcy/wddQKkmLHaj3TO3PazJ50rHwnQ/oeyrcR5SRi8O5uu6/idI8K3VMic5gkdLpeb6yWl6G2C0CiQoqcumO7uzqtAw0AEzb8ZkP0Zgr2A/z90E0oPI5df2IALCVHUD+sJvY50rNsbKKdOYANy3re7quXKRtZ6eWZ11RiNYTIkZT2Fyqmz0zKhCNUo/C0cwqYcRyfboX56Bl79b6sMSKfW2uPl+RkUWcmx3ZuGY43DqlmrBQxxjaBmHxBW1GwBh6sdUzXdXVpldXr5/7JSsLz+dH4WJHga7jCoIFHOXg2Zu9Z22I0ZBjD+2kDsR8wuIbyfT2eyskzXNyCAu5HMBoZnN2myIkEu0LgvPC/mLrrLCy4O+k+nZPgMl7CFJ6RS5Zgfzczoq/3seri6HxqPeG8c45bXPV5UnhxkJRD/Ym5uHAjSWyuCoInXHwaw168uLk7ylEzhpqph2o7i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JBEYvJ+l1x01sxTggqy3DI8F03L4ERiiptb+Y8+GpEwQ4hZiah9DjNMyvWCc?=
 =?us-ascii?Q?WU5SjXcyO+d7Mk/LfeZ1VCfvokQLjtrsH/jdt3dG4YOqAuNQCKZgi3UOfXyc?=
 =?us-ascii?Q?i8IgaTdfGWiOWS4g/XmwhfQyv/mhTItBcTveg+m2N4hATjyxrA0s9m4Luquo?=
 =?us-ascii?Q?ukM+uydMF6FWzUrX5jILmhev851YF17gU5F/FzrCae2JlcVGQGAHb02m5UMM?=
 =?us-ascii?Q?1Yg24lG2ACPJeTuCJgJeoqUqvAhIye4pYlFgoa0PCcJbdROOYJw8ShIt1lc2?=
 =?us-ascii?Q?1WbraCvsXbg7vFNbbFy2+tMynk4ywMimNPY04FaB6GpymzPVdq6l+8oZcRcS?=
 =?us-ascii?Q?3puACCpktLs3ztYTKxleaR/ukWqqgMXfFeasi2uwpZkML3OiQc73PzM3dOTc?=
 =?us-ascii?Q?HlXLtLJhp6NwfiEDCQHep1DnzUAC/fcrM/gKxE1PBUwn+LAfyf+oMPN4Ne0v?=
 =?us-ascii?Q?jm3lIYjVrNOEFHbfJ3GPDnyn1mEHJDDY1gn2eZcgIYVfevvUtGpWcEmC78wW?=
 =?us-ascii?Q?IxSc1nX76GYWWhLb6iP8TnR0RS0nv5brUThoqp18c+oAy+yMFkYOnpfUuTdN?=
 =?us-ascii?Q?Wjg6JlXWYnxPBVsYKKpZAYJhkl5rl3pcAy6sYbYSaJMM3x7PjHx40iBU7p16?=
 =?us-ascii?Q?BwqQCHnNDdN7Htm+eqtar7n+d3rcDx5h5m8uwnDqhB8Q4FotKpFP3ccDpayg?=
 =?us-ascii?Q?P4ML7jgz4txm0t5vvr96HYYAozDhF30rGNVmRWPpjqYz//fNyld9KpsIYpiw?=
 =?us-ascii?Q?drY87hrEzbcR55YKPIvdnZE1mzDzjmlvLWMX8+HHfwpTRPQs15GHqDOKuEx3?=
 =?us-ascii?Q?0SHH5tCIMt4NHtyNvg053AIagbCFAtco2QqcGDb5QSfDeSoDZ/NuftRPe70M?=
 =?us-ascii?Q?TnzX9CrI4gQOVMZHCc0R9SHHOM+K00OQ5QSOvSsscJjt0QLQVJjvacBvtAkb?=
 =?us-ascii?Q?il2pQd4opN/+YOenc1dDHiELskhnLtonbriqRDse0g3441IYM3fj1zhelesO?=
 =?us-ascii?Q?3Ivy/P53miHjWw8dodReof1fm59SQjRgGqWLdosj0GB31199YKw0AoHriAUy?=
 =?us-ascii?Q?TnvwjQaSCVMHCxMKPzjRyzf6idq3VhnKug/vX8FRT0AlTa4Ip+pkvMjaKfUO?=
 =?us-ascii?Q?2lXudHD+h2fnNfYROYEOns7MZcb4JDif5R+xvapHOJJc526tKTMXQwD1DroS?=
 =?us-ascii?Q?7AjGEzLqP9/ELuLg8r0RH1ByBglqskG2HlhbqUGe6TbkICnTWgOefeMiMwNp?=
 =?us-ascii?Q?yXUyxWPbjxtHV+YN/dIQl4IF+UWbhIWkm17DMoRv6wVEYUM/gqmpmw2tgPj3?=
 =?us-ascii?Q?0vVdm1II3w+ZHmuDJE1OibPS6nVpUFIy8tVPM3t4lRptvDwJ7MVcWkviz0Ov?=
 =?us-ascii?Q?ty19z3u+0DqHc14XiQ89b1A3f6XUgHpeQEHb46e5bnc/UCu7GlBdP1SEIM7Q?=
 =?us-ascii?Q?coyk+KUcL3PMPB1J5VW/mdfFNouoDbmbF2qBAzA5sTzl7jKkhUAPlmKsmeal?=
 =?us-ascii?Q?TmxQAzbBcZZx3OW5zEmBwPC921xxJ2ENC/4RGxZ3Lcf3f7BZiRuuNiIz6dJY?=
 =?us-ascii?Q?w2o0dm7eQMDVYs97ZxhYF2Pywwk6FyoS77rbxt4DnMnlNaUarNmR5q1V61P4?=
 =?us-ascii?Q?AnwFUlNtF1lvc+kEi41FWiaCUUJdfCDWt1fGVt8jNVlSbpUZXSDan8GHcXf1?=
 =?us-ascii?Q?CtdYhDvOrZ9RmmedCU9M/woSvk7jESK1EULSlsQnrNmmAVsApm19mFVycuSs?=
 =?us-ascii?Q?yNJJpi6G8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fddb9e-eba2-4deb-d25c-08de7e1609d1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:57:05.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjmQog/QNOr8C1aSlyMA35zI9Shx9NlJx9j3nHxUL3LARFFQ+Jyo3gpHjGvYPNUAN1kFCfLtEmI0vJQRYozSkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9289

From: Frank Li (AI-BOT) <frank.li@nxp.com>

> +static const struct irqsteer_devtype_data imx_data = {
> +	.quirks = 0,
> +};

AI: Unnecessary to explicitly set `.quirks = 0` in imx_data; struct will be
zero-initialized. Remove for brevity.

Frank
