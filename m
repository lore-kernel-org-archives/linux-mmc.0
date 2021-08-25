Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06468C4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 02:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D775A61371
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 02:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbhHYCRT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:17:19 -0400
Received: from mail-db8eur05on2050.outbound.protection.outlook.com ([40.107.20.50]:39597
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230388AbhHYCRT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Aug 2021 22:17:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TERLrGSpHYLMlflSXVo4+9p5oI1Sz5K0vqX4mhfwW7tB/w6eWHlpRQdsLrPWJ3sY7at8euRX0FStKL+80RVIrSu954udzE2HtjAPzcsBONSuR74Jvb8Qku/oVAPWugRfcv5s21Fsls5kFSuucxZp1aoF623D56OS4y9oxjfy4tfqzUjEISoj2J8B40bCoyaxYkZxtBJU5yx30AL5EjxqQSwmyau69rNXWE+rSaZSGN0cy2kxJApGvR9P9Bv2swgHiz4fPuKBtzEMqKUGjQA25ZzOq3Ri6I9+2rWZASCSTUh4pSqbzhY/lamEG4Q1HXhA7Db+aME0bM7/6b1bYT8HMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez6xtNyZJ9yMTSujYB/jkZP4p4AeZTDrEzAfMVEsOww=;
 b=atso+/oMaCroYHA2P1jgEyXR3Uk05dV8y0kVeogrgM1PAeyoj19HPyi98Qnm/7T9+KTp/KTMOhocrlBnfpncU78mHjNcKU2irlOZAF7NksGnhpoXYpIbgCgfVzu2nd17nDg8kN1RG7O7toYdtFJ386qg4PUz+N8OjkWpVlb2+u/HlGFkoIyG+lafVB6GjQnPtFKgGTihPfZWzgyRgJzwn+JHUdYSGvkCaRAyIPq4oen3J+KM51ycjWrqqx50fGxVMT535I0sJ7VALWzjlimdGBPKMMneKROu43Dl8VEAajQDVrXP5rK6iA/6UFgm/TSwDyrMx6Gt+bxRTCpicn1N6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez6xtNyZJ9yMTSujYB/jkZP4p4AeZTDrEzAfMVEsOww=;
 b=UCAZgo6z1+vr9JVGrxyDgCHzFgW5Ywensi8+2TwmWy1dtqJ7oXn6OMLXOxbW9YplcEvBvWR+N5kzBDoSY6NXFe1yUV/aUBnoDPpTQmHa+lhHfwfEocHPKHHBojKCDtYtUeQjII1hILG6M/792pJ2qjhpQOHWHdS+O1QfSmFsxrw=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (20.177.50.150) by
 VE1PR04MB7408.eurprd04.prod.outlook.com (20.181.180.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Wed, 25 Aug 2021 02:16:32 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::c59c:3e45:7b94:e5b7]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::c59c:3e45:7b94:e5b7%7]) with mapi id 15.20.4436.025; Wed, 25 Aug 2021
 02:16:32 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/6] mmc: sdhci-esdhc-imx: remove redundant code for
 manual tuning
Thread-Topic: [PATCH 1/6] mmc: sdhci-esdhc-imx: remove redundant code for
 manual tuning
Thread-Index: AQHXkp6sAqOLd2JqjkWodZ0zrMhFF6uCuVWAgADO5QA=
Date:   Wed, 25 Aug 2021 02:16:32 +0000
Message-ID: <VI1PR04MB5294D4EE6173C4897ABF496090C69@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com>
 <CAPDyKFr2z6t0uefxioLHaszvwrc9Pkf1OJDi=jozjpEZcKP5ng@mail.gmail.com>
