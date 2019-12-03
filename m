Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2CBC432C0
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D792073B
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WI+rVJcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLCMzR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:55:17 -0500
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:33645
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbfLCMzR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 07:55:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cb4SkYl4Yy5IultsZhvfKNtXs8Sdcj0QNCsFVUlxQfVvJl/96DHhOLkHMp+P4Yx6dk5/P5rr1829kvOsPxDDbAK8tjUj9ACa6hNL0EAYxCV9hYgbZZRrA1AbSkrbLhJxP9ewuDYXhYor+Vt9ANsj956s3/IcmEujY/FdiFiDY+CUbwcFVByx+bvgNuWysEkyz4IYV5RaGOwayyA1E1OPfR+oHJbntC96RE8eq6ZuEInvszQhWI7untL+nfzxrac0JSLMQyfO/BDmAmFaYzgHCSsdfIxlFKAyudz4r2oNLAfjAH48FM3FGYFAU337bIVxIHdBlJe870wNTPzrY2Rjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8qm0zf1Nh6iwRQ7SQ5NMAEOoCFLgUAb2Aafb82K9N0=;
 b=HowAhLIf29j+K1csYQIa5w7mhGNTIfiphkcxtaEkgFfgVyqU40sW2zDk22qCm8Vgl984XyXWTorFaXT9wUXLU26n8cboLEgvKln/AGlfZNxQbEKUf25iCi+3h27PrF4flIDz5zTCUvtB0KjNRRZ5NyJ4aT/NIduwlczQ757X0aCyfLD8Lj+diZuBnHpuVZd8cIP+VGpW8dZ6TFvoGNIkaX7JgHrV5oopUQweNsAoN5ddp9ifyHuOtmT3swP1t5WzU/2kE7ScLzaZ/LimhM9QwZRU4UUH5x6XodKugVo1PEgF4VCRLAZMRfLBMgyFUfQ4HhlpP/VkzeFsddK5KbwVgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8qm0zf1Nh6iwRQ7SQ5NMAEOoCFLgUAb2Aafb82K9N0=;
 b=WI+rVJcNU+ZVyo0hP7C8ES51p7j/l5MT9WSY88QJkkiHARuoUxyaVY68x76LVd1chOXzmb13PuOmTIn2tU9xFUcapbbi96wmsKIH9MWTCl/jITP/0omGZPO26q7jFDtVNUtYCk0odetDFHl6cHphvmEHk19fWuGE50buFXJDt3U=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4175.eurprd04.prod.outlook.com (52.133.12.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:54:44 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 12:54:44 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 10/14] mmc: sdhci-esdhc-imx: handle
 'sdhci,auto-cmd23-broken' from devicetree
Thread-Topic: [PATCH v2 10/14] mmc: sdhci-esdhc-imx: handle
 'sdhci,auto-cmd23-broken' from devicetree
