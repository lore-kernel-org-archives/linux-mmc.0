Return-Path: <SRS0=1974=Z2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A36C432C3
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 02:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CA12073C
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 02:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ig2PHB1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfLDCS6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 21:18:58 -0500
Received: from mail-eopbgr40054.outbound.protection.outlook.com ([40.107.4.54]:1927
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbfLDCS6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 21:18:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwqzhNUJCXIJL+eyc6TZcIyPkMY2ZlRKv2mAs1z3J727bRFqfrvBez1Vk2+QaUY79aOIzvMgLjvt83BVjf5uuirc0K9Qi4siOHpEOmwGDUlwrBftt6I0bmLNwDw7feCNDgSfPyVpzJAe5Y8tR3oyOJIkEQoMVTRgPXnyExYgCOYNQSDZnNhET3QNBgHNHdpBWpXVbkikXxvTAs6oeWCiTr1rCEMNSIZaKk5IX4PiKNVqUelnJBaC0jKdrVXzx4iMAhFymfYTUJZ8bi92vgHe9X9/s7i4BmZIBmhKmr2SUzLbsJBy/da+A03gCmduc1NVIKcT9da4reEGaFMjtDun6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjZ1kNn5QabcK8oPIrI9iZtZD8khhk/a53JAZfnKrys=;
 b=mEv60Ou+4WBMsNvz9ZjUlSaNGuymWhZokzlXJWPbEgoY5ZxLsv9RjNtTz4xUXumMocpCJuPdMZg/XiZDAthxnIX2wTLPi7xJj1iwrbRXF67wm8mLN0AtlbbylDywV7eVhfAOgyjAvFEcfc7sARXJ+lD1OuJkSzky15hhNQWlgyYtfbljVlQoh+NHeIJWNHswSOyXvauoQW7SSQbvyVqiH+VDh8ZgMuSJWOJrl1h4DnllwHrq15PpN6p15VCFbOTJ8Dbc5lLbXNT4ajONgfsDuQgW4MV0BTlA7MtCa8639m5TLKmV3mbBmIAjYD29cNS4qDyDxZrT2V04I1xPPlHl3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjZ1kNn5QabcK8oPIrI9iZtZD8khhk/a53JAZfnKrys=;
 b=Ig2PHB1Mq9bjow1R6JLBVbuxypXlSpRc0wwAcxVxTo5ANcD/BEYIWTdAnvQrNupvXQCcDvXRaP0r9FHCBeNPYtnPghU2XL33NG/JOltQ3acksHQmggkRw4Y1rki4rHUtBInJrtPjRVCvxFzN/TroA4G1yIqsRi9XObT9YI9YF5g=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB5056.eurprd04.prod.outlook.com (20.177.50.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 4 Dec 2019 02:18:53 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 02:18:53 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 09/14] doc: dt: fsl-imx-esdhc: add auto-cmd23-broken
 binding
Thread-Topic: [PATCH v2 09/14] doc: dt: fsl-imx-esdhc: add auto-cmd23-broken
 binding
Thread-Index: AQHVqkks78GOLEyThkiqDuMepXaJCA==
Date:   Wed, 4 Dec 2019 02:18:53 +0000
Message-ID: <20191204022537.15500-1-haibo.chen@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HK2PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:202:17::14) To VI1PR04MB5040.eurprd04.prod.outlook.com
 (2603:10a6:803:60::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0bfd63d3-c30f-403c-cca7-08d778604eba
x-ms-traffictypediagnostic: VI1PR04MB5056:|VI1PR04MB5056:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5056AB209E996648765227BF905D0@VI1PR04MB5056.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(43544003)(189003)(199004)(316002)(52116002)(102836004)(5660300002)(305945005)(256004)(478600001)(4326008)(14454004)(54906003)(81156014)(1076003)(7736002)(8936002)(110136005)(81166006)(99286004)(8676002)(50226002)(186003)(2906002)(25786009)(6506007)(26005)(386003)(2201001)(2616005)(66946007)(71200400001)(66446008)(64756008)(66476007)(66556008)(2501003)(6436002)(3846002)(6116002)(6512007)(86362001)(6486002)(36756003)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5056;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HKWy4orlNeGyYNqMPK8Ji5eWxI+EKGtEC3AjJLkAslAhDppPksRexVf+A2D1i/V99x+qOowM49+uoejIs8xXqKUd+2XBJwzuNrzgBf+Evc5bAGsGUHEeQMC1miF85N8TKyc2t/JMI2B29KQP2bOnaB2Icc6XWdU68i/B8bzRSDHbULkumK12f8nc43r/dKMLgixyFv0tLC8XVRaBWXbWVImeJu8w/czWytt+uodqS64HHE8On+mpuUvrHx2vgLmajWcUsuWk2OVMdU/ThA6SFUVH4KTqP5gsaYLSqGRRs8OwrislZAI0I5fOpss1nW+BrBc0MSP3815F6Yze26+3G++37l1mZqKflYStBxvqO6uvRC9A3y6WIy7+5Si60zrt8tH1/+m99zInaBxtM/LCERzNQHYSGvO8BuGUmeIKCqTs78RsaptwNW0I4hJrHz2lff4kVS3Sh9uXP/4owoTw95t/rjLJL4oZZY6BQYLCesYFaQqi9ESlIYhMaI+tD8eB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfd63d3-c30f-403c-cca7-08d778604eba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 02:18:53.1331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: We13iL4mnG22ZshZef2H0y+w8xaVMnGAo8eSPPCun/nb4Eab/LT97Tbn2FWvyi41GkhbHdmwQdTLkUZROYBmzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5056
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

