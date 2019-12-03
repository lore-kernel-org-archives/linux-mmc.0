Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCECC43215
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94365206EC
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tss9S4+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLCMzT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:55:19 -0500
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:33645
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfLCMzS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 07:55:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RD2eJth74UH5UVME3af8S+W/b8gQq7p68TjDOlaWtdKNQ+D7/qw/ifP1+Df23H3oNu589JCLHScGisHR/yRAobRFTOGP4qQBg8kuJXEt1PraBiewrC6aK3ePt0PBF7Z3Pa9ffAoF00m2v+/HxsOeg5ztFRWMz2RMoRcnJCIqcxFvqZaPRLyrpC7eonAlRcyAfO02ZyIBJ87UGyRdIkPqSR//YlL2BRTFi6qVF0Vw8riG8Ce+aRqKuuaAoVlzJahhI8lRjThAwHnyAJ5zTykw/dnW4zaQeIqdBtfzGOUeIFBkgR9pVdwn3Iyn7Jhi0FoTo+Gu3CtBkf+gfCm9bTY3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUBhQCZUV11vMiR0FTWaIzsH4A1Ak7odoS0BMkAPyus=;
 b=GVBRdtdYUOYJQdQZPXR2wxMFK/Rlvssz5MtQlYB7qCQevIViBdPPtJpHEPd18ZfWpBJcnyXmELqhUF2YNeq98hGeq/FBd7dOTXqFiHmk0wtDhZKkuxbyaCFmGfwXEs6u9e0M8RAFaGko97zrsypGOC1eYkWs8DDCsMQYvY57ss3n/DuCPp0YzAi77bo33HMfgkX75MnFhT/vJMfi308IXHbX/GqDFeU54ItnZqjtFCpvX2A3kJUVfjx8I8fYOj5ou+n64eOowt8K+qx9ebsNMtxLbtq7Axg8dMlEtEzoxsqcuMlSSv66FaaaSdzgl3nEBrphlwDXB3imKX3fd0UJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUBhQCZUV11vMiR0FTWaIzsH4A1Ak7odoS0BMkAPyus=;
 b=Tss9S4+47UuFSiuxQSrB/E+A8M/thVf2Fx6aVY92iy/1Uy0sMIpm4zH95hOgFEMHsuSBoYiweeEdR1fivGwQQaUI1gQSYygaKHkAVKEruZoUIUCKBMEQmrPsbama0TVAOP9ToUp7seLChJy2EhER4KeLIQqYR+J47uOlU1xssds=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4175.eurprd04.prod.outlook.com (52.133.12.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:54:50 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 12:54:50 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 12/14] mmc: sdhci-esdhc-imx: restore pin state when resume
 back
Thread-Topic: [PATCH v2 12/14] mmc: sdhci-esdhc-imx: restore pin state when
 resume back
Thread-Index: AQHVqdjZKKRni58SCkegs5GMcEUwwA==
Date:   Tue, 3 Dec 2019 12:54:50 +0000
Message-ID: <20191203130120.11511-13-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: f2c134bd-6e91-476c-8035-08d777effb92
x-ms-traffictypediagnostic: VI1PR04MB4175:|VI1PR04MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB41756C540767A10D791D25FB90420@VI1PR04MB4175.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(316002)(54906003)(446003)(2616005)(26005)(110136005)(2906002)(11346002)(50226002)(8936002)(186003)(2501003)(102836004)(99286004)(386003)(305945005)(86362001)(76176011)(52116002)(6506007)(7736002)(6486002)(6436002)(6512007)(1076003)(5660300002)(66946007)(66556008)(66476007)(64756008)(66446008)(14454004)(36756003)(25786009)(478600001)(256004)(71190400001)(8676002)(81156014)(81166006)(14444005)(71200400001)(6116002)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4175;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ThlyK2fpdxzzqO4D0Zc06WCm0o3ACDT2YrKuG9+S/FVg1HLBujId0qdnn4YH/gFr3eh0MIlFP9zAWSsKXSoXXiJ0vfhrXqWV7KILEHNUA5MG9kTILiZysln8OUJL2AYt9SEYCObCIVFVryQYY8UlSpfX03qADVqZVEheSb4zX51i9BIbizeSN+WxKZNh1Oc3G/M5RTXPKD6j2mgd0+GpTj/X9B/0C6Yk5AaRpdN4V63oQnS+G7Eqdf2x/v2eeuEPaG5Y4Ql2Vx3Pf8VMgEudvFrFYIKUNtf6lZeCL52cbIkcfdbEQO6K4b0Lx9HDSgsMJbEdDkGxEeewZmj3cCblbpZsYj/shdT5PEW0Ku4Y+cFt+M25ymJtKp2cwNIbsGnmvQsyoAGbrjRm/R55DqhfArJf0bg2LhVBl1xffemBwwxbG5RG3ZfT9CDWMxFQ/dSA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c134bd-6e91-476c-8035-08d777effb92
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:54:50.1433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TvMS+aiexjDYUKlFeE2LGj/FEvBbz8zHDTH6g4MiUaB2DstjtTpbucUTDkUsXx84jJRxXgvj4cZ52rR2gn6bRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In some low power mode, SoC will lose the pin state, so need to restore
the pin state when resume back.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-es=
dhc-imx.c
index ae1538e30b23..246b4eb52378 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1690,7 +1690,13 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	if (host->tuning_mode !=3D SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
=20
-	return sdhci_suspend_host(host);
+	ret =3D sdhci_suspend_host(host);
+	if (!ret)
+		if (pinctrl_pm_select_sleep_state(dev))
+			dev_warn(mmc_dev(host->mmc),
+			 "%s, failed to select sleep pin state!\n", __func__);
+
+	return ret;
 }
=20
 static int sdhci_esdhc_resume(struct device *dev)
@@ -1698,6 +1704,10 @@ static int sdhci_esdhc_resume(struct device *dev)
 	struct sdhci_host *host =3D dev_get_drvdata(dev);
 	int ret;
=20
+	if (pinctrl_pm_select_default_state(dev))
+		dev_warn(mmc_dev(host->mmc),
+		 "%s, failed to select default pin state!\n", __func__);
+
 	/* re-initialize hw state in case it's lost in low power mode */
 	sdhci_esdhc_imx_hwinit(host);
=20
--=20
2.17.1

