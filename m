Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A2BC432C3
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CE5206EC
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IRPDbhw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfLCMy1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:54:27 -0500
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:48773
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfLCMy1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 07:54:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTl9G+1czIEVihPBH7IYpXzLiHEOH/ET7fmURGglUKcDfAw9pbxK7b1bsfpiXwb7Pq4ofb54T63k7vjEKtIOkb9KdH8tuJJdaIcxBZb79OOATnf3q8elA+i+DTg2FuMIstcffP9oMbpXlfXoVCAnHblBi9Ga6aTdj4EGjV2xdKRh4RK6vxHZMslHsam9ID/Pm6G91XHvKpCTKUdCRxS9sezIRz7ShhFTQwwrpNRr2sWUO3778tjg7TnGOt1R3SEk2eioRgNPKNJSXQDnWXoN7asT1kcmsdUpmNNBIb4irKYpbhyoarwi8hmIglHDsTcCrxx7CZvLs8E7v+fJv6yc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G0/b+14UhZ0Btt2gn3FkOZ+8pIbfLojhCzwnqoKXXI=;
 b=naZVFdHlknvyQtRr69256M1VJSLh6IGYbDcVZpv+I8OFbbko/CtXEEPAw1xHfKKszqZyrelL46jaGt6FHeeB6BraEF+YPCQM7QInZEpyqe1aSTIQ2+k+1EGOf/am5Gfgcdxcw7pwKolzt5505Pojm7LA6xrwOx+0daR4CGGU7NWUgV40ON7AFxFqQZHJNCritXUHUz19+CeGLmLFNZaSqTlSYpODCiOIrDyk/EZ8XPrcbxCCmSW5Lt/Alae+13F0X+LPqOMunD8EBVd8TOarl95CgBA4gPhOWrVfbZA19K9PwpP7bwLce/lZFvi1onLUXcSk+u08qvyQoPe3DhA+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G0/b+14UhZ0Btt2gn3FkOZ+8pIbfLojhCzwnqoKXXI=;
 b=IRPDbhw7T3amufBVEqgIV+xly228jAYIaVcn0YW5EgFt6NOTYuq0MC8KGZJPKeUEmONpcraB2bjx2G0dOPm9c+hek5g3I9B3Y8xwavu1VH6ly4Ox0dxdWud63znATXUpcO8Vwc28nyTayKFfZ15RiglDb5arYAUPLX78lz5u2Pc=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4175.eurprd04.prod.outlook.com (52.133.12.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:54:23 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 12:54:23 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 03/14] mmc: sdhci-esdhci-imx: retune needed for Mega/Mix
 enabled SoCs
Thread-Topic: [PATCH v2 03/14] mmc: sdhci-esdhci-imx: retune needed for
 Mega/Mix enabled SoCs
