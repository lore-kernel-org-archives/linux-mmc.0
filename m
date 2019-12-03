Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51463C432C3
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F20A206EC
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SzgHGqq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfLCMyX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:54:23 -0500
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:27264
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfLCMyX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 07:54:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjtlW5n5z/x5Y5YKD5viGY9+mbcPaEN0ik2+ctKnyjLI92e01ph+nQMc7kzyWQE1Npg/xzbGHGRNXcawOq0IFnGjs4+PabpzcGNFXqpsBACmiQHmVCy0gOzQlyK0v3xDeGeX9gtH91mUkNYODqQ0N82e3z16s2M1Vk87rSNz9XkjZ7tQBp48C6/aVnUI3+kmF18SczRS5e1G19rbHuIv3oPZQjPg1qlD9HIS+sUUm3ZCUvkj0NHtLUFK24XUBH9ryQgbIhubOiea/uyqDvoWM3b3/l68Z73Ghc1+nUldgsap2NVfLz3o3XhqkP3PaQ/9bYbIrmE/er2SSiCmB6ozCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji3acwXrQpjvGJKPK1p84rflglpGpDmJq0Sk3iGTXI8=;
 b=I7FTv55jSH7BV5sGd/lF69okzrETksG6RKGFvA/A7gxXAfFzllFvBBxeY/zkXeOK4iVZoM4H3W0CeIP1L0XLRMrhf3brhROtj78p266VEwrbzNI7ojdoL2rHELCU1pXA14TTiqGdvFciz9fTlvTQ9r50T1C3JTe5vdvLRGsH20o0zk/gXch1Ixmku8L1+KU9iVckCHZDIpTJQ8eVTh0iPyZYsYAlEqW1inKH25C/rLyB2w5jQrb57Cr/P3BLgXxJshyyy9Dcg3mZJ2muD+1oBSMBx3eUlgpx5CQUSy9SxbefM4LX4sYVtLz49QEzmdNaqSHlm7MxIP2vNVFwbnc/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji3acwXrQpjvGJKPK1p84rflglpGpDmJq0Sk3iGTXI8=;
 b=SzgHGqq/TPWbRPTy8CYJPhPQmKO209l5wf9a/zdGyZZqDtk5wNhzSOoNWcXI0K/L1iu2lJjn0fzFQh3ImZ/JaA2XJ17x49nTEotlKF2GsSBATJVAqqKPzLUDhpEGOV0tA6P2UT4IBTGNecH6R41mbIWwdTIKgLYv0ucU4Aflsw0=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4175.eurprd04.prod.outlook.com (52.133.12.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:54:20 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 12:54:20 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 02/14] mmc: sdhci-esdhc-imx: no fail when no pinctrl
 available
Thread-Topic: [PATCH v2 02/14] mmc: sdhci-esdhc-imx: no fail when no pinctrl
 available
Thread-Index: AQHVqdjHL/Yu5f3AL0+NyHrCiy16WA==
Date:   Tue, 3 Dec 2019 12:54:20 +0000
Message-ID: <20191203130120.11511-3-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: 28d8639d-cafd-44a5-acc6-08d777efe9d9
x-ms-traffictypediagnostic: VI1PR04MB4175:|VI1PR04MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB41756226024208CA3BF7395290420@VI1PR04MB4175.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(316002)(54906003)(446003)(2616005)(26005)(110136005)(2906002)(11346002)(50226002)(8936002)(186003)(2501003)(102836004)(99286004)(386003)(305945005)(86362001)(76176011)(52116002)(6506007)(7736002)(6486002)(6436002)(6512007)(1076003)(5660300002)(66946007)(66556008)(66476007)(64756008)(66446008)(14454004)(36756003)(25786009)(478600001)(256004)(71190400001)(8676002)(81156014)(81166006)(14444005)(71200400001)(6116002)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4175;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aLef2JJ/Y6h7pS9jbE+4ffT+HL4mJZ06AV+UZZ/2RuIHCgUh8AwZdL1i3xG+awJmgWyOCCuf65Nh15S3mAMALe87/Ujc9vgxnkWnKh50WpmH4XYCZqQj8O1WZEAUKLXqoOvAr8WsU53yw02wBU4UhSC/EUSZIrLyB8/vm3DX7KEkRvPv9GzojY74GoYqw8OmvIIuBojWKV+EY+a51cZKdn51KvePUBlzVkT1WE6lG0fsHkDZ8kl0cjeknSlMsQ9UBQfLj+Kdw4L7U755itKQ9P31B2muXQwq3WK4Vo76HG4KC2B5O6Z1/nqthFK5ylw6GJWmI5g5e5LCSuIMpTUVx88rp9r0b1RqPTJVvX8Z5zZueEYYnx7CZ+p7oVvxoR/iSs6cQGOEpPGJ24DeqvOyRJeLK0paTBk6KVY2GRCDRaOSGRbtKeERe1nNtYNIk0/z
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d8639d-cafd-44a5-acc6-08d777efe9d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:54:20.3938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3QpHt7BeZVpOrWuKZGcuR42yEPtJVlAJLWTMYqLsxW9UNpZXm0KbLbc+pafRWV/edGXd96E7ujcwJwfgg5Yfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When using jailhouse to support two Linux on i.MX8MQ EVK, we use the
1st Linux to configure pinctrl for the 2nd Linux. Then the 2nd Linux
could use the mmc without pinctrl driver.

So give a warning message when no pinctrl available, but no fail probe.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-es=
dhc-imx.c
index 1c988d6a2433..3830f4dc8dfc 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1489,13 +1489,14 @@ static int sdhci_esdhc_imx_probe(struct platform_de=
vice *pdev)
 	imx_data->pinctrl =3D devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(imx_data->pinctrl)) {
 		err =3D PTR_ERR(imx_data->pinctrl);
-		goto disable_ahb_clk;
-	}
-
-	imx_data->pins_default =3D pinctrl_lookup_state(imx_data->pinctrl,
+		dev_warn(mmc_dev(host->mmc), "could not get pinctrl\n");
+		imx_data->pins_default =3D ERR_PTR(-EINVAL);
+	} else {
+		imx_data->pins_default =3D pinctrl_lookup_state(imx_data->pinctrl,
 						PINCTRL_STATE_DEFAULT);
-	if (IS_ERR(imx_data->pins_default))
-		dev_warn(mmc_dev(host->mmc), "could not get default state\n");
+		if (IS_ERR(imx_data->pins_default))
+			dev_warn(mmc_dev(host->mmc), "could not get default state\n");
+	}
=20
 	if (esdhc_is_usdhc(imx_data)) {
 		host->quirks2 |=3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
--=20
2.17.1

