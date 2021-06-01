Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A80C4708F
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Jun 2021 11:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01E96124B
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Jun 2021 11:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFAMBK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Jun 2021 08:01:10 -0400
Received: from mail-eopbgr00046.outbound.protection.outlook.com ([40.107.0.46]:8532
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233657AbhFAMBJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Jun 2021 08:01:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0G97XnCnKUC90iStY5PmLLolpuq87sqkHdMFO5g0M6t7yzFYFHAFbf8SgUSAYpSpEOOi2YtuON9njmU7U+SkIuxXW8di3cA/b8yoOtdueCNJkBx4UYNHDNahunTMpEEtzOZ0GceGlPPWug0dcZOaDbGEKcFi+K6JQ1XzFKp/KIdHCCHFrqTQ6S5/k9SSDjXC8b+yLKVd8YiCzzdDKcqklc6qzIcQDNaOjl8SKCxCOD51YF8PCpk6/Tg1wQe2/AZPps4HEvSs9WRsYio+TVDtUEWnH4YKmXLS91fWcUrDjjLYbv4d5e4gKC0xoqqRCuoqtpWK9eW6/ft55gkcNka3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IZCKRKnoEnhejhqp5vr7q1XtdTwu1wd8pQucRr4kvQ=;
 b=lC+8kEl6YMKO/iezNpV702bukybU2wo/1BP94027y14BagEUxXt4XpD6bOkLWG4UN7VD+YqyUe3T6hDtwJgz6Lqhz50sUO8MaDxTGq/Z6ItQEtKUeX1AmJ2hnM4bB6+xjscVklVhDTqjGK8MQmUePYPlAbHX683Dylm6NVvd0oy/QhYWIDDYXygOalz4oEnpDM048Elu8ApeK13UanPo2sEeGxVHC2ZqYjbiBE4XyurnTp37eZdch3Z/a4248jupnt7et/nN+94CVcnyXwL9wstYER5Y9/I/0qHEfEze7/1pgHtCweSc8X3ExQ138R5aazUrEt9w47YwbouClxYOrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IZCKRKnoEnhejhqp5vr7q1XtdTwu1wd8pQucRr4kvQ=;
 b=ZIY8lHYWBuqyety3M88NgDebeWC9RrnQ1GbXGmqMZnUwjBbtJLESpNmqrorrGanlWzkxHOSKPWn0h42BXa27jU23vyGVTvXyDbv38lLAvhs1Aa2vOxb4MRJghG+2zg2Vk0AjInbcSvGJTA8noQwrTISoGugTY3f7Nz+a8q8MouI=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR04MB6016.eurprd04.prod.outlook.com (2603:10a6:803:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 11:59:24 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::ed5a:8f34:39b:db40]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::ed5a:8f34:39b:db40%3]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 11:59:24 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     kernel test robot <lkp@intel.com>
