Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021088.outbound.protection.outlook.com [52.101.65.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F33D551;
	Wed, 30 Oct 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295879; cv=fail; b=XM1+zIGC+R5lQ5md16wQo9AY6Qij2LbwjIF4MoaMDjRUBO7uqyDItwXm0QEdbBxd31wektROVVVEjC4qPXAa5Xad5UU1yVHPgsJsRwOGxrQOplAnnQO5Evm1JpkUY9tEy7J1gtg6i6SFdct3cjZLrCNyNg80glzIUziZswmsUzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295879; c=relaxed/simple;
	bh=m3vULvpIiluuka7cZuaeSTGvwcqfuH762jQ9nDD/1BU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uR8vrKfcDdLdCgYkVAwjtaEnK+C2wcxHusFEqTv+20u55bNYTBJW44kWyW8B2N/of+iUXww3Xf3r3GYaeNcXXh/VtUjpMTulXO9b8WZIsPKchoIUIYj/Nsgu+TtgZoRGP885MVBG9JnVC808FqPfY9tZ6oC+yyfjeZ44gGDVI6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=OuDdLqxg; arc=fail smtp.client-ip=52.101.65.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="OuDdLqxg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8JptEcx/jmBzqxYVsArCCnPzSCM1trYx3LUe1nXBBoAhr1EvCi+pWskNRwSCB0YmF7hYtsf2vdaCEjZNsN56m6DKgia26QjgdsIgU6an/Q8R68ClT3bMg7tLI0i9oG87v+Q6XFcMxaPX5nzwz2OTlsr4NHNwsbBWlUpN4+84IeRJGea4kGUsuDFXwq/SHdjFvN/nZi4fIfaPOSMZPtnE4MXlPAKHzUG/pv5lwJhXb/gJOUbhGGUZAqhO4mB+QILCI6EvMXmhDxAdKTfjTibOjHrRckOIeU02gx4BIiejor9ErcaINhHgVx8SKdZcUts6TGuFduQ1kPxey6RR2tgog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3vULvpIiluuka7cZuaeSTGvwcqfuH762jQ9nDD/1BU=;
 b=vtKaAIvD1QmoQGaUAnW64ZGfCDu3Y75NoRC4ifPTDtix0UjRuqQwq7AoPSvgE6kwRTQgS+gSJEsrYyEftOJSSLM3iK8iUxxQXwM487QKkJOF6YcN+RyDau7sfu8jpLzJslCULVtsGFjrDLXQhDfnePTZYgKg/IVfxlxn7aYyhhyDrlue5q5X8plfqNNCNE/DK23FZ+MYbYUgme9B1RcmIzfN5UIms/y2JZlVWhJLaTh82TnMgvBdwXrWb/BqI0stYqzNUhwuULWg6v+F13rCD8XB9U7b7xdiRn8VwmzQ4wKZlcvxOx+rFZjKYsSG93K7pVn5CTO0m8UQPlAM0MDUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3vULvpIiluuka7cZuaeSTGvwcqfuH762jQ9nDD/1BU=;
 b=OuDdLqxgypY6HZYKB/kNFHxszxcT7q0wOqOQR4KB7d6OgyZuK+KXxbdaYc9hafsNkUisLqntYDKiKqD5u0oJz+/pVhJORKBTxQ31GUo/1ig4GAN6e5nAeyeIrtfALg+qWUHM+QMpkNREiNwSnyuPlrd9cE1fbbiz8sVybhUO8tY=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI1PR04MB9956.eurprd04.prod.outlook.com (2603:10a6:800:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29; Wed, 30 Oct
 2024 13:44:30 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 13:44:28 +0000
From: Josua Mayer <josua@solid-run.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Haibo Chen <haibo.chen@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: Mikhail Anikin <mikhail.anikin@solid-run.com>, Jon Nettleton
	<jon@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>, Rabeeh Khoury
	<rabeeh@solid-run.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "s32@nxp.com"
	<s32@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mmc: host: sdhci-esdhc-imx: update esdhc sysctl
 dtocv bitmask
Thread-Topic: [PATCH v2 2/2] mmc: host: sdhci-esdhc-imx: update esdhc sysctl
 dtocv bitmask
Thread-Index: AQHbKtDp4sya86G/gE+AHlUXZYUbu7KfTgqA
Date: Wed, 30 Oct 2024 13:44:28 +0000
Message-ID: <61fa7a34-fa77-4a7e-b6cb-45fb5e671249@solid-run.com>
References: <20241030-imx-emmc-reset-v2-0-b3a823393974@solid-run.com>
 <20241030-imx-emmc-reset-v2-2-b3a823393974@solid-run.com>
In-Reply-To: <20241030-imx-emmc-reset-v2-2-b3a823393974@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|VI1PR04MB9956:EE_
x-ms-office365-filtering-correlation-id: 835f4d51-9280-4213-1068-08dcf8e8f99d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZklJdjFzMkJvQXA5dCtMZko3dldybWlWRlJ3Y2h3ejJMVGJZOXdCZVV5aFdq?=
 =?utf-8?B?amtwdTRzZ0pVQXlsbFB2cDRJMHNWQTF1QUhDdzJMbkl3ai8vTFdheEtmVjEx?=
 =?utf-8?B?Y29uVTNBRitEUStLN1puWWFIOXpRTW5vVWNNT1BIOTI2ai80NWJWZG1BVW9k?=
 =?utf-8?B?TE5uVy9yTUE2d2l0dmF1NnNoTzNBdXVWa3J6V3pZK0NkcFFUSVc3Y0hQY0Nx?=
 =?utf-8?B?OFVrUFFyMDF0ZmZYT3NoVFl3QmZkbko3R01xbmRKOFFyUUVQcnhOc2RCeHcv?=
 =?utf-8?B?SzhDYy9WY0Q3QVJtYjVDeXI2OUVtak10V3JCWE45SHVqeXFMMHR1YnRyd0NV?=
 =?utf-8?B?NXByL3BsZ3A4RUdmWW5WTkt1MlF3RUFNUmYyWGxTaWpGd2JoOXZ0YjU1cmVn?=
 =?utf-8?B?SXo2enNTRlljcCs2TmtqVDVYaWpvajk3RGo1UlNtOXhqZEFXNXF3UUU1Y2ZP?=
 =?utf-8?B?eE10bW5od1VkVnd1c0VzOEE3dDFPWWdQaTN1UWZVVDRjWEVqcTdleUkzaTQv?=
 =?utf-8?B?VVJXU1JacXNjUnJ1Y3JzOVd1MVUyMVZPYytQeU9aNHZSc2Qrc2h0VjY0N2ww?=
 =?utf-8?B?U01CaVV1SFJQU3F2NGNpMUNCWWlOWnJ0b3k5aG9VV2kwS1A2dzFEaDN2RmJK?=
 =?utf-8?B?aGcyOWFVbXFNMkZOdnVmOUVvYjVMRDhvTytJaTlmcllvZTlJYXJia1gxZThT?=
 =?utf-8?B?NlpZTkM2alBZSm9Wc0ZITUxDYkJFL0xoNHpsL0kwUmIxdjZuUnoxanJhcWY2?=
 =?utf-8?B?TFFUSURreFdveFRzWmhYTVkrTHZMMGtNYVd1a1hlekVCQ0dxbnVhRVByZ3g2?=
 =?utf-8?B?TFpUSFF3ditvVGUzNnZuQzlZRXltQnBrVTA4R3dTOWVtSCtnUHN2S0tXWEhu?=
 =?utf-8?B?UlNUUlg2ZWloOVFiay95UEdSQXoweU1FT3c4YldzRGtTUUpVNUlhYjZteEwr?=
 =?utf-8?B?VHdrQ1dVYU5KRDVKOElheWFaRFRJT1o4cEwxT1h4QWVkUm1OVndqa01oSDNY?=
 =?utf-8?B?eHFrQlR0elZWOWFFRVdNZmFOcGk0aG9FZWRWcFQrQzZBME92ekFXcnZMZXJG?=
 =?utf-8?B?aGp3MlRFSGI4WDZRYVpNMXRwdE14aUlWd1gzS1MrYU5hZjdyT2Q0R3BjL1hh?=
 =?utf-8?B?TWNla3ErTi90ckp4UVZrUUhvVUdzZCt6NnVFS1hCRGRsdnRHUkJ5M045SjlG?=
 =?utf-8?B?M1NaN2VRMlNEaHZwaUNCMjdSWm84SkRhcXc5NjY5aDE3c09PSktXYmJIcURa?=
 =?utf-8?B?K0F5NFB1M0tXM2lqa3E2K1J5Y3VJUGpYcGlIbGsrSTgxdy9DbE91YmdqejNZ?=
 =?utf-8?B?TFNCa285MTFsQ3BKMElKSUlJUHZuRDZQeWRqSHdxSFFsMlhBRldzVWtqWUhE?=
 =?utf-8?B?RDZBSmw3OTVTYjE2ME1NTmJQRlQrYmhRTWRzdTFTMEVGdzJUY0diUmhKNThS?=
 =?utf-8?B?WjhXam04TFVaZjI5ZDZHcU8vbS9QUGZTQzFNbmx4MnpBVVhkOTZBYzZ6MWdv?=
 =?utf-8?B?b2cyZGgzMEdYWlBoUmV0V1lzSFZMTlIyOFJJdGNxc0JIelErL2o4OEtIRTZP?=
 =?utf-8?B?eFlMeGxxcTByOWZ2S0JkT2F0c2ExajByeDlLNnRTa3BtL0szanltbTUzZDZ4?=
 =?utf-8?B?N29tSHpvZ25yTE5waFoxR0NVSDdzbkpQcE5HRFJINU1DUnBMTWpCeStrQ1Qw?=
 =?utf-8?B?ckpKT3hIak9RR24vMXBLL1g1cWZiUktCWkZHWlYzaHRIdTgxZnp3QkxUc1lF?=
 =?utf-8?B?YmZIZ3dXYUpMQXl0cS9GSlMvOXlQdzlLZkVnUFdpdEFxUzM3WTk0VXBKTFd0?=
 =?utf-8?Q?pTcu91NUtoLwNaG5dOFFQfnmEVbGok6d5uOMQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnpEYnJkeTRnVXJETTcyajBybGVLU2pOdE9XMkt2QTIxSDhNcjh0azhBTGNU?=
 =?utf-8?B?OUxDdGlSOGEwZkhQUEthb2NrN1RZUThGa1VCYUdpNGFNcWpTQUdnQm1kdTEr?=
 =?utf-8?B?MERrNTBKU3Z0c1liQ3hCeDlNTm1xazR5OFNBaUFJeWNrWVdhR01JTDZSY1hq?=
 =?utf-8?B?MHkrV3U2emIySGZySmFRVXZUVXUzek9YWVFCUlNKaEJEY0J6NERhTWFjZnBt?=
 =?utf-8?B?djhQc0RvTmZNMEhlMXdkOFBDbm5zbGZJQnhBWFhBTk1WMHdXZTUyU3JIbFlr?=
 =?utf-8?B?NWlTeCtGQXc2OEdkRXBwUXdwUUdNd3dTbk5JK2dsRmVmcDQxcWVzQUxwU3Bj?=
 =?utf-8?B?NjNxa09lZUdrU1FWeW1KeDFVOTRwWWVMRWdybUNBV0x2MFlvUmk4Qnpqc1hx?=
 =?utf-8?B?R0JITm5OTWR4TVJHcG9zRkdXL1BUZmdBZEJTQWpuL1dNeXFLZ2xOWjNHQUVD?=
 =?utf-8?B?RkZscURlcU0vMjQ2TmZUZFFMZlFJM1ZJQXRqYnY3dERDL0RMNFFIdFY3SFds?=
 =?utf-8?B?YTRYTnJYOVZLclVGOFFxODA1cDVBQVppd1pWSEFyNlNiNlV5OU8vME4rczNM?=
 =?utf-8?B?YkZEeXF4aHBnWTIvUGs4TGhZZkRkcytnSm5YVXhzR0ZLWDJHYkJESlFEU0cv?=
 =?utf-8?B?RG9mbEpMajhCUld4TDNPcjJUVWtjMlp4MHBUMEJzeGZhWGhsSlBIaHVLRURm?=
 =?utf-8?B?Yk0rSDA5eG1qVHp2aTU0QURPN0ZXWGpJSm00c2VBajkwN2hUTTI5R3d1aTVV?=
 =?utf-8?B?ZTlKaFBxeDloQ0NnWFdGVTVkR1IrNmFVK3pvVUlTWlgrd1R6VzkxQkJtMEEv?=
 =?utf-8?B?c3ViKzRhQ3FZNjVpS1Axd1RpOXpCZlM2VkFNQm1CVHh0d0tkeEhXQTVhU2li?=
 =?utf-8?B?ZEhIbmZ3b3lIRWhpNHhUSTRIK0FZZzNuT0x3bWJqUFZuT29xY1MrZkxZNUox?=
 =?utf-8?B?cW14SnBnWjZIbmdISlZIbVd5NVNXWERId1h0Y1RuVVVZRjBGdXU1eVpsRlMy?=
 =?utf-8?B?NUlKOERUUzZYWGI5ZzJQcTR5SGFXRUU3QzdTNGtDYWs5OU5JY1ZCcVFBZG15?=
 =?utf-8?B?eElEcHoxTlBJWW1Gckl3dGg5QWVqT1p5UDZvdTBqQUw3WFpueVRwbnRkWlBp?=
 =?utf-8?B?eGtueUJsVUg5ekVSanNSN2FFRmJjZUQvYnpZWStvZ1ZRY01zanpBQWF4dGR1?=
 =?utf-8?B?L0xCRWFJU2dkMmcyV084RlJRM3NpNmxHVXE2MXh6a0tmVUJOTU51R0tQbDhG?=
 =?utf-8?B?bndsWUc1Yk5vWXl1bkZiY1Z5RGRJSVlWRnI4cDBMUzJZSW8zdnoxZzcveW9X?=
 =?utf-8?B?YUNkeFZyRTcvamNkSE14WnRBLzZRazUveEtsZHdZMkx0WmY0U3ZwY0JieDQ4?=
 =?utf-8?B?MThpYW4wMVZpK1BkNzdYdnJDb3B6Z2NScU00dURLT1NyQWU5SWRaUW54Vlh0?=
 =?utf-8?B?M095alZ3M0k5SWxUWEp4ZmpLSW9LeGZmNnBVVnp6a1o4YkFscVdreGx5Wlhs?=
 =?utf-8?B?ZE1OSTIzQTZ5OVZoTXRXL0RaMVdmTXRPTVYzRDZhRWZ4S0d2QXptaDZhR2Ur?=
 =?utf-8?B?cERzQkk0SXFqa0xwL3pqZmkyaXFKRWtBemxKWC9XM2Y3dkgwR0k2c1hCM1Mv?=
 =?utf-8?B?K2gwa0Nidk5MRHk1dU81Mm1qZnFta1VZQThjdWdWQmxhdnBoSHVqVmQwZlFB?=
 =?utf-8?B?WjdoRTM0TVdmdWVxZUhKQWMxejVSSzU4L1RBaGZtQ0hacy81bEc5YkFhN0Za?=
 =?utf-8?B?OGJuU0UxeDdRSERCZndsM0syaEpHazIwalFjK01lZ0VqOFJ4UjRQSERjZG9B?=
 =?utf-8?B?WThBYzhCZXNzblhYVWhXQWVQVEdUdXFrUXBZcHcxNURtVVQzVU1ySjZDM0VX?=
 =?utf-8?B?Zm5CdkN2NHZINU9BanFuQ3ZDY1BGQzc1dU9DUXhRc0NDQXB0M081SHNZK1NO?=
 =?utf-8?B?MnJ3SUIvZ1BNQzZHTGRnVFhSWnk0UVJJL0Z0U1kxQ1E1dDF3cVlFMkF6VFRw?=
 =?utf-8?B?dGlSdHp5TFl3Q0JVVTVtcGErOE5MZ05EVENZRjFxTFpNbkp5NStrcTVHK2Nw?=
 =?utf-8?B?NVEyYVBRdTkvcnNkQmZrTUR3K3ZXZzdKeHdndUNYbHRETlZZRmxrS3JwZ3Vq?=
 =?utf-8?Q?euF8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27FFC0D53578024888FBCD748921436C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835f4d51-9280-4213-1068-08dcf8e8f99d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 13:44:28.3542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjhuAhUk1mWnH09vQbOD4uYTWXjo2e/MBbYxEGUcnNYvxLwrb1EoPp71rk8uuv/PwGfe+r+FmY/oxzSHkkO2/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9956

QW0gMzAuMTAuMjQgdW0gMTQ6Mzcgc2NocmllYiBKb3N1YSBNYXllcjoNCj4gTlhQIEVTREhDIHN1
cHBvcnRzIHNldHRpbmcgZGF0YSB0aW1lb3V0IHVzaW5nIHVTREhDeF9TWVNfQ1RSTCByZWdpc3Rl
cg0KPiBEVE9DViBiaXRzIChiaXRzIDE2LTE5KS4NCj4gQ3VycmVudGx5IHRoZSBkcml2ZXIgYWNj
ZXNzZXMgdGhvc2UgYml0cyBieSAzMi1iaXQgd3JpdGUgdXNpbmcNCj4gU0RIQ0lfVElNRU9VVF9D
T05UUk9MICgweDJFKSBkZWZpbmVkIGluIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaC4NCj4gVGhp
cyBpcyBvZmZzZXQgYnkgdHdvIGJ5dGVzIHJlbGF0aXZlIHRvIHVTREhDeF9TWVNfQ1RSTCAoMHgy
QykuDQo+IFRoZSBkcml2ZXIgYWxzbyBkZWZpbmVzIEVTREhDX1NZU19DVFJMX0RUT0NWX01BU0sg
YXMgZmlyc3QgNCBiaXRzLCB3aGljaA0KPiBpcyBjb3JyZWN0IHJlbGF0aXZlIHRvIFNESENJX1RJ
TUVPVVRfQ09OVFJPTCBidXQgbm90IHJlbGF0aXZlIHRvDQo+IHVTREhDeF9TWVNfQ1RSTC4gVGhl
IGRlZmluaXRpb24gY2FycnlpbmcgY29udHJvbCByZWdpc3RlciBpbiBpdHMgbmFtZSBpcw0KPiB0
aGVyZWZvcmUgaW5jb25zaXN0ZW50Lg0KPg0KPiBVcGRhdGUgdGhlIGJpdG1hc2sgZGVmaW5pdGlv
biBmb3IgYml0cyAxNi0xOSB0byBiZSBjb3JyZWN0IHJlbGF0aXZlIHRvDQo+IGNvbnRyb2wgcmVn
aXN0ZXIgYmFzZS4NCj4gVXBkYXRlIHRoZSBlc2RoY19zZXRfdGltZW91dCBmdW5jdGlvbiB0byBz
ZXQgdGltZW91dCB2YWx1ZSBhdCBjb250cm9sDQo+IHJlZ2lzdGVyIGJhc2UsIG5vdCB0aW1lb3V0
IG9mZnNldC4NCj4NCj4gVGhpcyBzb2x2ZXMgYSBwdXJlbHkgY29zbWV0aWMgcHJvYmxlbS4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDQgKystLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IGluZGV4IGE4MzBkOWE5NDkwNDA4ZDMxNDhiOTI3YmYx
YWNjNzE5YTEzZTg5NzUuLjEwMWZlYWJiMjRmYjQxYmQxMGEyZTc5NmY0ZjNmOGQ0MzU3ZGMyNDUg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gKysr
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBAQCAtMzAsMTAgKzMwLDEw
IEBADQo+ICAjaW5jbHVkZSAic2RoY2ktZXNkaGMuaCINCj4gICNpbmNsdWRlICJjcWhjaS5oIg0K
PiAgDQo+IC0jZGVmaW5lIEVTREhDX1NZU19DVFJMX0RUT0NWX01BU0sJMHgwZg0KPiAgI2RlZmlu
ZQlFU0RIQ19DVFJMX0QzQ0QJCQkweDA4DQo+ICAjZGVmaW5lIEVTREhDX0JVUlNUX0xFTl9FTl9J
TkNSCQkoMSA8PCAyNykNCj4gICNkZWZpbmUgRVNESENfU1lTX0NUUkwJCQkweDJjDQo+ICsjZGVm
aW5lIEVTREhDX1NZU19DVFJMX0RUT0NWX01BU0sJR0VOTUFTSygxOSwgMTYpDQo+ICAjZGVmaW5l
IEVTREhDX1NZU19DVFJMX0lQUF9SU1RfTglCSVQoMjMpDQo+ICAvKiBWRU5ET1IgU1BFQyByZWdp
c3RlciAqLw0KPiAgI2RlZmluZSBFU0RIQ19WRU5ET1JfU1BFQwkJMHhjMA0KPiBAQCAtMTM4Nyw3
ICsxMzg3LDcgQEAgc3RhdGljIHZvaWQgZXNkaGNfc2V0X3RpbWVvdXQoc3RydWN0IHNkaGNpX2hv
c3QgKmhvc3QsIHN0cnVjdCBtbWNfY29tbWFuZCAqY21kKQ0KPiAgDQo+ICAJLyogdXNlIG1heGlt
dW0gdGltZW91dCBjb3VudGVyICovDQo+ICAJZXNkaGNfY2xyc2V0X2xlKGhvc3QsIEVTREhDX1NZ
U19DVFJMX0RUT0NWX01BU0ssDQo+IC0JCQllc2RoY19pc191c2RoYyhpbXhfZGF0YSkgPyAweEYg
OiAweEUsDQo+ICsJCQllc2RoY19pc191c2RoYyhpbXhfZGF0YSkgPyAweDBGMDAwMCA6IDB4MEUw
MDAwLA0KPiAgCQkJU0RIQ0lfVElNRU9VVF9DT05UUk9MKTsNCl5eIFRoZXJlIGlzIGEgbWlzdGFr
ZSBoZXJlLCBpbnRlbmRlZDogRVNESENfU1lTX0NUUkwNCihJIGNoYW5nZWQgdGhhdCBsYXN0IHNl
Y29uZCB3aGlsZSB3cml0aW5nIGNvbW1pdCBkZXNjcmlwdGlvbiA6KCApDQo+ICB9DQo+ICANCj4N
Cg==
