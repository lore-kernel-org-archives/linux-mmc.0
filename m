Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793637659;
	b=DS5Utq0TSuufPe+4lTopwgb/OZkNWmvY1Ug9MdvoNNXL44NXcQpgGmbn6Oo6kfSqjNwp
	 LP98rrjX/40Y9OZnuKdFwP7iLn5hOkhgtsmVpjWltkyH/QDLmj6v6DmytKMqYWPnuV5Q9
	 3/ogYToKnWt4dxEDMXIVPfCUOR50SydX71NZkKYwGBxMWMkQ/zIDX/fgvYXT5yyuqBzZ2
	 CJdiy3lG7MGlp82QR4NA1pxKr1KHu+ZuIdOIuNKRSEMOLJf1xH2jOckKxwbzAosx7PKj1
	 79f0CYtmSSTeUVV74rXL9RmwYvUHR6H2GhYLmnd2cZ/OFMu9dGuUmWCVEgv5YLeRkYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637659;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0AZEXm4C/DMSzFUg9+vViNaMwpucOgErMY5P1OzWIXE=;
	b=NAgULYuXvkrjfNgf1QSCvKEdEeyLLJTd9yDZsZX2k4C3hDJVAGyiIzrHCETOHhwfx9Dt
	 ZRvFa2gDEexBU1CLTpN1qisCboUA3IGYLmlxVjtvde1V43iF3ZPLnOTgiPClRdjfUP+YJ
	 /nQvq0/xWleW4Webo0h4bUrKh/XLZFqwvEq2kfP7O23pqnqqXPKFQ7FlJv3sI0MLcYwkJ
	 9Gs2oLeaOnn21zd9NCHa3i5BlsR5XUtSiaq1e5JnfsYl8wVcaYf5WJZhXEoogzcxzIL0z
	 Zp4PZ4DtSQ7r/S6z8Pt9xaBWEdMDlk04/x3pTQnhFhaR6+r9OXKW3hPyohG3HpnkpLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=V3ykH38V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.31
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2C608762C;
	Mon,  2 Nov 2026 16:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74C2C608762C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=V3ykH38V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUahqT6OH80SrFgl+J8Dl0qQuEn9rpBY/sf6cMIiybmTtPW/B0oQ8mpWx/3hFmjH5kM3BorOwqSSuQeNYkik1ZDQNpQmWvoYIoWtmK0U8pLVqhvucBo9oVRJhSztrB3rpJKKQWoAQF5Cq6L7jyeurjP6RzoQ+Ua3B6z+fM+m+D7m3Dpyhq1C+qbH5bgzIVqRrLMt7U6KX2atZK38B0xIK7Kl306xFeFPSkelpw5FBHPrpDaTcV4B6s2TQxkI3kh6pCGMT37TbGrJVTbyLmeLGwS0Cxuo5GIVoM1ZiNl36tC35ESLTD9fRUaa767TI2vjZjQcUlmQf3BBeUbqmZHqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AZEXm4C/DMSzFUg9+vViNaMwpucOgErMY5P1OzWIXE=;
 b=PrK0rnU2MQXRwPgJUUNGCRXQUyJZbjYp9VdLV86LlUg7HKLRtSypXjYL8GjRJ1PTh5HvCp1FDYBwAk67NfLbsc2171siuwW6Vukja1xYMHayoW8Rm6EEY3epYw21AX2UozOsMkJEK/GElQXfRg1PRaV5WAHK9VAWGaoC39ugw16XpPrgRc/nz+4bz9ElG4nFtSMUp7VpLaiZgclBf9KHaOcwyfVtgYZDoo47EsFn0wFBVuUTQQqfsifVyL/kX2ZP8ZglrxrF2KZb8vyto1FBtHBDQspIF2BWUkS8tsUD09nZwBQENMSDtX0c6CMzabo30vOQgUDq3leqETIR6QSdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AZEXm4C/DMSzFUg9+vViNaMwpucOgErMY5P1OzWIXE=;
 b=V3ykH38VVd8brV2cpxqM1yZIcyzF4+A+yXTcS+Y08BhlXL8iCqyoF1CGucLJ0jjpUzZB9MY787jCeghPRfcXGTdFd7dRAf8GpjP/X3qHOnbZpuikYmwa8IjPyjldv0Be1F47Qdm1F3Xzh/WHSzmxyoJlLLsiop21RzwzwdEyGO2cDNUwc77Yo+11q3D2+sNSwXOHSMSUN4VUjtcC7GV5ZUJ62QAgBRlsm93KXdBfz6CvMAeL/O7l6Rbid5eO8/WdsUa1jgoo1N8pSOTL03memeUBbtREi+uXasKnsrrWGNW/yGKlO4tGvKf64bgR8rKwct+1FAjeKF65dE/dDW/6IA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AMBPR04MB468013.eurprd04.prod.outlook.com (2603:10a6:20b:7dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:40:54 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 16:40:54 +0000
Date: Mon, 2 Nov 2026 10:40:32 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Chanh Nguyen <chanh@os.amperecomputing.com>,
	Alistair Francis <alistair@alistair23.me>,
	Julius Werner <jwerner@chromium.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Dmitry Osipenko <digetx@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-gpio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sound@vger.kernel.org, linux-input@vger.kernel.org,
	linux-tegra@vger.kernel.org, mfd@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
Message-ID: <aui9AFUS3JpDKZGP@SMW015318>
References: <20261102135330.2493332-1-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>
X-ClientProxiedBy: DM6PR08CA0037.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AMBPR04MB468013:EE_
X-MS-Office365-Filtering-Correlation-Id: 710964e4-aa24-4f3f-656a-08df39000ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|11063799006|56012099006|261009223027099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	713wdXmk0i3UHxEIluM11rOJcS4OyrF7QOCTSCmsWR3F+SjkAdWZMFG3VRd0RCZKsqzpwX79lW1ZURuA3XEG7NIHBOZkV4JnrBWaysJUjfdr0OUhol0yuECzmr5wd3Nm/UzUM5EwqVAR+QYj4W+SmtI761IP9KN6lWHWjbg/n6SjJOTOZ6msklaDfkH5hHnQP5StAKVHT9W9gsJqjzuHxfg+rf0Iy0mWgbFk/+2WbI9v3juaCvw7xc4DzCXO8QDOsKOf0JTc/cU+xocxpGBsM3RFG3QMuHAC7orJV2D4pCTGg+taaQlyWzi0XNsiASg4QbYrJjzl7BXz43cgvH2MI86i/EDbP3gel5zoG6yTkwuvQvt57UY/UKg10W3NY2jmRzvt3Yj4M0JT5rf+2tRzdGe4URWejHSMwBbt4nx1cepRuoiWpUjX9gRbpsw/QEpefuZoAaSV/BzdgQH0DnOqHyFkedCnbiZg2+NPQilXv15wWhHxWqVJo3gJyR3aPKC6jr75/ssgaUgLkJHrhSeVflsAaQPz210v76AxAOM8DUIj6uv3N/6DLX4v+06x+XEACqAiCrg7bAtQkMqY7vhViG9Xsn+83/QhcG5Aa+mQ0s+Ug8NVT1qTZHFSqjoL2yS2Oej19qpGLZNAe/mS3BTFlfVA9NqYnddes7uOh97mW6M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?miViUnAHLHlSfVvNykj6itq4LYyZuvFGajuF5/WfPyzRO2cwd46TenQEyCr6?=
 =?us-ascii?Q?Bk4r20OdtHVg4+E7+ONinqI5X1cdimy1a4RAJrw7ype9obM1asQI7C6wVGex?=
 =?us-ascii?Q?Df1a+opO+isY+bZYbPK+5uq9C0EPVS8XTio1wzxbktQqXm4DPSyMNlHwhDK2?=
 =?us-ascii?Q?aYIg/lsjPz5d0+J5Aq1tyf3Ql4rkk1IC/h2HDxCOqOnAv34JyclhCPcgiNbR?=
 =?us-ascii?Q?alQr1FUqDeJ0JZBNQQCyAFKUUPhc+Sp10sDhkY8MhLqeqclUPZaiGWh1G25u?=
 =?us-ascii?Q?/tnG5n8jk6GeM6ikrfrLEzOq4eFDktSaxonpzwhdZHHO/RpL/moKzOktaioj?=
 =?us-ascii?Q?bwvNWJ8kslkjWCVbXk34R+W9nFzirZrw1OgNcjeXw6WWP8nN+wVCTC3SwFsK?=
 =?us-ascii?Q?lqlMYYK4UUkLl8I10PH5DXJ/+b5zKdD0WRQpHrQKj6dTkT8I6lHNtIMs1aR9?=
 =?us-ascii?Q?SZm+gZOod+VCue2X7ykMd3vGD0ODjAUWC/H4hZN6dqtP2BWtPIKP/qldFX/W?=
 =?us-ascii?Q?gfMpxNPGxoRgkEWOHNIgcYZVOCpdSqID+31il65/Bcybng6IbJMsM7dBiKpA?=
 =?us-ascii?Q?Rtb38dq4PZU0FUeVKK3Vz/z080KxNNnFskrpNkpQcRbpWFcdMmkrQzJ8ZKrO?=
 =?us-ascii?Q?nYPU7BFNOrqUb27tqERv6Xs756Uy5lA2ZlkbXpLXAGPBvQ5YvhF0q8EWINPM?=
 =?us-ascii?Q?INXukbJB3rJzOSDgtYaLwDvjYt5jxBHIztmfDtfTLP3RhFrBGRl54GzrtQGD?=
 =?us-ascii?Q?GBMtwe77nUkzYN+Frpk8YjRQI1D49KpKlCz4km3foInJ5woh43Q+nnOamqVw?=
 =?us-ascii?Q?iNg3mJYCUzNLErYW3KrJK2Vug/N2aO9qtVWorfrspwxETpQFe1uyAf4sYncg?=
 =?us-ascii?Q?p54Wa7UuTfCtdCdZqoeDgk5IC4np4oFKL8L8k1pOzzDWS39CARqFI/8vJCGh?=
 =?us-ascii?Q?yRx+sBbeP7pH94bqiOUnrNIWxqQsh+JOvf8w1amHOYmYW0MaVFl9xivXCvtA?=
 =?us-ascii?Q?1StguKNayIluWpa5ZP98xmjQ4TZYHWjqktNNmQ0s7Dd3+uEy4AlkKZlrv+Gt?=
 =?us-ascii?Q?AwVCvMGHPG8LC+HfNdzDm3O+kPFZ/lbwg53ZLBWNbbL6+4YQh+L+1f5/m4n5?=
 =?us-ascii?Q?ZrHWXUBCzlhJzIvkFu0LkcXOx1IimA8eG0Fn/GFwOn+BnWHLonse0k38EsnB?=
 =?us-ascii?Q?SOryFVi1m+3pEWpDYg/CHmkfIfeV2XgQo5bMrQ1ljgiteO6/cR19/BGEUTRM?=
 =?us-ascii?Q?XGV7505tjTA8t+KETQsjdbh2WWr/hgWIjAcCWjK676y/o1Mz4sE5PSWmvqH3?=
 =?us-ascii?Q?w4zOWqbwBy594KUxDz8BjNgoHIW7eKWwhnBdt0hnYOmS3VuWwL5RNS0tfy4H?=
 =?us-ascii?Q?XswApNiAAjdTiaqz1dpu1PkoXwpLAZb4YTswjQ8O1inKWhW+uKlLqUO41O2H?=
 =?us-ascii?Q?p/DbllPNiHLg0WzdGQ8giUOBU84ga1119QfWGX2j5MPov+ToQ3aOZyZxaRMi?=
 =?us-ascii?Q?504bKjsTVvHpfPvhqOzUD8vWeqWfeI8vz4dFKOQ9v6/wLnWNUmgeNURUYGKC?=
 =?us-ascii?Q?Z2wQBjPnoF3Qd7xhB9WAv2uFCSKazrD7kudcoq5yLrZHn2uTlzt2nuOrXCMj?=
 =?us-ascii?Q?4ee5Q5NyAp8kxg9QZM+Vxjq+p7qNrg63cwOBY0tQh7FZTQRLWmbXYnHJCFGa?=
 =?us-ascii?Q?jtDpxtDJFM/z8+TqgBrLmYj15xcMy4P1rhaPvLbngkWw24YHQmK7COJY2OfR?=
 =?us-ascii?Q?YrfL1GNcONRkuUNhApZMdmxAbyCn3FxiBAYU608PkRryqUCh0Wgd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710964e4-aa24-4f3f-656a-08df39000ff5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:40:54.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fnO+R+KwExK8plb8UKHkb7CwqdyiR8BlWlu9O+f9zFhqX8xE8pSb4waLCfO7C9oxjAZQ1G2O3uYmut5fG5dOLhTOrhSgilIYT7HZsW1Lg8Yl0rUHI5yaM00tF9J8zP6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB468013

On Mon, Nov 02, 2026 at 07:53:22AM -0600, Rob Herring (Arm) wrote:
> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/display/xylon,logicvc-display.yaml      |  2 +-
>  .../devicetree/bindings/dpll/dpll-device.yaml        |  2 +-
>  .../bindings/embedded-controller/google,cros-ec.yaml |  4 ++--
>  .../intel,ixp4xx-network-processing-engine.yaml      |  2 +-
>  Documentation/devicetree/bindings/gpio/gpio-mxs.yaml |  4 ++--

for gpio-mxs.xml

Acked-by: Frank Li <Frank.Li@nxp.com>

