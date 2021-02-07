Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02782C433E0
	for <linux-mmc@archiver.kernel.org>; Sun,  7 Feb 2021 13:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C967564E57
	for <linux-mmc@archiver.kernel.org>; Sun,  7 Feb 2021 13:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBGNLm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 7 Feb 2021 08:11:42 -0500
Received: from mail-eopbgr60086.outbound.protection.outlook.com ([40.107.6.86]:28822
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229491AbhBGNLk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 7 Feb 2021 08:11:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMkcqPjGE+0pknLWPrVh4SwV5y+jDQWj83qqk5+OBjWBMHJju3yrypi0ZHtowSOaxzldFnJeKkad//YfJC8WIvDy+9iNCiNTYRC/EuFmlDCEix2WoT4Urna+YiAbUOK8a+lp+5cpMEXgari7TVIoetXds/awPXjcxd5QHHFa03Xbe033Rdyjk3yVY//jpgTNocnAWz+VE70UY/BEfh3HL8mHUwnsfQ06pw5R9pjGRmujGwQZr99TBHOFYz6/YV/AngyyVifR5BmJfdo0va9M0p4dkKF6bblhJV8V4CowdIMtYrz483cRvNwnA2TbnARoo/1cuZu8nvpZqFMPxMR7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eYh5MHJ9Rn6qOvDJuPHRSuL2PlMKOWDrB0yAYsfO+s=;
 b=XuDra1SQkDN/pR08B+Itv5g7yR7BpJNJCFfeZKuzWgoPM21TKKzuwyO8laFCCn8z+hWj+L3p6SupKdcyVgZVCS40TR/jUQmGxurcrkI+/I0oChBVBcWnO4NOsbEnwo2ztTfwvPmyBkZOKbswD07BMRru1QCAxjcFLqGejPRa3Bt0+XFOJa7yutFpSJF2to/Y+xEEzhmB4yPNMDdyq+uGvlzHd5lb6jOU5CYjEXpJcEWa+m44i2toORcredk4wbHFKupoX+OFNQGEysEeiUTH1ohPS/ZJjl9d8gCFrG0Me+G3NVDbO/t3A6pnHL7cPEbK7uo40RQ4pvBR/wBgeV5J5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eYh5MHJ9Rn6qOvDJuPHRSuL2PlMKOWDrB0yAYsfO+s=;
 b=ijaovIg/vvnI/kXCY70MhEdjqFHxFXmrMamSOcJe9bJdhguupxm8hbhEYB80T67D6QePaCCsT9WckmjASEx5KdiXwHL+mWpb6bxsu1DIDoizr1AFEnbmCZyLBxA997KHoqi7P0NGi/X8Q+eJfyTbsM7wnFU1tBbr06jUk8G/o4k=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5465.eurprd04.prod.outlook.com (2603:10a6:10:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Sun, 7 Feb
 2021 13:10:51 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0%9]) with mapi id 15.20.3825.024; Sun, 7 Feb 2021
 13:10:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 0/4] imx esdhc dt/driver update
