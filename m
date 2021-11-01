Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C327C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Nov 2021 01:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1019D610FD
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Nov 2021 01:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhKACAF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 31 Oct 2021 22:00:05 -0400
Received: from mail-eopbgr20047.outbound.protection.outlook.com ([40.107.2.47]:32846
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230222AbhKACAE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 31 Oct 2021 22:00:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnCQzC+HTdrKT6FUDJi4FFboYv6ODaeG9SqyGEJFUmNNQgUIUH3gm/jpGJy+V3xAXBNuXl9Ns04ATi9TCfExmeibVMwkA2bvwmYWfT9zK+QBEreVG7MCLO1J0TXMe81SAMFG+XSA8ZTOyBjzsudFLNT+pFWvnBARTZOCjfg3Mq0a/AS8ktE9gK1ulOyvkD8Kr3A0lLUuX+5BCqzOs4wExBuXcmr7uuPGGmXO8BYIGTYpdz00LwdhSxboEmXRKD/WY31rnMzqOsWktnJTd0hzzq+RYMfIyNRuseiMfNCCABSqmcbGrhrl3QgWz5zL37ySonYIlUH6VGEXMLbIPeFQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxmxyAmbJWzOxJRK2Edx0ubOtsefRhqZtDTbvPt+S2M=;
 b=H2ifpe5lirpD9lGp/0qulC3rz2hf1RA4v1s4i3EktGza3dw54UDYXmT/xrc6SIwmuxiZ9hMEnv+WuR3mNJnJzVXLU78zzlHJj4LYV6k2fodqYYLFrFrnatJ/e17UZtBvwVDRtd5oglBbz7JJzBVcfSNTlNB4xjDeOHtF4meZ7B1/8ztgGl8ClxI5G49GrkYCC2tEpKMqrz82l4IyC02w+G82SKuDrkjkavDe3gekdOhl5k9n60+YH+Z8sk1S4UPCqhQABlIzCyqqVT9EjapIVp/WLkF27cp6jpRWHbl381iliqOQeHFmYQE40vWtSgdCILfkFH/IwW+/iQAMtyvC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxmxyAmbJWzOxJRK2Edx0ubOtsefRhqZtDTbvPt+S2M=;
 b=kfE8q8ESdslB9c3QvkLieg+JMEQTDNoMRSb8WAdzKQi7luvNGX7jdJkKE87E3ap4Ri+R93RYUgFf37Ic4leAGQDYslJYwzHm3qJXL9dO8ZDI3yZc3iowMJ6UCmEgbaUUtyinxow5yuv35cbnNmCzb4S8rUSNoVOi2IaFKA07dAQ=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VE1PR04MB7408.eurprd04.prod.outlook.com (2603:10a6:800:1b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 1 Nov
 2021 01:57:29 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::6c18:7e06:8efa:c8c9]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::6c18:7e06:8efa:c8c9%6]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 01:57:29 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        Fabio Estevam <festevam@gmail.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>, Frank Li <frank.li@nxp.com>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Cale Collins <ccollins@gateworks.com>