Thread-Index: AQHVqdjVnj+SfUHe60GBHKj3bIIkxQ==
Date:   Tue, 3 Dec 2019 12:54:44 +0000
Message-ID: <20191203130120.11511-11-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: 1dbf8318-cae9-467a-7d99-08d777eff81c
x-ms-traffictypediagnostic: VI1PR04MB4175:|VI1PR04MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4175128DF0812826BE923DC690420@VI1PR04MB4175.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(316002)(54906003)(446003)(2616005)(26005)(110136005)(2906002)(11346002)(50226002)(8936002)(186003)(2501003)(102836004)(99286004)(386003)(305945005)(86362001)(76176011)(52116002)(6506007)(7736002)(6486002)(6436002)(6512007)(1076003)(5660300002)(66946007)(66556008)(66476007)(64756008)(66446008)(14454004)(36756003)(25786009)(478600001)(256004)(71190400001)(8676002)(81156014)(81166006)(14444005)(71200400001)(6116002)(3846002)(4326008)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4175;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ht6oSBEEVdqKaIxT9Wlz5V/eVg2Jg7J8GiDSkTEoNQ3D4h9ATtqHHhV0RmHtih1Ujv3DVzVcvtXM7eXdVeIpj6wxLOWN8GcEkXolT043dc1B+IdmrM+5um7YlMPJAagJ9tjFtKM76q+JgTbe/3aKFOpsiYEu141XWjmiOFX7wjFJPHfzdSbgB2PuNqPTMak9QKIMIJwl42GP8BqQQpO9wlIstNX7YOSBewvjbcwOWpTs8wlmOeSeuE+HyISS6jy8ZrPU44DlbeVhuCUMHGe0U2D2ppo6MHobs5BkwzFfoEBfLYXgKrA5qyTgu6Rfq4psBmqLP8gJopNZZ+pJ2bk5EpFEF5yH8mdVIHEux+1OsUWTkcORyP6pIg58pXjQpKujLhJqedvdyl6ZgBMagYDZ9zPwK8KiYxe2mE6cuIT95CMcEDqYFil6yR67NG66drWGqbbI3TbrovrgtKCZSiQ/y6qoKZGedsdX8wZOnhccXrefEuU9/WJuo0yQDU/eV4a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbf8318-cae9-467a-7d99-08d777eff81c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:54:44.1659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26qOxbIyLar7bYvlcKVa1kFHln8KVdb9HR/WsXGd79AXzLFjd9iLu3o5pxkMrYxaeQ9ckANezv6w3VjOyyilPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since L4.15, community involve the commit 105819c8a545 ("mmc: core: use mrq=
->sbc
when sending CMD23 for RPMB"), let the usdhc to decide whether to use ACMD2=
3 for
RPMB. This CMD23 for RPMB need to set the bit 31 to its argument, if not, t=
he
RPMB write operation will return general fail.

According to the sdhci logic, SDMA mode will disable the ACMD23, and only i=
n
ADMA mode, it will chose to use ACMD23 if the host support. But according t=
o
debug, and confirm with IC, the imx6qpdl/imx6sx/imx6sl/imx7d do not support
the ACMD23 feature completely. These SoCs only use the 16 bit block count o=
f
the register 0x4 (BLOCK_ATT) as the CMD23's argument in ACMD23 mode, which
means it will ignore the upper 16 bit of the CMD23's argument. This will bl=
ock
the reliable write operation in RPMB, because RPMB reliable write need to s=
et
the bit31 of the CMD23's argument. This is the hardware limitation. Due to
imx6sl use SDMA, so for imx6qpdl/imx6sx/imx7d, it need to broke the ACMD23 =
for
eMMC, SD card do not has this limitation, because SD card do not support re=
liable
write.

For imx6ul/imx6ull/imx6sll/imx7ulp/imx8, it support the ACMD23 completely, =
it
change to use the 0x0 register (DS_ADDR) to put the CMD23's argument in ADM=
A mode.

This patch handle 'sdhci,auto-cmd23-broken' from devicetree.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 5 +++--
 drivers/mmc/host/sdhci-pltfm.c     | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-es=
dhc-imx.c
index 54ffb04ab1d1..0a8a7b748341 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1371,8 +1371,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev=
,
=20
 	of_property_read_u32(np, "fsl,strobe-dll-delay-target",
 				&boarddata->strobe_dll_delay_target);
-	if (of_find_property(np, "no-1-8-v", NULL))
-		host->quirks2 |=3D SDHCI_QUIRK2_NO_1_8_V;
=20
 	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
 		boarddata->delay_line =3D 0;
@@ -1386,6 +1384,9 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev=
,
 						ESDHC_PINCTRL_STATE_200MHZ);
 	}
=20
+	/* call to generic sdhci_get_property to support additional capabilities =
*/
+	sdhci_get_property(pdev);
+
 	/* call to generic mmc_of_parse to support additional capabilities */
 	ret =3D mmc_of_parse(host->mmc);
 	if (ret)
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.=
c
index 328b132bbe57..862d2bb9c2a8 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -86,6 +86,9 @@ void sdhci_get_property(struct platform_device *pdev)
 	if (device_property_present(dev, "sdhci,auto-cmd12"))
 		host->quirks |=3D SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
=20
+	if (device_property_present(dev, "sdhci,auto-cmd23-broken"))
+		host->quirks2 |=3D SDHCI_QUIRK2_ACMD23_BROKEN;
+
 	if (device_property_present(dev, "sdhci,1-bit-only") ||
 	    (device_property_read_u32(dev, "bus-width", &bus_width) =3D=3D 0 &&
 	    bus_width =3D=3D 1))
--=20
2.17.1

