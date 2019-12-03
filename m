Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713ABC432C3
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4224E2073B
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nvtbf6Bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfLCMzL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:55:11 -0500
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:33645
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbfLCMzL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 07:55:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLkNniiuKms86fL/LmfjAuLuhS1WzkeFADfyLPMHByjoNNnF36Femb1cWvssCzV9nsDqKDrvGI0hmxspNvZ3iPna69f7lBppJc/psHBHEMyRih4FcBH/9twGJmWUcGAdH/lj2yvq8sSp0ibdg+ie00YCX4Go6SwwmegQmNiN3NwUtuP4Vii5Jh3CDZgrVrR4wcaKa0s82DOe+ya1/t3i7w7bPUIb4UVVUPDzaGzWINcm91qIgpzoEmmIockpRT+kvcVY0z8e4PZbOm9FV5uc/eTXkvRJewHAoMFc1mN8WgT4Vl3pfeueEbKIFeUkMHwgxYlg3TNpLzYBBg3JIn4A7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXu+MVo5qLgsFOkFxGGe+8ZGREiJyR8tA6303DFcETU=;
 b=DO/pPixAfsdozyZc03IEeUBtcusT5vq9muehoNpjyC5JeJQ8T1t52vYaXuwiiVm2oKJkDkNdQkOKWo1X7CxB6KQGha0oLd3qtGluRX1u3U/eg5aYoZhUKkf4msixtk0znLZtpv8sGRmg4HAt7uVA/iTN71rA3lfqk+TK7IbmifsfL7Nx8TDsi6PVo2QxQabyKH4xn4FCUzSBRAhurnHMMY7QPdMCCMGXx9ClmbSW4ku2S6Kt20jQ46cwDwv9SxDPNaMN6O4q5VCjWLlBysm/Q0WYJyZCSA9ftL0R6wWeVPcyqn9R8+mOOAfoohO2snTRlUSUenMCiRn9TSphQlyM4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXu+MVo5qLgsFOkFxGGe+8ZGREiJyR8tA6303DFcETU=;
 b=nvtbf6Bqnm4gwMGvm/w1we8eaVo9u82jBqtJaXIKvHddCK0hQ0zOrSp45HazAOW5G6wt4MTzaDxSANk3z1/c0te/YRmEZki4UOlHXPs49PGHSeVVGu/6ER42GgBFIee2U5HMV59j+4440LOT4tgNRDA2VZeySXANhBPY2If+ONA=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4175.eurprd04.prod.outlook.com (52.133.12.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:54:38 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 12:54:38 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 08/14] mmc: sdhci-esdhc-imx: optimize the strobe dll
 setting
Thread-Topic: [PATCH v2 08/14] mmc: sdhci-esdhc-imx: optimize the strobe dll
 setting
Thread-Index: AQHVqdjSM99eXfGOv0K/Owj1dyyKKg==
Date:   Tue, 3 Dec 2019 12:54:38 +0000
Message-ID: <20191203130120.11511-9-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: 5e7de3a0-3d17-446f-cb34-08d777eff48b
x-ms-traffictypediagnostic: VI1PR04MB4175:|VI1PR04MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB41756442860DB9B74982B67590420@VI1PR04MB4175.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(316002)(54906003)(446003)(2616005)(26005)(110136005)(2906002)(11346002)(50226002)(8936002)(186003)(2501003)(102836004)(99286004)(386003)(305945005)(86362001)(76176011)(52116002)(6506007)(7736002)(6486002)(6436002)(6512007)(1076003)(5660300002)(66946007)(66556008)(66476007)(64756008)(66446008)(14454004)(36756003)(25786009)(478600001)(256004)(71190400001)(8676002)(81156014)(81166006)(14444005)(71200400001)(6116002)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4175;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x2ZfU0vZKuAfshs4ZRg2Pzrdkq52C2aAy3oNPO3e9XsAMCH+nZiaCe/+HhU2N/NzavuPkdWIdWn9p93Bryq24TSG9nDg58Fq0oAI5DosGuiRk3mQFwKlCDGe9ZXUgn9o4a2+6ocf2KnT0QMhpmlRBXQ7mZsBuAKozXM+UbjyF5e6koyPKJtuIxdj7X769jQoRoFHzXpin3k5xVAQldsYUsfSY2tNhP4UYkmcQ1+JGHEgsqaA18q3AGkxtQKXBz+AwyTkQA/R/+cKqswzCHMXGkSOT4dVAKzvkhu+3q/7eCM9ErZ9oS6jiU2KHWBXbdvyvNscdAxhLiybyF/HKeASeYc+G+ulFZaL06+UiCt/nepFkHLqz4K/dPHuQfPi/S8i4K63ngOW4XQh9Xw0EzCJW76sFbM2v3LF8qOJvJYY8CUD6Kod4pbucA8MD3ilolNN
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7de3a0-3d17-446f-cb34-08d777eff48b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:54:38.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vj/ifZO6cGQGAWiuo1tU1aYkdsm/V6wc0yRVf8mHNiDPpO6EC7QngJDqGPqCEo8WyLfLo7vEbDKVCIzjx6T6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

After set the STROBE SLV delay target value, it need to wait some
time to let the usdhc lock the REF and SLV clock. In normal case,
1~2us is enough for imx8/imx6 and imx7d, and 4~5us is enough for
imx7ulp, but when do reboot stress test or do the bind/unbind stress
test, sometimes need to wait about 10us to get the status lock.

This patch optimize delay handle method, only print the warning
message if the status is still not lock after 1ms delay.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-es=
dhc-imx.c
index 9b03656c7abc..54ffb04ab1d1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1021,6 +1021,7 @@ static void esdhc_set_strobe_dll(struct sdhci_host *h=
ost)
 	struct pltfm_imx_data *imx_data =3D sdhci_pltfm_priv(pltfm_host);
 	u32 strobe_delay;
 	u32 v;
+	int ret;
=20
 	/* disable clock before enabling strobe dll */
 	writel(readl(host->ioaddr + ESDHC_VENDOR_SPEC) &
@@ -1046,15 +1047,13 @@ static void esdhc_set_strobe_dll(struct sdhci_host =
*host)
 		ESDHC_STROBE_DLL_CTRL_SLV_UPDATE_INT_DEFAULT |
 		(strobe_delay << ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT);
 	writel(v, host->ioaddr + ESDHC_STROBE_DLL_CTRL);
-	/* wait 5us to make sure strobe dll status register stable */
-	udelay(5);
-	v =3D readl(host->ioaddr + ESDHC_STROBE_DLL_STATUS);
-	if (!(v & ESDHC_STROBE_DLL_STS_REF_LOCK))
-		dev_warn(mmc_dev(host->mmc),
-		"warning! HS400 strobe DLL status REF not lock!\n");
-	if (!(v & ESDHC_STROBE_DLL_STS_SLV_LOCK))
+
+	/* wait max 50us to get the REF/SLV lock */
+	ret =3D readl_poll_timeout(host->ioaddr + ESDHC_STROBE_DLL_STATUS, v,
+		((v & ESDHC_STROBE_DLL_STS_REF_LOCK) && (v & ESDHC_STROBE_DLL_STS_SLV_LO=
CK)), 1, 50);
+	if (ret =3D=3D -ETIMEDOUT)
 		dev_warn(mmc_dev(host->mmc),
-		"warning! HS400 strobe DLL status SLV not lock!\n");
+		"warning! HS400 strobe DLL status REF/SLV not lock in 50us, STROBE DLL s=
tatus is %x!\n", v);
 }
=20
 static void esdhc_reset_tuning(struct sdhci_host *host)
--=20
2.17.1

