Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A913770825;
	Thu, 22 May 2025 04:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747889266; cv=fail; b=EL/qLP5ZsIyIO9XcNaDwOoOGGyw38JvXQQgRSjx/xkJmOWEbY1iIcDmXQOTrJo070qdmsI2oogEzFBSZh3PSUjjhB/cS4b3vx0BVg2PUeEhpw84249hZ610czic2+HJ+i+OYzRDC7oChEulWsHIFA6C4bngq2kip3+7Ws09Fszg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747889266; c=relaxed/simple;
	bh=G7HfnWggAE5ZugiYuuc89dMurhu1bS4gkkeaTiW22eM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rQZ82d3C0TiCUbCvmVf7iHdcwp7sxjpN8HsNMcjXs3ItvYOAcXoWfWt/wDR5oCnBclyWAkT9XmoTpshQWyzHb+5QgkOnTPJWJh4kcIUfc/1LR1paSkRnaE6sNw1RK2V12wZK5rbfxpAYxQPXr9hfnaz+fAMuLsjWyW0dEi1FBNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E0Csc9RY; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E0Csc9RY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVOf/8WRxaulIHiD+iJxh4jjemyN4OYyxW7x1VqDacLidTh38yEoFpIqSHs4dLN0zcMgHmlf2C+H9hVRrCDdyEa+3kEYLfTyZlqmRe7vNBCgtoJ44TlghipRWW9ooLlEGtUAaAiBx8cCv1MyLv/QOeFetDeblBFVLH58jkf/5W9dUePQCoPia/nUKW/LhXfC78iOlGzZHyOzmXXMWk+bQGbAqJ9JyDYEBngICzPXHN0++xsQMq0KmRo/XWbSaKXcXfu/0qTYQbauy308q4qGNueF0ATzVBkONPsmfm8FdvYLpmAsu7nKsZtDzcSHJgJmJ8vZHJdXXYposYa7rNJqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPyqCdBpcvHfAExHAO9nz0LR+3wyS5PU814X2A6kbxk=;
 b=dll9EzgHWWtwtbuQTzjlpJkQAksgcM3JJlrvQ3PYldx1lweSYO7tTIRHanwNuO6GdB29ogqSVNFCME5Ut6Erc8f4afD5Ku5ac7D9j+uPmxm+K8dzPjFhgcU24kuYfHtlnERk9eSx+Ei5jXG+WpRvhg0fUQWVfw6eXfdspjCmnFqgPpAzt6fBGrWxmxSCeexRuxSbrF0NOID4cSy56fozjR3QFlVHMPP6Zr/LXHHVSx1UDroPSQFEgUlgrLcE5BPeKCOjU6CRBXtrKvdNkcDMLlAzeFiFUyTnsJj6rN2v6aJMkJgibkKmvPBS9b8NcQthp8tOTJZlbx91B1fckV1RNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPyqCdBpcvHfAExHAO9nz0LR+3wyS5PU814X2A6kbxk=;
 b=E0Csc9RYHDheNOd5upM3qmDnZaGB7ipVIg+2/jCghK171G64a1Yq82IeeJE6H2ZMjx5A3s/6cqQD+G+JYe2O2LSvZ10fUucJ3L5NUjqzLel/MEV9ZtSsEMtgdUKiktBBiT8fkV+0qVYCrR8vua/RxgNS9vtPSEJpWQYSHlZ0sfh5jMY+PDxFtpY2AoNj7EiQz2csyWLhgZoZHhr2Zr8JOSbx3gXQtYxdS+saQLRMgMJz9gY9BevTg2wPd8stm8H1z7YFFwY29D9GbQ2rkUlG1LJjDCcoep3usq12Mt7yLOUr7n+hkLX9SEx5+yvhtaBnFa9uki9G3W0ZmsuDySr8tg==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DB9PR04MB8331.eurprd04.prod.outlook.com (2603:10a6:10:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 04:47:39 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%3]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 04:47:39 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, Bough Chen <haibo.chen@nxp.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, dl-S32 <S32@nxp.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] mmc: sdhci-esdhc-imx: inherit pins_100mhz from
 pins_200mhz when unconfigured
Thread-Topic: [EXT] Re: [PATCH] mmc: sdhci-esdhc-imx: inherit pins_100mhz from
 pins_200mhz when unconfigured
Thread-Index: AQHbykI0RkjEvoTaH0qVkVPeauFrZrPc9wuAgAEctPA=
Date: Thu, 22 May 2025 04:47:39 +0000
Message-ID:
 <DU2PR04MB85672AD76D82D5BB29FB5A47ED99A@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20250521112042.266111-1-ziniu.wang_1@nxp.com>
 <721420c6-5e65-48a4-81c5-b161d0df8cfd@pengutronix.de>