Subject: RE: IMX8MM eMMC CQHCI timeout
Thread-Topic: IMX8MM eMMC CQHCI timeout
Thread-Index: AQHXzQY5w6gpJ5wepUWwHp8A5XAi06vt6qtQ
Date:   Mon, 1 Nov 2021 01:57:28 +0000
Message-ID: <VI1PR04MB52942DA2B09A320B8060A3A8908A9@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <CAJ+vNU2Vt2hWW=Yxh5W=bVerJjwbNoJpTDGgXxUUo9PZvzFe9A@mail.gmail.com>
In-Reply-To: <CAJ+vNU2Vt2hWW=Yxh5W=bVerJjwbNoJpTDGgXxUUo9PZvzFe9A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8600253e-c4ea-41e9-3881-08d99cdaf5d0
x-ms-traffictypediagnostic: VE1PR04MB7408:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VE1PR04MB740801198EAAA7C4EEFD87EE908A9@VE1PR04MB7408.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5+8qQAvBsRIYFggW5ya3v6yw6APesJFQhr0gxypOhEBNQYoacmwJVO1klXn+uQsbOKyJJMW9olNRXntYBC9+9KCJpmS+aynkPAhlg6lB6XddI/tm5l6c+qRR/dw1+xRfkuesAPkLBGLsXTsOeb+e6z5kGeMhHkRb090qf18BCYcRAvL1L8ioiOG3p1BRvjyXoOSEblDzUnzUEX5DoPjL7XYUCJLlHOklx61PC38ocb6AmtKqwLZXRTRBNJAABC9Lmrty8aZ32CG3FpqTeMZ9lUvqCbEXJxPzaUO2jPQjTXGgSgQSP/irQ9SZyAO41LmxPVLynXl0XzzGPsMEWZ46Cxt567KK/Y//PRFwkI7jwXT2oaFqHdUBFRupXmPlBIG8k3nMnZHue88nnGpTaRHEFWgM9p1GQtyuwUTAr7IBOwN5jr8CMC/BbBGo2t/1tJYn0T1cE80Y1/mJtDaE8ShLa202LuTU4JnRWy6JwIcVozvjOOgjQur2DYr5yzjl8MRQvG8WX5IrAoBt+Yt/0jaNK/3H0HsR1O3ZlpkEBy/7aqNpYJ6BqLyTuicvoIm7Qp6l2C9GVlBYPUy+quZpnlGc5KHp7yqV1cDLNAtKca54hjzxkQ8mNuCSzcyFGH6CqlC6JuqOt0eWxz3TynjVzgXEYuTD7L3SsHHRAC6WyfAOykpJLLQMZgynXe4+EXwG2UQxLa5cl3d/PdqRXkKl5c7gpxRYLsYaFg/n6iACShodCTyaZOi8I941wINkakeNa1ACiYUW0CG0miCeP2WjLroa/TZQQmAA4b3fLaeIhpEkt9T+qfgvtNz0YTJnts0ObLr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(76116006)(966005)(83380400001)(99936003)(186003)(6506007)(53546011)(71200400001)(8676002)(26005)(8936002)(5660300002)(33656002)(66446008)(86362001)(122000001)(38100700002)(7416002)(52536014)(6636002)(54906003)(508600001)(110136005)(66476007)(66556008)(64756008)(66946007)(7696005)(9686003)(38070700005)(2906002)(316002)(55016002)(45080400002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WFljMUVYbWJ1K0NGeUV4d09pN2dxbEgxeG9iaUZUckk3UEhHUytxNUZybENV?=
 =?gb2312?B?cmFiZTZvK0s0QzlzTVNUN0dsUDBpNkJTbVZkU0JNaWFvNzBETWQya2F1QldP?=
 =?gb2312?B?SjkvODBjdHdBdjUyNlc5Zkl1UFdtUFMzSFVlRFBNdWI2b2dyU1Q1a3hrbldr?=
 =?gb2312?B?T0RkOHYyalhZR1ZUekdMWWNTejh2ZndEb2RYUkxkQVZyZjAvL3JtRnpPMjVV?=
 =?gb2312?B?N01zdHJlQklhNXRHdDBVcWdpZldBRUVjdDlQbytsWDFOVk5rVXdrdm1ZUjJG?=
 =?gb2312?B?Q2tGeWloNVZFSkdyU3dVQzh6QTdUOWVPZ1dyd0hyVU1MY1BnMlFvTXplL25F?=
 =?gb2312?B?a1VhbnFEMWVDcUQ1b3pIY0JzcWFSa2wzVnArQ0lkS09SWnhpOVloZnE1SGMy?=
 =?gb2312?B?bE5nVU9NRXJqR2pSK2VYbnVHWlAyV2pQZnphQ0QrRzU5MXdrS0FXdldQTnJ5?=
 =?gb2312?B?REt0a3BLanYwUUprMWZKL2VpN3NhR1lFdmU2czUrRVNZcEV0NitjcnMrWG5h?=
 =?gb2312?B?cVNXZ0RISWI2T2hiV2RwWjJIbWdocktMUzBQVUNPVVpkZWpoempRQSs0TVRZ?=
 =?gb2312?B?UTBVN2tLZDJOUllXeEZGcXd3a2gxamVRQUt1WHRPbnl5bzFkMjVaUFhBaDR2?=
 =?gb2312?B?YWJnRUZZeWF0R3V1VEtRMTNIVmQ5VVp3d3hIZ093TFNWTWF0RFRxSkczUWhC?=
 =?gb2312?B?eDVHM2haZzVINytZOUExWWVjUHhSbzh6R3FrTjNuZFV5K093QmtuemgrZzUz?=
 =?gb2312?B?eklZZytOQy8zckd1OE1MU2M4aFNyT21uSzc3bmFxcHFuNWMrRlB4RTAvdWdn?=
 =?gb2312?B?S0NEOEJZaXA5OC94N0k5Z2I2S3lVM1RVY1Q0NHpLakdkZ0lpQXVZOUpya3I2?=
 =?gb2312?B?djgvQURodWFESWUvckszVHM2ZUw3QlZpRkV4aUdXaFRFNmJkK3MwOFBRSUpE?=
 =?gb2312?B?OWRtS1FlWWxEdHZBYnZGKzVqR0F4d1NCV0sxaWxDVUJKMUtYK0ZxRC9TdDdP?=
 =?gb2312?B?R3ZNK2c3MEEyd2Q3RGN4RlJjVDlId3oxakdpZU0wU2JDM3NPckwxa09iZTBq?=
 =?gb2312?B?Mkl6VmNZakQ1bll5MWFES1FnZjdVMDdEQm8rZ3JJSjlPbG9za1U4c01OY3Bz?=
 =?gb2312?B?Z29Xb1NYL0pUZytWY2RHR2c2aTdDSmJ1amhNdzAxVDJ0UUlOMkhyUHhwRTk1?=
 =?gb2312?B?VDFMekI0YU5JTSttVlhKSUtGa3l1VVNnS1JTLytyRVRWZEtMRXMrQldST1Bl?=
 =?gb2312?B?T1ZMNW5WRExqRlBpMmtUUGJudlFycFpjNmRWYmFNeEtvNEdkUDltWG8ybW5K?=
 =?gb2312?B?YVVaYXFkUlhTekVvVzkybWZzWTFiVUxpeVZHeC9MTklUZXJXQnF4Q0hJZmUv?=
 =?gb2312?B?dXVySGFPSFFMV0swZ1VvVVhVVnZJd3NPMFFGZVI4engzbWRGb3JGOWRsMTVw?=
 =?gb2312?B?b3J1TWlUZ1BJZHFHVlRMUDNvZFpvL3RjS3JVdlpHTXZkQ1JyNDVOQjdveFFH?=
 =?gb2312?B?QmZhd2tQd05HWlNyVE8rck9kbHppUjNnOHJBWXdGdENHUjdjaDk1NXg5SkE2?=
 =?gb2312?B?VFlMVzBQY0l1VkRJREhBQUxwb3BXbDdtSFk0Skh3cDQ3bEt2ZTBKTWRtTzUw?=
 =?gb2312?B?emxZU1RoUnpVQnJKVFJsZllFcDFMbEVRYTk0U2FRMXM4a0EyRytQYXhkeGRH?=
 =?gb2312?B?VjlZNEtCb2gwUFFMejJ1TS9ISEZWMTM2b2dYekRndFB4UGJoeU1LYWNKbFBW?=
 =?gb2312?B?Um4xL2JEekNHb0ZwdDZSNDgwdktpZ2JWei9kTzd6cTIvQzhSNG5GVGIra0sv?=
 =?gb2312?B?Nk9ocEV6V3VQQXJ3dUNVazZqUmdiOFY0OXpFQ3VjL0o5UkQxZ3JpN0pESzdU?=
 =?gb2312?B?emhPeHE3UUh1SkR4QjlLRlRsM1NZTjVQd2pKSjBRc1VLM2o0TnhIbTlzUlEr?=
 =?gb2312?B?T1lTQUVyZ0JsYTk5N2VySTVFZHlZNHh1L3lZdW5TUlRKdGQ4akgwMXVuTmR0?=
 =?gb2312?B?V3J1bk5Fa0w5T0YrSTZVeG9iNHQ1aVVkK1J6Y1JDaXdMYlJQbXFrVEZiN3k4?=
 =?gb2312?B?a2F2RGVwNlJsK1NJaDBoWmkzOWJ2NktULzBYNmpCTFBRMmgvNGVNV084WElp?=
 =?gb2312?B?SVlrQ1hsOVV0R3ljdHh3QldoUnBxNjhqSXo4dGhQSFQ4YW0yMVlpcldidU9Y?=
 =?gb2312?B?OEE9PQ==?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_007F_01D7CF06.DF5FF440"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8600253e-c4ea-41e9-3881-08d99cdaf5d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 01:57:28.8784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXaHvFfbt/GjWm8lsaGGFHLeUEdNyMAV5q6D5Mirix3GpCHuOE1IPujCopavMp6f6AqVxvA5bnkLGu+syg6kgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7408
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

