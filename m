Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A103115BD;
	Wed, 25 Feb 2026 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009481; cv=fail; b=HVkXJCQg9Lsfku5eNc+IqAr2nBolNdxPj1q1X7X2aPrP9CJZGUwPZsPm+P95E+3f37dePDMQkqEkvgr3W1ZwPA42ijde+dotFBL2U8HD/5vOAA97b0dJRiTofEJN4Hwx0Zx8p2o2774HEnVHgmq+s4VEEhiRiH8fScEO/sRlU/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009481; c=relaxed/simple;
	bh=IbbxYWGWE+0r0TUcIzoCcU/NhkWMs9Q/TOnI6/ERyLs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K7WzKbqeVWSF6Rz7IhxIxBYVbDA9tRi4j3mPulyjiSMm0FdBPbjuwO428PykUAuvtfWwFH3NLUPIDSImPjZuvbdgkgVfSYfBaNrgJPScjuCMJ5ebpHqRJFFdbLjXL1lZuI437WjK8K/U1mbLPDNod3LhJWxeBrkpm82CGjlno4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MQ04pnNM; arc=fail smtp.client-ip=52.101.69.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MQ04pnNM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGCxwIQkYJQtRiC53q+Qpv9ZsNhsMu4L4gzePkTdVoVFlu1wwR2A9fTxZkI5JkyX8hH5FfcTvere127hgXCvwsDyWeO/HiUiOfxj8eDMSJgJ2woIRDwEm+EPuHJwXA9+aiqkWX59OWw8iH4DgICg9MAg0QeAt9RKSXKQBYgBhwL+n3cMtLP/h8fTRCeDHFftzkS/H7DIwClFBwR6LOpxdw7bVyGsgv/UEJeFYO3s2v+Qh9FHf5piy7rU7rgh/YJ8m1HNBVcVov5G56X8uzxgD79fM03yoWoaYA31V4A45YcGE8PxM+nK2Pr8WAwgczlrdsg2kcP7pbrOy0GGIHibJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HG7dZ5QBX9RbprDbAyvxFeVElz/ommnAAPWb3ygL3Q=;
 b=iLmCo+t+1ovg22foZjuaxFRQavheb6cwPr+ZDUCguFJyvRRd4JRUeC93dvn88HO/DW1X0/SOOl3hA7icqR2AehNrVu8GKUFLfP9rKvUk3LPpxGS+cwVi8yRLuDp+M2RneUIaBfF8H9SsaLeYgwv5XayYruXjVAAaf49qkEMeo6gtI1bl6pRHBRvhQpVVmLXb8YKGYOvEiQDt0LsRQsW/Sc9p8036D8HqPqNYac7NTuohgfSsDW4/ILPpyWyvCnBTdWwzAuFd0xXDFRco1BA2Ma5ondfYY8JqTYuazCylukSzETEgPV8h8b4U0IfCmqSd/inKp4EpXU8mPQTBr8TJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HG7dZ5QBX9RbprDbAyvxFeVElz/ommnAAPWb3ygL3Q=;
 b=MQ04pnNM6nfOaGgGtmWME31+qbcxLVm+Qn5yUT9iQuZMeQ6rb70mbQR4nK+uvzVj0fUUm4XX5tCLmU0TqNoDFUGwgzSZ96kzvaqMHNlVBnkxWjRtFa6EBG3LWXDaKmzYVieXoHtTWglGuviZeG6T20j25gM+lHezcVrSczL/vh78lUF4GK34hd92IVJH+7d7HYb0lxqZZoT6pNZk4KqBUt1rIIVQ8VDCZe+GugTf16I2Y+UMC+TY9AYQqa3pm8jKkLBMuljMhgilICJmZUrjUruLCsw6fM+6dQYW1RB/kDCAX6+0COetHhQrLylFF8HXGcNA+Md/kixT/78RBuIN+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DUZPR04MB10014.eurprd04.prod.outlook.com (2603:10a6:10:4db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 08:51:15 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:51:15 +0000
Message-ID: <dd06f0f3-c70c-42ef-9ce0-f1b3244ae668@oss.nxp.com>
Date: Wed, 25 Feb 2026 10:50:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: interrupt-controller: fsl,irqsteer: add
 S32N79 support
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 NXP S32 Linux Team <s32@nxp.com>, Larisa Grigore <larisa.grigore@nxp.com>
References: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
 <20260224111533.3194883-2-ciprianmarian.costea@oss.nxp.com>
 <20260224-tracing-undesired-e53512135f11@spud>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260224-tracing-undesired-e53512135f11@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0042.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::19) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DUZPR04MB10014:EE_