In-Reply-To: <CAPDyKFr2z6t0uefxioLHaszvwrc9Pkf1OJDi=jozjpEZcKP5ng@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5221c89b-d555-49e5-48f4-08d9676e5b36
x-ms-traffictypediagnostic: VE1PR04MB7408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB7408E87E8830ED7326503D3D90C69@VE1PR04MB7408.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fr+PzmXjS0IPqo7XaMacN4ajyw/9BgfPElpkcPaqBE9/KxIBA7r7Rf+zv5lhX+liJfHhOQeLey0zhV2gSG3Ziu9rsGYhi+WymBvYhcwle6Jyn/hFUqG6qwOIDG9NtIHpvN+Kv+QWx7X3SWaK+3/NbDmx3Osghz+heZWDRtww2CY/Wk77fivTyZKhiLYqVKUGcJ7WxsqzXLKzMY8ZTW+7a4ec5HpggUdBzelslX1V0PIn3Dcve4W2PftTUmHtizLDhCQUIghlgRMiuP2yRNkGzM5yFuX086OejvsnAUQ9+HOj6/ubCla1fCtc0VPIr9nWuN58WHopy7qAIUk+HzaEa/9d5kkhDbkjqQ0/VDJWnetT4+8pMX3zGsm+DHYT7ZO2viLvKOhnFzZggXMvGukz078VVKaJsm1NYmzeRhN34LPdICL5gugheJHITYPDNnZvUDT59GyPdhB5JxTwaGGLtYE69qahJPZtHdr9mxpOeaRzQG+B1K03LFX9tW5Nym5SFzrEd6vxfXoDLF94baPb5enQnImLye+fnINo/zYgT9n/7N62hKzBbTX4RK/u1CmXJD8uw9qZdLPnU4oi5r+4XT5v5zQ/LKAcG5g6wXUqe4iR1Yvz3BxBy2K3sJpbRQKWTDQRprlgsSqpB1PKq8o53riNjEJrX195qZ9ezoW5GeALLC1CY21HXBjN53wzj/mHQeMkKGIApACQB/C6mxwblA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(52536014)(38070700005)(478600001)(55016002)(66446008)(86362001)(8936002)(4326008)(71200400001)(64756008)(122000001)(5660300002)(38100700002)(33656002)(7696005)(66556008)(7416002)(316002)(186003)(99936003)(8676002)(66946007)(54906003)(26005)(2906002)(6916009)(66616009)(66476007)(83380400001)(9686003)(53546011)(76116006)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVo3TU16dlIyc1k0cllFbS9IRFl5cFR4Uk43WWtRYUJHZDdmMkE5SWZTNDhs?=
 =?utf-8?B?bkpUV2pDQ1cza29EUDN1TUJtTkw2M3pkRWpEUGZ2TUZjbENQZWhXc1hNWHRs?=
 =?utf-8?B?N1FIajU1V096a1RUTU1WY3hpeThTck1jc2x1bWhtcHpaaVc0ZDFqOCtIbDNa?=
 =?utf-8?B?MEN6RG4vY3htSjFsdEFiai9YZ2hQM0UwVVJNMVhNK0VJbnVod1BtTllab3pV?=
 =?utf-8?B?d1FMazhOWjRYVXAyNnA1SGlkRzhoeEZ6UUlSa2NDSGdSNUk1UjlGUUtXalB1?=
 =?utf-8?B?aHBsNmtVQ3MxY0NndEkvWnpXemVXZXo5UFI1RGJPMGVLZ3djWCtKb2dDdUJz?=
 =?utf-8?B?NGNLK0Zlc2J4QnZQOEEzM2FOZ2NtSDRsaEhTZ0FpUzg4SHJRNy9ZOXpSL0Fs?=
 =?utf-8?B?aGJaTFJHQlIwTGVMK3JrUlNiS1ByVzJzNWF5SzN1b2E1NnNsRWFZTXBCbE8r?=
 =?utf-8?B?NzFvbzFYS2JRZ2pIVzV4aXNYVnZ0WktCdUdPdEJVZ3VaZ2NXZUJlQzBBbmlQ?=
 =?utf-8?B?UENXTm56aHFGVTY5SHBLRk05T0VLUkQ3VURENGhrLzJjMUd0VFFEdFFLdDhY?=
 =?utf-8?B?Ykx1alBaVitzV2VodVdpbmpzamxaVFB2LzB5alRvODllSDFzbU5MM1JKM0VJ?=
 =?utf-8?B?MTRVc2ppbzFVTWxEbkJLSkFDeEowQXlUWU4rVDhhMm1mc1pITVBmTkh1cE9Z?=
 =?utf-8?B?UE5JZjBRL2RCMmJJejh6SjVaaGk0UFg1N2hVWG9sVmFIWGIwR1E5cEY0NXR3?=
 =?utf-8?B?cEhXSkRCZ3VjVURXa294T21KL3BER1Bwd3QwTk9sc3QwMXhVWGl5ZWhhRWdN?=
 =?utf-8?B?eGc4RFViOFpJK0tDeHpyY1BWdmRnZ2pBS2kvenc1NUdLZk5yRnd4ZGw1QWZh?=
 =?utf-8?B?SU05NXFKM2ZNT2liRVpJRklmTlBIT2RLT21MQkhPVm9zS01yWnhob0k0MEdM?=
 =?utf-8?B?UTA3cnB5Nk9RR0hNTi82ZzBlTlQrbGFSZndKZUZEamVFUnVHRmc0MWdhNEpI?=
 =?utf-8?B?bHVaNHBqTzhseGZyQmpLMFRGMzZ0QUhhbmVXbElacWhDb0NmT1p1ME1PeWxv?=
 =?utf-8?B?ZHludzZVazV4b21EN0VDOHMvUCtwcW5SN0I2MlJKNzhIYTE3RUJZMEhvMFNZ?=
 =?utf-8?B?M2U5bUliVVFKODVaaGNlNXZ2anVPL3NxdCsya21LRllRSnVzeHlGWExLTTA5?=
 =?utf-8?B?QVZ2c255NmtlVTFzT25zeXAzTzFDaG5DYjFyR2pmRGQxdldaNldReSt1cXNk?=
 =?utf-8?B?YkpDK0tGOG5zVDRhSGRvVHNVMlFMb3pnWDRuR2gxM1ZGR0NnK0thQXlWOHho?=
 =?utf-8?B?RGJqRzZYTWx5VzIxTk40RzdBaFJ4bWkwRVdBVWV0YklybTlFZ21iOVh5M3pG?=
 =?utf-8?B?RWFtaVNRajNtZ1NpZlFhMlNmMXFBMXliWHhlUVhOS0VDY25sd29EenNrTkxz?=
 =?utf-8?B?N3FKa2xrVlZrUkJBNUxPT2s0YTR6SG9obWZRUnJxWlJMVHd6bys0ZGFDNDZs?=
 =?utf-8?B?VHNybGxvUmlaTHhZSWFaNGs2SHRNUVlmYWhWbi9mMkZublRZWUliVVBTM0Ey?=
 =?utf-8?B?WGZ5eGtvejlHcTF5cll2RS9aUlVBK2VXL08xSGNja3BVVk9vTXNiaEJYQ0hZ?=
 =?utf-8?B?RnIzSUprMGdaMzZhQWIxWWE0MEV6V2wxN0RVbXI4WklRUEEwMVkwTHZ6eXBx?=
 =?utf-8?B?ZllrT21qbGVWbGpnUUNWZGVzYjFPc0d4NkoyYnB3SGFybXpyMUVIV1VJcEI4?=
 =?utf-8?Q?T7O/T0MT/Wg6ZvnrPNf+bLzQ4MK4ps+e/E4WlsN?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_02FA_01D7999A.447F0F70"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5221c89b-d555-49e5-48f4-08d9676e5b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 02:16:32.2904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eG9eQxeY4gFXT3kUb2lnLH4S5DiFWEpkR0qeYW6khyo9t+QrxrkZEDHy+9pmT0vxFtf9LVaSAyD8sfNsnyqMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7408
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