In-Reply-To: <721420c6-5e65-48a4-81c5-b161d0df8cfd@pengutronix.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|DB9PR04MB8331:EE_
x-ms-office365-filtering-correlation-id: 122cf2be-e353-4210-efea-08dd98ebc7f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ig5PqgFls2bcSNfum5iVODh1LtT9RHBw+pgDvDkihL4FJD4K3omsZMrrbxoO?=
 =?us-ascii?Q?qdC2oZBX+IGRaP261U/oJkVGVVS/mict9/SCMXhgTCbWsCiPCAOTT0NN8pUF?=
 =?us-ascii?Q?+9RAIRb/5YCgqwaCnAxDn/xM5Z7JKB8rlVO7y62ZJZTS74AKwFIcF/toH50k?=
 =?us-ascii?Q?/lIw2FSf3Y/6tSKDe5p+f1hGHcdynSARHVv8H+WryALVcTjC8kQT/AgHf5SW?=
 =?us-ascii?Q?T4rh6IPV4e7Urb3ZybsQQUMqmio5gtjkzTjtepCSJch7dCh5nozk2NFPk5Bg?=
 =?us-ascii?Q?Ds6mk0AErPlnbUwI7tuDwCq8aKShEKGSEEDJn8ht47V7+AOB4+c/SkRGh7Ul?=
 =?us-ascii?Q?IPndRBfCZflBYCGMYQelLpq0UVtqzZrmxs2uoKEMJZFNn5PwZLAbs8m1RTFq?=
 =?us-ascii?Q?y0mQwhVVbWf7mYhl5uj9IVxlLyfo7lIHPgzHGwPJ1oNRfcKLgVAzUnWrC8Jg?=
 =?us-ascii?Q?FjZTDVYA7wLhFgUPHztby3/dxFwlzSHZrZ/z++Q/dowk3bi1iiJqmH5zBU/s?=
 =?us-ascii?Q?S3J9aLCI1tMKxS7TrIYalWnxsKmEFxb+9rsYSURCnMb+lpJAjDLP83XiENqf?=
 =?us-ascii?Q?1dSBaU2jOjQnZ0CwUSgbzNQW84dcfAQjmb32qoE8bCdVaNDs0R+Zya/HoeRI?=
 =?us-ascii?Q?QNsbH4Vi+AxG09ca8G4aHhfzvuXGmiGXmWevZRWB5MCoqR92YWbzLxD7N7St?=
 =?us-ascii?Q?q1hh5yYInw2eBEj7y3FPkq7rR/DhZqXvtPZo7Gw7Lg0q4k7vmDhIKt5VOZJ8?=
 =?us-ascii?Q?AhVq5YDnls/wOLMh0cJWvktQ/q0Vsyx7PueukQtK+soI9DkR+GK5CmJSxabm?=
 =?us-ascii?Q?zTPI1ddMPMRCLC6KQLtwFxTRU8tOQermAIaStk/UVA3189UmugVHoqOrSY/f?=
 =?us-ascii?Q?JqQy6bcVat54fxmlH/SSFIefGngYq+ygEE/ijtpPeaMWJoe9XkZQXX/9iBus?=
 =?us-ascii?Q?Q6uRXhUeIrfBDqKs4YErXUVIbd/Yy623cIUh5qBfJ7HmyklDR1xg5ZKoKNP9?=
 =?us-ascii?Q?ODhJ+r4pcpsllVFcqbpZwNzksyxV/j15ePpaT3BKsA+HBHEIQjdimX0584I+?=
 =?us-ascii?Q?6UWwCykam28uxSuDCPCFzDcc2AOxFkN6WXatBHRm4FBQooPrriKnkG6d7DiY?=
 =?us-ascii?Q?RzAKs2TZv/V7q6GSMFaS5lf7/MfkU95t8j4L9GHyGD+UE9X9qGId7tpiaFhP?=
 =?us-ascii?Q?7EWa3S7geyf/R14ZKa+ockLSZUNk9cckw4Lhz9WJSe/I8jiHtcI4qrli09w+?=
 =?us-ascii?Q?Q7YPz+vcdiDOQECNl1U3tVHivqW2zixbQQzwTLeiTzr5S2KK1/TVvwlQMiFe?=
 =?us-ascii?Q?d2eEgBeqagM22QAh+tqrOmtILgawT4Ma5Bz4NZwnRtK6JQcp0FHo/HC9e/Cg?=
 =?us-ascii?Q?ZMSvd7czcLiSPQRI589UgKFz5zV9INzJM3nuLFKfkWHuDPhHJkyk1LqM5FB2?=
 =?us-ascii?Q?ccqz9BAEHjY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Nd4EiiLK8dy9scjt3DrU+Slku9U+1ri5mqtLquMwHfgw4qXbW55HfjqBambD?=
 =?us-ascii?Q?QTXudXsYzC5ULwHYz1I/uLeeaK99tVejpFtggwUFs9tAr5sYf7AQk94kDDXk?=
 =?us-ascii?Q?OgOZgJqAGQ1nQ+n3NuDCKrJnE6rs4CAvDlQm8uqfW2Rd3rWOq+CmSmmr3SAp?=
 =?us-ascii?Q?aqov1mOn4C/C3lnJu0KWQMjgPJIH/rhDAVFozgxoa5+FqMZwwh84/Zx08eP1?=
 =?us-ascii?Q?lwNsPSrNXLMIR0h0SEe68C9MJsEvjqZnzMicd4qIn4ePrg9yBjpL7GtQtwb1?=
 =?us-ascii?Q?Jp/VcDCYtiH41+q63VZ1dwYi0iWarynTwd/PjMu3nQRw/D9lkl9bAbdEOq/a?=
 =?us-ascii?Q?x9igECN4YhgyLyU0MP+dWiV9estsCOznZErj9O+owZglggeAwdosm0EEzdah?=
 =?us-ascii?Q?zq30iWY9pxStdZbOAJSO3LQHkMXnAj5Hl97dtpP5wac5F+BcocssQpapXhOg?=
 =?us-ascii?Q?uPfS37n0pBo+9q5QPodjMRqjZ5+MbrsiL6pkpMpkV5RBnXnhl2Gm8nKRDUCt?=
 =?us-ascii?Q?MMPouytIviWOXRw/zFnPtP9QUTPNURuwGPCP7w3j0HS27UnoguXuNB/8tnm1?=
 =?us-ascii?Q?/+ppJlxoQsRfruWNhfABmUKfG32OiBvCF6DU07vFZwzWeMkaGLcq185wnaYU?=
 =?us-ascii?Q?BHV3TTivwz1mzensEz4sakcgUkeln8rV6MEU2oQaIUll6kFwSmDx7uTxh/Do?=
 =?us-ascii?Q?xsEHo40hYKvM6WvWOoT/hN7kRKFMcS8VastgPa0DPnkU687Jda1vgMyAE8wa?=
 =?us-ascii?Q?k87gPNkVlgxjOC0UkUMHbsTwX/ins5KXtkCz8Sxx6Lt/e/LSE28972RxO45N?=
 =?us-ascii?Q?TLUF+fouAklOsP+9aDsVGIL2VA6lTl5/t37/1a3zMMoferLkcbX5khA6ax2e?=
 =?us-ascii?Q?PPfoAW+49n3T3FXQQ/+91/WTXUaH2v911zgTtH0qhqaNJ8SsOvDEzai8zjbD?=
 =?us-ascii?Q?p9dO4O6YgpVdgCATUov5wgZoBcCVr7t0ProA02pEXyNEkB/YuKqNdXxRtrEj?=
 =?us-ascii?Q?8atiGdf9pspNFA7e1kCey1SvgehKB5T6d9PfbmwemX1hT6WMFzlxz18KLRIV?=
 =?us-ascii?Q?2ozI7QZrLZ3tPRG5ysbRhlHRAUvUYXnTCsq5EnpwluKuaGHWXmAx+MaUI8kC?=
 =?us-ascii?Q?mw1f5wp/t/g5vEyxgXxGdubQIwBkCPN+O07CgE8c89vsS3np1xagG0HYrNwX?=
 =?us-ascii?Q?3kcdfqdgw+sqv0pqtbnnAq+dJcZW1spxTsqz8vBzHtvs9Y+3P2Joq4fhWqs6?=
 =?us-ascii?Q?EQgdC2pvDncZbmQ0f+Z9VG5YariLL+7Mxx8qZ8uOyxzKN+JYWifC+IR4CDbZ?=
 =?us-ascii?Q?cjtKN/lepkcHXNYw4VzNhEhapai9EgLEnUWLoXx+nZFEmDbiyASbLkRXcrUX?=
 =?us-ascii?Q?0mYkwDH2tTeQqCohPXmD+2fG23qN53J8tsAo0JSVq8HsEQc+PKS6hIdNSngi?=
 =?us-ascii?Q?n932OW4NtTBeBNJC1C54gs5xXvswyWctVPzY7UQLFBt/wV/SJWsRLwM7vD18?=
 =?us-ascii?Q?kuooUeCv02i6pTl3LQWTHu4B0YDFM+azOta0pnHVHnb24v7uewoKbWl4dwlp?=
 =?us-ascii?Q?4wW7TSy4f8mXpuSqS6R5NMLQ5f4VRoqtw4KCKLvQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 122cf2be-e353-4210-efea-08dd98ebc7f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 04:47:39.5730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ykxi0jPlsyLcWK6A9emy57hk3lIJS/6bR2Ef1M9xr64nXPesAHFun98SsepfDY7R949/Pw1c49GZSQgxpFSAdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8331



