Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9766FC432C0
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D33F206EC
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RmC1+IM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfLCMzV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:55:21 -0500
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:58425
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbfLCMzU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 07:55:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdP7fPdHuVlHE6bTaOVlAuCZ4iFOZ829skIaG5iximOLsfvwhK+vCPFUja3szZx728MLb8Jn4WoOqtH4dLFBllMMYzjdfbkJGn0Oo0OUt7MPFeRCfuNPAjD2etNuUQIFEMOElKToGLun5JtghFWV6X+tbdrZlsoFKkyebbIo6P86/1KSF1QF4dVhsGro6WhmDpwa0bpJqlaEh4a4kswPSymg4oKxe9g1t+shuxec9tY1VTUFVQ5/Hh8KuBksiPkYLsz42+/XRLHZKgnO9a+x9G7hsED06EMTnilaUAEfpJPSIdN4APl6hpm1z7FA/v/tYZS5eQabQ0FhlJN+g4yPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k82kN0y6ZHBb6o4PXWXzEuWd4nUkhzZBLjzOYObjRsw=;
 b=EQHaLNDkwvqp2xdot7oO83I3VFSnjeSU20FnAFsypfRgKe+5yhH1vpcinx5l+mysfGWXsDaR06F98dssnK6BDXgQjLrWY8j5lORYWE1CgAWt+OGdu6Wz7f46752VLuVXXZOYFNSZWWu2r4ZuJiwxxVYFDF8q3swPipfMar9IGTD6A5W9aBABhvT62OEoPq8MhgoaEPh1+7TjB3Ac3GP8E6OtHVcVRrFB/iDX5uaqEJN+jDiwcP79OHlPdxwIHm5EjZcqJ4tJzx6NXLPzGaE1fRz+Y3r6SR7zlfL6XgXQTsh9qkkfcJecl0uKqoxEGEyo4gy58mqdyrNX9NFvwlejHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k82kN0y6ZHBb6o4PXWXzEuWd4nUkhzZBLjzOYObjRsw=;
 b=RmC1+IM7c0GOa4tC2RjDdMsDGOP+b+/LjWhU0dYI4x/4z9usd1gIfGFypP/KQUVPJL7epvc/Nr3PR9YvDuyfNqf7BEsZKUdwOW6wYT4Evdwq5/j3RLmpJFeCcNsUbn2R+IzEmwtjvL2ASMUQso+SOxnjhn2bIY9SU0efxV8j4aw=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4175.eurprd04.prod.outlook.com (52.133.12.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:54:53 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 12:54:53 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 13/14] mmc: sdhci-esdhc-imx: clear DMA_SEL when disable DMA
 mode
Thread-Topic: [PATCH v2 13/14] mmc: sdhci-esdhc-imx: clear DMA_SEL when
 disable DMA mode
Thread-Index: AQHVqdjb8ZrDWWh03E+wXR7jWnQ33g==
Date:   Tue, 3 Dec 2019 12:54:53 +0000
Message-ID: <20191203130120.11511-14-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: 68a14f48-71bc-4704-69c3-08d777effd69
x-ms-traffictypediagnostic: VI1PR04MB4175:|VI1PR04MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4175FA71CB552314D5C8010F90420@VI1PR04MB4175.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(316002)(54906003)(446003)(2616005)(26005)(110136005)(2906002)(11346002)(50226002)(8936002)(186003)(2501003)(102836004)(99286004)(386003)(305945005)(86362001)(76176011)(52116002)(6506007)(7736002)(6486002)(6436002)(6512007)(1076003)(5660300002)(66946007)(66556008)(66476007)(64756008)(66446008)(14454004)(36756003)(25786009)(478600001)(256004)(71190400001)(8676002)(81156014)(81166006)(14444005)(71200400001)(6116002)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4175;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 47C5Bl0lZ2ZnO23c7RRi+BJW6RJRcV6wnp477U5yUvqrjn+ZjDlk7LJpCZfg5CAwTlOpf5hcQHnAeqv0B3n8yfwFG3QdhnRin8APDnrKez3x3lquvjys9o3aOW6zUIZ092qWQLAW9GkAjl7wfNpOTHKSOIGAFyR0LasPUVw4JA6pD4ksGvMqKKL7h8Ueiiu7XD4wJkbNdGZiV/9oocE7Dd+leRA7pYaWthS1FJm4n/Tll9dL4sB1zGoIZ9+4v53wl+Rt+MS1muPTZmsThvF58RBKDGZ3fQ66K9HR33F/yl29WfJxsQznqLNNJKgUqE+qTUBsIii3nrUM5u3+ssSfnetrFDgENpNfABPh1ng59P+e9q7vbHX7BS9pYy1StdxKANA+RYQTTVUAUNQYdtr2Ewmzu+FgkRx1VvAWPdd+IaRvr0hHf1r+D4RXtQoW1LBE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a14f48-71bc-4704-69c3-08d777effd69
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:54:53.0636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yc/QzqHlmai9upRjr02nsjWXm+E13mA16UVOVzLIgvxelftTqbe99gijbgjL22mFY9UpLJX9w00heh44FJO62A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Currently, when use standard tuning, driver default disable DMA just before
send tuning command. But on i.MX8 usdhc, this is not enough. Need also clea=
r
DMA_SEL. If not, once the DMA_SEL select AMDA2 before, even dma already dis=
abled,
when send tuning command, usdhc will still prefetch the ADMA script from wr=
ong
DMA address, then we will see IOMMU report some error which show lack of TL=
B
mapping.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-es=
dhc-imx.c
index 246b4eb52378..7430708f72e1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -608,10 +608,24 @@ static void esdhc_writew_le(struct sdhci_host *host, =
u16 val, int reg)
 			 * For DMA access restore the levels to default value.
 			 */
 			m =3D readl(host->ioaddr + ESDHC_WTMK_LVL);
-			if (val & SDHCI_TRNS_DMA)
+			if (val & SDHCI_TRNS_DMA) {
 				wml =3D ESDHC_WTMK_LVL_WML_VAL_DEF;
-			else
+			} else {
+				u8 ctrl;
 				wml =3D ESDHC_WTMK_LVL_WML_VAL_MAX;
+
+				/*
+				 * Since already disable DMA mode, so also need
+				 * to clear the DMASEL. Otherwise, for standard
+				 * tuning, when send tuning command, usdhc will
+				 * still prefetch the ADMA script from wrong
+				 * DMA address, then we will see IOMMU report
+				 * some error which show lack of TLB mapping.
+				 */
+				ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL);
+				ctrl &=3D ~SDHCI_CTRL_DMA_MASK;
+				sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+			}
 			m &=3D ~(ESDHC_WTMK_LVL_RD_WML_MASK |
 			       ESDHC_WTMK_LVL_WR_WML_MASK);
 			m |=3D (wml << ESDHC_WTMK_LVL_RD_WML_SHIFT) |
--=20
2.17.1

