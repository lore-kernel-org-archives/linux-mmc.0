Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6807C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 12 May 2021 02:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A4D6188B
	for <linux-mmc@archiver.kernel.org>; Wed, 12 May 2021 02:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhELCZB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 22:25:01 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:46977
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229932AbhELCZB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 May 2021 22:25:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4xVDG4aCzD84bYaYBJH0yrXp5ptVK8bkRjAbveMwSPxf2O9vOnJeBCboX1j+c2cRUNM7MjFp7VzSNECYppxvHupfMhGK6zaiITPqiQ/jsV02LGTuXyAuqFOPoN4rqBdYZC+fb74xGTTQqozTpirFw/HxzAMvjdJ3DDkFtucq/6eEBgUy/xPh/CZ1JWlQoMBN/1Yb9P6Ad7mag9jU5IalIRD6DfnMaaXrz0f/AHqTssuayo1nCq01cWagR16jebUFkR0SXC07EkfBQsmccobXzKZHtpVh0wamb8uDmgm3Sa9TT0IUP4o6VtAmhHlWMVveUVijc+LcwYhKpiqXfD2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7cWTfBFjpl/2IYlOulFOiy6fM4AUXvRIt3D0N5y8cc=;
 b=JNqx6ijDsdginHRKmndu5zLUluCvPXsHFN65zzPcl2RN0Y5XhbKjLfCxtQlxmDEj21YAfeyF8DFFwBhDhllU2g2hZtW9/GQu3gGvxftAK3mhxd55zHKjSUVnL+PHctYmDNL2baVgJcDuhUff693J5MbHivDq8UgWqs5Uejb9/NvsRIvi8aJCo8qB492EeAP0O3CBo/6JAqg5wvdVVx9VAHr+pnlgJNPNCM9snb7NN8wGh9hxGaxlzSX/yd9d3wX/+ZsWQwXJ5JycMumslDG2t5N9tettjINjpWkls65pOf/C0i9j4mS65LUn1gowu6UcGC1Fjx/r5s2s6cbfavt8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7cWTfBFjpl/2IYlOulFOiy6fM4AUXvRIt3D0N5y8cc=;
 b=F+vP/1IyLwCMAufGN3o0gw++hfulLsau9DKUE9ufHEUPVmVrZQyNGOWR/Dk/cfHo4j8+Go5nn2+VcUnzf/QvtpWLVfPknpSlxYH5oURkhWuFHjZXSTvLk7DCGu5drF8AJFw+sLtKFB1vfpTiJp6EQr9lGjNGA9WwTttzSbuf3FU=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR0402MB3550.eurprd04.prod.outlook.com (2603:10a6:803:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.27; Wed, 12 May
 2021 02:23:50 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::ed5a:8f34:39b:db40]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::ed5a:8f34:39b:db40%3]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 02:23:50 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: advertise HS400 mode through
 MMC caps
Thread-Topic: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: advertise HS400 mode
 through MMC caps
Thread-Index: AQHXRc9Bnq07D6evekaifiKekikY+ardlYRwgABbZYCAAEk9gIAA5M4g
Date:   Wed, 12 May 2021 02:23:49 +0000
Message-ID: <VI1PR04MB5294B58769D6BCB2615F90DF90529@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <20210510190400.105162-1-l.stach@pengutronix.de>
 <20210510190400.105162-2-l.stach@pengutronix.de>
 <VI1PR04MB5294AF754C68D41C844083A990539@VI1PR04MB5294.eurprd04.prod.outlook.com>
 <8b7ab5139fea41caf15b398ec975ed71229dfd5d.camel@pengutronix.de>
 <2269d9ee-9ca0-a1b7-666e-8f2d9bae51d3@intel.com>
