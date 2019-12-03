Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38CFC432C3
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6FE206EC
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nBmMSHep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfLCMzP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:55:15 -0500
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:58425
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfLCMzP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 07:55:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFJ9TJ9KyyGws6mD+KT0+nQCWx3baCQT0CZbbztqRoH1pz5OIDBXYyBb9twjRSr51+1oE6ygi3zV7GOr4/frxcbY/oHJ36jY8esLcuCE2lDPyE09qMqJtj48MOyizkw/99k5gwRhvjEfgCdbIdoES4sEUg0AgDu0PagAlq5UIPO0tN52dykRc0f6S2E7k0eEd9VR1T7T+f+/3n9luNDRlTaB1ehS4ZjbZZEFVCieLg1+Vi+0J9QRWIxy6wGkg9P54RAOORx1Jm1jD5Of3ySJRbGcfWbHPB2o5aJja2Nx3xyjKWe05tzT35jxpyvpSAEJV3SkgD/ZKoijoviKBcjo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If63YVvszuJfkk25g6OT210eHJZClzVbHwdKzVBOdNA=;
 b=M6nQa65MeQdJEHyuIfhOuJp7GuIELFDd2NsIkygPyCHaB82f0bXIw2ctqZsv2JzILYQizRgzMgh9e7cMY3EkTupw1WjljEkYa3f9JIm9dwUZT4nLOJIS/hgFJMusHYZ0xd1/SlzcgdQBVstYMvU2uPl6NrkJoV6N3fhWHqgiGaPOfJ+yJ0fowu6zCbtnpN2KzYs/p/019SFjM8PFI4ZZkkIFCQ5OuveYkE3t/RKWlvxnM7FCldij9LnMhHGnfC5nlhiGgXwaENQ1gc2l1izmwJYj08/aB9oLTqvJUuNf6WKeUNx1/Hur+Evqxc9pkFH0DVLq8ZrE4i5u7/yYPkwvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If63YVvszuJfkk25g6OT210eHJZClzVbHwdKzVBOdNA=;
 b=nBmMSHepaJwTEDBwX5z0GcwG/0i368ZbSqRjipfSnwnjU+E7PJOjHKzPQS1A1WEOAGpram38+kwJsL/5D0rTYDlPQk880BB5F8OzSUsg4VsVkfeeonGgUnmZkYmG6OXaHd3cwJIdVGz1BVBPLC39JgYZV6C+6wgx8q3JbmveRuU=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4175.eurprd04.prod.outlook.com (52.133.12.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:54:32 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 12:54:32 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 06/14] mmc: sdhci-esdhc-imx: add strobe-dll-delay-target
 support
Thread-Topic: [PATCH v2 06/14] mmc: sdhci-esdhc-imx: add
 strobe-dll-delay-target support
Thread-Index: AQHVqdjO3OyZWtmIiEeElCDyjtyv3w==
Date:   Tue, 3 Dec 2019 12:54:32 +0000
Message-ID: <20191203130120.11511-7-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: ee7bdb8e-b183-460a-a79d-08d777eff101
x-ms-traffictypediagnostic: VI1PR04MB4175:|VI1PR04MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB417544949CA3897AE3D3891C90420@VI1PR04MB4175.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(316002)(54906003)(446003)(2616005)(26005)(110136005)(2906002)(11346002)(50226002)(8936002)(186003)(2501003)(102836004)(99286004)(386003)(305945005)(86362001)(76176011)(52116002)(6506007)(7736002)(6486002)(6436002)(6512007)(1076003)(5660300002)(66946007)(66556008)(66476007)(64756008)(66446008)(14454004)(36756003)(25786009)(478600001)(256004)(71190400001)(8676002)(81156014)(81166006)(14444005)(71200400001)(6116002)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4175;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ol8KSIarsj0nQjFvBlZzNJtk+LX7EPjRh9W9GYDkcVtVGcWpZcP2gu7xUz/4+rWccDvMlX8HSLsAeuzIoftWrzVxO7cVDDCspX7p5/owgRTwF3ngbEOUJHagW4ZPi+MJusMAv9Htuk1gcC1oAYMy6Akxe2DhDMIe+qict8Q5tqpg5YayuFHzFdqrYTJDQ9RViEYeJ5LieHImMFWX5BFjw6rIJ1JESOWtHHDI1kPgpFBzXudhvjGwN7YEKw3M5hc8sQzlwOHY4AqvxUNpAFb+ONN42HLYdd8hGc03JbiBGATByEQCruLo1W84qmenpbOo0MPG9DlAuBeDY1MJVlyul8ryIo/h6mFNBJStXBl9roZrJuXMQztJNmEvTAOS7Fd85UcgMtxq+GGXSV/6RUs03dc4kZmGwC8AMwiinpT4qCfLjDkOiwKlKt0KzXUDDsZn
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7bdb8e-b183-460a-a79d-08d777eff101
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:54:32.3879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmg1chHzShSDj7Lgl3DEpuilI7HBw/PiKcnCQ+S/dUC1U7GxU18lr8Op1hemM/x4pxsQzqIEIbZGeZBrE/Smtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