------=_NextPart_000_02FA_01D7999A.447F0F70
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: 2021=E5=B9=B48=E6=9C=8824=E6=97=A5 21:53
> To: Bough Chen <haibo.chen@nxp.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>; Shawn Guo
> <shawnguo@kernel.org>; Rob Herring <robh+dt@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> Estevam <festevam@gmail.com>; linux-mmc <linux-mmc@vger.kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>; DTML <devicetree@vger.kernel.org>; =
Linux
> ARM <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [PATCH 1/6] mmc: sdhci-esdhc-imx: remove redundant code =
for
> manual tuning
>=20
> On Mon, 16 Aug 2021 at 15:00, <haibo.chen@nxp.com> wrote:
> >
> > From: Haibo Chen <haibo.chen@nxp.com>
> >
> > For manual tuning method, already call esdhc_prepare_tuning() config
> > the necessary registers, so remove the redundant code in
> > esdhc_writew_le() for SDHCI_HOST_CONTROL2.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>=20
> While discussions on the DT binding, etc, continue with Lucas and Rob =
on patch
> 3 - do you want me to apply patch1 and patch2?

Yes, thanks!
Let's wait comments for patch 3.

Best Regards
Haibo Chen

>=20
> Kind regards
> Uffe
>=20
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 57b19ca1ad6d..a49fac719fca 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -628,17 +628,7 @@ static void esdhc_writew_le(struct sdhci_host
> *host, u16 val, int reg)
> >                 else
> >                         new_val &=3D
> ~ESDHC_VENDOR_SPEC_VSELECT;
> >                 writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
> > -               if (imx_data->socdata->flags &
> ESDHC_FLAG_MAN_TUNING) {
> > -                       new_val =3D readl(host->ioaddr +
> ESDHC_MIX_CTRL);
> > -                       if (val & SDHCI_CTRL_TUNED_CLK) {
> > -                               new_val |=3D
> ESDHC_MIX_CTRL_SMPCLK_SEL;
> > -                               new_val |=3D
> ESDHC_MIX_CTRL_AUTO_TUNE_EN;
> > -                       } else {
> > -                               new_val &=3D
> ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> > -                               new_val &=3D
> ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
> > -                       }
> > -                       writel(new_val , host->ioaddr +
> ESDHC_MIX_CTRL);
> > -               } else if (imx_data->socdata->flags &
> ESDHC_FLAG_STD_TUNING) {
> > +               if (imx_data->socdata->flags &
> ESDHC_FLAG_STD_TUNING)
> > + {
> >                         u32 v =3D readl(host->ioaddr +
> SDHCI_AUTO_CMD_STATUS);
> >                         u32 m =3D readl(host->ioaddr +
> ESDHC_MIX_CTRL);
> >                         if (val & SDHCI_CTRL_TUNED_CLK) {
> > --
> > 2.17.1
> >

------=_NextPart_000_02FA_01D7999A.447F0F70
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
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
MBwGCSqGSIb3DQEJBTEPFw0yMTA4MjUwMjE2MjhaMC8GCSqGSIb3DQEJBDEiBCDJdJBX8Yxp9FZr
n/Sy7aj55qZHtq0M2PmdRIt084qw6DCBkwYJKoZIhvcNAQkPMYGFMIGCMAsGCWCGSAFlAwQBKjAL
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
DQYJKoZIhvcNAQEBBQAEggEAdT6Zb9tVJTrsu9OlcTmJmS1FhiedU4lJTiUsjp4ExskLZJn3gDBV
9muqQ8Z8UI8xNQUs/LzOx3A0xRiYDRk6vekACG0XmnmA+zHa3BIfxOCi17dkQliCkk/RyQnAR9wV
SiEFnPrCFjLCCVzYGv7Ok/AUrWLYu+VRmheOr5mT4+BzmeQi52/+kLeNK4ndoN5wBvxO0Vm+IprG
00dBVHzD0HLBklK24JLqubVZCJQBxhAufuiZS4VV8x4ql4b55Cc8jlSxPVHEGbKMSObLVv21uuWF
JKuDdzhMe25V3/Yp/3QUeZ+lbcmhaWGISeUThmFjCMzsTL87LmFDZJDmKhlwnQAAAAAAAA==

------=_NextPart_000_02FA_01D7999A.447F0F70--
