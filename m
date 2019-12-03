Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295D8C432C0
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32BD2073B
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mUxUfWrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLCMyV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:54:21 -0500
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:27264
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfLCMyV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 07:54:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpqTJh4izqv1SFJOk7+qGWnH7VHbMhypp3Y4JdCz0w33gL2xwsrDSbqgCGZLLx8HDJhdGLtQtsvEIQBBfNsRNHdjZ3F6Uxjd1q1jooRMA1JBxI2ojEjOJ+H1qnGIDdHMYzLX2W2GQIpxFtUlZ3+P4vB2XvUhJAPYwTOXbR4m4cj/PpFU02yKOBdAvEAuL7wGxaowLOO3rqMyF1PNhxebPygRzEzbhZduJ8gleM/sWv5xxujGnAIn/ytG5agIM3teeGzsDBzh5cWlzqqjGGI5W4gbzbXXXdt/l/l7E1JIob4KTfeYKbp6YV+5Yxuv4jBhXQYU9u7ZQQlYJoc51nKeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg8ayQi7WJtjZFu47YWjYcDwB904GmNWB2I0GbxqTt8=;
 b=LoQlYM8ZPNyPGocAcSmBdLo560vaQlzRezgXBknLESd3WPVIQycaUHiXFTFUIodeUArA7oHsUyCdyZfXdSqJwSPhq+Y2bAkD770VGjL9EJYIU9dJel35SjRxaUDBbFz0ORvzp1v6w8oiHKnq5RQNndxhKBKQF9X8Z5Q69S9JYu/yL7ZWOgEjEhN2I3vCaNymta2jVbpx1m6Oq0GGN7hMpDw1Wx5KA5Gr5v8dIsw/0YKy5YNHNKbJsLJlrODYhmSsrFsKo2glbB6rERHSINV9XzmUWIdZvo1mN8/+YyMv0hh+4SLZjxnpZTW09wq38s7vlebILCjHUof6qFYP6bTCZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg8ayQi7WJtjZFu47YWjYcDwB904GmNWB2I0GbxqTt8=;
 b=mUxUfWrmEKeTK+4Wx4SE4+3xtZ3bB5m8mlYo2NiJgqgyNkPZKR6NnGEtq6ZNmyZ2Cs7U4ruSfjCkwEGfZRVPgQrX8eTilHQwVO43baSKdntdFJkgK+4FyfKVoD+tHfeCYINJcBNeSIyPKt5NnaIWaYGjr6PM82OuX3ap79Sw+dc=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4175.eurprd04.prod.outlook.com (52.133.12.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:54:17 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 12:54:17 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 01/14] mmc: sdhci: do not enable card detect interrupt for
 gpio cd type
Thread-Topic: [PATCH v2 01/14] mmc: sdhci: do not enable card detect interrupt
 for gpio cd type
Thread-Index: AQHVqdjF4yOvA9ZAokeRqllIJ+d+sQ==
Date:   Tue, 3 Dec 2019 12:54:17 +0000
Message-ID: <20191203130120.11511-2-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: 45719c26-a00a-4ef9-dfed-08d777efe7fd
x-ms-traffictypediagnostic: VI1PR04MB4175:|VI1PR04MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4175E70680EC9743F0B7986390420@VI1PR04MB4175.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(316002)(54906003)(446003)(2616005)(26005)(110136005)(2906002)(11346002)(50226002)(8936002)(186003)(2501003)(102836004)(99286004)(386003)(305945005)(86362001)(76176011)(52116002)(6506007)(7736002)(6486002)(6436002)(6512007)(1076003)(5660300002)(4744005)(66946007)(66556008)(66476007)(64756008)(66446008)(14454004)(36756003)(25786009)(478600001)(256004)(71190400001)(8676002)(81156014)(81166006)(14444005)(71200400001)(6116002)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4175;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wD+YGVbUQq3zTx1QKfgCyVddSNx1ZqBGM5L1st386+2P0q66rixRi5flirEzSMsuMFDxnyWAr+t4GBl/go2wXX0wmdPCUSo/FZXDaspewKHwU9mzPIjb0CvH3h80W2QpYcH69wNt3CMgcK1fxYkW5nHqAkLY4MnJfp+7T3+k1s+fjVw+QmQGF1eWfx21o7rRkOsb5CsgKT6qfHzDjcgYWkGtURoAiIL2z9af+abSkN0Y9OtdWl7UW5MFwRieC1ZxnkeaSrVFyBlleMgp4VwlFKMsvDaAuCplvaT4Bszfwu55wQpW9Q/W/CG0Mbvl64oGEFhw7195+airjvUpZvrIR/dX+NC10dmJTFkAFLlu6Tnjcq3CK0pNul1XnuItaOPsuhb+mNOkbGc8WcDTIrYwUIrkb0JV7TL74j95WhlZSS/T81sV7bCLP1IH6/dKvHrn
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45719c26-a00a-4ef9-dfed-08d777efe7fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:54:17.3136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZfD7pMx33Xr+ZG7FFEVauBrNgtOJuZNWp/r+igVNUz31BNTBbvpz0dgZlbV2DrY2nQ21tlUYqUb7yTaAaP8ojw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Except SDHCI_QUIRK_BROKEN_CARD_DETECTION and MMC_CAP_NONREMOVABLE,
we also do not need to handle controller native card detect interrupt
for gpio cd type.
If we wrong enabled the card detect interrupt for gpio case, it will
cause a lot of unexpected card detect interrupts during data transfer
which should not happen.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3140fe2e5dba..6dc88b1aee6e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -152,7 +152,7 @@ static void sdhci_set_card_detection(struct sdhci_host =
*host, bool enable)
 	u32 present;
=20
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
-	    !mmc_card_is_removable(host->mmc))
+	    !mmc_card_is_removable(host->mmc) || mmc_can_gpio_cd(host->mmc))
 		return;
=20
 	if (enable) {
--=20
2.17.1