------=_NextPart_000_007F_01D7CF06.DF5FF440
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Tim Harvey [mailto:tharvey@gateworks.com]
> Sent: 2021=C4=EA10=D4=C230=C8=D5 4:47
> To: Linux MMC List <linux-mmc@vger.kernel.org>; Marcel Ziswiler
> <marcel@ziswiler.com>; Fabio Estevam <festevam@gmail.com>; Schrempf
> Frieder <frieder.schrempf@kontron.de>; Adam Ford <aford173@gmail.com>;
> Bough Chen <haibo.chen@nxp.com>; Lucas Stach <l.stach@pengutronix.de>;
> Peng Fan <peng.fan@nxp.com>; Frank Li <frank.li@nxp.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>; Shawn Guo
> <shawnguo@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; Sascha
> Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>; Cale =
Collins
> <ccollins@gateworks.com>
> Subject: IMX8MM eMMC CQHCI timeout
>=20
> Greetings,
>=20
> I've encountered the following MMC CQHCI timeout message a couple of =
times
> now on IMX8MM boards with eMMC with a 5.10 based kernel:
>=20
> [  224.356283] mmc2: cqhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D CQHCI =
REGISTER DUMP
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  224.362764] mmc2: cqhci: Caps:      0x0000310a | Version:
> 0x00000510
> [  224.369250] mmc2: cqhci: Config:    0x00001001 | Control:  =
0x00000000
> [  224.375726] mmc2: cqhci: Int stat:  0x00000000 | Int enab: =
0x00000006
> [  224.382197] mmc2: cqhci: Int sig:   0x00000006 | Int Coal: =
0x00000000
> [  224.388665] mmc2: cqhci: TDL base:  0x8003f000 | TDL up32: =
0x00000000
> [  224.395129] mmc2: cqhci: Doorbell:  0xbf01dfff | TCN:      =
0x00000000
> [  224.401598] mmc2: cqhci: Dev queue: 0x00000000 | Dev Pend: =
0x08000000
> [  224.408064] mmc2: cqhci: Task clr:  0x00000000 | SSC1:     =
0x00011000
> [  224.414532] mmc2: cqhci: SSC2:      0x00000001 | DCMD rsp:
> 0x00000800
> [  224.420997] mmc2: cqhci: RED mask:  0xfdf9a080 | TERRI:
> 0x00000000
> [  224.427467] mmc2: cqhci: Resp idx:  0x0000000d | Resp arg: =
0x00000000
> [  224.433934] mmc2: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI =
REGISTER DUMP
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [  224.440404] mmc2: sdhci: Sys =
addr:  0x7c722000 | Version:
> 0x00000002 [  224.446877] mmc2: sdhci: Blk size:  0x00000200 | Blk =
cnt:
> 0x00000020 [  224.453346] mmc2: sdhci: Argument:  0x00018000 | Trn
> mode: 0x00000023
> [  224.459811] mmc2: sdhci: Present:   0x01f88008 | Host ctl: =
0x00000030
> [  224.466281] mmc2: sdhci: Power:     0x00000002 | Blk gap:
> 0x00000080
> [  224.472752] mmc2: sdhci: Wake-up:   0x00000008 | Clock:
> 0x0000000f
> [  224.479225] mmc2: sdhci: Timeout:   0x0000008f | Int stat: =
0x00000000
> [  224.485690] mmc2: sdhci: Int enab:  0x107f4000 | Sig enab: =
0x107f4000
> [  224.492161] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: =
0x00000502
> [  224.498628] mmc2: sdhci: Caps:      0x07eb0000 | Caps_1:
> 0x8000b407
> [  224.505097] mmc2: sdhci: Cmd:       0x00000d1a | Max curr: =
0x00ffffff
> [  224.511575] mmc2: sdhci: Resp[0]:   0x00000000 | Resp[1]:  =
0xffc003ff
> [  224.518043] mmc2: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  =
0x00d07f01
> [  224.524512] mmc2: sdhci: Host ctl2: 0x00000088 [  224.528986] mmc2:
> sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xfe179020 [  224.535451]
> mmc2: sdhci-esdhc-imx: =3D=3D=3D=3D=3D=3D=3D=3D=3D ESDHC IMX DEBUG =
STATUS DUMP =3D=3D=3D=3D
> [  224.543052] mmc2: sdhci-esdhc-imx: cmd debug status:  0x2120
> [  224.548740] mmc2: sdhci-esdhc-imx: data debug status:  0x2200
> [  224.554510] mmc2: sdhci-esdhc-imx: trans debug status:  0x2300
> [  224.560368] mmc2: sdhci-esdhc-imx: dma debug status:  0x2400
> [  224.566054] mmc2: sdhci-esdhc-imx: adma debug status:  0x2510
> [  224.571826] mmc2: sdhci-esdhc-imx: fifo debug status:  0x2680
> [  224.577608] mmc2: sdhci-esdhc-imx: async fifo debug status:  0x2750
> [  224.583900] mmc2: sdhci:
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I don't know how to make the issue occur, both times it occured simply
reading
> a file in the rootfs ext4 fs on the emmc.
>=20
> Some research shows:
> -
> =
https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fcommu=

