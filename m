Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DBDC432C0
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C427A206EC
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="keihz76p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfLCMy5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:54:57 -0500
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:33645
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726131AbfLCMy5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 07:54:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYTGN4sOwV0EUp6HQuhW30iPeDcBpNhUlRwxEGxlV9JoWUcSm+GZsmWzKPjIOj7adYREIqdXnVfBYDxleOO4jM/fIRD3p7YN696S8B2uirXKgpHP1WVyGrwd8zHmxD84Cv3QfzBLvEp27FjUKsPXdQ4216Gbsot8LcEDWT2vpUrieE0AHJCoHH9tlASeVI6S2OybFrd5BE0HWqeddSJdPA8idp0B68DwgrEBTMSNWcBKJZLKrwxJTUSQrJmKv1hTk5hcG2x2YeyO3Oqli2E9hnorfW/fQVVp3dp7RiadS0Zll2d1wseiGF5Marn0oZxkGy9ufgFMM1J3Hvbj/Aix3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CSWuS8iS775GTLTNXGu9opYZ44g9Bt+nNmhBfMi/gs=;
 b=GqWKPET+51qmahbXvbqY42NexfNCiqFWF+plvigtJ2eM8V6FkZC8A9aUwmmcdRgZGOQ73FSuSUtksu5vC56vkrkAKfQq4x5GVxxueKSwB3m5rNt9KeBqfy2FM/j573s5UwPSPPxqDFIcBixFK6AcTDX4t7DUd/gLg9oJz020sZ1ZfDEzTkJ6/SmRVnPnYGWBX555eOHcrkxHGRoFoVUxA9ByzQuDh3OfItuToWcBLeX4irfOrLczKIBsItfUg8nKkdmUCj5z5Al/ov0vlpcnDWveqRf1po8neX7XV+TDv4NOfzGXfcf45XhrzR6nrlDbmlsWXRqKkepHw1yv2lHIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CSWuS8iS775GTLTNXGu9opYZ44g9Bt+nNmhBfMi/gs=;
 b=keihz76pezf8gHs16H+7CYtVknlhOLmE3+hmwIwD6kT7rGGGdVidYoj21+kx2lecGjfLXeaTIvbNJjx90PNZ95eskYXk+zXLNo9pQYPUnQSbsr2AlCv7dFn/qUaziYQ3U14r57g5JTGFAD5pNTq9gtDLCarCpWJjp2vxsMdKOOY=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4175.eurprd04.prod.outlook.com (52.133.12.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:54:35 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 12:54:35 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 07/14] mmc: sdhci-esdhc-imx: optimize the clock setting
Thread-Topic: [PATCH v2 07/14] mmc: sdhci-esdhc-imx: optimize the clock
 setting
Thread-Index: AQHVqdjQwIYAkS+0t0OLfL7IPZ1Lcg==
Date:   Tue, 3 Dec 2019 12:54:35 +0000
Message-ID: <20191203130120.11511-8-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: c1c82076-1898-46c9-61a7-08d777eff2d3
x-ms-traffictypediagnostic: VI1PR04MB4175:|VI1PR04MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB41754BBF6A0BB3D01714689790420@VI1PR04MB4175.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(316002)(54906003)(446003)(2616005)(26005)(110136005)(2906002)(11346002)(50226002)(8936002)(186003)(2501003)(102836004)(99286004)(386003)(305945005)(86362001)(76176011)(52116002)(6506007)(7736002)(6486002)(6436002)(6512007)(1076003)(5660300002)(66946007)(66556008)(66476007)(64756008)(66446008)(14454004)(36756003)(25786009)(478600001)(256004)(71190400001)(8676002)(81156014)(81166006)(14444005)(71200400001)(6116002)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4175;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E4yklc2pjiEoggkyXoz35jXQ+l/V7eStQfMr16s7Ldewe0CP1m6D5PrpMJUYeBoC3If6fXm7BjZ2a0h7GdlUm1XX3Vlb5WLI6tvwWTQs0dpLaEqbzAqQTqlHWlA/Dw1lGNNoL4ks9omJEwi0iUVOIuaqq/8oob5NetQTmaQLvBFmqH5B3yX+3CTQ+KAvyLrBLAk6cM2P2U99RsUpPLd0ZgGYY59NJ9Ng3Ee6e74k1OMNGcAgQymKtlN1RPxHRf8ZFaVA2EOBG/qClKIF3w3ZJOZjdKl6bBPqpKfGv1g/44mCLu9hC2fA5Aq9QdIawRi98eutPl0bGyvtt0o5br2gg258+jo7RGzBVyqAbjt7G+JU/UTbESN51EC82Zj+LJ7zB1we8UpmxGA4uJ20af4S1GR7/0j7KwD3/wDKBMlY9YytpYR/axgBMDDl1umM37Tx
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c82076-1898-46c9-61a7-08d777eff2d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:54:35.2831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJWadzt4MmtppK4IspqGdl/egzqZ/GJmaxI1i0eKniU9Rh0d1NyTBHp7oP0XATz0/r4mnFIYGz1WY5O6BZk4/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When force clock off, check the SDOFF of register PRSSTAT to make sure
the clock is gate off. Before force clock on, check the SDSTB of register
PRSSTAT to make sure the clock is stable, this will eliminate the clock
glitch.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 24 +++++++++++++++++++++++-
 drivers/mmc/host/sdhci-esdhc.h     |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-es=
