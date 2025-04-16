Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012012.outbound.protection.outlook.com [52.101.71.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B089192B81;
	Wed, 16 Apr 2025 02:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744771366; cv=fail; b=jSOd5QJ8kBXy9ZvAoSFLvUlUy88/dm7M17blppQD3dSXAM9n79bbHIgq7RFznHg82zB9NDnn6bRTj2RrjF/2KRnc7B95ENYgdjWFrsEAbYoNo3wQ3AhzqoaykildLUzGyMaw5xh41//viNjnLkjsLTDIGhECJGWMU99qyqdEFcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744771366; c=relaxed/simple;
	bh=0Sti0r8n5rdOhv18S4CLiB24/BT/zmQ/rKxtYz9n5sE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ze4fEDFYEAWQ+faFccNSSGVBw7bkpieFuvegwZM8wn+MZ7x6kPsh4e5i2s1MBCyXR5I3/CrX30CEFyKavxmbF0fjHI3JQoNa+l9iFE8iTbYNdbuHzhWHzy3EfeTihorszh/gvz/z7HYbdt9PSAVySDQDiPAe1Io/lccPlMLJn8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BHDx+j89; arc=fail smtp.client-ip=52.101.71.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BHDx+j89"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLMXAgiOxXxmSO9bX7uBz8lAsHG0+4CH4CpPDx4Su2jcCynAakJ1MiL7yZ1EYlH6jOqjdeX/KjnMjcnTClpdPI2uqm8h7ZI/NC+oAmql96reuWm+MCBL61ACZb+twxYoAxz7dPY97sDHZz0l6QKi3IZYdLoQ0kGtyMqy15FBmKD7O4L9cVGQK2Mp5KahnFTo0hcoXxfIkQbRGfFMerA8AI07Fnccf51175RDRFEpicdgG9TI4p/Vz0mdYLeDhfx7lM4YoZf0Ojjl9T8H2NrwlG33pSo9xKqOTkSrysABHVyVAFZzGL/JD7lZG/JjwtNEJZdZajKvih8F7JLfMyT+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNGbLtmXDBOE5ky1SjPtAp53dAZVPH5fLrgwQjHC6AQ=;
 b=PxRxnfGxHcAuIIlItRZCYWTVzbyIXTaS2q3eukqZwq6jsy1G+69lBAypbNCrjj7s/r9qJwi5ovQhK05LLzMmySMX3bbFO5cDxMunj45hBQjL/UPMBGoEUNm4SRmLSWjrMjYG+Z5w66cvBDUv2kiiH+v33GwkIcvW0vY/0aL+GDvcmrVIh4qsuRwixbNdu/w0vyTz0GMYOG9b4dHloRqPjDdiGy3WGkFW8NR395lZjMNORFw6qDhyrCf+is1vSNNijiiQI4eSv2htu+1QvwEWfFcZ5fyRrHmJbumI47aiNkrAp1lV3UScG3fXqqVjc+rYMBivIbrV8ACzD7JbbswbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNGbLtmXDBOE5ky1SjPtAp53dAZVPH5fLrgwQjHC6AQ=;
 b=BHDx+j89fJUwwuKCNU+JYgMdRrD22U9LBvcpslBXiaQG86AtvGzjaR+MknW6/3LyJ2qGiepZvL7FDsM4/UP/HU3QAmx6Kh1vbTslJLxSLztGPnSCGNsbMiajsclPoY65KgAt51a69toRT5P7AMklsg6+8N/C6YkZVN+ORjVqx2D2XZ94Uk3qdXn0j5AReEmhY8hdz31bvzxqSTl7qsV4aZKFfwZzu1uXd7mDcneBpIatPFrUTiBsk/Te8oWqtx68bswc6BQmmrOm5Sd2UNQ12Py9yhhFX6/N7PGVrPvi4YQXB75tinuVxr5I8CH4NS4eJmaSyUAiVkzqw5syvs7sbg==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PA4PR04MB9440.eurprd04.prod.outlook.com (2603:10a6:102:2ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Wed, 16 Apr
 2025 02:42:41 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 02:42:41 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Bough Chen
	<haibo.chen@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Josua Mayer <josua@solid-run.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-mmc @ vger . kernel .
 org" <linux-mmc@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] [v2] mmc: esdhc-imx: convert to modern PM_OPS
Thread-Topic: [EXT] [PATCH] [v2] mmc: esdhc-imx: convert to modern PM_OPS
Thread-Index: AQHbqsAQEeWYoKBe402OH8kq6kt3qrOkEfDAgACkaYCAAOWuQA==
Date: Wed, 16 Apr 2025 02:42:41 +0000
Message-ID:
 <DU2PR04MB856710E8F6D4AED4E03C760BEDBD2@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20250411085932.1902662-1-arnd@kernel.org>
 <DU2PR04MB856729305860ED5C3C545771EDB22@DU2PR04MB8567.eurprd04.prod.outlook.com>
 <3d544dbc-863d-4ac5-9839-aef3a36881d1@app.fastmail.com>
In-Reply-To: <3d544dbc-863d-4ac5-9839-aef3a36881d1@app.fastmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|PA4PR04MB9440:EE_
x-ms-office365-filtering-correlation-id: f5c40e2e-e2b7-41a5-ed42-08dd7c905bd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RESgxcjIQ8NmVWnX0svOxcvkuT7VFEgtEY6h+Wix40wRyGUwox3k0Y/GU3mE?=
 =?us-ascii?Q?64DcyQJCCU1IYG3X8I4odHuvyBdRvqiPk2wdZ63Aik2DXxMDlLbu1Gwtm+Eq?=
 =?us-ascii?Q?BG/rs7Z3gmZxURpl06E63H9zYKsk2tElY9IvTwk+etwBSfbqT5E2cSXgNzFB?=
 =?us-ascii?Q?qP0qZDJE7aFOjylYbWcLX5SEqkgeSfbY3UPJlkC43vD2RSoPOSfgUVua3CLN?=
 =?us-ascii?Q?vv1TWtTf3Kmuohv284l1/tyy0pDDERCpcZadXtBS697GlVZ+qMGZ0hT/9Zmj?=
 =?us-ascii?Q?KSAMDoeDljzNZ2MLx3HPM6ktTRVL0udKE4utDumnrDbBkf+uam0Cl6oTRkL2?=
 =?us-ascii?Q?faB6hH0uHD5atPLYsVJN97oVD4eOuiKIZtfJlH7S1ZB23XdV+Zkj0jlvv20X?=
 =?us-ascii?Q?M5qLamuC25MSmsm5Vn+4ztebKpCY159PdXMNQQr13IgjBpea7QxZGGq6mk/E?=
 =?us-ascii?Q?j028f9E4ASXceiMbAT9pZi+sygCoQfjt2gIh4TBZAeei9eyy+KBIQTWPXfwy?=
 =?us-ascii?Q?jNEQCnmbcANH+GeAZbKGpZS0KGBxqKvjqQoK+4BMA/zKBvPZMy6PTnh1+d02?=
 =?us-ascii?Q?ayJs+/6H5QTaRj85ZDcqTaxBC2i23lbdWYMJBh2Hrq1jQx8SIzcmcyTBpTfz?=
 =?us-ascii?Q?VUFCJDU/NzcLqOHQuC2MfgrQUtUdZEF18UPQSZDNJeICMOJylbak3mFeWYLb?=
 =?us-ascii?Q?6XrTrha3Ir6FbOVd4SIvhMPbk5RQLz9CH+y2+6zMAyaizGctBfcvsJGJ1LiO?=
 =?us-ascii?Q?KIwpQa6uMkrc2kXlCbPVq43WXHykVR/U22AEvFTZUEfH5UoeNC1zNKKBu72L?=
 =?us-ascii?Q?zkeKrYIu2aDL2SYH3SfbNX2vast7Ps6zeD42ELt/R99WV3bv+F8rKmpWDWKE?=
 =?us-ascii?Q?IxPz7pE1P7M/KXdm39Dh5XGxvQ5+OEazpuNiSt3lXlTp4m3oPyxnm+TNEGI1?=
 =?us-ascii?Q?Kj8M4WrjvVi37LoP4eD8MdBmi7r+cYJegRFQt9Be++k4LKT8p1b/VGCQdXqv?=
 =?us-ascii?Q?iQXNf30yrdeEPcLrTI8vESsN2rwMQwi4Pw0p3hYcbBwBsITpizNO52ZGoThe?=
 =?us-ascii?Q?HHXWhn9Pj11mDAH7nPjJc8hwV2UzP2q1URURNQAaAq8w+mWieaqzQvtzcb1/?=
 =?us-ascii?Q?IZHVes7m1PtfSCAg/B1Ty78g+ucY/o0N9/vRKHq0qlbrOcw1csZ0sMwPjcFt?=
 =?us-ascii?Q?EyRnyoiz4SVA6b3r91Me2CaUrImcAGDWMZgmkwIzq6p+ja8bAIVTWgjBm8xR?=
 =?us-ascii?Q?ZmTNajf6QjwfpB+1XKeVo0zWgBMAmgt1ZMoFZhp1yvEY0rW1c4UT30+N0cCi?=
 =?us-ascii?Q?XoBk0+O4Tl7FT9eS7OSUsnnwp2Yfe/YQLHe8bk72SxcCWBGDmrXr1BIsVeaY?=
 =?us-ascii?Q?l4lJUFTv1+tU5oA+prxbqKb3zj04On+wVejgCMYEEv/q3kG0LRwsXks9BwMh?=
 =?us-ascii?Q?XqNchpBYTvdebrR0qaJC1R4M3RGZckfwqz0bDvlOEqpTA8PYG4bzBw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vINsDhHr//SyLLSsDf5kt5RlibbOBfpIQ1fFy3Jw445sR083ciT8b/YmAvFg?=
 =?us-ascii?Q?ZaSqR+50W3SlO5hM2OHi4qXIG8RVHnvvasKE7FA5HlyhfY85LFGR7Mkc5kp4?=
 =?us-ascii?Q?RY6/CqIyjZJe++D2UmzKp7krX4MlotEJPJqJ1ALPPq4+x4C6zw4hjf1jUdHJ?=
 =?us-ascii?Q?cSUcRv1ChPXvDTs2SBlF56Ad+l6l5bkuJ4WS1Y5PwLe8lyY4C2CKfZrjbbUj?=
 =?us-ascii?Q?GI8SwEvRhMfx8H0+iLhZDhoxFK2hxgnl3mGnInkxbIsat9eECn1v67TrBrJz?=
 =?us-ascii?Q?Qw8wczbITnKwaJC1eWryhCvUf/2lPxGoja4/2+ZeYumb9EquwzxTS+coQlTp?=
 =?us-ascii?Q?sKMYP4pv/Zz7WEC+3v0Mi8+acdFMJ5tM30rN/KTXsT3xWNYQowiWvuGl92v9?=
 =?us-ascii?Q?8a5Ausw5Zs8IZabggxXsNhEwA6myyMf53FR9XmvldYWveuIyrMC9LiNl2Jy5?=
 =?us-ascii?Q?6dvdhnCF5Xf8B4S5Dz9Tz7yDdP5ab7axDJrif7mYNV5jTXuHqPx2Apo4GRa8?=
 =?us-ascii?Q?EtB+wM3ZPu/WsuoP9vVjLGd+PtquPaflKPJUmdSVy7GyyOfQkGvurOmNt3fR?=
 =?us-ascii?Q?gVbm7Vyeqw3WvfwnUfnB5vU5k3OTenE/burQXDnHUul1bDI/jEFAWWiN40eX?=
 =?us-ascii?Q?fCtTfyYPtOOQ9ZphgxLRX3wa2CTne8xSn4GLmHpe1hoIQCkrIr6XyQZMMT0x?=
 =?us-ascii?Q?G+1sSLAANE1wuWjUuY3zj7vhtpJJpKeoDPGeYg+Sb3h5cYB1AMh/bEMMzDdt?=
 =?us-ascii?Q?KspXF++YUzTTMBwN01cxxiSWjhYlwjk4cPrtQzfDRo4nRibfOoZPB554QE+/?=
 =?us-ascii?Q?GRYWlKcTi7kLFoEY9OmTNtb3JBtAa8uDovoEivlNp+GIqenkaqq6g7BI65l4?=
 =?us-ascii?Q?DEuEBjpfktSARZQ1s+65/G9RfdQe2K7pYZvdm/qURttqrMB0TKZZUfUEvUgq?=
 =?us-ascii?Q?mWJ7384JRhbS2yiqll9b8Q45msyHCXXf+7DpPsplaFTalu/j5tHQdsLXPK13?=
 =?us-ascii?Q?V5zG0AtO6k/QnaqZi9SRZvPHrPwxhpXVJd2R006pw8QBiZ5rFzJKXcMz5D5l?=
 =?us-ascii?Q?0ZFDOizmZ6q1E6aE4byyuAAqtrvaEIcuXHcbgl6KL4WXiuUa2U1Mz9CSR+aQ?=
 =?us-ascii?Q?um3J7pB7vjOfzDft4ClFd33mFyYyqfZ72mGLWoReYIOJLBMRXc5sX7UE1r2w?=
 =?us-ascii?Q?rSKvWowxLHp2P0z/52naLpzqQCd4LjHWK2A/lapvtkcRiBZMn9fXlf2mClsy?=
 =?us-ascii?Q?2tz+lj66WuBSPmjZ5GCGIPZPSrI5xZoa9RT0HMUgijr/vnGBrmktkOWwY0BX?=
 =?us-ascii?Q?MHjNEFJelLsS+U0X5M1zpH2AZASbcsQLRCcJOk5TIGs2k/AXhaRtr09n68Cw?=
 =?us-ascii?Q?wCwk7tQVddbhHrqKfzW6iruP/UeLpFl0UwZ8iDjaaQE/GQ3YSjX7bIrE1+a1?=
 =?us-ascii?Q?rXKj9AguQuOSTvjo4CzVY/RIuMiAO4Y1XL1Cyi8VQd9zIEL0ka1v4VyEDqvV?=
 =?us-ascii?Q?TNDemxgNIabCUMfV6kGJKa+0NO6N3Pf15PcQGjW8z7U38HtJpefZxdTg55Te?=
 =?us-ascii?Q?38Tj3qpH4zoyg+aDtTPobD+UwEbIAKQOL/J3Zcf1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c40e2e-e2b7-41a5-ed42-08dd7c905bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 02:42:41.4069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7mkL/VKNs389iKERtxmcTU2y5q3lw1Gpeh8O4Baccad1K+L4lGBkTCTlqTIPn6ZrDsWRzDNrG++3tdd813UzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9440



> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Tuesday, April 15, 2025 8:57 PM
> To: Luke Wang <ziniu.wang_1@nxp.com>; Arnd Bergmann
> <arnd@kernel.org>; Bough Chen <haibo.chen@nxp.com>; Adrian Hunter
> <adrian.hunter@intel.com>; Ulf Hansson <ulf.hansson@linaro.org>; Shawn
> Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Josua Mayer <josua@solid-run.com>;
> imx@lists.linux.dev; linux-mmc @ vger . kernel . org <linux-
> mmc@vger.kernel.org>; dl-S32 <S32@nxp.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [EXT] [PATCH] [v2] mmc: esdhc-imx: convert to modern PM_OPS
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Tue, Apr 15, 2025, at 05:15, Luke Wang wrote:
> > Hi Arnd,
> >
> > This patch has compilation issue because sdhci.c still uses #ifdef
> > CONFIG_PM. Do you plan to send a new patch to fix? If not, I can send a
> > patch to fix the compilation warning.
>=20
> Can you see if the change below is sufficient? I see I have that
> in my randconfig tree and I did not see any problems with my
> v2 patch and that. I probably added that one originally because
> of some other build failure but then never sent it.
>=20

Yes, it works fine. No build warning/error with CONFIG_PM not set.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index cd0e35a80542..4ee2695b0202 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -874,12 +874,10 @@ irqreturn_t sdhci_thread_irq(int irq, void *dev_id)=
;
>  void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
>                            dma_addr_t addr, int len, unsigned int cmd);
>=20
> -#ifdef CONFIG_PM
>  int sdhci_suspend_host(struct sdhci_host *host);
>  int sdhci_resume_host(struct sdhci_host *host);
>  int sdhci_runtime_suspend_host(struct sdhci_host *host);
>  int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset);
> -#endif
>=20
>  void sdhci_cqe_enable(struct mmc_host *mmc);
>  void sdhci_cqe_disable(struct mmc_host *mmc, bool recovery);