> =
nity.nxp.com%2Ft5%2Fi-MX-Processors%2FThe-issues-on-quot-mmc0-cqhci-tim
> eout-for-tag-0-quot%2Fm-p%2F993779&amp;data=3D04%7C01%7Chaibo.chen%4
> 0nxp.com%7C1dc0981634f5460a779808d99b1d5a88%7C686ea1d3bc2b4c6fa9
> 2cd99c5c301635%7C0%7C0%7C637711372651089473%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C1000&amp;sdata=3DITcs7%2FMy%2F1Vx1TMB2VlaY4QhibKuSFBD
> 6UZhzVFl%2FqY%3D&amp;reserved=3D0
> -
> =
https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgit.to=
rad
> ex.com%2Fcgit%2Flinux-toradex.git%2Fcommit%2F%3Fh%3Dtoradex_5.4-2.3.x
> -imx%26id%3Dfd33531be843566c59a5fc655f204bbd36d7f3c6&amp;data=3D04%
> 7C01%7Chaibo.chen%40nxp.com%7C1dc0981634f5460a779808d99b1d5a88%
> 7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637711372651089473
> %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
> BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DxaamzPb2CdW6YDzW
> g8uBb0PjomkoWAziu5qglvMbT2I%3D&amp;reserved=3D0
>=20
> I'm not clear if this info is up-to-date. The NXP 5.4 kernel did not
enable this
> feature but if I'm not mistaken CQHCI support itself didn't land in
mainline until
> a later kernel so it would make sense it was not enabled at that time. =
I
do see
> the NXP 5.10 kernels have this enabled so I'm curious if it is an =
issue
there.
>=20
> Any other IMX8MM or other SoC users know what this could be about or =
what
I
> could do for a test to try to reproduce it so I can see if it occurs =
in
other kernel
> versions?

