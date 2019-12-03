Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E67DC432C0
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DC1206EC
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p1WfXwmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfLCMzS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:55:18 -0500
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:58425
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726079AbfLCMzS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 07:55:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzCAWMGqNnJGUdJqHRdbNnIf2owK2Cd1W4XyaFW61pi7DGocIz37U6GHwkcatPiq7vmmK2S29nmG+gbZCqZl6/EBcPcIzTK42QCqDmGGjlVOMWuFn4+3akIJ0nS9gJ3XcDpe6GUfko506MSip/nj/awrFWU7/dTf4bxxmGAP2hp44MSYemT8eLTj7sau7VTu82mMP/pkCBnA+YOewBS5S5+ka7XMTzvF2Eb87MVSw+0CRViKrTcIXbmw9iH+fFZb9W8LLEVMUeGtdiLUBpwvYvTgbbiOcn7fulTrE/UGwjgFLczfGi49NikCiqflayNOPJ/scFctCtFAPFvN26FReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N82up276ZK8YNqdMt0ykXPjoixauJLUsOpdGb8NU5jY=;
 b=b9+QR0Q0w8aaxuvISeGDKKYwFUZqqEtN8rOZ+XIvveHOhLaTtaUEdrB6C4Q834oaoHSe+/dULT9rWuWN8OrPbR+Uo2LiB9s4kiA2zQ9bQSsooGXJK0kDro7+GrAbPt6+M9w5UkZqw9pqd784WekFEo+wzYy8JtI8lKY+M0GmATFDY/JYmbD7bhfIKLJs0Iwe0agHdizzAp1z/6jNvze+MbjVM0rRcd6tO4V85DWpMcDXfo1S0ZRmXr7xWe5oADgg7q5VJVrbv9fAFf24at8dLsHd8E6hLori3kBjOdBVLnDNLVhucOKBgLVZWvvevpcc7mje1w8yytNMHQLPE1vJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N82up276ZK8YNqdMt0ykXPjoixauJLUsOpdGb8NU5jY=;
 b=p1WfXwmonQu7gOBDqBAzKiaLHlKFkZ7vBTJlX+4+NLA7XWlbiY1Ud/tRrSyfyZT4fwyhgzaHYE9f48WEf9zP75hcPx8mnehB+i9JF8PQKKCw/BxxDM/TXwxe1vN+Pg81mri2W8/sHWmi1n+FbpdnMtM3Oi4E+bAUNBDM+C3CeWY=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4175.eurprd04.prod.outlook.com (52.133.12.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:54:47 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 12:54:47 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 11/14] mmc: sdhci-esdhc-imx: clear pending interrupt and
 halt cqhci
Thread-Topic: [PATCH v2 11/14] mmc: sdhci-esdhc-imx: clear pending interrupt
 and halt cqhci
Thread-Index: AQHVqdjXFB/pAp1YnUOX5Myp+8nFGg==
Date:   Tue, 3 Dec 2019 12:54:47 +0000
Message-ID: <20191203130120.11511-12-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: 017d689d-187d-4515-691d-08d777eff9d8
x-ms-traffictypediagnostic: VI1PR04MB4175:|VI1PR04MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4175581FA445770D6D525CB990420@VI1PR04MB4175.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(316002)(54906003)(446003)(2616005)(26005)(110136005)(2906002)(11346002)(50226002)(8936002)(186003)(2501003)(102836004)(99286004)(386003)(305945005)(86362001)(76176011)(52116002)(6506007)(7736002)(6486002)(6436002)(6512007)(1076003)(5660300002)(66946007)(66556008)(66476007)(64756008)(66446008)(14454004)(36756003)(25786009)(478600001)(256004)(71190400001)(8676002)(81156014)(81166006)(14444005)(71200400001)(6116002)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4175;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ISSX3ZlWqclOTBEH+zSl/Ztu1EkDh4YTjMshrq7MPRbh5gVepBPOKUXQTJUXolxmvkJMmEchPKkmepphchktg4/MHvsZabp4fq96gx9lxxL5WsV+RD/pyO2oUs3zo/heykrlcVf4k0I95zek9HmnXw3HXL67Z9Io1NNDQJSAjvcx03dV+hxy64lpoX9Qh884vR5VN/Haz+WOay26zkzXj7cuW2O9fMHpA9CFfHb/4UqMIwbpVq8AcectuYY2a80LHlU7s1818j6uJ859TG/Btwwfv/aBUnhVkdfNNHrvPGRu4uNL95/G2YIADdNvIoqn2+XaMivg2xeq956Itn09qi1ROHWZ0XUqvH3SPgOGuu3ieJXqJcCeCFy+mawQBKvvOI+PhMWA66tWgBYq1KCRI7JBC9DuLgKGifbC40KWS3DPV3oKyf/enranMhiZMjHF
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017d689d-187d-4515-691d-08d777eff9d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:54:47.0632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ms1u7wgbKxSzwAeNhQjvNFxUCfsSAel6fyPZOOJRLtZOJBHFhaOJnyH6vS7d6qlgxffpakpOb4kwdv0ZeBXsNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On i.MX8MM, we are running Dual Linux OS, with 1st Linux using SD Card
as rootfs storage, 2nd Linux using eMMC as rootfs storage. We let the
the 1st linux configure power/clock for the 2nd Linux.