X-MS-Office365-Filtering-Correlation-Id: 157571a8-3b4d-43a4-26e0-08de744b08df
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qjh5NDRzeW5LbkZRL1J4WGtvMEZNQVJWK2RGMXJmdFhuNzV4MkpMUWhadFQx?=
 =?utf-8?B?VlpUazU0RnN5eG9lTVpla0thUnZXdjF1U2xkTEpPNkZoU3Z6a01iaEp6dWtF?=
 =?utf-8?B?cW5obFdzUXJhREVsZmRuOG1VSDZ5TVArNnJ6Vi9XWXVPQjNiNzU3aWluQnRt?=
 =?utf-8?B?ZmV1SHA5M2NJditUSlFPRkRxZklkVkRpZ004VzZBZEoyb04yVC82RnluZ3dQ?=
 =?utf-8?B?dEloZGxOcDVsOS9JMEVYR1NRTjluRWtMa2ZhaWRMM0poMjI0ZHlIaDJOSVNF?=
 =?utf-8?B?dWFvVThaSHJEa1YyVDd0VlFhWkt0WnBMc3RvdnpFd0VHSXJTYjlPcXg0WjBy?=
 =?utf-8?B?SXZQWSt6R1dJazZidVg2ZHZQUFMrTzNmNkNtaG12TzVkcGtwSjQxUEFFS0dH?=
 =?utf-8?B?UEY5S2MwMlFLSGRrZU1tTndjT1NpMTNsSEFBcW1oNVhVZE1BTzRHR3FPV0pN?=
 =?utf-8?B?TEVqYytKYStXaDZ5UHJvSzRqbHo3REd4RnRESDU0anRmU0FPZlNIUmtOTWo2?=
 =?utf-8?B?Q1N6dmdBTUJ5WE1rUDRBRVg1bFhJTlVlN3BkVjA3NHBGREZkWElYcDFGUGtB?=
 =?utf-8?B?Nmd6YU9WMmdGUi9qSjQ2bGFKdlRYSUxlNTZ3NDluZlBJM09YdFMxK0RWdmY0?=
 =?utf-8?B?VlgyUGNlOXZCSG1vR1kvNVBBdGFTbkN0dFhUUnJ5RlZ3d0RjY0txdlcyTmY0?=
 =?utf-8?B?QzF3dTFQMjNpOURKdHdUTzFoRkdxd1FQcWs1Y1lVYUNWZDVaejFNaUZ6cW8z?=
 =?utf-8?B?Q3NYcjU4MGdZT3lVVTJkdXBDbTlVL3hGVHFXRTdtYmNyYWZLQUpFclg1akZ0?=
 =?utf-8?B?T2J4L2p3OHdUSHl6bEllMTE1cUNoMU5tTGIwU0FaZEt2WTYrV3VTQ0JHcXRH?=
 =?utf-8?B?RXpJSEZSMGUxdlI0Ni9BcXNEYjZmNHB2c0tFVXNBN1owaFRxU01rRWlMNjdL?=
 =?utf-8?B?blpEeHhrQ1hIZ0w5VklEbDJoQmRRb1FuQU82M2ovQW5JRTF6NmFuT21Ucno1?=
 =?utf-8?B?SDQwN251SEVOeStpTXNIbStLWkRBUnhWR1lYVXVpSk4xMUR4WjgzL0tZd28x?=
 =?utf-8?B?Y3V3TFFkSXRBTFh0Zm9hbTdqTm16bnUyMGZ6RWozNVNUUnY3UjZkN1dSWDRN?=
 =?utf-8?B?dUlDRG5RYndnUG1WdFZhUllWNGNHM1cyaHlpOC9Ha2pwOUoyc1ZRNERSdm5u?=
 =?utf-8?B?b1RQb09zVDJ2ZnN2K2hZT3NDNXVvY0YzYVFKOWdMN2xZNTdiTHRhQTZIZUFK?=
 =?utf-8?B?KzRIS2FLOEYzYU01b25NQmlJVWVmOXhab0JVWWlZTE1MN2NhK2I3Tm1EWnNs?=
 =?utf-8?B?ejM4bE5FQ0RadXlVY0tOWUVEbG84azBSNk5CN002c0dWaENubnU3SVVnVkpF?=
 =?utf-8?B?K0NmajdjU3E1SUJOT2liMlE4bHNMa3BmbkZCeCtOSWFMQmtZVFVGY01EY2Ja?=
 =?utf-8?B?SHlPVGE4UHRxNVplbzQrLzFnSk13SExlZDVRVklIeElRNGdUMG04OC85eVlG?=
 =?utf-8?B?cnBMcGo1SEhEQytjQnFna21OQjhSR2ZaTWsyaWJqRHZMbjBYTXhLMTVta2Nm?=
 =?utf-8?B?cHZNNk1BaElEbmdsSTJxRUg5Wmk0NWxabDEyQjA0cEN2NTlLSUpqVmJYVlpq?=
 =?utf-8?B?UjZJWGxHOXMyM0tMSWtHNnM1b2tLMkI5ZVdvRmFjT0ZFa1RVS0JFb1gvVkF3?=
 =?utf-8?B?dU9uaWV0alpRQ3BzeWNTVVlkeng3ZDBrWTdoOStRVjF4djFOVk5aeE1NNmhT?=
 =?utf-8?B?enRiNnhLRm1KMGhub0ZET01rL3NQcy8yS2FXN0JVK2pibXE3Ly8xT0czayt1?=
 =?utf-8?B?aFRKV1BoVE9Hak1QSlNFUjFBaldkYzBwOC9iMzJkczAvVzJHN01yZnl4MmFs?=
 =?utf-8?B?UWRZRGFrUkZoa2pRbjNhcWZrYUVCQkh4NjRDR1REa1BsdjBUcEpTcmRmUEJN?=
 =?utf-8?B?MFF0VUNVdm11VmwzU0dDSEp5VkR5NDkxeGpGbXh3bFVtSDllQXZ1am5yQVlX?=
 =?utf-8?B?VFN1M3RxRlBuU3VROEFxTVI1djZrMnZ1TlNDMmc0YkZMMmhnZVI0THl5STBH?=
 =?utf-8?B?WnYzT3A4dVVuVVpHU2cvK2dkTmFuVUNzUnJYV212K1VlK2RvRUg3bXp1OHN3?=
 =?utf-8?Q?PZaE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUpCVEI0aUVlQWphaEMxcGJDNkNCVWtqaWYveXNxQm84YWlTWjlpVVdUTG41?=
 =?utf-8?B?OW5Zdk10UXpicCsxdzlvajF6Zm9WTTJZUExOdnp5R3RZYkxUYzgvRmtLeWFJ?=
 =?utf-8?B?NGo4MVQzWXh6YnlnNHVKT3M0NDVESmNuZytqUmJYUk54N2pHQ2lJajRONDI0?=
 =?utf-8?B?U1FjZjBZSUhIRGlWQ2NjMmpnWXh4WEFZUFQ3VVFYM0FUTmljQzRKL00zQkt3?=
 =?utf-8?B?Q0F2RExoSVAvU3FXOFNoY1g5M3dtakhEVERmZXZTR0dhTG9GZFNMRlpiREhN?=
 =?utf-8?B?cWNHNit3YmttZXlWdEU4UzROdVNIK2dSa3ZZVFdlRndUUkxoc2V2eE9ZWE44?=
 =?utf-8?B?NUNNaDl1dnMwTGxKZC9GZDhuQk4veDNaT2o2RnZpeHFFdFBzUDJhRWpsRldK?=
 =?utf-8?B?ZmplMEZoSU9kS3o1UWRlYVBMaldpV0c5Q2dtYU56aEo3RS9PbzBWaTFiZWFQ?=
 =?utf-8?B?MXMzLzdpMFI1SkhTUGNsaE9nWTVkQlZ5bEQyTUc2TGVvNDJaU3dxY25kazd3?=
 =?utf-8?B?L2FmZ1BxSUJGejY3dDQ3Qi9FMDNBVGZ1SFJUMW12Rk81bldreXFFSnphTEUz?=
 =?utf-8?B?aUNZZWwzanN0RmZIR1FNQ3BnZEo5M1F5M0xkenF4TmR3blVWdEdjdW5RMEt6?=
 =?utf-8?B?VE00NEVQK1orY0w3bUpyR1dlYlV3M2lIbGVpb0RNbmdHV1Q2cWQwc3YzaDRI?=
 =?utf-8?B?SG4yY0ZNOEgrai9OWVEvYUdORFh6NWtWdnVaN2hZWHhjQVdSV1FvcEhDbzVP?=
 =?utf-8?B?eks5Q3haRWZQeEpxN3pCRklJSUZqbW8wZFBlN2NTNkw4N09ZVWpoUit6N05s?=
 =?utf-8?B?Z3FRTjB2VjYzZXhFV1E3SHR5S3k5cm1TeDg0UzM3a3RrdE5hd1hCWS9MQnJx?=
 =?utf-8?B?dy9OSnFqSmorK2FMR3dYZW16OVo5SVFHamxJUWM5SzdjRklDa04yWWJYVXRs?=
 =?utf-8?B?dXg2QmNZYUIvVUZsRUFOQW93bDZHMFdtWkR3MENxRi92bXE1TlU3QkQ0MGN6?=
 =?utf-8?B?UkdpdWx5TzlDR2FNQUJVYnYyTXdjbFM2ZEZDWDh5bGd2dDhIQ015ZTYvT3R5?=
 =?utf-8?B?T0NSN2FHZktCWGhDZlYrbXV2Z3RlZ3diZVgwZkpmTzNyUE01STN0eHZ5Y3lz?=
 =?utf-8?B?Wm9BT3ZEd3BlMldWNFlDRXMrblRUNXpJL2JhTlJaQkJicklnR2ZrTHlWelpI?=
 =?utf-8?B?ZHFpMXNDQWVUOUhFTkx1UGJpUFlHWkwxdFZ5Wnpwd2pxY1ZVZDhPWTdib05B?=
 =?utf-8?B?RGt4V2NCcmp3UmVMckxxMm03dzFDY0g0MFhxRkFXRFVUSmFvUTBrU3JTL2tG?=
 =?utf-8?B?Q1EwSVluckplNkQ4TTdKUm1YT01sYTlGTmJQdmdWNlZDN0NmcW5MbW1LakR1?=
 =?utf-8?B?N0hzMis4bVUzRzFHOVJ0TFJsUlNnUTJzVzBWZUdCdzFwcnMxMEo1YlJWazJv?=
 =?utf-8?B?ZjBLSmZ0SlJ6NzIvTXFFdlViOWhGVFZrenY0QjZ0Wm9VTmpXMm5lbjlrQmVq?=
 =?utf-8?B?dEdXVWR5czZ2dmxrZS9WVFRDS1Z1SGVNejZDRzdRanVsNnRmbnhwYm5mS0p2?=
 =?utf-8?B?YW1zMUZ5Z2phaE5ZYm95MzBxS1IrUjEzTEdiL2l4VmFZS3VEaG50eHpYVjN5?=
 =?utf-8?B?bWs3YnJhRHBsWWVnVzdxS1BraStkNy9vME9QMTdIeFR6TmxSQ0pOTVgwRHZ2?=
 =?utf-8?B?WmxtencyYUZyRnhFTmJMNTdwL1lQRDdoYzVyVFNENVRYTllUQlVEbE5Zdi92?=
 =?utf-8?B?WWJGOFVUSGpzL1VzTDZoRTc0bXp4MnNWY2lTZ1dFLzNCVXo5elN1RFE3Sm8w?=
 =?utf-8?B?cUdqRFo0SDVLYUN5R2FkUUd2SG5DSmNMNzFoQzNYVU5iWGcwcHFFVTYyajRI?=
 =?utf-8?B?bC91UWlvVWFWd3kreDFFVGJMK29jSVFHbHcxZHA1eFhIRTN2OW9NbnYwemd3?=
 =?utf-8?B?cGw3ejFQaDZBMVhVWFVrVU9teFVDUm9DREZVRXBDUFZ2MkRFcllsNVdyeGxV?=
 =?utf-8?B?aHRjdFZDSklZU2IxSjJRajhEMXhtWHA4b3MwcUZKS2VlcmIzWXBVWWhlQk9i?=
 =?utf-8?B?THl2ZHRJTE1VQ3VHT1B6YTVLaFVLQ1BEM0c4U0RSb0RtRDNJaDYyTGgxaXF1?=
 =?utf-8?B?MFQ5cDA0NHUwU1NkWDNqOERNUzQybkVZUE12UEpwMFhWcnd0bXBGR2dxZjRU?=
 =?utf-8?B?TFgvUTA1a3dNNHhmQXJoTFBGN2RwYXMzTi9vUkl1SGNNVU05WG9VckZ4SXhr?=
 =?utf-8?B?bDczeXJRcFNTYTY1OTdZYlRJTER3WmYrVTh0N2s0eWRIdjlPMzRuRnQyTjdO?=
 =?utf-8?B?OTFiUDRpRUFoanpjam45TnQ1eTMycWVuV1NBQWY5Y3dxdHE2d2J3L3hNS0Na?=
 =?utf-8?Q?gf8zzMJYeMkSqN6qNfqTTgr/oMthYsz+lE81Q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157571a8-3b4d-43a4-26e0-08de744b08df
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:51:15.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eETDfPCbzeLivmsaxapPyLFe6iG+/IB0ox1nx7RqaWUcQfTakz1CYTMnbdWPIgm3bq1NXT4IqvkJ9lCg9uKchyZkqUkLytrPmOkvdGQAyPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10014

On 2/24/2026 7:57 PM, Conor Dooley wrote:
> On Tue, Feb 24, 2026 at 12:15:30PM +0100, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add compatible string for the interrupt steering controller used in NXP
>> S32N79 SoC.
>>
>> The S32N79 SoC differs from the i.MX version by not implementing the
>> CHANCTRL register, but otherwise maintains the same programming model and
>> register layout.
>>
>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml   | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
>> index 5c768c1e159c..caf3e4a1f26f 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
>> @@ -22,6 +22,7 @@ properties:
>>                 - fsl,imx94-irqsteer
>>                 - fsl,imx95-irqsteer
>>             - const: fsl,imx-irqsteer
>> +      - const: nxp,s32n79-irqsteer
> 
> Should there not be a corresponding driver change for this?
> 

Hello Conor,

Thanks for your review. Indeed there are driver changes in this regard 
which I've planned to submit separately in order to not mix the mailing 
lists.

But I see now that I should have added them in this patchset according 
to the 'submitting-patches' guidelines. I will add them in V2.

Best Regards,
Ciprian

>>   
>>     reg:
>>       maxItems: 1
>> -- 
>> 2.43.0
>>