Subject: RE: [PATCH 1/2] mmc: sdhci-esdhc-imx: remove unused is_imx6q_usdhc
Thread-Topic: [PATCH 1/2] mmc: sdhci-esdhc-imx: remove unused is_imx6q_usdhc
Thread-Index: AQHXVswSaWABUdl+tk6ih4stBkz9car/DSwg
Date:   Tue, 1 Jun 2021 11:59:24 +0000
Message-ID: <VI1PR04MB529444E439F50599339BA17E903E9@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <20210601095403.236007-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210601095403.236007-1-krzysztof.kozlowski@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec7f880f-faa5-4beb-649f-08d924f4b2f4
x-ms-traffictypediagnostic: VI1PR04MB6016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB60163D9DE3A66A0130E36492903E9@VI1PR04MB6016.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:81;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oq0pmlIxgAA0os5Fz3bvpZRPdGE898xHoqO8ZLUURa3pRKp4o0zOsAtjabUWAIgN+wGAzPrTW14MP9YCuTuJ3R0j6O/Jny1/C1idBPh0YYKyi/0p+PS/OanQ9PaCKSNLp0GuLHuqTgwR4CVZrXlOC+UpA4Dw3rkkozt9LZUpmrGQ+w4LBH+TXDF9PADQwdHtpQXhbHqKCnquU/iojaevsaaUXHUcniHJPcHiy2NJ1hoGcDyETnZnN4CH6YxeF8o2SrNwYFNBBcRU/KFEInXmsZrJCUTyxQauvuPI1KkvKugFR8NIZq7EVmZR2/wKgWYSUDTjyUUgj/eD+AtXrAPN0yHhni9peDPPvZHfFFWnKokDqw98NgwX+836f4w5+LCfSJeB2HE0NiivsO2zHYWjVH7ls0FrENSAGzvfKZ36JOqhZkucXaTswYg4zvxl2CEThFeTVMcsaHj2BftuT+m79CCUGkDymE+fN+kize7izj/1AriWSWOxZioQP+XvpuL60skfaa6XcNLzXAl9ifXnk+d2fABrgHPOETl0RsgzO1SUHBJdpZyiP7slVDLTnJku1jqujOnCfE3xpDX+CgYpH46cyNdaQ3tWodqH+W5vIcFUlp/pzoxYICN6JLK0g0xE9bSs7YbEL9Kp2roVQYj+Jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(110136005)(99936003)(66946007)(86362001)(4326008)(55016002)(498600001)(66616009)(7416002)(52536014)(33656002)(64756008)(66446008)(186003)(38100700002)(5660300002)(71200400001)(66556008)(66476007)(122000001)(6506007)(7696005)(9686003)(8936002)(76116006)(921005)(26005)(8676002)(53546011)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?bnYxc3dibEdsUkljNitoT21UWllvQjJNK01tUU11OFZhZzhxcm9wQjFBQnhO?=
 =?gb2312?B?dzZRUm9wdm1wOGk4K05wL1pJS3VCOEh0RmxwanhmV0RmdkZLcCs2RVBLRmFR?=
 =?gb2312?B?SDlsTGdXOEZ6OFV1Y0wzUWV4QU5GNTdMVmw4Y25JczJvQUtiTkdXYktlMml2?=
 =?gb2312?B?ajRtYk5DbVZ2QWRMNWd6YmxQU2d3NWhpZXZaZXFpcDVHSklGbWV4QXNpaDFB?=
 =?gb2312?B?bGhJc1pJR3lKZXJyanYydVdmYUk4QlIzYkxESytCVjZQSHJqU1h1RVRjYUNp?=
 =?gb2312?B?a09EZHFVN2ZDdmhvN1RnSG9QYXkrLzRUVUJyeTc0ZFJ4OFhuUElROGswMTNR?=
 =?gb2312?B?RzhyWEc2aWErU2xPbW92aHQ5SysyWWFKdzNlZ0xpaWc2bDJZYWwzL2laeUZD?=
 =?gb2312?B?MmRiRjVKaHY5TE1jdGVRRnpWWG1ZWkFRZGcrQ1VXR1M3UzBIU2lrcGwvSVJI?=
 =?gb2312?B?Qk0rZlpuVVVNb1IzaDNXWldrdFF0YXpTWURmbU5mOGU1NnVHZk8wMkU3VFJr?=
 =?gb2312?B?Zy8xMTYwLzZkWXQ5UlpabWZMUkRld25BZTRtMjRjeHlYZUlmcjZiQ2EvV0RT?=
 =?gb2312?B?MU5idnc5WkppSjArZlBrQ2g2eWxNNnJROUxZdzF2azFidHNVRjlpWSt5dHNl?=
 =?gb2312?B?MXduUldkZlZ5UGREL1BiOGhFZUE0MjBYVDM5dEl4VTNQYlpFSzFNeDNYeWRr?=
 =?gb2312?B?Zms2Q0NVNWNVNFVTWnhhVjVZVGMyblNLVGZxczlpQUlDdTZLbTlSdWFZdm00?=
 =?gb2312?B?c2kzSW9rMVJMV1hYVE52eloxRmRGYUwxenJBSk9rZUw2SmZMb0l3WUNsYk1h?=
 =?gb2312?B?Uys2eEhkQXNOeWVWZ1JOU2xRcUlKWUZpKzV5MGxFZnZwbmw0Z0owN3lGTGpQ?=
 =?gb2312?B?YlBIOWZhVjFBdmV0Q0I5eWNWMXdXVFNTaTJoM1NZQkdremI0T05GaEVBVVR1?=
 =?gb2312?B?WWVJQUpRUldVNllrZVlML3FkQlhiZ2FMNEt0MWlSSGk5MmZTUzdyR1RGS1l0?=
 =?gb2312?B?M0JuaFBiUk5nZlhMWDgySUtaeTc4bll6Skx4Wjk2OGZUandwZHN5bEpoaG10?=
 =?gb2312?B?MGp3RGxJa0xXR0VXQTBjOVJsK0pxMzRXdVI3UHgvYnZtWHZHMW9PZTFCOERq?=
 =?gb2312?B?WDh1OG9YVUFXSU5HSkVyU081dVJpM1J2Z21PbUQ2bWl1OHdpQTNQRDRqR1Jz?=
 =?gb2312?B?Q3FoRjR2Qi9tQTN3cGxvRGc2eVpXdVlveUFoRjAzSEdxNVVzWDlpVFhVeXRZ?=
 =?gb2312?B?QXdkOWkxQmZLRXhRNU5YWFF4WGdIWE9ScE9uR3JpUVdIR2NpNVRXZm9RSEdE?=
 =?gb2312?B?SERtUmdSaCs1SkNydjk2S0xWUncxWlhTdkxKaWZhdjN5cGtXSDZDUVNXNHJU?=
 =?gb2312?B?UVVCTURFQWY0YTdNN1FzUE8wY3BrUVBoaDJ5SitGSkR0bnRybmREaVdZc3Y2?=
 =?gb2312?B?OTdmaFFBbWZ5d1ZFSkpMdnNBQUtCalhWWlNFNit6SEVvM2RDRGlLRFZDRDNS?=
 =?gb2312?B?bnN5SVcvb2xMaXh6aWdoc0FRcnFEOFU4OWdRVU1GOG55Sk05U0lSMU5sMHFH?=
 =?gb2312?B?a0h1RGZKYVJSU3Z3UUVDNjdZcExRL3lGTG1ZN05IQll2UnJTME9XdnpxVkNm?=
 =?gb2312?B?cWlPUkdvTmdMSmltMWRjb2lyQmdiWk1NUDBON3BKZ2NVb1owd0FIVGYwc3ZF?=
 =?gb2312?B?dk1XY1NOcUs2TnpEUERoZExrWm1SeEsxaVBLM1hveEFUYVM2VnRZclI4WWZY?=
 =?gb2312?Q?tgOCyPCHU0svCQ4SGDC7iR+GwRE5sA8XxBgaDXC?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_028C_01D75720.9C7A9C10"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7f880f-faa5-4beb-649f-08d924f4b2f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 11:59:24.1327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7tFfAPxaKKjmqW4K7ExU4aloQCWhjpXxOAI4Ket+1GiqVOr/ln7861sNXis8zzwAJQUVHrBggupi5C6lplznCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6016
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

