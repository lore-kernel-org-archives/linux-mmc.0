Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6E3C432C3
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB5B2070A
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KXRYMF0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLCMyc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:54:32 -0500
Received: from mail-eopbgr30054.outbound.protection.outlook.com ([40.107.3.54]:9306
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfLCMyc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 07:54:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxhweOBKbTY2Z+JejtuTl7U11sCMeGd9IoJjwfIn6HPbU8Pk+0vFvHg8ZIM2aJfmy+FTOvKCC8Ls1Kn8zcFjlI16O8dtC6aOvFRIJGAjZLNI52aVkWemg6AMvHVPne9X/ztlzRpHwO5+vJdfHZmxDZDx1pI0gyz8rCWv5/1Yy5YkITDduKPjMzngDN4MzDO6sdWZUU0LrmDg4dzM/0v5xj4KQ8xOMTbcN+Nlq6jWArYH+PQd3/n9OCX6SDFt+/zQeVM0ohTFK5GSo15DsuUemtR+DYMyM2mcUxvrYILJ5WyZ5rWoWWwwNwmDbccrnLGE4/S6xneaCXM8y0jDIlI1bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLceWLpfZ2/TghsK04OcCVxmkfHtlBjjJV89+kjwVfc=;
 b=WxmvtBMSxV392z2hohSpVaMfykhvHnR1ln2qbzWMLBzE4oCXOIFz1Mvc2XlpMFuAqIGrexoTq5Yq8/toK1HW756Ks1B1fKt3smi8s6eyDxX/win4MO352MIfKTkS/1Ol3Y0cA70ngzzfVZ7OhW/JJkKV41qvv22rUWvb38Qf9Z0mraLfrpc3FARUwef/LNo1ruX+v00wOskhPVrh95+PFAWQ90lofYFRZyEsZWp0GbM7YuWamal95ZtzH1ekQYyYBpgbqHKVIqmAY2iQHebCRiy6eVWEurh9g8X5fmNFtDLmKWv6Xw2uff5Jmnd3i+IZuYs2dJMJMopEt6zraue5pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLceWLpfZ2/TghsK04OcCVxmkfHtlBjjJV89+kjwVfc=;
 b=KXRYMF0xSW6o/oUCt9jl8YjFTzFUMiPSwmnVKR35r2SHD02iT0qgyTwNFJpjBfz2l8TkqkvjE7NxzkKBsENFs0qOC+aOFn8cmuywwxMjSayechKLlepqx7eyH6rDkYVsP3qYTZiki11fw9zqg/53os4XnO+syfaz/MQyIs7OlkI=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4175.eurprd04.prod.outlook.com (52.133.12.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:54:29 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 12:54:29 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 05/14] doc: dt: fsl-imx-esdhc: add strobe-dll-delay-target
 binding
Thread-Topic: [PATCH v2 05/14] doc: dt: fsl-imx-esdhc: add
 strobe-dll-delay-target binding
Thread-Index: AQHVqdjM6d0A2BMEJEmSplPKQapDaQ==
Date:   Tue, 3 Dec 2019 12:54:29 +0000
Message-ID: <20191203130120.11511-6-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: 64db80b8-344e-40e7-84a4-08d777efef29
x-ms-traffictypediagnostic: VI1PR04MB4175:|VI1PR04MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4175FCA8069D4DEAE129F7AD90420@VI1PR04MB4175.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(43544003)(189003)(199004)(316002)(54906003)(446003)(2616005)(26005)(110136005)(2906002)(11346002)(50226002)(8936002)(186003)(2501003)(102836004)(99286004)(386003)(305945005)(86362001)(76176011)(52116002)(6506007)(7736002)(6486002)(6436002)(6512007)(1076003)(5660300002)(66946007)(66556008)(66476007)(64756008)(66446008)(14454004)(36756003)(25786009)(478600001)(256004)(71190400001)(8676002)(81156014)(81166006)(71200400001)(6116002)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4175;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nSQtSgEIo6cG8/a6a6kJEn7I80FKNyYOXOhbLThEuvuTrwTV6jJquLW7swyvWi6CtqBhMUNpj+sDdQXoaNKwUCMae1/dog9gL6OToXECpF1I8j+zlK14K3bTu2I5KbfQ19HTg+UAhZqHDm8CHjamB65Sl/ZvLq5UUTJCkd8ZGkNaCyI3ZLu36C6fpnVopI3qqqigjBvK8nntEGS+nw3s+HpVKczZo1tMXCFmHUzTOXGmziSrUABHr57ZQUXCQE5xHU1yHvdOCyAT+nNkkTiuauQ4JBrGy5ZGVkNuO8bcZZwZrqr4WL5JFFlDPwpNg5nAZJoHLyb9UCFvcpoVtJex2HZN4KqcNcvsse6U8ofCM8H2SglFuvVSWHdOzugWUjsq6HAShA3UEVw8yVrPagKNA64YaaC3tpiSxO8c0hxe9LB+D7Vgod/18SrNUY+EVR17olJfm76J7BxybeRax89nEDajgV7lMKwBEjdvRroOVREyPpDtoqvdiPS3cbvaOsaC
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64db80b8-344e-40e7-84a4-08d777efef29
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:54:29.3406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkh5mX0PI+DsH+u3S5yiqbQp9gMW3LoFLE15SvpQeW39RDliR1fe4ABNZmPuJq6zNP1yFN1cG2puico4tvZp0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add fsl,strobe-dll-delay-target binding.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Docu=
mentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 2fb466ca2a9d..89b986a2f9d5 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -41,6 +41,11 @@ Optional properties:
   This property allows user to change the tuning step to more than one del=
ay
   cells which is useful for some special boards or cards when the default
   tuning step can't find the proper delay window within limited tuning ret=
ries.
+- fsl,strobe-dll-delay-target: Specify the strobe dll control slave delay =
target.
+  This delay target programming host controller loopback read clock, and t=
his
+  property allows user to change the delay target for the strobe input rea=
d clock.
+  If not use this property, driver default set the delay target to value 7=
.
+  Only eMMC HS400 mode need to take care of this property.
=20
 Examples:
=20
--=20
2.17.1

