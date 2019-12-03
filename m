Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0614BC432C0
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39082073B
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QaFzw0S7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfLCMyT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:54:19 -0500
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:27264
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfLCMyT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 07:54:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6PnPzdo115i+xBxZKfcbgV1ttHBVtP24mGaTObCC7Cjd8zQH6vGpa58A5n7QhJhl6e7F8R0KgGDUj9LAxpukfGyNYJi4ae/2Bvb9wy468wYDwj1Jzc/TRDeJhAVJMSotCoVSWNld4SUrHyq8l5J/jH32bHaRt9dNIs2ykFVIuCoEHwF9kq1EekN0qZtzyT9u4pcsrmutrnzSSKVVNBLjgwWzaXwEEprSk01hYDneBGhN/HzByyvlbLFZNEgCoeEX/ICiGZzz8csKa0953iYWOblZXCejngVP5R8IubiQJW2bcw2SUPy3Xd4Gk2SYQ9L4BcLVZ/Y1Ue2CnbpfXY8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBIjMU93vZV16kTVi7u8Jplwn3xrMastGDoRgImewk0=;
 b=MiNOzoYt7Pnv6N3k4WeJnOINZGWoHhGBalohEk5/e6Vz+oP7pYB/f8ktiJcdt7zdeJZqULNMGxas5U7C8c0MpNLaGNfjiC7gxvlcFkHfhCGcWZbdZkDEO3L7nFbUH4YBh3b1z3rBMCsY8vOxO0vsjjTxYOLSeCXwOcphaJHyEStqmGBpUIUONQUdBxKGuqnvS8yFZoABnaHRQngZVjl4ClTZR1bY3UuH6llfah5H2kcXb/CJMUZWqvLjRze0jNTRR2uw3ydfo1nwPLl2YkzRLeFqsuYWkaibR0OkQnTM8GsS62GQMrLCSNhKJMr53f1g9iiQGTp5tGMwEaKdA2BJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBIjMU93vZV16kTVi7u8Jplwn3xrMastGDoRgImewk0=;
 b=QaFzw0S7u+AqPgJc8sCELTcTuWQB1C0k7f+HGMKd99a0TpT+seL5wJzwQQ4QqDNk0XeTJNs+uYv4enatTGzfgE9Yf0mqeaWS5/VN8y4IJKyevbsqool+kEq+Bq9QhQHPlWKElC+svkSVHVKdz7tVW/b5jeVyu8fmkBCQp2cBG0o=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4175.eurprd04.prod.outlook.com (52.133.12.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:54:14 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 12:54:14 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 00/14] few fix for sdhci-esdhc-imx
Thread-Topic: [PATCH v2 00/14] few fix for sdhci-esdhc-imx
Thread-Index: AQHVqdjDdJY0cuwvIk6Xml2eFO3mng==
Date:   Tue, 3 Dec 2019 12:54:13 +0000
Message-ID: <20191203130120.11511-1-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: dce9a419-6d3e-4537-88d4-08d777efe619
x-ms-traffictypediagnostic: VI1PR04MB4175:|VI1PR04MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB417505E1C4C3FC81236192AA90420@VI1PR04MB4175.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(51234002)(189003)(199004)(316002)(54906003)(2616005)(26005)(110136005)(2906002)(50226002)(8936002)(186003)(2501003)(102836004)(99286004)(386003)(305945005)(86362001)(52116002)(6506007)(7736002)(6486002)(6436002)(6512007)(1076003)(5660300002)(66946007)(66556008)(66476007)(64756008)(66446008)(14454004)(36756003)(25786009)(478600001)(256004)(71190400001)(8676002)(81156014)(81166006)(14444005)(71200400001)(6116002)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4175;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dntqHChGITxr/bG2R4tSq7YbCVmy93mmYN7up0E4l0IWz3Sctyi8kRZW+47pMUPnTQBDgXyUMO/P4XT7jqUQKDKlhitkFmbb4l3ZXoqVS1m1JYIKeJUbTbHF6W9z1qh29rYPvJzrRrmPoBXy7nw2D2pgYwbmsYMHaoR3w32qQVUJi/sfzDeVs5nv6ajzravaOJ/RyWDx4Ag/qkdxcjWOt9s9pbf400XAWZvyVluJOHed0cMcfBjECAgZzxkj9Jgpj4Il/f/69Y/2pDKXfXRcnOj0FhQqhdfGd/ME9P85A/QMSolbSsQtrhseqMQ4YSyCti2nI2/Tp4cBRrDCNSkCgQLrf0C1vs+nXAMz/fBTGcx1/iRis92APpOBg5YGH48NEMxs537akj//vM1IyltyziR0olPiP5g839/hDSHoX+eCZbYObL4U9JDCLhSLymqh9kEcUMU/lg7MQ0yD8E895p234KpzV9BUETfsBlpd246Ej4haE8R8JssBwciOynL+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce9a419-6d3e-4537-88d4-08d777efe619
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:54:14.1754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/6lHVIKNJSEJPrz5BvOTwkCN7pHCNCK3VJQpdBXe7AMhzQs1Mypf0CN8v/G/kdKTEVEPJCUvzaZtjEo2uwS6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

---
Changes for v2:
Add Adrian's ack for patch 1~8
Patch 9~10, change to use 'sdhci,auto-cmd23-broken' instead of 'fsl,auto-cm=
d23-broken'
Patch 11, clear cqhci irq status and halt cqhci, move this change to sdhci_=
esdhc_imx_hwinit()
and add some comment to explain the reason.
Patch 12, add error return check for pinctrl_pm_select_sleep_state()
Patch 13, clear the DMA_SEL in sdhci-esdhc-imx.c instead of sdhci.c
Patch 14, add the dev->dma_parms in core/queue.c, instead of host/sdhci.c.

Haibo Chen (14):
  mmc: sdhci: do not enable card detect interrupt for gpio cd type
  mmc: sdhci-esdhc-imx: no fail when no pinctrl available
  mmc: sdhci-esdhci-imx: retune needed for Mega/Mix enabled SoCs
  mmc: sdhci-esdhc-imx: restore the per_clk rate in PM_RUNTIME
  doc: dt: fsl-imx-esdhc: add strobe-dll-delay-target binding
  mmc: sdhci-esdhc-imx: add strobe-dll-delay-target support
  mmc: sdhci-esdhc-imx: optimize the clock setting
  mmc: sdhci-esdhc-imx: optimize the strobe dll setting
  doc: dt: fsl-imx-esdhc: add auto-cmd23-broken binding
  mmc: sdhci-esdhc-imx: handle 'sdhci,auto-cmd23-broken' from devicetree
  mmc: sdhci-esdhc-imx: clear pending interrupt and halt cqhci
  mmc: sdhci-esdhc-imx: restore pin state when resume back
  mmc: sdhci-esdhc-imx: clear DMA_SEL when disable DMA mode
  mmc: queue: create dev->dma_parms before call dma_set_max_seg_size()

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt |  13 ++
 drivers/mmc/core/queue.c                      |   9 +-
 drivers/mmc/host/sdhci-esdhc-imx.c            | 146 ++++++++++++++----
 drivers/mmc/host/sdhci-esdhc.h                |   1 +
 drivers/mmc/host/sdhci-pltfm.c                |   3 +
 drivers/mmc/host/sdhci.c                      |   2 +-
 include/linux/platform_data/mmc-esdhc-imx.h   |   1 +
 7 files changed, 144 insertions(+), 31 deletions(-)

--=20
2.17.1

