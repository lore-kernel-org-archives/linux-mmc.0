Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CCCC433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 03:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8501061448
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 03:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhEKDBt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 May 2021 23:01:49 -0400
Received: from mail-eopbgr30041.outbound.protection.outlook.com ([40.107.3.41]:38628
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229637AbhEKDBt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 May 2021 23:01:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuAPo2GNBLa4h0mGvuvrN4FVC5w7+JAzDRDpGjLMHeU+98ZfXSx7phITp3acu/8rjhj9vWexCot1G9oRcL4Lqtd5rMesc3/B48Mil4qEdGfpfbG8IlzdQ8qWp00J6vsEzi8EiBKUA7GYaV1JrsC2aNY755AeVaT2An7BiJ7efEDfEzcnkRJ45vq5iBSnxCJVQTpEWygnCJBMgiyaB8kq67xnUPgp3lHWMvnqdlDHxwjmALAFtPdDX2LVu8ABLDGV5+mOkQmZWniWn59dXyiXMK5owabdfxDt2ZRkcQ+sjGWKlRODrsLfAxWrwtIJx/bzcBnmejmpJWpj2MLrNn3kow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MUwygWd4E8k04RXERKW3f9Wh/STYcwi3wk1H7jRgk0=;
 b=mC1+XXQ2muWO9/Vq5K17li6zvju4NjSrUI6DNN6AevkHer7m4l3GTIeMaXTU0whHzD9V7JBeNvHLSFBIsDjk7wmx0om3C6qKEfBkUcXUxUSWNlw65/qi/6hhK4JSEkl8QaObspBkWqzJGOrfPtSxP+KI2XE9Qb5Ak6HyV3rM7YOEGnzDBOYBFZdxuMgJPi8hTlfpW8eGCw6tkPnTHmzdzGt6A397O7ITyPDvzj3P1arRlPr/sjYaoO4ABkqadfA9pDnIhukvxzu6unEL+wKXcIENPqXwl0pccuq2Xt90LgAaC5P6B4P1lDFysQAnaxLGfKVyUbniww8BuL3hrB1ZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MUwygWd4E8k04RXERKW3f9Wh/STYcwi3wk1H7jRgk0=;
 b=U9J2nTZ0JddP2s8fphBgV+7cp5XbH1dxfiChAVsdt8bXfFPYR2q7TCacJShgwZTAM+Ye9awxOTDg1XSulPWVVYLnL0XNVh+eTYJLYx/0b1KGXxe1zgSWYnno8euCyTJ7ksQzVNJRtJwAY9luc1N+ur55pSEg0nE8jcs3Ja8nOeY=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR04MB5854.eurprd04.prod.outlook.com (2603:10a6:803:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 03:00:40 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::ed5a:8f34:39b:db40]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::ed5a:8f34:39b:db40%3]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 03:00:40 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
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
Thread-Index: AQHXRc9Bnq07D6evekaifiKekikY+ardlYRw
Date:   Tue, 11 May 2021 03:00:40 +0000
Message-ID: <VI1PR04MB5294AF754C68D41C844083A990539@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <20210510190400.105162-1-l.stach@pengutronix.de>
 <20210510190400.105162-2-l.stach@pengutronix.de>