Thread-Topic: [PATCH V2 0/4] imx esdhc dt/driver update
Thread-Index: AQHW76RVLKb1OEKwmEWX0lhOZ4iaA6pMxeWQ
Date:   Sun, 7 Feb 2021 13:10:51 +0000
Message-ID: <DB6PR0402MB2760CA4A3D7DC4D5D6C3D81A88B09@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1611198593-16287-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1611198593-16287-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc5c1550-d100-41aa-2e1d-08d8cb69cb75
x-ms-traffictypediagnostic: DB7PR04MB5465:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5465FD3BD3CF4F0238BC8A4C88B09@DB7PR04MB5465.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kCNJp+85EsYFu0WANO92MY+PjrQsaO+KC8OLnLonBN/nUY8hVSK30ckqkjEFogtMhjgQTgegCLyPTrPLI8+BX67ORVRTowXG+g/mgKpTre5hHw7Zt9bJGku9m/3+eeTjBg2LwiNhgCTTie1wk8sCLrFSAIj/ux4iYptlLnyvu3y5UcunAgon4M9JQX5UF8S7IvDNq3/EMFfBFtQi6CRW4xNSzHTPBmFqmfj/h6xTsJcvz9//0t2C9dY2GVG1IJ8VfB/1oM/BRbqGu617MTvPHpOTsoV1psgnqvQf7UcNg2JWnEe2O8UiPszne/CtM8iyfVvQPNAM2cWu3fBTnomWYx+jjzIcogpVqKBmIEaNOKn3Jcba4eNAnQb8GIXIpA60fg1DOrAS21vQjwxhtMTzdVZCXapFdr60URwryqDCi9gLwtu3jAIjHQZcJq9NR7XIjQlBzru1lxNLJgd4NRCtWs/ZEuaBlYNazqYCawTvn3SE/ojZkt9bgEEG89UpiWbt1W2iXq4eihWKrG7fsPKkYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(64756008)(316002)(66446008)(2906002)(110136005)(8676002)(15650500001)(66476007)(66946007)(6506007)(66556008)(33656002)(71200400001)(55016002)(7416002)(8936002)(9686003)(76116006)(52536014)(7696005)(44832011)(478600001)(86362001)(4326008)(186003)(5660300002)(26005)(4744005)(54906003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MrwEqpCndnwvX5SKCDfql4tK+0/MGsRIiv6O22oCV705oRchNKze4anfLL3j?=
 =?us-ascii?Q?AtiF8sZH3NsWeT6Ij/jwNPS1ISTB75z3/dEqadvwhCmR80e1ua+x47IHj4mj?=
 =?us-ascii?Q?8aSe/YWAr73jqsEYgFZhi5aQG3EX4QOdENOiAyTnA4Yv0LkiHqTXitYtm5Uo?=
 =?us-ascii?Q?zpO64g0PeEDySDIEI39buckv+5CKeCQTcXlhO/AEAE8F0HN2VLDUk03pR7z6?=
 =?us-ascii?Q?bNo71OGKRcRV90uQLfQp5+rNou78ZLR8IUVo4bUMwLScd5wx3Ua8/7aMCCUu?=
 =?us-ascii?Q?/wp4YTDdKM/k7GmJBU/1FFBJWqA0+RcbyOnskAoAjOFaut7dwRwtGisaIOT4?=
 =?us-ascii?Q?/gtf8Gc9KzM5Pn0PoF2sWcGf++Wy5LuGuDg5fpPC4qWT/FhZ/kKLxHdMtx4D?=
 =?us-ascii?Q?vKLahTyEC5sTM8QQW74/c4b+Ii6EsE27/69yDl5VvWF1VABa7xgwcnJII6a+?=
 =?us-ascii?Q?4rifSBlbNupSryK/9VVkhtC/WTI4tx1a8vHbNPPRRX0b6mYtFVwaALEd/VrB?=
 =?us-ascii?Q?7d6ikafKKYmrwEmK5Xgamv/GOIEYrBOFtruZ+iGZ0CsDK8tMsJglesfgNE+5?=
 =?us-ascii?Q?YJh39ZBBsiQ520GtiPGOkLZpJjrkjyVnHJ+dO6fjKmsKnKSXw1YM/acxLiea?=
 =?us-ascii?Q?pV8MdcGuwuupn+Zc9iA0yQZ74iCcbokD8ebN++8lmenEOoLwK6fc99FpAP+o?=
 =?us-ascii?Q?CIbu2wIHm05pvaWz88+o7G1DyXTy9w/3beoJEfSPRYkZm8VwegHLYWsKrDFf?=
 =?us-ascii?Q?FvPj+lK5uqQA7gEsVdLAUxHaEefwcRBSWtWw5DYObqeL5FNX4ipTTCb2s62L?=
 =?us-ascii?Q?sSJ9KmF6qqrRQyb/fvZ/Tc2kyIQzBY+RcIp4uKUrsYsz/tMnFjK8T4VcOF/y?=
 =?us-ascii?Q?r2FE/0lH6qArWBT9lkdu6j9LG4T5IqUKsvgud4JShrXT+un3CtuOoZg38UTC?=
 =?us-ascii?Q?+yyV3AHVD/nHab/BmPD3HSIYnT+O9DV6OfWpIpOji/kCBMpkq685Gh8RbvOS?=
 =?us-ascii?Q?boUUX64L0Mhy6VXclkrFZ01vXLJ/wQKn1sbOMh6DS8/8RMXn4jey7vWc3O79?=
 =?us-ascii?Q?zpQzcvzU5Yy5iqAzVt9PSe/Gw7ADw1aVrT3JDMFjcWsTGy4zcfRGevUg3T+9?=
 =?us-ascii?Q?FU0sNBpIvo6TUDQMJPSOshGcTNcMMWuG0XTTvm8K+45IxRfBxy2JB0pWipUS?=
 =?us-ascii?Q?CRGC2QM+wD8eBC9HZZV7CO1apQOus6ZlKJjLjaZzx1JheWoQBbJtg+Gjz4f7?=
 =?us-ascii?Q?8q9wiG5zk/Smj9slNL4aG5C/9FszCjsJCdqRp+Q/sqZyckmsrlcktEX4ovnb?=
 =?us-ascii?Q?M6ijNw0juI18G9K3VcgfbSpe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5c1550-d100-41aa-2e1d-08d8cb69cb75
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 13:10:51.6764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRZIjOaJ0ka3eEESXAQt74LDCnuhX0ZHHdw8mDAK68GKgVpiay9j4u3/x/y7FQl0j8CVoWtRpeH5N1Y+/da60Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5465
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Subject: [PATCH V2 0/4] imx esdhc dt/driver update

Gentle ping..

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Patch V2:
>  patch 1, 2, 3 is new
>  patch 4 is not changed
>=20
> Peng Fan (4):
>   dt-bindings: mmc: fsl-imx-esdhc: add pinctrl bindings
>   dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
>   arm64: dts: imx8qxp: correct usdhc clock-names sequence
>   mmc: sdhci-esdhc-imx: validate pinctrl before use it
>=20
>  .../bindings/mmc/fsl-imx-esdhc.yaml           | 36
> +++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 18 +++++-----
>  drivers/mmc/host/sdhci-esdhc-imx.c            |  2 +-
>  3 files changed, 46 insertions(+), 10 deletions(-)
>=20
> --
> 2.28.0

