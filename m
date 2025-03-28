Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013017.outbound.protection.outlook.com [52.101.67.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925217A2E0;
	Fri, 28 Mar 2025 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743130751; cv=fail; b=p63PE1FOFB7PkJuRY2qTdS8wdA/LQM67JDGGuXKbYgCxXM8RuUNVHlK1qAwacevyFYir0WJtqj7BvqJ0yBaWQAohum0RmmEP+fRfYePb0XjsBzkVfZN0BKD6g/O1/MwR+05/1PTpG6e4UHud2o4YhglHmKMz/BQHgq8/l0P2D+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743130751; c=relaxed/simple;
	bh=MTybixd58bihsTifgkpulvnTGkJV9Q/MW7Zwkdkxf2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ilN5YzpcIRTn6aunV+YySI2XR2Rq0efmHk5M6Y14G9WeZitvj+elzHFfqzjK9g1q3NNqJ1MsZaxoO0aCbAK2apaZsk6RSg9agqgb1dDlFccmc5FguU4bAyA0QMhLNYBNCczxsO2uUgFSIb4KjZFXuQFo7SKwny3pY1MK+TaEuWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FhoAvLfT; arc=fail smtp.client-ip=52.101.67.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FhoAvLfT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hROUwRPqva7aqELQw3AP7p3I7A5gV40P/pAz247FBr5IYGHvcffdCBpFvxOw6lc8iyZ3zQsQa7lHC+1LnX6zfuB44TxwqJbuif6JxwF+xi8H7C0vEPoI/BJJueaQ6hsgUaLwbqjnZac/rp5ATZoBlD7wuapUiSlru7viD5W99QOl4GjYYfsY7sR788oOMcQ3twbuV/AiN9XtOnJexMMgKcLjhIw+Zykj7xuflBy+NskYM86pETcVT6WdE1rrHeDccASe2UxBDqsmBw3BUz/deR20hs+8uTM9ECSpWlPOOVBJCsGMPBWAJ8ArEiwzaMGr+rZVxO/iwsDzB0nYCIcF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ygGvam7ghpG81B56oB7jmejiJ0jY7bnpeCNJ6jEEV4=;
 b=P+9db5osGrcTRByVI1WUWz9TNZRaX2lBApsVFef6mId1vNuWtF9cJHnUrlCuSK5TwguXP4w4DIT/ynyJIZ0tMn5bTp+ljFUPsNF2DwnfjinaQtZF3o0ldn4SQIbjFikWEXKBsPoae2IBAG+CWVbZQ+ZbMhaKbFetq8SX3eBThhJ4fmmlreVsl3NQ9V/AnicwXPkn1IY6o2lE+xyJiRhH2FC3wJJZTVAm327dnNKNayhFpHscKNQ9VLKKABmpeq911QxNy+vrYIgsF6kkM1zYe/Gg5nGYZuewE7S5Wcn1ySiVrhw/6tp1q/4UmopA2wXDAx1AhkhRANPfOXdSkKHcPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ygGvam7ghpG81B56oB7jmejiJ0jY7bnpeCNJ6jEEV4=;
 b=FhoAvLfTCYUDahVbA7kaAeSs9qKtz8Trj8wZWssNBmLBCzomqL5rd4qAr6UvEb/OuBDUiDPM+nftxzJHryS3k8IgwPJYDLONIDe2Fo5U0JfyrPPJr8JAlxaYJQxoRf6YftGADCUOkagig7sWDNkhubOFCfFUZcP/AzfSmFuiVD/zHwgBk/Ax52h97e/AxFs11VxTdm5OXsNMc3737JBjMZErLyZtUqtaaPzsMeH8mE7nMaA694Ume4paJAmezZYJmLjjCMFXMihZyQ2TPJc6iqqfKdR3RP0Bng8EQJNOxF1mmH9+OTmoiMZthH3Rc+gPNZrVEB9Qm1PJVbGFbZMEbQ==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AM7PR04MB6999.eurprd04.prod.outlook.com (2603:10a6:20b:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Fri, 28 Mar
 2025 02:59:06 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%6]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 02:59:06 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Bough Chen
	<haibo.chen@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: host: sdhci-esdhc-imx: save tuning value for the
 card which keep power in suspend
Thread-Topic: [PATCH] mmc: host: sdhci-esdhc-imx: save tuning value for the
 card which keep power in suspend
Thread-Index: AQHbnWozZk/+MZ7EDkizMOiRfP/4QbOHOoMAgACjycA=
Date: Fri, 28 Mar 2025 02:59:06 +0000
Message-ID:
 <DU2PR04MB8567821AC37014A2C2089553EDA02@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20250325094330.2242646-1-ziniu.wang_1@nxp.com>
 <Z+WFvMXKo8Vg18r3@lizhi-Precision-Tower-5810>
In-Reply-To: <Z+WFvMXKo8Vg18r3@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|AM7PR04MB6999:EE_
x-ms-office365-filtering-correlation-id: 3779931c-ef8e-4754-9507-08dd6da480f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Dper9kOPUcV4a/bXSRj9h7yh0XKcNF3jzXVlaby6pPui4wfm3mJCia9lIjiZ?=
 =?us-ascii?Q?XD4ZoSoqLsOSBZmkiVDsljkypuq/UyDAEUQ80wppJsZPadw/VkO8aGfu3AUp?=
 =?us-ascii?Q?vaSAntVk4JNoj+ceA4bLBuWJenr/ijpt8k7QIW7AM/i+Jpyej+/F0fQ+uv2Z?=
 =?us-ascii?Q?9krYx0IChRF2WqkOW8uNGuXOn7uSL5cwXESnT9hqE9wYZJoigWVmociJSOkK?=
 =?us-ascii?Q?8DCVDuHhrshE5niyHmbypEnDTpSRXE1owwN8uea2qZsEacSw+59IuFHEdPRh?=
 =?us-ascii?Q?xdT6Lf8sFnYzcazbxnlUcNZof2FZQ7uXaxAzSeO+hz8loTgm7/KRCm6nPWWC?=
 =?us-ascii?Q?rVkLGtzu6XpDbF0tUNNVTqweTLlQCwrveaIjZidC21veWZjZdqCTLf2u/k1/?=
 =?us-ascii?Q?nw81YEd6kz7qrTebvW2KjijvXuOIDTP8Id8SRo2f9zpFOSYxRqw3bo2cimCy?=
 =?us-ascii?Q?OoS5PggdsynKd3KKTY6AInJd2qkVZ1gh+Zj3c0ckeRT0sUx8upRvEx3PNinW?=
 =?us-ascii?Q?k9DNRkUFYv+gfAG9nFueXZFU8Izdf9XVplKKD5a130trEDC95UBFoibAFvM9?=
 =?us-ascii?Q?U6CDNfBP/Map4onUsed9ZJ/3oexC8kZKWz8pE5oYFKguJHXmEL8eUTHKM9br?=
 =?us-ascii?Q?+IabSyjNt/+SFFYzFmgo/cew/nkQspvpnGkpdraOB6r16fwlmgX/NvrWJOot?=
 =?us-ascii?Q?XYrnAJDfl6PPc7gPAmjUzZLx6BKKcQT5qSXgXKdpeqBAjxQHmYt8R2ot3oRY?=
 =?us-ascii?Q?705+lYOy2h1a0JZz2vJEuxJtgr7LgkOOAhNk85BaRyARluwe81WJZqP/S9Pr?=
 =?us-ascii?Q?W+h+h7vZ6sWzBGkrm7myMyiWT4jBNe1uzRE1SA8PgMb2Nt7Jq1x2NH6z8XlB?=
 =?us-ascii?Q?o2YETo45qg0rgdWrRKPvJz+VQwHB2WOqB8N/T/R/tslnVqD29OYhk5RYM8qP?=
 =?us-ascii?Q?Ii2kv+DHN2uMVXjUb9zZUaBBZP0UlyUWj2DHTv/34yTXp6ih2qrLhc12Do2q?=
 =?us-ascii?Q?8HcFU+1hOZBfT04Z5ihelCoTBtdLTklbTCbkoEPMbqyVeNzjQtCmOeaII68F?=
 =?us-ascii?Q?VzKa/OY3WtdK90OXp4oVvQf/3pEypQr/7hf89RAG/BeKDfmOL8eVsVxC3zTD?=
 =?us-ascii?Q?kIKc4/G+oWis9vdMR/Ar50lEM3jjMv+IvUpFm7wRkhCczCBtORwWfiqd9wI1?=
 =?us-ascii?Q?tiEhfKwYaVabLcAiUYMRKgNcheBRog9FJY55pG6q1fxK4s51zdHRZvU1h/Z0?=
 =?us-ascii?Q?tNswqPLIAkBWnGkvyFkivwGOD0hwP3ls9+z2fAdLaIWTh0ywH6jS4xFADYbc?=
 =?us-ascii?Q?ncvAwMrOQv2X0lAyiDjTxR/cvpehP1I5sFtKy62b+9bDRRnvnejPjiEQ3BBR?=
 =?us-ascii?Q?+RyQj/A/BsIdEIbilREY7ve2NDAj/DaNfUWpZH3Gesmlp/j/g44N8Kdlfhg4?=
 =?us-ascii?Q?Op6HRvgJoUG89YDQB90TN5SolWlHMGhV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eGZ9bM1xdOjRhNtXQPUCWjy9LJF9nlGVpbuUh79xekmYmStjSge5idPi70Wq?=
 =?us-ascii?Q?4VIu8u1z+o2zuhuEXXypEwm77yKLlmFvEHWkp8MVq1g7w7lcNZjgZ7cDTB5n?=
 =?us-ascii?Q?OOKhFt01+EPysq/UKEX7SPi6nhVlGpi5dmxAjSZkuEmh7GitfLfiiTwTPHLo?=
 =?us-ascii?Q?Zsq/vu+a3qlRdz3tIokZ+j9hXwaYGKuLC/XZEF0wtnoZV4x2L5A2GuCBdmew?=
 =?us-ascii?Q?3Poy7OY0Va/9XCjEDrV+rGDNy9/q4PX70hQ8ScVgmYdYBxqozVojFX4tx6cP?=
 =?us-ascii?Q?Q56efFxyo+433/EuV8mtpSxz935pImfAYIJpEztk8jZ/X7Hd6vozw7veB3jm?=
 =?us-ascii?Q?eQZ8800J606oRA6DBHVRY/ZxjTefl7a1qHRPE2pFLX8mIwL/uY3+jGmZqexE?=
 =?us-ascii?Q?ogBSI3CvkZ3sTH5LlND/zipWDtF2vAW8ZGX8pphHoPmfA4Z69D3SPHXNobCS?=
 =?us-ascii?Q?G4n81Bj3o6bBxuvrb1INXXLF096Qiyj7J4yNZcRTBehTsPY2DBwcgxFhLxVf?=
 =?us-ascii?Q?WRM/fx2KPqES7mFcacUzM8c1sjhPSMlOxPU3o+4nRbWhZp0B2eDtRq8JlEGL?=
 =?us-ascii?Q?aoDWqm1ilFn0q4f+Qx0aCl9sJHBm8to43cMh6pDMBB8nkagR7F/m4+SLn8Lr?=
 =?us-ascii?Q?X8/6VG9JO9Hsb9+SHxWABDeLtCRaBZ9+9HUyEyuLEvtEb7nqfl4Cm3fnTJiK?=
 =?us-ascii?Q?fTZIyxInGll0ZdMbf9zXV56e12tGDSXRpTv6K4xpDRxpM+CvqFt4Je3Ehsg8?=
 =?us-ascii?Q?Q8MM6cdK9FitPGDbwB+vWIrFH+UMCPJ/qldiv+39VG9f64VX7WsvZjv8uiqy?=
 =?us-ascii?Q?QKzgWarsqOANeWTeKh+7CVk7zoZF5jJ/aYKiiCJylUdOMheyt7gSK+c/R8Uz?=
 =?us-ascii?Q?+hNMOx/BKxunRo5jxDFuN2XcYKzMdGh+nvjv9uhVp43Eu4wV4Uy1LKe2GV/O?=
 =?us-ascii?Q?BTzYqsWZjSxQGHOh4OfCapkCig6jFXKYswGHNT8lVjfzoHvUPWQeGlVJa/V9?=
 =?us-ascii?Q?DGVNpw0xtSiISn+NFxFNR1ibbHgDXjxDYbkKgPvfFqdDhv0llyKCvgC4raj2?=
 =?us-ascii?Q?EDOYWRgRdlyrY+x8XpxQbOvkumuTBI6jStGGDw+SZ2QAYHIM4iN8VRI4apcJ?=
 =?us-ascii?Q?o0W8/UZkIwuCS0/Xc+x/gDWIAYj2oTMnhIBxL6MHrwqGWoD880sKbs1BtAN7?=
 =?us-ascii?Q?mLhHMpPs3/1G5QrQ06oH8l8h6tjlFVkF3e1oz2ih0R2o0fC87WW23Lylley1?=
 =?us-ascii?Q?FUNSZfBWgg4ygzpxqJUj7EapX3yECWj+TNNVZzuWSN262Y4Xosfm3R5RK4iI?=
 =?us-ascii?Q?d6ZQjrcR7AxH8as3JLjHPm0YtZkjEEGrCxiG4j4S8QTLp96ihSbY2c9coZCm?=
 =?us-ascii?Q?RJBCxoPoAIoDeZSW3vx/eO5M4ny+eu4PivSOX5hedHhRnqilEkRtwe/WSFos?=
 =?us-ascii?Q?Xo+1Eg+bjsFqaNC6cR1c2Kji2QSXQssvz4x1xpHNG6aH6m5na6DAB4HTf8v9?=
 =?us-ascii?Q?18EuFlDI45Av0Vc/9ktnoEdm784MdKjpkx5AsUOrqBpVA8Y9ITVCVs3mpNPK?=
 =?us-ascii?Q?Gw3LakdAljyEDKDJqTkCKXpzbY6sFRU2Mrz1HR0K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3779931c-ef8e-4754-9507-08dd6da480f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 02:59:06.2113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnn/msivl9+b8tD6EfjCgogVTWEBvKkigbou+dMK8BwrFXBKedLUcO2DCUa3/Cb3E3wKZmJYWnif5T8RJb3v6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Friday, March 28, 2025 1:07 AM
> To: Luke Wang <ziniu.wang_1@nxp.com>
> Cc: adrian.hunter@intel.com; ulf.hansson@linaro.org; Bough Chen
> <haibo.chen@nxp.com>; shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; imx@lists.linux.dev; linux-
> mmc@vger.kernel.org; dl-S32 <S32@nxp.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: save tuning value for th=
e
> card which keep power in suspend
>=20
> On Tue, Mar 25, 2025 at 05:43:30PM +0800, ziniu.wang_1@nxp.com wrote:
> > From: Luke Wang <ziniu.wang_1@nxp.com>
> >
> > For some SoCs like imx6ul(l/z) and imx7d, during system PM, usdhc will
> > totally power off, so the internal tuning status will lost. Here add
> > save/restore the tuning value for any command after system resume back
> > when re-tuning hold.
> >
> > The tipical case is for the SDIO WIFI which contain flag
> MMC_PM_KEEP_POWER,
>=20
> tipical? most like typo typical, you can run
> ./scripts/checkpatch.pl -g HEAD --strict --codespell
>=20

Yes, it's a typo. Will check the spell next time.

>=20
> > it means this device will keep power during system PM. To save power, W=
IFI
> > will switch to 1 bit mode, and switch back to 4 bit mode when resume ba=
ck.
> > According to spec, tuning command do not support in 1 bit mode. So when
> > send cmd52 to switch back to 4 bit mode, need to hold re-tuning. But th=
is
> > cmd52 still need a correct sample point, otherwise will meet command CR=
C
> > error, so need to keep the previous tuning value.
>=20
> AI tuned commit message as reference.
>=20
> "For SoCs like i.MX6UL(L/Z) and i.MX7D, USDHC powers off completely durin=
g
> system power management (PM), causing the internal tuning status to be lo=
st.
> To address this, save and restore the tuning value for any command issued
> after system resume when re-tuning is held.
>=20
> A typical case involves SDIO WiFi devices with the MMC_PM_KEEP_POWER
> flag,
> which retain power during system PM. To conserve power, WiFi switches to
> 1-bit mode and restores 4-bit mode upon resume. As per the specification,
> tuning commands are not supported in 1-bit mode. When sending CMD52 to
> restore 4-bit mode, re-tuning must be held. However, CMD52 still requires
> a correct sample point to avoid CRC errors, necessitating preservation of
> the previous tuning value."
>=20

Will update the commit message.

> >
> > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 90
> +++++++++++++++++++++++++++++-
> >  1 file changed, 88 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-
> esdhc-imx.c
> > index ff78a7c6a04c..d3ac5f38a9eb 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -81,6 +81,9 @@
> >  #define  ESDHC_TUNE_CTRL_STEP		1
> >  #define  ESDHC_TUNE_CTRL_MIN		0
> >  #define  ESDHC_TUNE_CTRL_MAX		((1 << 7) - 1)
> > +#define ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK
> 	0x7f000000
>=20
> Use GEN_MASK

OK, looks better

>=20
> > +#define ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_SHIFT	24
> > +#define ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_SHIFT	8
> >
> >  /* strobe dll register */
> >  #define ESDHC_STROBE_DLL_CTRL		0x70
> > @@ -235,6 +238,7 @@ struct esdhc_platform_data {
> >  	unsigned int tuning_step;       /* The delay cell steps in tuning
> procedure */
> >  	unsigned int tuning_start_tap;	/* The start delay cell point in tunin=
g
> procedure */
> >  	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe
> pad (read clock) */
> > +	unsigned int saved_tuning_delay_cell;	/* save the value of tuning
> delay cell */
> >  };
> >
> >  struct esdhc_soc_data {
> > @@ -1057,7 +1061,7 @@ static void esdhc_reset_tuning(struct sdhci_host
> *host)
> >  {
> >  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> >  	struct pltfm_imx_data *imx_data =3D sdhci_pltfm_priv(pltfm_host);
> > -	u32 ctrl;
> > +	u32 ctrl, tuning_ctrl;
> >  	int ret;
> >
> >  	/* Reset the tuning circuit */
> > @@ -1071,6 +1075,16 @@ static void esdhc_reset_tuning(struct
> sdhci_host *host)
> >  			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> >  		} else if (imx_data->socdata->flags &
> ESDHC_FLAG_STD_TUNING) {
> >  			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
> > +			/*
> > +			 * enable the std tuning just in case it cleared in
> > +			 * sdhc_esdhc_tuning_restore.
> > +			 */
> > +			tuning_ctrl =3D readl(host->ioaddr +
> ESDHC_TUNING_CTRL);
> > +			if (!(tuning_ctrl & ESDHC_STD_TUNING_EN)) {
> > +				tuning_ctrl |=3D ESDHC_STD_TUNING_EN;
> > +				writel(tuning_ctrl, host->ioaddr +
> ESDHC_TUNING_CTRL);
> > +			}
> > +
> >  			ctrl =3D readl(host->ioaddr +
> SDHCI_AUTO_CMD_STATUS);
> >  			ctrl &=3D ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> >  			ctrl &=3D ~ESDHC_MIX_CTRL_EXE_TUNE;
> > @@ -1149,7 +1163,8 @@ static void esdhc_prepare_tuning(struct
> sdhci_host *host, u32 val)
> >  	reg |=3D ESDHC_MIX_CTRL_EXE_TUNE |
> ESDHC_MIX_CTRL_SMPCLK_SEL |
> >  			ESDHC_MIX_CTRL_FBCLK_SEL;
> >  	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
> > -	writel(val << 8, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> > +	writel(val << ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_SHIFT,
> > +				host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
>=20
> FIELD_PREP ?

OK

>=20
> >  	dev_dbg(mmc_dev(host->mmc),
> >  		"tuning with delay 0x%x ESDHC_TUNE_CTRL_STATUS
> 0x%x\n",
> >  			val, readl(host->ioaddr +
> ESDHC_TUNE_CTRL_STATUS));
> > @@ -1569,6 +1584,58 @@ static void sdhci_esdhc_imx_hwinit(struct
> sdhci_host *host)
> >  	}
> >  }
> >
> > +static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	struct pltfm_imx_data *imx_data =3D sdhci_pltfm_priv(pltfm_host);
> > +	u32 reg;
> > +
> > +	/*
> > +	 * SD/eMMC do not need this tuning save because it will re-init
> > +	 * after system resume back.
> > +	 * Here save the tuning delay value for SDIO device since it may
> > +	 * keep power during system PM. And for usdhc, only SDR50 and
> > +	 * SDR104 mode for SDIO devide need to do tuning, and need to
> > +	 * save/restore.
> > +	 */
> > +	if ((host->timing =3D=3D MMC_TIMING_UHS_SDR50) ||
> > +			(host->timing =3D=3D MMC_TIMING_UHS_SDR104)) {
> > +		reg =3D readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> > +		reg =3D (reg &
> ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK) >>
> > +
> 	ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_SHIFT;
>=20
> FILED_GET?

OK

Thanks Frank
Luke
>=20
> Frank
>=20
> > +		imx_data->boarddata.saved_tuning_delay_cell =3D reg;
> > +	}
> > +}
> > +
> > +static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	struct pltfm_imx_data *imx_data =3D sdhci_pltfm_priv(pltfm_host);
> > +	u32 reg;
> > +
> > +	if ((host->timing =3D=3D MMC_TIMING_UHS_SDR50) ||
> > +			(host->timing =3D=3D MMC_TIMING_UHS_SDR104)) {
> > +		/*
> > +		 * restore the tuning delay value actually is a
> > +		 * manual tuning method, so clear the standard
> > +		 * tuning enable bit here. Will set back this
> > +		 * ESDHC_STD_TUNING_EN in esdhc_reset_tuning()
> > +		 * when trigger re-tuning.
> > +		 */
> > +		reg =3D readl(host->ioaddr + ESDHC_TUNING_CTRL);
> > +		reg &=3D ~ESDHC_STD_TUNING_EN;
> > +		writel(reg, host->ioaddr + ESDHC_TUNING_CTRL);
> > +
> > +		reg =3D readl(host->ioaddr + ESDHC_MIX_CTRL);
> > +		reg |=3D ESDHC_MIX_CTRL_SMPCLK_SEL |
> ESDHC_MIX_CTRL_FBCLK_SEL;
> > +		writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
> > +
> > +		writel(imx_data->boarddata.saved_tuning_delay_cell <<
> > +
> 	ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_SHIFT,
> > +				host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> > +	}
> > +}
> > +
> >  static void esdhc_cqe_enable(struct mmc_host *mmc)
> >  {
> >  	struct sdhci_host *host =3D mmc_priv(mmc);
> > @@ -1900,6 +1967,15 @@ static int sdhci_esdhc_suspend(struct device
> *dev)
> >  	if (host->tuning_mode !=3D SDHCI_TUNING_MODE_3)
> >  		mmc_retune_needed(host->mmc);
> >
> > +	/*
> > +	 * For the device need to keep power during system PM, need
> > +	 * to save the tuning delay value just in case the usdhc
> > +	 * lost power during system PM.
> > +	 */
> > +	if (mmc_card_keep_power(host->mmc) &&
> > +			(esdhc_is_usdhc(imx_data)))
> > +		sdhc_esdhc_tuning_save(host);
> > +
> >  	ret =3D sdhci_suspend_host(host);
> >  	if (ret)
> >  		return ret;
> > @@ -1916,6 +1992,8 @@ static int sdhci_esdhc_suspend(struct device
> *dev)
> >  static int sdhci_esdhc_resume(struct device *dev)
> >  {
> >  	struct sdhci_host *host =3D dev_get_drvdata(dev);
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	struct pltfm_imx_data *imx_data =3D sdhci_pltfm_priv(pltfm_host);
> >  	int ret;
> >
> >  	ret =3D pinctrl_pm_select_default_state(dev);
> > @@ -1929,6 +2007,14 @@ static int sdhci_esdhc_resume(struct device
> *dev)
> >  	if (ret)
> >  		return ret;
> >
> > +	/*
> > +	 * restore the saved tuning delay value for the device which keep
> > +	 * power during system PM.
> > +	 */
> > +	if (mmc_card_keep_power(host->mmc) &&
> > +			(esdhc_is_usdhc(imx_data)))
> > +		sdhc_esdhc_tuning_restore(host);
> > +
> >  	if (host->mmc->caps2 & MMC_CAP2_CQE)
> >  		ret =3D cqhci_resume(host->mmc);
> >
> > --
> > 2.34.1
> >