dhc-imx.c
index 4b19ac0039f6..9b03656c7abc 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -9,6 +9,7 @@
  */
=20
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -313,6 +314,17 @@ static inline void esdhc_clrset_le(struct sdhci_host *=
host, u32 mask, u32 val, i
 	writel(((readl(base) & ~(mask << shift)) | (val << shift)), base);
 }
=20
+static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *h=
ost)
+{
+	u32 present_state;
+	int ret;
+
+	ret =3D readl_poll_timeout(host->ioaddr + ESDHC_PRSSTAT, present_state,
+				(present_state & ESDHC_CLOCK_GATE_OFF), 2, 100);
+	if (ret =3D=3D -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc), "%s: card clock still not gate off in 100us=
!.\n", __func__);
+}
+
 static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
@@ -526,6 +538,8 @@ static void esdhc_writew_le(struct sdhci_host *host, u1=
6 val, int reg)
 		else
 			new_val &=3D ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON;
 		writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
+		if (!(new_val & ESDHC_VENDOR_SPEC_FRC_SDCLK_ON))
+			esdhc_wait_for_card_clock_gate_off(host);
 		return;
 	case SDHCI_HOST_CONTROL2:
 		new_val =3D readl(host->ioaddr + ESDHC_VENDOR_SPEC);
@@ -754,12 +768,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci=
_host *host,
 	int ddr_pre_div =3D imx_data->is_ddr ? 2 : 1;
 	int pre_div =3D 1;
 	int div =3D 1;
+	int ret;
 	u32 temp, val;
=20
 	if (esdhc_is_usdhc(imx_data)) {
 		val =3D readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 		writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
 			host->ioaddr + ESDHC_VENDOR_SPEC);
+		esdhc_wait_for_card_clock_gate_off(host);
 	}
=20
 	if (clock =3D=3D 0) {
@@ -814,13 +830,18 @@ static inline void esdhc_pltfm_set_clock(struct sdhci=
_host *host,
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
=20
+	/* need to wait the bit 3 of the PRSSTAT to be set, make sure card clock =
is stable */
+	ret =3D readl_poll_timeout(host->ioaddr + ESDHC_PRSSTAT, temp,
+				(temp & ESDHC_CLOCK_STABLE), 2, 100);
+	if (ret =3D=3D -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc), "card clock still not stable in 100us!.\n")=
;
+
 	if (esdhc_is_usdhc(imx_data)) {
 		val =3D readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 		writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
 			host->ioaddr + ESDHC_VENDOR_SPEC);
 	}
=20
-	mdelay(1);
 }
=20
 static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
@@ -1005,6 +1026,7 @@ static void esdhc_set_strobe_dll(struct sdhci_host *h=
ost)
 	writel(readl(host->ioaddr + ESDHC_VENDOR_SPEC) &
 		~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
 		host->ioaddr + ESDHC_VENDOR_SPEC);
+	esdhc_wait_for_card_clock_gate_off(host);
=20
 	/* force a reset on strobe dll */
 	writel(ESDHC_STROBE_DLL_CTRL_RESET,
diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.=
h
index 9289bb4d633e..947212f16bc6 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -31,6 +31,7 @@
=20
 /* Present State Register */
 #define ESDHC_PRSSTAT			0x24
+#define ESDHC_CLOCK_GATE_OFF		0x00000080
 #define ESDHC_CLOCK_STABLE		0x00000008
=20
 /* Protocol Control Register */
--=20
2.17.1

