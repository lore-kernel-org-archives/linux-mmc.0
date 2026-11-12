Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794473670;
	b=WDPrZcg9/fd5arfhLXbCkxF28hS5Og7sfXXHiQr+8Z4qQc5qBS/5i8Tzb6QL08hfDYeX
	 vOxgKMTvOzPuHAyGiqKV5kTQIh0TSYT6T6X6ypJD6l9MNUQ9V9mAAmwEHew2tWmoVsGsP
	 FqjjJu6Gj0VwwXhuAQDPVcn+/GWq7+oc8OiNPkBgxEHLT5MzLo/5IvwoCem70uryT6PKx
	 SZvAIMeAALfOtug30Ks9bDQ86iw3d6lMcKObX/yWmQyXg+BJdb87A5fSqwreAjf9j2/cz
	 q2sYczPwevEEo4ZTynZ8dJkMRI5axM1ZFkm4MYL0Y5O6GHGDH1T2IKL58bCXPvQxzfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473670;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3hSdrree7mkalBMSQXh5OGUB6ltIwr1aZ72PHT628eI=;
	b=K/DfzXVyj8/kP009te0KTGrzGajjfyc9brbsQRCUZZorJ0wZ86H3DIE3nvWFcgd8fOec
	 c8iZ9WJFwDvsuh1g+7wSX519P+qHqCiZLLWrM88waRRBaF1cTFnkON3hl3Z2EEZ8W6t9i
	 cxmvkju9SSsfckgeHVDOjwOncjHTtcyJcdb37ky9BuEOT9uYNBy3qg4AeX7q1FZPyNfKZ
	 4d5FunkDeopEQNu+1ROStKuFNT3FwJZVyYFIEo5LMcfHp9Wg0ePdYyhDStKapiMxGWYjq
	 taGEJJvxGzAJaBwBH2PUnpal+bH/snd3QSFfJ3JJw3677dFjewxRnOPi7L8DQccJFlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b="a/xjiQMj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.18
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F88606A323;
	Thu, 12 Nov 2026 08:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1F88606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=a/xjiQMj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKEBIVC8vg5v5KclcvbFRvz2/JBW8MNzvvgBGNnbISAe2btp1ohRPNLGyWo+7Y3IhYROcyJX3pyvxeptAA54Ng+Xy5wxmE6fgQA6McTE6/DS3nqIgEOcqWABfOzWJVnERgIrMTExCOwjnu98K40Z5J2pRbzYiTURlFvKnpRYL4TSQV3B4d5Gs86+7TtNy+MdAbcBy9ACeLXItC0MGMPaKE7C3NcTTzEdEI/BLUnv2UaDWyA3TdeOCnf1fKTPi3ta1yvkcDJUydCIH+ZWmTB7zYpS/INcEeue2xzf/W+RyY6PB0NTuMA1zj3pbHlSX9WwGb+gjiuLAWIIUeECj2rtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hSdrree7mkalBMSQXh5OGUB6ltIwr1aZ72PHT628eI=;
 b=YNSE5jA0VtchYQYBS4fKXYacu2PENt7zJSdzjEQmAsg0KNLCL9GjEH4D/Qex4pJvi0Zfl4qi5jpq34Xi5KtjXJ8VQRC10rwyZtZmv9sDbNrqeYC+CW5TbDsQhTCom/lSZlwzbBUPhjaz/WlLMM02yWN5LTJbEqn9YgMT3BD9Ptb1wyEa8QmLVTVBpgwOnzAqCsJ1qRmZrHYtC+VjxIAo2LBSXxJZUveb1RWTmaC+AdHxUxnDfgKipE9tjLfR9M3njvtIiCL1MySciYQ5Zlx8R1HM05I/ABwkEsbyT92FwDsFv3xySPan3u05AiqirhvirHo9QEcZDoS/ERLOK441CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hSdrree7mkalBMSQXh5OGUB6ltIwr1aZ72PHT628eI=;
 b=a/xjiQMjju6DLxOMjkYDilsA2AwGQ/+N3s/Z2oZM+XWS59CXfPlR2ssUlBFvLfH6L+bW8epbeOm9YCf3wiPQNnRsfmXrKIueZeMlbhqCzScRxKyQynCyxKciQxcBoCm+wowD6N2xtlWv39bOt2u6YJeb+F0TZy5VqgSTvClrR13Paex3MYoBSyrEY14wLozv/WOSd3PvCxyK1qPyEX9QvChpdMZF3qIJ8ZHxeF9xbEby/8DUnsSgmoKdnlmWMSQODRm4kNTWY3kfR/H5ac7KDs8TaC8Kt3lE1cF7yWKhmjGL9e6QpVs6MEHO+D3UeVaDI3ScmnEISl1g9Q8no7j06g==