strobe-dll-delay-target is the delay cell add on the strobe line.
Strobe line the the uSDHC loopback read clock which is use in HS400
mode. Different strobe-dll-delay-target may need to set for different
board/SoC. If this delay cell is not set to an appropriate value,
we may see some read operation meet CRC error after HS400 mode select
which already pass the tuning.

This patch add the strobe-dll-delay-target setting in driver, so that
user can easily config this delay cell in dts file.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c          | 12 +++++++++++-
 include/linux/platform_data/mmc-esdhc-imx.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-es=
dhc-imx.c
index 0cce4d97f0a5..4b19ac0039f6 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -73,6 +73,7 @@
 #define ESDHC_STROBE_DLL_CTRL		0x70
 #define ESDHC_STROBE_DLL_CTRL_ENABLE	(1 << 0)
 #define ESDHC_STROBE_DLL_CTRL_RESET	(1 << 1)
+#define ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT	0x7
 #define ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT	3
 #define ESDHC_STROBE_DLL_CTRL_SLV_UPDATE_INT_DEFAULT	(4 << 20)
=20
@@ -995,6 +996,9 @@ static int esdhc_change_pinstate(struct sdhci_host *hos=
t,
  */
 static void esdhc_set_strobe_dll(struct sdhci_host *host)
 {
+	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+	struct pltfm_imx_data *imx_data =3D sdhci_pltfm_priv(pltfm_host);
+	u32 strobe_delay;
 	u32 v;
=20
 	/* disable clock before enabling strobe dll */
@@ -1012,9 +1016,13 @@ static void esdhc_set_strobe_dll(struct sdhci_host *=
host)
 	 * enable strobe dll ctrl and adjust the delay target
 	 * for the uSDHC loopback read clock
 	 */
+	if (imx_data->boarddata.strobe_dll_delay_target)
+		strobe_delay =3D imx_data->boarddata.strobe_dll_delay_target;
+	else
+		strobe_delay =3D ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT;
 	v =3D ESDHC_STROBE_DLL_CTRL_ENABLE |
 		ESDHC_STROBE_DLL_CTRL_SLV_UPDATE_INT_DEFAULT |
-		(7 << ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT);
+		(strobe_delay << ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT);
 	writel(v, host->ioaddr + ESDHC_STROBE_DLL_CTRL);
 	/* wait 5us to make sure strobe dll status register stable */
 	udelay(5);
@@ -1340,6 +1348,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev=
,
 	of_property_read_u32(np, "fsl,tuning-start-tap",
 			     &boarddata->tuning_start_tap);
=20
+	of_property_read_u32(np, "fsl,strobe-dll-delay-target",
+				&boarddata->strobe_dll_delay_target);
 	if (of_find_property(np, "no-1-8-v", NULL))
 		host->quirks2 |=3D SDHCI_QUIRK2_NO_1_8_V;
=20
diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/pl=
atform_data/mmc-esdhc-imx.h
index 6c006078c8a1..0434f68eda86 100644
--- a/include/linux/platform_data/mmc-esdhc-imx.h
+++ b/include/linux/platform_data/mmc-esdhc-imx.h
@@ -37,5 +37,6 @@ struct esdhc_platform_data {
 	unsigned int delay_line;
 	unsigned int tuning_step;       /* The delay cell steps in tuning procedu=
re */
 	unsigned int tuning_start_tap;	/* The start delay cell point in tuning pr=
ocedure */
+	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe pad (r=
ead clock) */
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
--=20
2.17.1