------=_NextPart_000_028C_01D75720.9C7A9C10
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
> Sent: 2021=C4=EA6=D4=C21=C8=D5 17:54
> To: Adrian Hunter <adrian.hunter@intel.com>; Ulf Hansson
> <ulf.hansson@linaro.org>; Shawn Guo <shawnguo@kernel.org>; Sascha
> Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> dl-linux-imx <linux-imx@nxp.com>; Orson Zhai <orsonzhai@gmail.com>;
> Baolin Wang <baolin.wang7@gmail.com>; Chunyan Zhang
> <zhang.lyra@gmail.com>; linux-mmc@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; kernel =
test
> robot <lkp@intel.com>
> Subject: [PATCH 1/2] mmc: sdhci-esdhc-imx: remove unused =
is_imx6q_usdhc
>=20
> The is_imx6q_usdhc() function is unused:
>=20
>   drivers/mmc/host/sdhci-esdhc-imx.c:343:19: warning: unused function
> 'is_imx6q_usdhc'

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: f47c4bbfa283 ("mmc: sdhci-esdhc-imx: create struct =
esdhc_soc_data")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> b/drivers/mmc/host/sdhci-esdhc-imx.c
> index fba4a963d12e..7336ae749137 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -324,11 +324,6 @@ static inline int is_imx53_esdhc(struct
> pltfm_imx_data *data)
>  	return data->socdata =3D=3D &esdhc_imx53_data;  }
>=20
> -static inline int is_imx6q_usdhc(struct pltfm_imx_data *data) -{
> -	return data->socdata =3D=3D &usdhc_imx6q_data;
> -}
> -
>  static inline int esdhc_is_usdhc(struct pltfm_imx_data *data)  {
>  	return !!(data->socdata->flags & ESDHC_FLAG_USDHC);
> --
> 2.27.0


------=_NextPart_000_028C_01D75720.9C7A9C10
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
MBwGCSqGSIb3DQEJBTEPFw0yMTA2MDExMTU5MjBaMC8GCSqGSIb3DQEJBDEiBCCdgnOlsXKvnM8x
dhe/oqGK8Mbj9i+S/XcMOKlD+B+H3zCBkwYJKoZIhvcNAQkPMYGFMIGCMAsGCWCGSAFlAwQBKjAL
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
DQYJKoZIhvcNAQEBBQAEggEAXrcYTGBNvnAWr9xkR+W7AYi3el/h4G+grYrwANIMAj+aE6RyWhRO
KtGhRUPXVL3uVkHZ1GkcnTl4yqmLTIBQAvf9CMtGrs40Epr3wTjKGohSHtGJoN361ZbAefEFnduw
/z7GhU5QtWFF1fbolE67AA19QbQCOk6w+va8Irla0LDhCrQS9sf/OM1jiZMcRJO4kuBJaGFgVEBy
OXdW0nsSJjKotRkwisPN0OunN9+s8WnVxv/rrtfaIV1s27m/k3Os7aencZw1gmvcXSIrEjubX5bb
S8/tYsSneY27ZCS0niMtlRGCoHzoUK9w6i2M/HTdlxyaJUqCftDT4c9Edz+hAwAAAAAAAA==

------=_NextPart_000_028C_01D75720.9C7A9C10--