Hi Tim,

I'm debugging this issue those days, but unfortunately, still not find =
the
root cause.
The register value of Doorbell, Dev Queue, Dev Pend seems abnormal. This
issue happens
on all i.MX SoC which support cmdq feature when cpu loading is high.. =
Now I
lack a mmc
logic analyzer, make it not easy to debug this issue. So stll need some
time. Sorry about that.
If you want to make mmc work stable, you can disable the cmdq as a
workaround.

Best Regards
Haibo Chen
>=20
> Best regards,
>=20
> Tim

------=_NextPart_000_007F_01D7CF06.DF5FF440
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
MjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIw
S2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhw
LERDPWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlz
dHJpYnV0aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VD
QTUuY3Jshi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCC
ARAGCCsGAQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVy
cHJpc2UlMjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZp
Y2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9i
YXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0B
AQsFAAOCAQEAJpGYHveFzmgLQ4J62fcmPkd4wJ8urL46itMWCgyLBPRARYB9oArCqPd4j0Yl0RmS
F1oNZgVDYQTy2aLoe+YGm23TkdJsTx1ExTxtv+njRnvvlSXMMULlOIt25/Vj+vTZ/wjFDq6PJOSZ
MSQHaVHSUrkLBT1H0pBmCA1Ecjuo7gUpG5T2NqD5KJP083pJZ+nogA9TVC9Ob+jNx0d/UR7UgRLf
KOxBG05AakTa4luadPIRktiULtjzG20WDhvAIg4M9w1+9SV+LpvvqBtkovpCfj9Rf4pNRV1CjjTY
AFIH0s3Q11HnFd1UNHKUvpp7/SrTyxaCXBO68U5aJz4zDjwIPzCCB+swggbToAMCAQICEy0ABsdV
/0AV+3f0TucAAAAGx1UwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMTA5MjIwMTMw
MTRaFw0yMzA5MjIwMTMwMTRaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
MjkzNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL6VTRRCbJgUEuoR2bppNZQc3ghr
l0pDEZjK8uaayFYadelTc6iWe8EBLWrrOWd17yNeXc054yw+Yu8eI1IWMEE/mo5l93Kw+BkuCUda
vpqZUMOvaPDKkHNPBNPJ6AP+vmZW8p/46dxo6Nx6xGzkpbUZ1Ju1a9LuxeFQBNNvV54wYbFmoKJF
eQQ3RZdEafNucOw8ukTyWurcC8fPUQwqE1sFRdtjLeJWZBtrvNim4oikb5UFxcmoaQkJ/sqoJGZL
+bR3ZZx3101+Y7RJp56hfqT1eqkJkc7OTz+tsZx3p1a6r266NCB/RBIGVD2cFmhUs2Uitp/oB+9k
BhycuX8wowECAwEAAaOCBAowggQGMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/heaKboS14X4CAWQCATowEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwQQYDVR0RBDowOKAiBgorBgEEAYI3FAIDoBQM
EmhhaWJvLmNoZW5AbnhwLmNvbYESaGFpYm8uY2hlbkBueHAuY29tMB0GA1UdDgQWBBQY587dMxoS
HzI5SkUyoLrumaVa5jAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSC
AT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1
LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2Vy
dmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBr
aS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCB
uwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlB
LENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24s
REM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRp
ZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2Vy
dHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0BAQsFAAOCAQEAsjJuJnMzvA59CAlY
87eQCOafWbMF4HfC4oobtAqboB48BtCZ5dOeo+X4XQRaSmTwFJ2hZjX614KFnRGXLk/nDIY4pp8+
fqfgHKUdY1ceVqs+Kjtabk3gY8zq7PtFUsAkwp4OW23kwphh7Awx1tf3XRZeOqwiVuk5V57GT8Tu
dKNiOZqut3mrcdZINNUsqjt7ZA82r4ov5MbEBHeWVjo7CeWbgZFZhKhMKC9+2DKEUkdDJUcDYqxz
+Rh+6B+dgxeYkTGIqHELhkMjMCC5SwRNHfCxXCI+qRy4zIAo2K3V96zs3ungqiFZuFrpatfSBfAL
d86AIrOgsHhvOB0UU1W//zGCBLMwggSvAgEBMIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlz
ZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3Zl
bjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT
8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0ABsdWyH4wxYEw
yQ4AAAAGx1YwCQYFKw4DAhoFAKCCArkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjExMTAxMDE1NzI1WjAjBgkqhkiG9w0BCQQxFgQUho35aBNpOIMpJIcS1a2LL7a4
/FgwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3
DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhow
CwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwgd8GCSsGAQQBgjcQBDGB0TCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMIHhBgsqhkiG9w0BCRACCzGB0aCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMA0GCSqGSIb3DQEBAQUABIIBAEG+
uBwQzmVJ60bORgiw+zFRp23P8NFbhx0tmPM6shKv4j4+WbYg3huk2JbSqvytUgMK1llxkInUzONq
uxKvHSOmG91Udt0uwtJtkWv04SKzlZAhrpy17A7PF78LXYIHBbsmB+cc6lfqjiSpptSMjMKFqpuB
5EzEXhRkuaZwicBp7MaORJ+DsNDA3sCl/23vQ8M/425j82U2mq5G2crC+kzkGfOLmAcBEUQYDBdw
6FqNdLmmtgxc1uLWx5+dk9Ugc+Hq4OOc76KWXpRJ4Gs5vR3JYxCJntckW9TZ5eTpYwLSy+ogm45q
hKwwoxRHIQ5sD39lPOptd+p5sT10OWhd7N0AAAAAAAA=

------=_NextPart_000_007F_01D7CF06.DF5FF440--