In-Reply-To: <2269d9ee-9ca0-a1b7-666e-8f2d9bae51d3@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 932882bf-8945-42ee-cc34-08d914ecfab8
x-ms-traffictypediagnostic: VI1PR0402MB3550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB35507621F4835E0A06AC07ED90529@VI1PR0402MB3550.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g+a8ETdu6yTsI/ikh/drUPdlFxzp07wIBTwhrjYjZ7kc5PyJergGLCR8znUlgdNXA/9REjDtj1q+9FmLrvTDA1H83NfnkPq5jA13GE819uzYaZynqDLlIxd/FTqYbiddINoVJM6E/n9S7X3ujUIvScgcSgckSyt30uYNh+9elR+68XVqaBN8x+HUduOV+KnR5jtlD0ynEEbh3FwpQ7LOYl1lXuiplwRP/PHtDXRR40ubwszHYXpZlKM/wauGD0qZUcALtXSb0eiQTWRR36OjNtxhHgbAHQWTlbrpuFEhdevpzr2apSWqKemOvHTWcWZjRmw3BBc5DWRUOOx8LwdDzWISAPaKz0Yt9iwpjNUIAOjD9cOH2LUcywR0CXL8j/8jjuO3KfXgyyJPREGtfzoBYlfKV0QkHjz3S/ePWwHFnGdAb8T2EM3NCuBoWQDdJ1tZRXigFcycm+nMkNbHfuZE45relSWPDOcA64XkZG2dUCG7vR3w15n7Y7UDmCB8ikYslLqFurh4itnHdu3jfxDnL5R9rt+kK9J3r64IbOlzHpg3l99xD+ci3ra3l6/MhEQvIZFsG8H0XGtcDAs0vduuI8OUdBmL1fdekDfpMcPn9CM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(6506007)(76116006)(8676002)(55016002)(53546011)(54906003)(7696005)(99936003)(4326008)(2906002)(71200400001)(66946007)(110136005)(83380400001)(186003)(26005)(33656002)(38100700002)(66446008)(66556008)(66616009)(64756008)(5660300002)(66476007)(52536014)(8936002)(122000001)(498600001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?b1k5a2RHWjF6UkhldlRMVHZiRUFVcy9ldkF4bjA2MFB3dXZtaUljNEx3aFlC?=
 =?utf-8?B?NDVnRTB1Vk9sdG14UXV5NkRkazA4S29IZytURCtCQ00vWVJmU1pGZUtMU1NP?=
 =?utf-8?B?dldOWGdhdFpBSHU5Rm9sYVJiajIwYjRuMmEzUGpiRXgzYXIxME40Z2Y0YTY1?=
 =?utf-8?B?MjhnbzhJMGxvY3hSeXd0bjAxYmFoa2h6VnlwR1gzUTlFSUJKMldkaCtSakNv?=
 =?utf-8?B?bElacEVidlNZVE05M0syVW5OOWwxenpPd1dFNEFOL1lHZGF3OVJFZkltSFpF?=
 =?utf-8?B?QzZUYUE5MzcwdGpkTkZkTEl5MFJxTXE2TFp4MEpxWHB3dE1CdnpERlU1Q2Vq?=
 =?utf-8?B?M3ZtNHFFTVFUWTU2L0tEOU1IWGtGY3VManRDaFJ3cnRqV3djWCtKdWUrcW11?=
 =?utf-8?B?L1M3QVZReWIzeE5sUHNRY21QVzRiblVXKzRLaHZZVHM2ZEg5aWlXeUsxcVhn?=
 =?utf-8?B?Qm9CM05obTYwZnhFSU13U0h1c3hZeFhGSlNWVkFDOVh0TGpSbkJOYlkyOXRU?=
 =?utf-8?B?VExBU1hsc0dWVDVaSEEyb2FUT1JuRlNvYWpXV1ZFM1J6bzcvODJCQ2Z0REIz?=
 =?utf-8?B?bFVySmFRV3RPYmFMU2RHNVlXWXdqeTFZVjRtL1gxeEdMMSt2aWM2VHh1ZWtm?=
 =?utf-8?B?dlErQ1h4TGNwbGcrR2pBOU4xNjRSQ09mR1BoQUpDSVl3UnhkT09PWFR4NnRB?=
 =?utf-8?B?WTN4U0dWSE91TjVHbHlNZGZ2eTdiWi9XeFlaME1yZHNvQUVqWWpXaWozb1kz?=
 =?utf-8?B?TUZCQm5SRTU5Qk9MTG0wOE9sdGR2dUJEdkpQRmozTjgxSVYxSXJRZEtBZ3Q2?=
 =?utf-8?B?em9XZVEvVEdJczF0b0FWdXhyOVJmZzN5U0p5akpiR1BaM1ZjY01SMklaUG1a?=
 =?utf-8?B?NHQwSkFZU3JLSHU2Vkdtb0c3KzlGYUU2ZFovTFgvcmh1aXMrdCszNkZrc1FM?=
 =?utf-8?B?eUhoZzFyNTRWc050Y0pmcjRZWVFWblpTN01RaU9XWmViWXE2aFZwVjQzU0RQ?=
 =?utf-8?B?dGdkSmludUl2TDRiOFlYS09abmszTGlmMk9QRGNiRHRlSFdodWVyTnZqN2Nl?=
 =?utf-8?B?bzNUU2ZqUVRsenU1d1dsL1daRjFNOWpMd3BzOEU1RzZGaUpWY0FWeHQ4Y21W?=
 =?utf-8?B?dWhrU3ZzMmNNQitvZDRCMDJnU1hJTk9KNEQ4YlhjN3E2YWppNURRVG5pdFVh?=
 =?utf-8?B?emNTRHJ0VkprVXlTdXNacVBYWFdPbnA1cVpZbGFwWEZkb1p0djB0OC83VHdj?=
 =?utf-8?B?WmppSlRqZmRlY1lVN3NKMldKYTYzTTZXVm54cjlOZElQOS9aNjVGbTNyU1Vs?=
 =?utf-8?B?WUpOd0hIN0l6bmwxdWxvempwaDBObFBkRjl2ajczeVFWZlFVbzBnb0NSOEtU?=
 =?utf-8?B?bzBPOEc2dHJxTHZQcDI3QmNWNk9OeERlQzJaZnZ3U2poQXduc1NmaHZ2c1VN?=
 =?utf-8?B?WGhucHdFUm91Qm1NRjR0K2owZmZ2bFBleXZzamV0MktySXZUMGl2ZVhnK01X?=
 =?utf-8?B?ZEFBMDJtMkJtM05TUHhiSGtaWnNndWhwNlRhUEx6R2VqYVBrRmRVdWQ3Vmxp?=
 =?utf-8?B?QWlPWmZKMW9yLzhYTFZGYWpKdE5GcWtQTWtEUG5CTHU4SzlTM0I5Q1VESHRz?=
 =?utf-8?B?QS9XUkJWc1ZUNVBEVFlvK0R1T3J3ZXlSUVl6N1ljNzl6WDN5V0dMZzBCQ3NU?=
 =?utf-8?B?bFhOc1VyT00vYlIwcGp1NFhmbjFja0V6VmQrUWdYYm5Hci9EVWtEQVI1NDlr?=
 =?utf-8?Q?5Td/RY6lkm10uU9crOgQTZ6V2frKbd2dwC4NiDH?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_033D_01D74718.E40885F0"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932882bf-8945-42ee-cc34-08d914ecfab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 02:23:49.8329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0mtYoHi9oWnhy2ZWf6AP2AWHrFa33MZExv8G6szOOK8wzhONwVqrO8yEUvUiwkz/q4hhVGl7eZCsSOpIjCBqjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3550
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

------=_NextPart_000_033D_01D74718.E40885F0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
> Sent: 2021=E5=B9=B45=E6=9C=8811=E6=97=A5 20:41
> To: Lucas Stach <l.stach@pengutronix.de>; Bough Chen
> <haibo.chen@nxp.com>; Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>; dl-linux-imx =
<linux-imx@nxp.com>;
> kernel@pengutronix.de; linux-mmc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: advertise HS400 mode
> through MMC caps
>=20
> On 11/05/21 11:18 am, Lucas Stach wrote:
> > Am Dienstag, dem 11.05.2021 um 03:00 +0000 schrieb Bough Chen:
> >>> -----Original Message-----
> >>> From: Lucas Stach [mailto:l.stach@pengutronix.de]
> >>> Sent: 2021=E5=B9=B45=E6=9C=8811=E6=97=A5 3:04
> >>> To: Ulf Hansson <ulf.hansson@linaro.org>; Adrian Hunter
> >>> <adrian.hunter@intel.com>; Bough Chen <haibo.chen@nxp.com>
> >>> Cc: Rob Herring <robh+dt@kernel.org>; dl-linux-imx
> >>> <linux-imx@nxp.com>; kernel@pengutronix.de;
> >>> linux-mmc@vger.kernel.org; devicetree@vger.kernel.org;
> >>> linux-arm-kernel@lists.infradead.org
> >>> Subject: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: advertise HS400 mode
> >>> through MMC caps
> >>>
> >>> Instead of having an indirection through the SDHCI layer and
> >>> emulating a capability bit, that isn't there in hardware, do the
> >>> same same thing as
> >> with
> >>> HS400_ES and advertise the support for HS400 directly through the
> >>> MMC
> >> caps.
> >>>
> >>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> >>> ---
> >>>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 +----
> >>>  1 file changed, 1 insertion(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> >>> b/drivers/mmc/host/sdhci-esdhc-imx.c
> >>> index a20459744d21..65a52586db36 100644
> >>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> >>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> >>> @@ -427,9 +427,6 @@ static u32 esdhc_readl_le(struct sdhci_host
> >>> *host, int
> >>> reg)
> >>>  					|
> >> FIELD_PREP(SDHCI_RETUNING_MODE_MASK,
> >>>  						     SDHCI_TUNING_MODE_3);
> >>>
> >>> -			if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
> >>> -				val |=3D SDHCI_SUPPORT_HS400;
> >>> -
> >>>  			/*
> >>>  			 * Do not advertise faster UHS modes if there are no
> >>>  			 * pinctrl states for 100MHz/200MHz.
> >>> @@ -1603,7 +1600,7 @@ static int sdhci_esdhc_imx_probe(struct
> >>> platform_device *pdev)
> >>>  		host->quirks |=3D SDHCI_QUIRK_BROKEN_ADMA;
> >>>
> >>>  	if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
> >>> -		host->quirks2 |=3D SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400;
> >>> +		host->mmc->caps2 |=3D MMC_CAP2_HS400;
> >>
> >> Hi Lucas,
> >>
> >> I think patch1 and patch 2 are enough to cover your requirement.
> >> For this patch, I think it's unnecessary, sdhci-esdhc-imx.c need to
> >> reuse sdhci.c as much as possible.
> >> In sdhci.c, already contain the following logic.
> >>
> >>          if (host->quirks2 & SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400
> &&
> >>              (host->caps1 & SDHCI_SUPPORT_HS400))
> >>                  mmc->caps2 |=3D MMC_CAP2_HS400;
> >>
> >> The reason why we directly use host->mmc->caps2 for HS400ES mode is
> >> that sdhci.c do not contain the similar logic.
> >
> > No, it's not enough. We call mmc_of_parse(), which clears the HS400
> > flags, before sdhci_setup_host() is called, which will then add the
> > HS400 flags again. So either I still need to evaluate the DT =
property
> > in the esdhc driver to make it return the right emulated SDHCI caps
> > bit for the HS400 case, or do it like in this patch.
> >
> > While the way it is done here is a bit of a layering violation =
between
>=20
> We see SDHCI as more of a library, not a layer, so this is OK

Okay, I see.
For this patch:
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Regards
Haibo
>=20
> > SDHCI and MMC, it still feels like the cleaner and more straight
> > forward solution.
> >
> > Regards,
> > Lucas
> >


------=_NextPart_000_033D_01D74718.E40885F0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCIF4w
ggVNMIIDNaADAgECAggS5FlmZd/gxTANBgkqhkiG9w0BAQsFADBlMSIwIAYDVQQDDBlOWFAgSW50
ZXJuYWwgUG9saWN5IENBIEcyMQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNV
BAcMCUVpbmRob3ZlbjELMAkGA1UEBhMCTkwwHhcNMTYwNDA4MDkxNTA0WhcNMjQwNDA4MDkxNTA0
WjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwFq50pGD+tAP
MI+ADpAEw4523YC7+sGhX8lxP4b2rXVs9mGLW9WEkYuf8F1vj8/K7E5ko+4rrCPhXCz/FhGjFS5+
LBCEGDSPCiVAs9tbbCAK2LNITChFBXgqt5sUyXz6s3Y/QhMSQZWeb1kuHq/HiSPFPJGa7eAqGOw3
tBXSYd+T4uUBs1BZhbmi4F31dTecrpE8xIas9+pDg6EkcPngxx/WKm83n8xByvXfd0zYi2lZZZ+N
jtKmiDJsStWjXGcfp0JBbBf1a1fTPYixgPkG/zBZkdtDCQFOZERpCdv0M4FUDNzZZqf2xf9x1jid
o9pqYGsb88RzTfua0jb5Btr0qQIDAQABo4GuMIGrMB0GA1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6
jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtp
Lm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FHMi5jcmwwHwYDVR0jBBgwFoAUeeFJAeB7
zjQ5KUMZMmVhPAbYVaswDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQAGzlH41kw4
/oQci9bjY1nKYu/LQczr5bZGuRHygo/Lrr9VkFX77oBdEbKs6YH1jMI/xJ01Rx6zPvmr7lLWqaLs
qpKu8/MQRaVmvZ7IPL75shzwh6EHQahWiB4wjPxq+o1QdW6AVmkEzK/BRBuwx5YTm7IZZt8xduop
eTYwEhocK8syYw+v6B8iosNQUsR74aT3NNXuZ3plz19wtKWN7XA9S2Lqxg1rxh1Ux9QSDKDpJk2t
RF3KLz91sH0rxEAZzOGXLvEyK0m/sbuBrrT1zOkfRtL64MiS1HANy6k4a+LmeYQDYywgs5jEYjiz
ymx3zlAkviS2nboVb9AX39gF2NnDnE3SBWIMFHgEa4Mcgk48aCzWPel0Rs6XRGYVFt/68I62WyAT
FL8nPMjjXIvmHtR3fhUSFcA8kZxzs/yksL4HSF3C5Tf2yieHsNMVWFvWNJhmFoLJh6UGGeTMpxoZ
5sMbXRjGz8j3oZQUtnS24QACmKC/nmqFDqp44pXZNsA+oBYNduaA8rDgKi8cit1WPZAeWfFY4d9C
5OQebju6MZN/4RvKBHZ+Ks+tZUZezfEw4QTR3CgJvpbOQQamVLDjQEnmx4T/Mi5EvaSlzHuW47nS
5NV1b3ErJv4iESWJHW3k14qQbuIIzEPzgpfkKhasnQ70XvQkHcz6lIa/D4McYMrECTCCBawwggOU
oAMCAQICCE5+BsxlkQBIMA0GCSqGSIb3DQEBCwUAMFoxFzAVBgNVBAMMDk5YUCBST09UIENBIEcy
MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjELMAkG
A1UEBhMCTkwwHhcNMTYwMTI5MTI0MDIzWhcNMzYwMTI0MTI0MDIzWjBaMRcwFQYDVQQDDA5OWFAg
Uk9PVCBDQSBHMjELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5k
aG92ZW4xCzAJBgNVBAYTAk5MMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAo+z+9o6n
82Bqvyeo8HsZ5Tn2RsUcMMWLvU5b1vKTNXUAI4V0YsUQRITB+QD22YPq2Km6i0DIyPdR1NbnisNp
DQmVE27srtduRpB8lvZgOODX/3hhjeTWRZ22PAII57gIvKqZCMUWvYRdYZsSKP+4Q+lEks89ys95
3tp3PI8EeUztT3qUTfs7TbgD5A9s+1zCPqI7b/XmXTrkWBmwmmqDHBijwIvzy5uE3MTBunVZFAl2
kD/jiBgdj+4O4u593Ny1c9c4If6Xvz3+DEIjdvbULrUyGIatwJdvw6FxRt5znmYKe3VyzsY7Zk/8
MsOZvzoSPBMSZBWSHj/e8fBwDEDKf6XQ0BD7Z27AWTUcddk1sphn38HHOwEpjKfOxNGX7fSXqz2J
aRtlamvSoCrd4zrH5f94hcSVFcP9nF9m3JqRzAmbGYTdzgAjKjPRVWAgaZGF8b/laK5Ai8gCEi76
7DuzMsXkvj9/BQw8fyn5xOY55zRmFo2jU8/blWy/jsAwUeEBDo4KPRAuPbSiOt8Jf8NbDOvDGPKw
EC8de76SxPi3ulhuFb0Qzxsbk39+ET3Ixy347MAZTji/a87GeIDWi+nCWHwZPQSEg0e0LVh7uRNN
b1clWILEF/bSMe3zT3rWKWDmzCiTn3+PicqvYM7cWiZi3srlCkIAeaiav9tMaAZ3XG8CAwEAAaN2
MHQwHQYDVR0OBBYEFJBIUyMqeeqEmz0+uQ7omXRAXqC2MA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0g
BAowCDAGBgRVHSAAMB8GA1UdIwQYMBaAFJBIUyMqeeqEmz0+uQ7omXRAXqC2MA4GA1UdDwEB/wQE
AwIBBjANBgkqhkiG9w0BAQsFAAOCAgEAhIKiXslbxr5W1LZDMqxPd9IepFkQ0DJP8/CNm5OqyBgf
JeKJKZMiPBNxx/UF9m6IAqJtNy98t1GPHmp/ikJ2jmqVqT0INUt79KLP7HVr3/t2SpIJbWzpx8ZQ
PG+QJV4i1kSwNfk3gUDKC3hR7+rOD+iSO5163Myz/CzzjN1+syWRVenpbizPof8iE9ckZnD9V05/
IL88alSHINotbq+o0tbNhoCHdEu7u/e7MdVIT1eHt8fub5M10Rhzg5p/rEuzr1AqiEOAGYcVvJDn
rI8mY3Mc18RLScBiVHp/Gqkf3SFiWvi//okLIQGMus1G0CVNqrwrK/6JPB9071FzZjo5S1jiV5/U
NhzLykSngcaE3+0/zKiAP2vkimfHHQ72SJk4QI0KOvRB1GGeF6UrXROwk6NPYEFixwTdVzHJ2hOm
qJx5SRXEyttNN12BT8wQOlYpUmXpaad/Ej2vnVsS5nHcYbRn2Avm/DgmsAJ/0IpNaMHiAzXZm2Cp
C0c8SGi4mWYVA7Pax+PnGXBbZ9wtKxvRrkVpiNGpuXDCWZvXEkx118x+A1SqINon8DS5tbrkfP2T
Lep7wzZgE6aFN2QxyXdHs4k7gQlTqG04Lf7oo2sHSbO5kAbU44KYw5fBtLpG7pxlyV5fr+okL70a
5SWYTPPsochDqyaHeAWghx/a4++FRjQwggX8MIID5KADAgECAgg1lzuwn2Gf8DANBgkqhkiG9w0B
AQsFADBaMRcwFQYDVQQDDA5OWFAgUk9PVCBDQSBHMjELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5Y
UCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xCzAJBgNVBAYTAk5MMB4XDTE2MDMxODEwNTIxNloX
DTI2MDMxODEwNTIxNlowZTEiMCAGA1UEAwwZTlhQIEludGVybmFsIFBvbGljeSBDQSBHMjELMAkG
A1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xCzAJBgNVBAYT
Ak5MMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEApcu/gliwg0dn1d35U0pZLMvwbNGN
1WW/15pqzBcpG/ZBq5q+ygq4/zkEqQAM3cZsSi2U2tjiKZOEfj4csyEJVZFQiwXMptsmErfk7BMo
LtaIN79vFOd1bzdjW0HaSTb9GkJ7CTcb7z/FKKiwc2j53VVNDR1xVBnUNEaB1AzQOkp6hgupCgnl
kw9X+/2+i7UCipk2JWLspg9srFaH0vwrgMFxEfs41y6iBVD70R/4+suoatXvgFv3ltGZ3x/hak3N
1hHkjJq3oa1jSkLmp6KoQAqbcHTkeKomMOmPUJK1YqDkpdbGuuRkYU3IvCW5OZgldrkigcOTaMNU
aeZUAv8P3TTtqN4jIp/Hls/26VR+CqdoAtmzypBEyvOFDtzqPqVzFXfkUl2HZ0JGTYEXUEfnI0sU
JCyLpcLO1DjnwEp8A+ueolYIpLASupGzGMGZ5I5Ou1RoF2buesEgwb+WV7HRNAXTmezUh3rWLm4f
AoUwv1lysICOfGGJQ2VkNe5OXzObvzjl30FYdDWb6F+xIDyG0Awxft4cXZcpFOGR3FH4ZZ5OH+UN
l1IxnNwVpGSqmzEU7xnoTXlyVH3Q/jYDG27HSoILQp/yRMJXWx/Xn57ZVXNm63YrZ35XsX91pMHD
RoQdJBMKkya813dggmhEszSIBYKqoiFt1HaMK/KnPwSSLO8CAwEAAaOBujCBtzAdBgNVHQ4EFgQU
eeFJAeB7zjQ5KUMZMmVhPAbYVaswEgYDVR0TAQH/BAgwBgEB/wIBATAUBgNVHSABAf8ECjAIMAYG
BFUdIAAwOwYDVR0fBDQwMjAwoC6gLIYqaHR0cDovL253dy5wa2kubnhwLmNvbS9jcmwvTlhQUm9v
dENBRzIuY3JsMB8GA1UdIwQYMBaAFJBIUyMqeeqEmz0+uQ7omXRAXqC2MA4GA1UdDwEB/wQEAwIB
BjANBgkqhkiG9w0BAQsFAAOCAgEAh6/N13Geu64yCb21EO8YEFm8MnFrkIkQA8sJKgdZsQIRuj7e
KzabqQ/7dwbR/6AMs/oMRixASz9qix9JDLxoU4+HAsipFuhJFMZT/VNThmKmlNLPML90p8oWw9wa
0jR6OAafhRgm/ICxzBkHbZj/QN8GXUPPbcrviY32+nXQ2MmQ9VxWlWArNPHQycazfsbj7/r5nz/N
JKg707i07Xmm7CU58fAWzvuVo842jiXINqOk7Oq3y90L7aSHZrpRC1k4n+gv+dHmW58mhxk8Imba
Uf6GJZANDNrufwC8/2skvmq9PSUXO5atGld6/CCG2Ej1vlsoJoO5v3ElDCRTMj1hMVvyKmyL9eib
tehGz2kDM1LEW62CYsL/Z7leqJIQBrrXbcNKSEOzwpLXKKAGoCuBFGj7sGHypZkGpmhfIHi18+ON
FpgibCxlbYgEQDJRZX+czbjPj70syjnnS0CXptCF9FIWWmoNBy1MNwoYVXzMQMwVHgKvSsVmshpz
wNAGWQ5scOhMX1ajVrjzK4SBSS+2jBrnoDvjV1fCuSyP2Zp0ZNoc2YUhm6QoP3QKeb5bt/NGS+dm
7F3iZENHD9x+RWehGU1ZxTp0QgirGyUZsDDJfht7AkLAhtxYtCW3r6bmGwzubm463fYnelwDHtvX
fFLchYKl4EQOI4GbGSDnSKTVCdEwggdqMIIGUqADAgECAhMtAAC+69VX9gixtDt/AAAAAL7rMA0G
CSqGSIb3DQEBCwUAMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJ
VDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQt
QnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmS
JomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwwHhcNMTkxMDMxMDEyNzM2WhcNMjExMDMwMDEyNzM2
WjCBmjETMBEGCgmSJomT8ixkARkWA2NvbTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT
8ixkARkWA3diaTEMMAoGA1UECxMDTlhQMQswCQYDVQQLEwJDTjEWMBQGA1UECxMNTWFuYWdlZCBV
c2VyczETMBEGA1UECxMKRGV2ZWxvcGVyczERMA8GA1UEAxMIbnhhMTI5MzcwggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQC5Fs2nsaFqYnhLqrOb1eg4KkvzdU5iYj5YPHLrYNLQAiPoLHYg
Eq55ndyFExyVHuaKeFASgGgf/lquXabym0KaHwZGTQoGHfHd2A3Hi6Yf246V1SUR2gxB8iB5o+9G
wFbVFAsTkPeVeGsNMMBFfVu68PGszY0azrROLz+Y11CZ6rtin2hs91uP57OMg6ovaOeGcLm9iKt+
KnGbIcdKb3eQYbHvDPPnq9mglU/H6VKPQodNTZ2D2H23aHjziXKpZN8+/n3St+XPP571V4GJFD6u
rlBvmC9UotMDAI1I9C88LuuDzNdXTu+25bmORqBv/ARu1EdT9KBxpUoT5V1WpenxAgMBAAGjggOJ
MIIDhTA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiFgsB+gY70VYbthTiC65lLmpJWP4Of3RqF
qL5FAgFkAgE2MB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjAOBgNVHQ8BAf8EBAMCB4Aw
DAYDVR0TAQH/BAIwADAnBgkrBgEEAYI3FQoEGjAYMAoGCCsGAQUFBwMEMAoGCCsGAQUFBwMCMB0G
A1UdDgQWBBRpVCNcf3T46yO3gIgMS+MnJjiCazAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6
jhedBzCCAUYGA1UdHwSCAT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRl
cnByaXNlJTIwQ0ElMjA1LENOPW5sYW1zcGtpMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIw
U2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNv
bT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0
aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Js
hi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsG
AQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2Ul
MjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENO
PUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29i
amVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cu
cGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDBBBgNVHREEOjA4oCIGCisG
AQQBgjcUAgOgFAwSaGFpYm8uY2hlbkBueHAuY29tgRJoYWliby5jaGVuQG54cC5jb20wDQYJKoZI
hvcNAQELBQADggEBAAbO3KB4UPjzcz8dqs00dc1WxVm1GGcg29yJnKejuwv95IGs8TmqHcXZ3zot
7J4cDniEn2Pdvjfw3tVoykkz7vT/JkS5QfOgUeQX7GAKMe2AT17e9VskzipZ+37vsDPfW1XPVRn4
WMgJUHLRad79yO/ojeTPavpUFtAY3wlI4B8dT7du7ibI4Zokemv0PvTpanmUY+V+EjibmoXDTbXm
VJEG965sDuYYeh40QeE5siWSSoDA0yHxRb0TvMBbbkR406oUSSIEZyR4a6iGRgsXral8LULemoOx
N6HCSMmhyGdWXJOMFhbLkPEZQkOXpUCdzwJnG8X3hPnlRNp1qEeIXoQwggfrMIIG06ADAgECAhMt
AAC+6uSCGwwZxWD/AAAAAL7qMA0GCSqGSIb3DQEBCwUAMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJw
cmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRo
b3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmS
JomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwwHhcNMTkxMDMx
MDEyNzM1WhcNMjExMDMwMDEyNzM1WjCBmjETMBEGCgmSJomT8ixkARkWA2NvbTETMBEGCgmSJomT
8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA3diaTEMMAoGA1UECxMDTlhQMQswCQYDVQQLEwJD
TjEWMBQGA1UECxMNTWFuYWdlZCBVc2VyczETMBEGA1UECxMKRGV2ZWxvcGVyczERMA8GA1UEAxMI
bnhhMTI5MzcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDE9+2XERF+z26pPnpECTBk
Qd8RJomqRzsIUDwr4pXlYguj7693YrAllPcn16SP/HlCQLOV73S/EQlQ22fHiv8Op3odseIduNQt
qSaD65NFnj1wOvsidBPwP6GeSk4ZE4lWZYVAE/UT8bT6dDNgM3NDoCEPRSNnJwsp4qGlyFYpl1wa
JuNyF/crQt8c0HZ7IZmcpMSdywmmWhYQOjDg+GzDdHfFSK1EmFf15IgYh/S0iKjwZXcohqRSFh4/
Y9O+PqQ8tRuuIh/nZMK9E8tT/WIFd2kWe2dR1TbcyTpXEPrCNZiYj5LV6dPVJuQsCWwy6evTzLkU
rqcPsCky/loDLZ7NAgMBAAGjggQKMIIEBjA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiFgsB+
gY70VYbthTiC65lLmpJWP4Xmim6EteF+AgFkAgE6MBMGA1UdJQQMMAoGCCsGAQUFBwMEMA4GA1Ud
DwEB/wQEAwIFIDAMBgNVHRMBAf8EAjAAMBsGCSsGAQQBgjcVCgQOMAwwCgYIKwYBBQUHAwQwgZQG
CSqGSIb3DQEJDwSBhjCBgzALBglghkgBZQMEASowCwYJYIZIAWUDBAEtMAsGCWCGSAFlAwQBFjAL
BglghkgBZQMEARkwCwYJYIZIAWUDBAECMAsGCWCGSAFlAwQBBTAKBggqhkiG9w0DBzAHBgUrDgMC
BzAOBggqhkiG9w0DAgICAIAwDgYIKoZIhvcNAwQCAgIAMB0GA1UdDgQWBBTlL+2gnauehNbF4Mck
cbLTqj/vJTAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSCAT0wggE5
MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPW5s
YW1zcGtpMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMs
Q049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRp
b25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6Ly9ud3cu
cGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBraS5ueHAu
Y29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCBuwYIKwYB
BQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlBLENOPVB1
YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2Jp
LERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRp
b25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2VydHMvTlhQ
LUVudGVycHJpc2UtQ0E1LmNydDBBBgNVHREEOjA4oCIGCisGAQQBgjcUAgOgFAwSaGFpYm8uY2hl
bkBueHAuY29tgRJoYWliby5jaGVuQG54cC5jb20wDQYJKoZIhvcNAQELBQADggEBAHNaESyBZSXf
2VjPBOZH2PR/VsyRkmOCEkPU1uxvKTFAYPwmzTsnlPgU4OK9G3DLFpZhrUFfoz2G5Z9lHxrOftqX
lCk7OQpEtEom0dbQN/ZCAmsMIfweppoH+zVGjO45OVI1W+qlQcNhdSV5sylHjD5Gg1GF/DOL4koc
vFlMhaX/MQ7vNrRO6KI7vTl5mcObxpfWVdPT3D8RgKml2n8xTLi7jiIII8rgWexZYlx3ukUBWRJb
ZgDGZ+bOPl0EK26M1ELLUTT/uAxPifKlj1Ls37bW+h3GhgsiW+lZVN7qZWar54TIpAogfVOIaip3
BeirywBeJLBrgkFfD8yA9JvyFNQxggTDMIIEvwIBATCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVy
cHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5k
aG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJ
kiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhMtAAC+69VX
9gixtDt/AAAAAL7rMA0GCWCGSAFlAwQCAQUAoIICxTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMTA1MTIwMjIzNDZaMC8GCSqGSIb3DQEJBDEiBCAHYEH4bENO0pKy
lCtkEcJBnaX95L98J4h56eSaV8Tu6DCBkwYJKoZIhvcNAQkPMYGFMIGCMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3DQMCAgIAgDANBggq
hkiG9w0DAgIBQDALBglghkgBZQMEAgEwCwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjAHBgUrDgMC
GjCB3wYJKwYBBAGCNxAEMYHRMIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQsw
CQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UE
CAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254
cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0AAL7q5IIbDBnFYP8AAAAAvuow
geEGCyqGSIb3DQEJEAILMYHRoIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQsw
CQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UE
CAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254
cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0AAL7q5IIbDBnFYP8AAAAAvuow
DQYJKoZIhvcNAQEBBQAEggEAJvbzMhiGxOFfrgLHeyehFcAz3FJUE0i8PQ88kpC6wjnkN93ZsWkk
QTdsCUb3JW+T7UwkVSR+s90S5GZIszHxurrlRBut7/Uh3pag+BAPf2ZCN12p0dXwjxyLg0aSqiOj
mQSfr5a4lmkLFjPDZVRx8C7aUAbYw+EV1Nc6X04G+hBwze1GTjlI9nlbU4E8wWSjQrgk4LaGM2Wu
aRCC51GSLsbCXwb64Xt5+uVj0ZHcuJ31pqu2+y0AIO6JLL41uiyzqKdif6Ylt5aEXBPEnsoKs1su
+GWHu1coiS7HaLPnytORpWXMp2HOGyA3SxKPWjr8/OVCZ6efvjlTeHcgQ2Hm/AAAAAAAAA==

------=_NextPart_000_033D_01D74718.E40885F0--