In-Reply-To: <20210510190400.105162-2-l.stach@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db936da3-ea10-4a2c-d672-08d91428f5da
x-ms-traffictypediagnostic: VI1PR04MB5854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB58541F00426E5C9A78D3DAC790539@VI1PR04MB5854.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JwJ07yj+Upb5OIkbPl1qXflrvWDVfIDJLHNoIGLfcW7UxoQruds2hkxz4105PUZfu+VK+H5Uv2GVmyiL3rkHMdm2LTyj6fQR9VzZsDhx8QjurIFfxRl5yA/fQ7pmJmaJruQrZWSPDVEdKZi1EX9SLNwhV5TCrzscdUuiUbW04taD436VhlgzuJCLBkah7ePRoKa8DTxKJ5NmqvKrdoPHS/+fE4bT4MppxqkQCB45Cs05/HWHX9QfI8RCYJ1lw4r9Y+J/mD7MHMfHiOLjc/W8Ye0B943zetlkM6Ku7nzgI+h7iHfz9maa4EjF2UPfOBEx1oxUhs0w5LKEBATs+1Rk6rcSsOdufuSe36fCYUf+gcJzwdD8vmNRCeaRf37ABlSA9ESCvkL2dVAwavVJuzZCa4nAaFgalMWL2M45x36N5pNuslFaHlweFyGeo7ersKtaPx6VkrE9hBFsWwmuj/Fja0RvwV3giM0oWPVaQJjddiyjpzi6KWO68P43vY8XSpxW0zu0OkVpdbk66jMosWwHak5ltcVT0Z4dlGm7OXbe1TzeYsY/2aKWja3SiEr6Auzc2ZeUE8hXN8bCmByfIvYW1ZFaHgKmmwBKGAr0R2v4keI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(5660300002)(33656002)(8936002)(66946007)(9686003)(4326008)(316002)(122000001)(55016002)(83380400001)(86362001)(478600001)(26005)(186003)(2906002)(71200400001)(64756008)(38100700002)(110136005)(66476007)(66616009)(66556008)(8676002)(66446008)(6506007)(54906003)(99936003)(52536014)(7696005)(76116006)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?MGkveTVsbU03aUVNVUo1REVuTU1aSHZmTjNzMXJtM0lZUkRQTXQ1elpGSXFH?=
 =?gb2312?B?Rjc0TS9DeGN1OTFOTm9qbTJnendKY3UwZzRUYXZsL3J4S0pDSHluSkt0bGI5?=
 =?gb2312?B?MFREQUtTb1JpUmJCNldMVzN0aGg5bi9taHZrOFZQeUV2RndNL3lXbW5wU3BF?=
 =?gb2312?B?cTQ2RVhBYXVLTjY3QWlLTDRyNG53cGhDQXA0V2sxdmduNnJyNjd4bUo3VjVV?=
 =?gb2312?B?cnpGSzJsUCtYSWVjU2dGMzdVTUk1eURUdUNOSWliQk1qcThLOWd1dlgrUDVH?=
 =?gb2312?B?T3VwelBvUDlvbnAzOWllajhzYTd6UHJQcHl0YUJxQnAxbHNyZndvKytIWnFE?=
 =?gb2312?B?Z1Y5WTgrSUlac0ZCaCtJZUxzMHpHRnFkWkx5emJVeXNDZWgxcHpldXV3T1pG?=
 =?gb2312?B?b2pmVmlnZDdJekw5ZCtaVU9NWGFQQ3h1Wm45aGlSR1FyZ0crcVNWOGZHUHY4?=
 =?gb2312?B?UC9FWExnOG1vV0FQNE9lUTRLWVNWdGNSczdrd1pnTmg4UW1LdFVYUGRYcTd0?=
 =?gb2312?B?dkVTTkFRamNta2VmZTJCVWl4eWNZbGR4dFo3ZEgzajZnVUFzMERPLzdSRkNv?=
 =?gb2312?B?dFpCR0dNejIzMzBtUTJwRGNucnA3Sk91V29OQml5MURWWXU2SjFla3ZmTmx5?=
 =?gb2312?B?bXh3bnBCS3NSdkFRMHQ4SnF5MUhMMnVnR0poV0lnNnBZL1lUNTZ3cWkwc2tt?=
 =?gb2312?B?bHZBVFkvVTlpUHNWaS9PcUlMajYrSkpwcGJsNzAwN0svYTdwaW01SFBEM0k3?=
 =?gb2312?B?N1U2bXlyMWhhWGt1RW54TUhpbFA1T20xQVdGeWxpbHBqRlM2TFNzdVRjK2Z5?=
 =?gb2312?B?ak1FQVRndlZLQ3BiMmg5RzR3a3hRckNFOUl0cjFrcmc2b2I4Y1dQc1VDVnFj?=
 =?gb2312?B?am5qWW94UzVJTG5xb2FoMUliZ1ZIV1lQcTBOczhmTGJBdXFkcCs2RlZOaFRo?=
 =?gb2312?B?SDFONlZzcWVpR2FsVGdtZWlWb1pVM2w0VDFDRWtoM2xmc3hzemdDVFhqRTJz?=
 =?gb2312?B?R2h6UTRjNUNRUnVxTXpGSHNQZGZPNHl6bGxmcmY5blZvbmI3L29abjhlck1R?=
 =?gb2312?B?bU5zZGxESm9DUFlLVTZ2akczb1RaMGRuYWFTV1AvZk0xSFZhNXg5SWZLZzl4?=
 =?gb2312?B?cVI4RW9uZG0rRm1DblhreEtQNVlPeTVySW81a2RvY0lxMU1EdjRERURYUGV4?=
 =?gb2312?B?aUhtWWFaKzlEd3R0TVJ2UVdieEppTE5XMFhRR1BSVVp1RVNWSTlMcGpYN1F0?=
 =?gb2312?B?YWN6TU9ycVZGZmVoTG05NkVQdktVVjYxTmp4Y3Z5NkdLZ0RDbUZhZ2hPcy9E?=
 =?gb2312?B?akdqUCt1U2tVK1EvOUgxRzdwck8yMDFiY28rSW1Jd283emxQTi9TYitRTWdW?=
 =?gb2312?B?UXBISTVDQk85WDFLdXpCNTc1SUQvUmlrUDZSbnFNZVVCcUlIOXFJVG5HYkhZ?=
 =?gb2312?B?VVdsMzV1bW9sWlN2RFk1em1YbC82aVFXTjQzV0ZoSlJyUmtQbmo2Mml3RmxV?=
 =?gb2312?B?SkUzZFo0S0F1S2hGcytBcTR1TVQ1c2p1TTc5OFZLdGpEbFdueVFMMjlGaU8v?=
 =?gb2312?B?UDlpTHFUekxha3d3QUZJc1ViQVlCTmx2amVtQzhPZVdUTjd0NloyRk1RNGxX?=
 =?gb2312?B?Q0dNSEdNRXV2dEozbUdGOUU2SllncitYMk1xTW9jVUhSOFNleDh3UjRMQWl6?=
 =?gb2312?B?RWJlLzBSM0JNT0s3eXl5N1Yzb2xCbEpSaFppOFpLZ0JJaitJaHd6azRLNWxZ?=
 =?gb2312?Q?IgDD0D8cHkKzv9kONR++flhESgJauUShvUyja7K?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_02A9_01D74654.DFDDEF20"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db936da3-ea10-4a2c-d672-08d91428f5da
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 03:00:40.4563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8FNWUUznXS5pLj34Bs3YoRoUbXJx3BGLDi8z2iwy4Noze4lqVFW+s+AT9XiFnzwSgepgLEqQDe/XpcWDKJR8fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5854
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

