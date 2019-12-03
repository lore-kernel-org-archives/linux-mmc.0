Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF48C432C0
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E4A206EC
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b8H5iKh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfLCMzO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:55:14 -0500
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:33645
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726079AbfLCMzN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 07:55:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu0cSeD4dJE00umYmyhPCW8sGXnwJHdSGuyvMBNOZYTfUYz2036+/3AUBCNZLuTYBp1+yuY2/nwEx7IUhtn3T8giBexyp4/t6u3of7hJZVW3D8AJDGBSyto83555hxnnTktlz1Qw0MvKqdrxkPWEbke3drVAYRoRbEVugKTWBkG5VKGErYxVxt4IpqtTVn85Vjn68RXL/3/3TtLq6taCVplgDgSxQw8mVU7ohJCy8m9UEnDxbx1PG5oQKJ31AQzecC6OcuzHxo7zwLWkiDrFHB9TJ18wu8Hn4XQvONJFxAHg0G94KQ90qG0iCQqzoXoqYTm5fbEDiy1WcO/+wkM/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjZ1kNn5QabcK8oPIrI9iZtZD8khhk/a53JAZfnKrys=;
 b=Uj9FscZbwGqMfda21azBqRuPV7Sfm9D1kwYRDsM237POhi3mQbffYmBF+kY+qgVVxHKxR3+9xeDtWIjPSMEz0XAow4WrdoPdA4JNHjdFskfonPJg/jmsZ8NQJQ1eUDjtSyOrEThJ2WAruz7VzAAQRCm8hAKyM+ZCpoXb9JCNiaRDGnuyrXWtYuTGgfhzYR60iF4/26qqA8+8OB8qJ5rkoHg1ZFsvpUB4aAZ57MWkf9eVgIhAGanSGphIpIeqAzkG1ob3gABw5LYOjQIxmm3QBPGe/PIMJIZEakN9Hf0B5EU6eDQBK91AWUMMzDcoo3w4tJpBLksysfDt2A0hevmbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjZ1kNn5QabcK8oPIrI9iZtZD8khhk/a53JAZfnKrys=;
 b=b8H5iKh9e8GbQnqPDeEKI7/yNapn/ZWUFw3fGIl3CbFu9lWHzx98+vWT96x9PVkI0haa4QJdrFQpWzO+/yaKGV32FlAm+/Vj66TvWjhun2ambwOqpaMIBz3ihTRN5jr7CHzOULZLg8YfSNR2VKXFN4ZdVaNyaSvwtVjNhwrUkRs=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4175.eurprd04.prod.outlook.com (52.133.12.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:54:41 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 12:54:41 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 09/14] doc: dt: fsl-imx-esdhc: add auto-cmd23-broken
 binding
Thread-Topic: [PATCH v2 09/14] doc: dt: fsl-imx-esdhc: add auto-cmd23-broken
 binding
Thread-Index: AQHVqdjTjLRtJqjPkketBWV+YO8JRw==
Date:   Tue, 3 Dec 2019 12:54:41 +0000
Message-ID: <20191203130120.11511-10-haibo.chen@nxp.com>
References: <20191203130120.11511-1-haibo.chen@nxp.com>
In-Reply-To: <20191203130120.11511-1-haibo.chen@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HK2PR03CA0052.apcprd03.prod.outlook.com
 (2603:1096:202:17::22) To VI1PR04MB5040.eurprd04.prod.outlook.com
 (2603:10a6:803:60::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf9fd215-2834-4a11-5b25-08d777eff64d
x-ms-traffictypediagnostic: VI1PR04MB4175:|VI1PR04MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4175295B2AE1FE94D76C6ABF90420@VI1PR04MB4175.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(43544003)(189003)(199004)(316002)(54906003)(446003)(2616005)(26005)(110136005)(2906002)(11346002)(50226002)(8936002)(186003)(2501003)(102836004)(99286004)(386003)(305945005)(86362001)(76176011)(52116002)(6506007)(7736002)(6486002)(6436002)(6512007)(1076003)(5660300002)(66946007)(66556008)(66476007)(64756008)(66446008)(14454004)(36756003)(25786009)(478600001)(256004)(71190400001)(8676002)(81156014)(81166006)(71200400001)(6116002)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4175;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: At9R9nczpeUMq/qjCnR/5+G4SAydp1euP2zRKmPArl9IqaNnvWh4IVnqQGgbwv1vu9x9051LJqX84XIvZSKFotROprBG50974K4YBPNCykK2zy37aW3MV+fr8LP35sH34Sc/1qOqVVNriy7a2W2KaH/fRACYEi/hO0fHmsRpdJEla4z2mzzqQQotVTlDlgj65DAttzdtTLu/J6IB+hHbqXXpyLuAYx5Dc5VgCj4h9mCD5VzvY9RJCdgRsv65qOKuQAzexlmF4OcpIjakEvhF8zAVcOFobeC2fPd0wFMl1lOONBkzvCtbedkHOUlZTElMAy9iY4zbNFWfoz9A9MXo7PLJXkuWBkE/FM9iDXasPHo9quhn69Op2rZaoRxBrceFQBbd99ZgtU6XUGpnCDmDSO+4qK+j89XxV3aB8O9CK9++k2APyyNevrK9WVi38EpmBEShJH8YnOc9Widxeem9SUJNiSaDarbCG2ZrDuUUG7OROZothXJ+CiWHxoRWpWvQ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9fd215-2834-4a11-5b25-08d777eff64d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:54:41.1407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBLZXpe/YRbYsj0ZlVBtMSUspu9Xxi1BE7l/e7FSPBc8O/lL1Um6yXeDeSrzTerzb6YTM9AM3cfhciuH4qqACg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add sdhci,auto-cmd23-broken binding.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Docu=
mentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 89b986a2f9d5..7ea8e0f14e5f 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -46,6 +46,14 @@ Optional properties:
   property allows user to change the delay target for the strobe input rea=
d clock.
   If not use this property, driver default set the delay target to value 7=
.
   Only eMMC HS400 mode need to take care of this property.
+- sdhci,auto-cmd23-broken: disable the ACMD23 function of USDHC.
+  This is required for eMMC on imx6qpdl/imx6sx/imx7d when it use ADMA mode=
. Because
+  for these SoC, it do not support the ACMD23 completely, only take the 16=
 bit block
+  count from the 0x4 register (BLK_ATT) as argument for the ACMD23, the up=
per 16 bit
+  of the CMD23's argument is ignored. This will impact the reliable write =
operation
+  and the RPMB block write operation, because these operations need to set=
 the bit 31
+  of the CMD23's argument. SDMA mode will default disable the ACMD23 mode.=
 SD card do
+  not has this limitation on these SoCs.
=20
 Examples:
=20
--=20
2.17.1