Received: from DU7P251CA0014.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::17)
 by AS2PR10MB7603.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:546::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 08:54:22 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:551:cafe::83) by DU7P251CA0014.outlook.office365.com
 (2603:10a6:10:551::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 12 Nov 2026 08:54:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 08:54:22 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 09:54:55 +0100
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 12 Nov
 2026 09:54:09 +0100
Message-ID: <9dd9b3fe-11b3-4a40-8681-8bbc0f35bd30@foss.st.com>
Date: Thu, 12 Nov 2026 09:54:08 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Ivan Vecera
	<ivecera@redhat.com>, Benson Leung <bleung@chromium.org>, Guenter Roeck
	<groeck@chromium.org>, Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
	<brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>, Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Lee Jones <lee@kernel.org>, Srinivas Kandagatla
	<srini@kernel.org>, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Ulf Hansson
	<ulfh@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Ray Jui
	<rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "Broadcom
 internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu
	<mhiramat@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, "Orson Zhai" <orsonzhai@gmail.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Paul
 Kocialkowski <paul.kocialkowski@bootlin.com>, Shawn Guo
	<shawnguo@kernel.org>, "Chanh Nguyen" <chanh@os.amperecomputing.com>,
	Alistair Francis <alistair@alistair23.me>, Julius Werner
	<jwerner@chromium.org>, Paul Cercueil <paul@crapouillou.net>, Dmitry Osipenko
	<digetx@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Thierry Reding
	<thierry.reding@gmail.com>, Ray Jui <ray.jui@broadcom.com>, Scott Branden
	<scott.branden@broadcom.com>, "Krzysztof Kozlowski" <krzk@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<chrome-platform@lists.linux.dev>, <linux-gpio@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-hwmon@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-sound@vger.kernel.org>,
	<linux-input@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<mfd@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-pm@vger.kernel.org>
References: <20261102135330.2493332-1-robh@kernel.org>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|AS2PR10MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 42aedc12-75f3-44a9-0348-08df409a8bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|7416014|22082099003|18002099003|10067099003|56012099006|261009223027099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	E3Hn9+91PYLiCPy6iewOxcJGn0xmrf27E7xqACr0TwJZxexYfCYXZP3zeajQW/D7mm2lK63uLtbDAcn6E6jAydIN02RKTt85fs/gR3+yDDQo0Qequ7NDRM1sA+w5f8yzjNCrE7StrwU8cya3uwjzZqDVA5d/n27eG6IQFj01/DJNs/xfbR0xibmQjPjRAwu7NESA8qzz12uNdLWtof+zOkPN/Y6dLZCBSj46hqLktwXfGndpL1UKMkOtjOrwMgST/Zicoonkg++KJk5jqUuHnNOU66S3HFJjqlEY8znI7RXoEDpRKM+0lRXiX7JYj4Ii+ea09kh0Axb8GRpMMztQ3JlUYhafHoDaQC5GH/0mBQmZeZzCV4zW+LtHTMrB68j+FRebzN1i3xmEkOwlI1ghoRoTYp6qQHovWBs/yOLRI6wdr9hehceG9YWDiAuErXjcZSi/ZT04fciHqigmdnZIGAoXxXoRrfMbRax1hyeCUFL+Yx7k2Z62tEfF69h94bbjm/q9FmDq2VxOFOBAhI5D0iTC++kbAiTgMcVsjO9nRkqiWxz9g8amPxlo3UMtJtrtaEyFLOJhtEVs+IBxj6U4mEntk8vHl86A99Wp/jcoZLSnUmGr2DskMKXCXNSskYqMu0GplufZsBK+8OmaiZmHR6YlmodqIZCooyXyp26XdWrK/AslAkfqm7+2gSKt19/4
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(7416014)(22082099003)(18002099003)(10067099003)(56012099006)(261009223027099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1CfsLkQBhd/S+iSj0Mgc8J74IQv8uaa5snYPLkuAdma36tpat9k8Ec+j22MYZ3RIiTRvPozFbu0Url9kjQgaBy0ay4my7NTuigYGL5wuSfa7gi/iES6M6IKUwynUr+NYB66tjwvLjF3BBmeSLqRV+G5Z44Te8ZkBYfq/NUqW/b5NMq+q+Ec1Bjzjv+gaWu9yuPqAOTgy79AseiiQnBPj6uRruofVy8OjDGwOV0w5aBw8s5r2ouFOKiUSjcppKrpZHDca9x21R308QwYQWwjCnT6GYvURGZ4XjvDgjEDzT91NgiJ82G6PqSZBM78KwheSKmYuVZkawsi0rkhJi8CGDtV0T66/6QHmh0SE9TJVbDiIbg1n7AevAC1GoxYPrlhBR4KKWHy5aNF+yELl1XktrvtD+w8D0YhVg+h4MUGp07fFRqfo7eOFqvDTgdii6Vgg
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:54:22.3476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42aedc12-75f3-44a9-0348-08df409a8bc9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7603

On 11/2/26 14:53, Rob Herring (Arm) wrote:
> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

[snip]

>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml    |  2 +-
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml         |  6 +++---

[snip]

>  .../devicetree/bindings/mfd/st,stm32-lptimer.yaml    |  2 +-
>  .../devicetree/bindings/mfd/st,stm32-timers.yaml     |  2 +-
Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com> # stm32