------=_NextPart_000_02A9_01D74654.DFDDEF20
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Lucas Stach [mailto:l.stach@pengutronix.de]
> Sent: 2021=C4=EA5=D4=C211=C8=D5 3:04
> To: Ulf Hansson <ulf.hansson@linaro.org>; Adrian Hunter
> <adrian.hunter@intel.com>; Bough Chen <haibo.chen@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>; dl-linux-imx =
<linux-imx@nxp.com>;
> kernel@pengutronix.de; linux-mmc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: advertise HS400 mode =
through
> MMC caps
>=20
> Instead of having an indirection through the SDHCI layer and emulating =
a
> capability bit, that isn't there in hardware, do the same same thing =
as
with
> HS400_ES and advertise the support for HS400 directly through the MMC
caps.
>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a20459744d21..65a52586db36 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -427,9 +427,6 @@ static u32 esdhc_readl_le(struct sdhci_host *host, =
int
> reg)
>  					|
FIELD_PREP(SDHCI_RETUNING_MODE_MASK,
>  						     SDHCI_TUNING_MODE_3);
>=20
> -			if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
> -				val |=3D SDHCI_SUPPORT_HS400;
> -
>  			/*
>  			 * Do not advertise faster UHS modes if there are no
>  			 * pinctrl states for 100MHz/200MHz.
> @@ -1603,7 +1600,7 @@ static int sdhci_esdhc_imx_probe(struct
> platform_device *pdev)
>  		host->quirks |=3D SDHCI_QUIRK_BROKEN_ADMA;
>=20
>  	if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
> -		host->quirks2 |=3D SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400;
> +		host->mmc->caps2 |=3D MMC_CAP2_HS400;

Hi Lucas,

I think patch1 and patch 2 are enough to cover your requirement.
For this patch, I think it's unnecessary, sdhci-esdhc-imx.c need to =
reuse
sdhci.c as much as possible.
In sdhci.c, already contain the following logic.=20

         if (host->quirks2 & SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 &&
             (host->caps1 & SDHCI_SUPPORT_HS400))
                 mmc->caps2 |=3D MMC_CAP2_HS400;

The reason why we directly use host->mmc->caps2 for HS400ES mode is that
sdhci.c do not contain the similar logic.

Adrian, what's your comment?

Best Regards
Haibo
>=20
>  	if (imx_data->socdata->flags & ESDHC_FLAG_BROKEN_AUTO_CMD23)
>  		host->quirks2 |=3D SDHCI_QUIRK2_ACMD23_BROKEN;
> --
> 2.31.1


------=_NextPart_000_02A9_01D74654.DFDDEF20
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
MBwGCSqGSIb3DQEJBTEPFw0yMTA1MTEwMzAwMzdaMC8GCSqGSIb3DQEJBDEiBCAaQbVVnM/oRpyz
8k+4j1wapwUPTmGDpnbAdOE1CmqmlzCBkwYJKoZIhvcNAQkPMYGFMIGCMAsGCWCGSAFlAwQBKjAL
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
DQYJKoZIhvcNAQEBBQAEggEAE7bgw0NGMIXLsRCLG9ZnvqiYVVjf044MmpWIXX2SqVDaEUjWZuDz
U78cj02M6xdEd1N808LEVsvxeXT5zALnu3UBJ9YU42K/aP3RJx+NEoUlfyw/Qh9iDH+4wWNKV5G5
QQI8XYNcEqDi8JJT1OFHotiKvrQ4QDsSuIf8y11V3KIHEe2hY2LyeqqUC1IIhV1s3OBY2fgenxx0
3ZJOYRlAQxACPT3cYh2S3fDlNUlGDtVz16e+LDRgn1BvDusxQk4Wki3g4HWKPv+8WJt44YBcfHGW
Vui8/zkxxQs1mQkBCY4UfesLlq6l8kH4ngxw5YrYPsyM+67VN8LjMMWW4AImQAAAAAAAAA==

------=_NextPart_000_02A9_01D74654.DFDDEF20--