> -----Original Message-----
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Sent: Wednesday, May 21, 2025 7:45 PM
> To: Luke Wang <ziniu.wang_1@nxp.com>; Bough Chen
> <haibo.chen@nxp.com>; adrian.hunter@intel.com; ulf.hansson@linaro.org;
> linux-mmc@vger.kernel.org
> Cc: imx@lists.linux.dev; dl-S32 <S32@nxp.com>; shawnguo@kernel.org;
> s.hauer@pengutronix.de; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de; festevam@gmail.com; linux-arm-
> kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH] mmc: sdhci-esdhc-imx: inherit pins_100mhz from
> pins_200mhz when unconfigured
>
> [You don't often get email from a.fatoum@pengutronix.de. Learn why this i=
s
> important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> Hi Luke,
>
> Thanks for your patch.
>
> On 21.05.25 13:20, ziniu.wang_1@nxp.com wrote:
> > From: Luke Wang <ziniu.wang_1@nxp.com>
> >
> > On some new i.MX platforms, hardware guidelines recommend using
> identical
> > pin configurations for SDR50/DDR50 (100MHz) and SDR104/HS400
> (200MHz)
> > modes. But defining two identical pinctrl for 100MHz and 200MHz in dts
> > creates redundancy.
>
> I am not convinced this is an improvement. If 200mhz is missing, it's
> understood
> that it's not supported. Now if 100mhz is missing, it means something
> different
> depending on whether state_200mhz exists or not. This is more mental
> overhead
> than having:
>
>   pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
>   pinctrl-0 =3D <&pinctrl_usdhc1>;
>   pinctrl-1 =3D <&pinctrl_usdhc1_uhs>;
>   pinctrl-2 =3D <&pinctrl_usdhc1_uhs>;
>

Hi Ahmad,

This way looks better. Will use pinctrl_usdhc1_uhs for both state_100mhz an=
d state_200mhz if there are identical.

Thanks
Luke

> where it's directly evident that you share pinctrl states.
>
> > In this case, omit explicit 100MHz configuration,
> > driver will inherit 100MHz pinctrl from 200MHz.
> >
> > Preserves existing behavior if 100MHz is configured but 200MHz not (e.g=
,
> > imx8mp-navq.dts usdhc1 supports SDR50/DDR50 but SDR104/HS400 not).
>
> This conflicts with the binding, which doesn't allow for state_200mhz
> to exist without state_100mhz, so that would need adaptation.
>
> As noted before though, I don't think we really need to change anything
> here though.
>
> Thanks,
> Ahmad
>
> >
> > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-
> esdhc-imx.c
> > index f206b562a6e3..dfd8be5000c8 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -1810,6 +1810,9 @@ sdhci_esdhc_imx_probe_dt(struct
> platform_device *pdev,
> >                                               ESDHC_PINCTRL_STATE_100MH=
Z);
> >               imx_data->pins_200mhz =3D pinctrl_lookup_state(imx_data->=
pinctrl,
> >                                               ESDHC_PINCTRL_STATE_200MH=
Z);
> > +
> > +             if (IS_ERR_OR_NULL(imx_data->pins_100mhz))
> > +                     imx_data->pins_100mhz =3D imx_data->pins_200mhz;
> >       }
> >
> >       /* call to generic mmc_of_parse to support additional capabilitie=
s */
>
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> http://www.p/
> engutronix.de%2F&data=3D05%7C02%7Cziniu.wang_1%40nxp.com%7Cd8145bf
> 22a114de4256f08dd985ced07%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C638834247059505189%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0
> eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpb
> CIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DtXhmm%2Bd3rGbtfl2VorcnL
> OvfZ8NcVFc0EJ%2B4fTxYJns%3D&reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