Thread-Index: AQHVqdjJV29nzvK6906nGa+BobsNyQ==
Date:   Tue, 3 Dec 2019 12:54:23 +0000
Message-ID: <20191203130120.11511-4-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: a3296471-4a26-45c3-9cda-08d777efebae
x-ms-traffictypediagnostic: VI1PR04MB4175:|VI1PR04MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB41757314B3284624CC84810A90420@VI1PR04MB4175.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(316002)(54906003)(446003)(2616005)(26005)(110136005)(2906002)(11346002)(50226002)(8936002)(186003)(2501003)(102836004)(99286004)(386003)(305945005)(86362001)(76176011)(52116002)(6506007)(7736002)(6486002)(6436002)(6512007)(1076003)(5660300002)(66946007)(66556008)(66476007)(64756008)(66446008)(14454004)(36756003)(25786009)(478600001)(256004)(71190400001)(8676002)(81156014)(81166006)(14444005)(71200400001)(6116002)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4175;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nBoorNkwNJ1NfVBseOp1wbIVlqMV9uKawbLyHu7d07AlYZGYiM6KaSqFaySi3U5GMiIk7Kur/bNAJLCIOIpwcMf08bMm6jYBLsVtcXyF2mvCAtNOaazpz4TmC2XhSgHkf9JF2dJ1eGVuOV2B9UdcI1IsDly24kmHnC0zUrthvfjbv3W6O/LHf4oXwioIGgxeScRq86/qOVE1iKNA5xRV1jAdodf+6gW107/Rd7mPw4oDZIdqS/Ep0VHF4TGixw2nBgWtdIwybGw4A8qTFhh/fIiH2tg3hXLn/nPShn3PcG6eJ1/Fnw4dbXmlDuEntF1eytTjNHDYKwCtKocwqy7dBDbzSpwBBzJg/FZf5ffWDwBGxfqkI+hENK16cWhBk6F65nxIw16/MXcWqWrObmhKsEU8kOReZLw6xwCkK/ZtU9fH9ZtxlwK/34Oja/unUt10
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3296471-4a26-45c3-9cda-08d777efebae
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:54:23.3421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G88EsepaORr6nCjPzh+1yc5fJHwxGWUPmo7QV9MCOtLGFvz9uab0LyAPktP3Qnn6Ns3xSbSg+oso1hQaai3fWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For Mega/Mix enabled SoCs like MX7D and MX6SX, uSDHC will lost power in
LP mode no matter whether the MMC_KEEP_POWER flag is set or not.
This may cause state misalign between kernel and HW, especially for
SDIO3.0 WiFi cards.
e.g. SDIO WiFi driver usually will keep power during system suspend.
And after resume, no card re-enumeration called.
But the tuning state is lost due to Mega/Mix.
Then CRC error may happen during next data transfer.

So we should always fire a mmc_retune_needed() for such type SoC
to tell MMC core retuning is needed for next data transfer.
mmc: sdhci-esdhci-imx: retune needed for Mega/Mix enabled SoCs

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-es=
dhc-imx.c
index 3830f4dc8dfc..0f281821a269 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -160,6 +160,8 @@
 #define ESDHC_FLAG_CQHCI		BIT(12)
 /* need request pmqos during low power */
 #define ESDHC_FLAG_PMQOS		BIT(13)
+/* The IP state got lost in low power mode */
+#define ESDHC_FLAG_STATE_LOST_IN_LPMODE		BIT(14)
=20
 struct esdhc_soc_data {
 	u32 flags;
@@ -193,32 +195,37 @@ static const struct esdhc_soc_data usdhc_imx6sl_data =
=3D {
=20
 static const struct esdhc_soc_data usdhc_imx6sx_data =3D {
 	.flags =3D ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
-			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
 };
=20
 static const struct esdhc_soc_data usdhc_imx6ull_data =3D {
 	.flags =3D ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
-			| ESDHC_FLAG_ERR010450,
+			| ESDHC_FLAG_ERR010450
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
 };
=20
 static const struct esdhc_soc_data usdhc_imx7d_data =3D {
 	.flags =3D ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
-			| ESDHC_FLAG_HS400,
+			| ESDHC_FLAG_HS400
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
 };
=20
 static struct esdhc_soc_data usdhc_imx7ulp_data =3D {
 	.flags =3D ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
-			| ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400,
+			| ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
 };
=20
 static struct esdhc_soc_data usdhc_imx8qxp_data =3D {
 	.flags =3D ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
-			| ESDHC_FLAG_CQHCI,
+			| ESDHC_FLAG_CQHCI
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
 };
=20
 struct pltfm_imx_data {
@@ -1613,6 +1620,8 @@ static int sdhci_esdhc_imx_remove(struct platform_dev=
ice *pdev)
 static int sdhci_esdhc_suspend(struct device *dev)
 {
 	struct sdhci_host *host =3D dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+	struct pltfm_imx_data *imx_data =3D sdhci_pltfm_priv(pltfm_host);
 	int ret;
=20
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
@@ -1621,6 +1630,12 @@ static int sdhci_esdhc_suspend(struct device *dev)
 			return ret;
 	}
=20
+	if ((imx_data->socdata->flags & ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
+		(host->tuning_mode !=3D SDHCI_TUNING_MODE_1)) {
+		mmc_retune_timer_stop(host->mmc);
+		mmc_retune_needed(host->mmc);
+	}
+
 	if (host->tuning_mode !=3D SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
=20
--=20
2.17.1