When the 2nd Linux is booting into rootfs stage, we let the 1st Linux
to destroy the 2nd linux, then restart the 2nd linux, we met SDHCI dump
as following, after we clear the pending interrupt and halt CQCTL, issue
gone.

[ 1.334594] mmc2: Got command interrupt 0x00000001 even though no command o=
peration was in progress.
[ 1.334595] mmc2: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTE=
R DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1.334599] mmc2: sdhci: Sys addr: 0xa05dcc00 | Version: 0x00000002
[ 1.345538] mmc2: sdhci: Blk size: 0x00000200 | Blk cnt: 0x00000000
[ 1.345541] mmc2: sdhci: Argument: 0x00018000 | Trn mode: 0x00000033
[ 1.345543] mmc2: sdhci: Present: 0x01f88008 | Host ctl: 0x00000031
[ 1.345547] mmc2: sdhci: Power: 0x00000002 | Blk gap: 0x00000080
[ 1.357903] mmc2: sdhci: Wake-up: 0x00000008 | Clock: 0x0000003f
[ 1.357905] mmc2: sdhci: Timeout: 0x0000008f | Int stat: 0x00000000
[ 1.357908] mmc2: sdhci: Int enab: 0x107f100b | Sig enab: 0x107f100b
[ 1.357911] mmc2: sdhci: AC12 err: 0x00000000 | Slot int: 0x00000502
[ 1.370268] mmc2: sdhci: Caps: 0x07eb0000 | Caps_1: 0x0000b400
[ 1.370270] mmc2: sdhci: Cmd: 0x00000d1a | Max curr: 0x00ffffff
[ 1.370273] mmc2: sdhci: Resp[0]: 0x00000b00 | Resp[1]: 0xffffffff
[ 1.370276] mmc2: sdhci: Resp[2]: 0x328f5903 | Resp[3]: 0x00d00f00
[ 1.382132] mmc2: sdhci: Host ctl2: 0x00000000
[ 1.382135] mmc2: sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0xa2040208

[ 2.060932] mmc2: Unexpected interrupt 0x00004000.
[ 2.065538] mmc2: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTE=
R DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 2.071720] mmc2: sdhci: Sys addr: 0x00000000 | Version: 0x00000002
[ 2.077902] mmc2: sdhci: Blk size: 0x00000200 | Blk cnt: 0x00000001
[ 2.084083] mmc2: sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[ 2.090264] mmc2: sdhci: Present: 0x01f88009 | Host ctl: 0x00000011
[ 2.096446] mmc2: sdhci: Power: 0x00000002 | Blk gap: 0x00000080
[ 2.102627] mmc2: sdhci: Wake-up: 0x00000008 | Clock: 0x000010ff
[ 2.108809] mmc2: sdhci: Timeout: 0x0000008f | Int stat: 0x00004000
[ 2.114990] mmc2: sdhci: Int enab: 0x007f1003 | Sig enab: 0x007f1003
[ 2.121171] mmc2: sdhci: AC12 err: 0x00000000 | Slot int: 0x00000502
[ 2.127353] mmc2: sdhci: Caps: 0x07eb0000 | Caps_1: 0x0000b400
[ 2.133534] mmc2: sdhci: Cmd: 0x0000371a | Max curr: 0x00ffffff
[ 2.139715] mmc2: sdhci: Resp[0]: 0x00000900 | Resp[1]: 0xffffffff
[ 2.145896] mmc2: sdhci: Resp[2]: 0x328f5903 | Resp[3]: 0x00d00f00
[ 2.152077] mmc2: sdhci: Host ctl2: 0x00000000
[ 2.156342] mmc2: sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-es=
dhc-imx.c
index 0a8a7b748341..ae1538e30b23 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1203,6 +1203,7 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host =
*host)
 {
 	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
 	struct pltfm_imx_data *imx_data =3D sdhci_pltfm_priv(pltfm_host);
+	struct cqhci_host *cq_host =3D host->mmc->cqe_private;
 	int tmp;
=20
 	if (esdhc_is_usdhc(imx_data)) {
@@ -1279,6 +1280,21 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host=
 *host)
 			tmp &=3D ~ESDHC_STD_TUNING_EN;
 			writel(tmp, host->ioaddr + ESDHC_TUNING_CTRL);
 		}
+
+		/*
+		 * On i.MX8MM, we are running Dual Linux OS, with 1st Linux using SD Car=
d
+		 * as rootfs storage, 2nd Linux using eMMC as rootfs storage. We let the
+		 * the 1st linux configure power/clock for the 2nd Linux.
+		 *
+		 * When the 2nd Linux is booting into rootfs stage, we let the 1st Linux
+		 * to destroy the 2nd linux, then restart the 2nd linux, we met SDHCI du=
mp.
+		 * After we clear the pending interrupt and halt CQCTL, issue gone.
+		 */
+		if (cq_host) {
+			tmp =3D cqhci_readl(cq_host, CQHCI_IS);
+			cqhci_writel(cq_host, tmp, CQHCI_IS);
+			cqhci_writel(cq_host, CQHCI_HALT, CQHCI_CTL);
+		}
 	}
 }
=20
--=20
2.17.1

