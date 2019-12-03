Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67547C432C0
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342EF2070A
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OX+lLs8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLCMy3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:54:29 -0500
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:48773
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfLCMy3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 07:54:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF8DscDUYhNtzXSwIKdBNv7fnWGMlUHCKTbRyH1PwuUdgaK0Tg4p/SLOsinSp8hXtVrqDl+spO+KFw4u0YTyzV9jnIJZAJmoO2I+6QU2ckK893wvO9dKVzIs8DwZMTOSMxSrncS+KcqllsT5Hc0D+rWOPYm94KSCTg8n1GVQPLZrxki65MXJZqX/rPfhMqYM003DEs3oKg53JJdKccPgElFQm63FP2n4vh26FpdX051oHNHCKl+zqt6VBoh4470rhKvPpF2GpRZUZyHf3gB90U2kSOaxIzaRDgDs17CcJChCwEY9McgTlM1pgoOmL9T1xVdGcvVIvjzl494TC7HQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ACFRw3zCeVNDiJZSKV2jP/6XZ2C/oslyVVCzQYvdIo=;
 b=hCxSDbJLGP3qrrK6H8LDDubgqKHjUL5towHM2SXEFgE06wbGiQgko7c2JDUpQ//JwSSzfQ7COfseiUE7F9FYqf25oB4XklxT5ePiZ9UGb6K5F85+MnZCG67AmrlC2t1Day5xBrgDqMVC3g0QBdxW45EwPklFXwzNxVCmqi1dmLaErKQlhRcuzkq8N6PIad3S4GVpfdHY0aLWSCyKnLv4mRywYN8SG2fr+CqpLmtyMPGnPEmvg3S5x0Yji9lpc9L+ueI3T484u40gbn2oCYjwPv4C37UdDxrEqQxf9Gwcf/9NNJJc04H8afdD+03C5hdyRKMa7LvXNFwOWuN8sJfLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ACFRw3zCeVNDiJZSKV2jP/6XZ2C/oslyVVCzQYvdIo=;
 b=OX+lLs8d2KKis/prjZFnYIFQmMqZHQJ+7cD2htb8Cb/JmqW8/ypLJ5xjY4E3h/WHspykrMZ0ZpfRMrXCr7MNGvy2YID1uil2mHeApihneU6mV4ehZ74xpEp8EkmkptheXsI2rlo4uU1AEBd5icrJ2maXw2TCUYXzm9vHsgLaKs0=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4175.eurprd04.prod.outlook.com (52.133.12.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:54:26 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 12:54:26 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 04/14] mmc: sdhci-esdhc-imx: restore the per_clk rate in
 PM_RUNTIME
Thread-Topic: [PATCH v2 04/14] mmc: sdhci-esdhc-imx: restore the per_clk rate
 in PM_RUNTIME
Thread-Index: AQHVqdjLQtGwmcDSKk2xlu+qQhULqA==
Date:   Tue, 3 Dec 2019 12:54:26 +0000
Message-ID: <20191203130120.11511-5-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: d361ecb1-fe3f-4f3b-e53d-08d777efed6d
x-ms-traffictypediagnostic: VI1PR04MB4175:|VI1PR04MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4175209251479667229F32AF90420@VI1PR04MB4175.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(316002)(54906003)(446003)(2616005)(26005)(110136005)(2906002)(11346002)(50226002)(8936002)(186003)(2501003)(102836004)(99286004)(386003)(305945005)(86362001)(76176011)(52116002)(6506007)(7736002)(6486002)(6436002)(6512007)(1076003)(5660300002)(66946007)(66556008)(66476007)(64756008)(66446008)(14454004)(36756003)(25786009)(478600001)(256004)(71190400001)(8676002)(81156014)(81166006)(14444005)(71200400001)(6116002)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4175;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8VZ1xwsCfEPpUNkn5tIWMk5OZoe+SFDSj5NyN8XGgnDBMRwLCL5uw1PKtgKmwnm0RcQp9TvXZQLkM/qKgCNCncZHPx+aBSJzALjpxDUh5KPTYk7eLY7wpaI/d2ZQNo5OX5Eu9yhUmfiRSPLsVIhpPNGFX9DZGfqWNor/6bFSzM48IDdUSiJ3eF7rywFgGAm6haRitqyjPTbQ9se+dvxh8Np5f6QkSOJ7QvLagJzcq6Ar7XXHS4o9AXNTDmurI6a0IYG4plEwpz8yTXgMRsYfXDQC1TDBJetYVi4XiAS7ZccQtJvcAdJSdnfA6L/4xvWt4nMV9jpGZo+SJ3oiMxvhgPWZEaIcWXFgvoXajsCSxsbln7fMYea184x323HY77IzjPocjWoQLkzFEuuouKGrVHIUlwvfW0oaDLe0U8QtKQht7S3C/xjMoCTMZvupMoIo
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d361ecb1-fe3f-4f3b-e53d-08d777efed6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:54:26.2194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zH8bTelSeC/uG8cozigAp9qPZZlJ0lLYHdR8ZUIaq5JdhTlyEO2IDZgBT1FXZgt5COqt2gtSL9fKo0fPfFfDKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When pm_runtime_suspend is run, a call to SCFW power off the SS (SS is a
power domain, usdhc belong to this SS power domain) in which the resource
resides is made. The SCFW can power off the SS if no other resource in
active in that SS. If so, all state associated with all the resources withi=
n
the SS that is powered off is lost, this includes the clock rates, clock st=
ate
etc. When pm_runtime_resume is called, the SS associated with that resource
is powered up. But the clocks are left in the default state.

This patch restore clock rate in pm_runtime_resume, make sure the
clock is right rather than depending on the default state setting
by SCFW.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-es=
dhc-imx.c
index 0f281821a269..0cce4d97f0a5 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -162,6 +162,8 @@
 #define ESDHC_FLAG_PMQOS		BIT(13)
 /* The IP state got lost in low power mode */
 #define ESDHC_FLAG_STATE_LOST_IN_LPMODE		BIT(14)
+/* The IP lost clock rate in PM_RUNTIME */
+#define ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME	BIT(15)
=20
 struct esdhc_soc_data {
 	u32 flags;
@@ -225,7 +227,8 @@ static struct esdhc_soc_data usdhc_imx8qxp_data =3D {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
 			| ESDHC_FLAG_CQHCI
-			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
+			| ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME,
 };
=20
 struct pltfm_imx_data {
@@ -1705,6 +1708,9 @@ static int sdhci_esdhc_runtime_resume(struct device *=
dev)
 		pm_qos_add_request(&imx_data->pm_qos_req,
 			PM_QOS_CPU_DMA_LATENCY, 0);
=20
+	if (imx_data->socdata->flags & ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME)
+		clk_set_rate(imx_data->clk_per, pltfm_host->clock);
+
 	err =3D clk_prepare_enable(imx_data->clk_ahb);
 	if (err)
 		goto remove_pm_qos_request;
--=20
2.17.1

