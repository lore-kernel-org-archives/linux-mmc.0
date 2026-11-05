Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793916894;
	b=y/+DLv4ZivgPB6y1Bkrjrowlr4mpILJJHOmEL1jg41KhUt3PLWgvcfWH7ASNp86Q5CLA
	 N/g3iECBmmFCcBFdWJOvg5snxWKy6tspj8fDbAsHIRgK0ZWdJ26/69XddPNd3mQWeyIFq
	 7L1xlb7hJJwuCJCkePkHNG6XM5HP3v9q2bOwnIim7eauB2wKVHpgmwWZZ4thOo56k8YyY
	 OOUkeXnG6Powa2w/cvzoglXfp38paJdowyXDc5SsLUIkEV6E0hdXHcTaSNC6b1xbmexj/
	 C9Zs1jg7iCrgIyX866dFuEGgjeqV0AxUIT7m58CULrZQDrLO88CH8NKwJgT883sfm6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916894;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HZ7juux5R8oVdanLDLkX7W4FRgv1zIz28hwQXnGuuN8=;
	b=YC9ynb1hG8sE7CbrZYEu5/RWCDqbnJmVnzo62SUX7LQ1Usw1hNHtq9+BWdnWOJnEW4hP
	 KcgnjgMheu+i3GXNJxia0eR1Orwt7x3/K934txbQm6Mj40s4gCbReRxPLKa/+FC5KkrBw
	 xMSaO1wCWnZ4QnXNCVZR/UVYvUe+gldxJvHelq+Xn88LXQpvs0kLFcEHE3TqwWI3hFSyL
	 cPqHd12J+nP/f0zqGh/gOw7K93bERkmxIfN0kr3BEjVOzJODf7n9TkT8Yd78rIEM2MTPM
	 icJR0EWY7pVP8dv8ODJBln5Jb3UApqIeRXDIWjWEPqFKx5u8O+vrqnD3RI01XY0f0TA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cvcFLIZU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.68
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011068.outbound.protection.outlook.com [40.107.130.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBBE606A328;
	Thu,  5 Nov 2026 22:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABBBE606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cvcFLIZU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvkykQjuodfw5Oe0INwHqxK1AU7VPVzd7OzmsLeq6Fel1bwz/3sAuahVBUANsjbLAkQxvukDehkFn8ryA6Or4qXpTSuTa7PHmzn0Ibeic7wkXa+R7IMauaL8CCI+kTTrnAm4hZemqE9KcVVpmddq7UspCS/0c9ta7QGuxVieE7gyfmAdJUJHzG+1IFRIZBSV2P9NSxny/dheAI+LnCNl6szk1vmwPaO2HjDTjFwrSfI8w9CsZVo6/mJICYZ7d6V+W4RiafLJ+Y4cWiCF3v/1BTu26EqZQtLbFt1VwVL/jRVJtjdoF7GhsPrcLn2WkGFzDkxmyrwVF6+jkM8TkoUaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZ7juux5R8oVdanLDLkX7W4FRgv1zIz28hwQXnGuuN8=;
 b=kXGavl2s6ep7hKj3cK8gMHqC0yRcrcHjKPILSJkoYeRBShpdH/Tk8Ac+pazyUEy3xz9+53RSRb1RBVyyec06RhpVRZn0ZTqtNNEoePnCN2AH2kMPkc8BDL8Q0vPiL20cC8M0nq/9jxK8wgrimzpciz3aqbUk7hZF5GD7/PtqofvPUNu0kBidKAIEnL5U7jaQCLlW9oYVz4UcYKjmSR/BVryHNOPm7HYgUeIunsHza0Jpp4MQqyL7z7S26qga75FmXkxkBrKXQAVYoupBsyL6PCUrA8Ngjwp3JhacATzMHWYbzryFe0JJIhkYZ+BXx9BMl3MkIZeMOBwNsEq1gpIzhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZ7juux5R8oVdanLDLkX7W4FRgv1zIz28hwQXnGuuN8=;
 b=cvcFLIZU4irypPrrTNNN9Z/0PHS7Reo4+keYQEPgjMXbbPoa8fd+SZjfhHp/nskhloJVa/oSzVn0ypXBixpPYPzXQmuJKBsOu+QboHXDuM321NhwPqGbZLuJGkCMFPTlKqw0FafEHQAb94JiJ172oMXfBp9aSbZf6SlRr/jL6RxJ0ATQlDi5DpdteIzjeNVv6exdqCWB/PdYry9NaF8YyBbendFIqLIviSB7Hjpwlh/RNFJXYuNLqX/j2FWMpSK+C9bnABRT0HJvEAUF6YvCVZzKZYxxyXXJsavQFYp/+/73quTkxx1FjWdWAfTghhkLrEVdi8vzTDgRnNwvYdGQrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB8541.eurprd04.prod.outlook.com (2603:10a6:102:214::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 22:14:49 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 22:14:48 +0000
Date: Thu, 5 Nov 2026 16:14:30 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Paul Cercueil <paul@crapouillou.net>,
	Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Linus Walleij <linusw@kernel.org>, Fan Wu <fanwu01@zju.edu.cn>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>, Rosen Penev <rosenp@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Rakuram Eswaran <rakuram.e96@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INGENIC JZ47xx SoCs" <linux-mips@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..." <imx@lists.linux.dev>,
	"open list:OMAP MMC SUPPORT" <linux-omap@vger.kernel.org>,
	"moderated list:ARM/ACTIONS SEMI ARCHITECTURE" <linux-actions@lists.infradead.org>,
	"open list:TMIO/SDHI MMC DRIVER" <linux-renesas-soc@vger.kernel.org>,
	"open list:ARM/ARTPEC MACHINE SUPPORT" <linux-arm-kernel@axis.com>
Subject: Re: [PATCH v5 1/1] mmc: use dmaengine_get_dma_device() instead of
 chan->device->dev
Message-ID: <auz_xmiFxljxiAS2@SMW015318>
References: <20260930182826.766224-1-Frank.Li@oss.nxp.com>
 <CAPx+jO--zsr3TY7W-o5Jk=L5caDh_HYXi-VZTmCj46ixcE5ioQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO--zsr3TY7W-o5Jk=L5caDh_HYXi-VZTmCj46ixcE5ioQ@mail.gmail.com>
X-ClientProxiedBy: PH8PR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::13) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc6da82-fd2c-4b64-13ae-08df3b8a347e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|19092799006|261022105027099003|11063799006|56012099006|4143699003|261028144727099003|261009223027099003|261026121527099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b4T/ycm0t6dw2lC7eZfGtckKd8GJPh19g45wyZX3RohcL5rvLbKVMwxWu9xj7qGS3ERw3t/nT5fw7tbZnY5hkN5whZWhkK8sWLhPoIaq9nc0R4tXiXqIPw6BXnofxAimpb2Farhc/L3KWGIL3B6Y77s/RgMwJvl/v00wEIwrsRDXPSnQ8/wmUNv+mqvDPm1Xn8gdKNzO5/c19d7zg+TDMEDqMV9TAgmIGtWPvAt4bzSMNH2iS0FCJwAPD9nOLxqjxw3e3yOOXwPOnb9T7kczp7R4GU3nomNNKTn4O4HLh5ZgHEtzVAeXmFatzD6VVPGoov96xCGK8keln71InwapRBEwr4Nt/NqVEHJlzJgI5DipRMYV3mE7uHxt+fmvV9W7bodFcmPn/1qvXKCK3DKIWgRpiCZU+qUcrcwOybFY1Vi+sQCmoEbX3NTAyPObWvt6xcw+260pjPp0v7aEQzCiK8SU9GySYnY+wVsG97Kowpq6FyOK8yWlDTxUlvalB/tRGT5JsVJ8RjSQHXRA2dOBgoG0Ngf22VWBOR3R+BVudzFX6ZI+mEeJd1KmA5NO95dRRXQf6B2PNVejpTJIXhgFux1716CPMufPM1jWNkgujPJ/cxLkmwyMJCkPy1IYRBS7wpElyNCqeiL5XMnnyZSx8ugVs4DJadvDAB5KfgTNmGk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(19092799006)(261022105027099003)(11063799006)(56012099006)(4143699003)(261028144727099003)(261009223027099003)(261026121527099003)(261026140227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFo5T3JhS1Y2SmRKTzMvNllMVFh1aEloeWc0QlRGWlBicU9GTDVDSHFmS3pS?=
 =?utf-8?B?ODh0Ry9KL2xkaDllQVh1djhJcG1GbDZ0ZTMrU3Z2S1hDWHo2SUtpcXFoZHRG?=
 =?utf-8?B?UWprWE00REx3THpuMElPRmZ6blNnTVY5U1k2dnAycm9acmJOQSsrUUtZMVBV?=
 =?utf-8?B?ZFU5WUFOTkJ4RVRMOGZuRW5ncDhDS2JESWR6eWRONGJqWXZuaElpdDY1WExw?=
 =?utf-8?B?TmRBcHAzSFVvc0E4UzIyeDRmeG4vM3VDMzNiR3Y0b29oeDcwNmNhQlRZcWcz?=
 =?utf-8?B?ajkrYTlBdFRjaXh5SGVHSVVORDNzK2FZTm1xZjIvOGhuRHdQTkdieU54WVBO?=
 =?utf-8?B?WmpsempJbzhtNk82QmRFL3RBS0ZPQVJFY1g5Yk1wRHNLdjBQNE82Wndwdi9Z?=
 =?utf-8?B?cEtsdlNycDBhcnluclVYZm5oNER3c08rUmR1OVlwV1ZRVnkwK1VQL29DcDJV?=
 =?utf-8?B?QVg5bFBvN0JSL01ZWnErSFM1MG8zM2tNWUMwbXBBaXhrVmtIdG1KM2l4akZz?=
 =?utf-8?B?dWh2UHlUWlI4RHVmWkYrSWtlMWhmYjFlUnp0MjF5ZFpraVI2K3l0VWtuMUdM?=
 =?utf-8?B?b1RHQk5ZN0wyeVNRNURrUEhVdHVnREc0WWR0cnoxeEJmVFkvT290NDNObkFD?=
 =?utf-8?B?OHNlNmo1eXY0Ti81ZFdBMjZtQU9HT0pDekM0NGpHcnJqdkhKODA1YmJhMHNr?=
 =?utf-8?B?Ri9UVHdncnBCR09hTzIxUFVXalZwNHpzYms4bkZNUWVhVEhNOGJ2M0hVbUJv?=
 =?utf-8?B?MTFuRGMwUDZHQjBXUjN4QmdRUUdlZTNHQlZGcWtnRGR6NjBNVzdzQ3paYXVz?=
 =?utf-8?B?ajJZYlJ1Rkw5SDZQbTFvUjRhaWJNMXRMUHVZUDJCZXE4VFBiSTdRY0M2d2Ix?=
 =?utf-8?B?b0F2QjVPSEhUeFM5Q2hLLzkwYTlOeUNvZ0QyOE9tNndQSGtsSlppME04dFV3?=
 =?utf-8?B?QVVNd2hBWUMrYndqTWJaeFhOQmdyRjlsOGZ5dmoyZkVtRWh1ZTlwallHcUYy?=
 =?utf-8?B?TlhjZy9ORWNZVUtqRXE1TGoxVkZkRzZwUVcvVnJ3ZDdOdWxDd1NTUE1rOGRl?=
 =?utf-8?B?KzcrMDRvRyt2QUgzOFpqU2JMQlZoMFlVbEQyNFF5aGFncWQ3L2txWDZjU1BI?=
 =?utf-8?B?cGdBUEg5TWtRazE2VTdzMHNONGFQYktkM1p3d3U5aGhBS3Z6dUtrYWxZUitH?=
 =?utf-8?B?NW1iaVRPWkwrbjZ2R2NNUnNTbXFrcGtBM2FNYXZJM0NvQkdCdU1reGJDWlVk?=
 =?utf-8?B?YlR5cXV2emlSTjhkRHpEWXF4dGhCQXNHU2YzZFpqMDhLTGIzNitza0tiSUw2?=
 =?utf-8?B?Q2NhN0I3SzM2TXVOWTUxQ1pYUlRjbEEvamJUNE9oTzR1ajhiZHZDSlFTeWhw?=
 =?utf-8?B?czdpR3gySDgyTTJOWXNOR2VTWGllQUIyS2s0NDRMUlpZbWY2RWxIMzZNTEN5?=
 =?utf-8?B?bWl3WWcvaWkrZW54UFdpMWVqcklmbXNtUktVd3cvVTNQZEVpampTWjVweXpF?=
 =?utf-8?B?ZmJkdjNPRS9UTnVHOUNibEhQLzZlcE1ic1hjQVplVS9zdUFHb0Y1bzdlcW02?=
 =?utf-8?B?Wnp4dnd4SXJBcHV0ZnlMbmV0OEN6VG91SmpNcU5vRktaUGpRQ1gyUnJaYjZI?=
 =?utf-8?B?VXV6SkgzcGRNQ3N6YXkrOHE5dGVCL3FjQXZKeGthTjRKZmxseE5Rcm5lcXpk?=
 =?utf-8?B?RDBkV3lJd0FPK3g2bThTRXZ1TTJrczY4OXduWmtVeFlGQTRWakNRNXFuN1gw?=
 =?utf-8?B?eDdjNUhLL1NHVEhrWjBieTFBb1krekFrWmxZWmhjNURnWDBoa2tPdFh1aW8y?=
 =?utf-8?B?UXozNHlFZGpmd1E2dEhrOW9RK3VnU041RHBEQ1Z6TklhTXhNSHg0MGxhemFR?=
 =?utf-8?B?MzVkVTQyQ0FLbmxBTEFyMm1zMzlqcDA2akd4bU9lcGJHZFl3Y1hKMUlHNTBG?=
 =?utf-8?B?NUUyWURhbDJwVDNwUWhQYktMdUFvVHZMMkFIOVQyUWM2bDI5WFZudWoybWZn?=
 =?utf-8?B?MUc2MGNrSnAvYm1uV2ZzeU1qN2xRcG4vMW9Qdk15WUxFZUVNKy8wcmluQ3Y1?=
 =?utf-8?B?bEcvWEFNNkptTlVxb0lSWkhVM0JJdFVwcWxhNUJHMVQ5TXBLb0pNK3FnY2FF?=
 =?utf-8?B?am5YbXFvSVNVNm5uTXVSaXp1MnFRNWRyY0UxQVA2QlQ3SnFQd1U3eFdWb0xE?=
 =?utf-8?B?M1piYXBrUEN6SzlZRU9TWkQxNzZORWl2KzQ1MTdvTW03ZDlDZ3Q0SDZqaVZ5?=
 =?utf-8?B?VGN4K0swM3QrT3M4Q2QyRVZlalZhZnA4YU1yNVdFVU9sdlVkQUpWVGpVMGJy?=
 =?utf-8?B?MWhsS3ltSVIyY3oraEpQSmtzeVZRbmNJVmhJRW50Sys4V2hpLzd2OStnZWxa?=
 =?utf-8?Q?f1gV1xQfzFRfph5E44YHyHY1UzAvnLWJiKyXC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc6da82-fd2c-4b64-13ae-08df3b8a347e
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 22:14:48.4294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lG6UBy6UijyYYyTlYUstI7+Wn32F0fNnLHfPJPMY55tKJrer34E43+3pCRKoijBv2riqtuAjnAsBjhklWOz8oXX02bjaLnMEk49+QK6C4bEPI2l1zVuAKxoHdv6LiMTJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8541

On Wed, Oct 28, 2026 at 06:15:02PM +0100, Ulf Hansson wrote:
> On Wed, Sep 30, 2026 at 8:28 PM <Frank.Li@oss.nxp.com> wrote:
> >
> > From: Frank Li <Frank.Li@nxp.com>
> >
> > Replace direct dma_chan::device::dev access with the proper
> > dmaengine_get_dma_device() for consumer API
> >
> > chan->device->dev is not always the device used for DMA mapping.
> > Some DMA engines support per-channel IOMMU mappings, so different
> > channels may use different DMA devices.  dmaengine_get_dma_device()
> > returns the correct device for each channel.
> >
> > This also prepares for making the DMA engine provider data structures
> > private. DMA consumers should not access DMA engine internals directly.
> >
> > mxs-mmc.c wrong use mmc host device when do DMA map. Fix it by use
> > dmaengine_get_dma_device().
> >
> > Assisted-by: LLM
> > Reviewed-by: Linus Walleij <linusw@kernel.org>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> Applied for next, thanks!

I have not seen at linux-next. Anything wrong?

>
> Kind regards
> Uffe
