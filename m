Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39A9C10DCE
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 14:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD9D20663
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 14:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="KUTmcpxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgCLO33 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:29:29 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:14248 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgCLO33 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2020 10:29:29 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ehT3N1poa0efK0KcBQZhNkwv+nIcfyBc3GkvQNpHtzhPAd0cs4JNy3cmT1zi3B2TX59N1ilSeT
 MKNAwuDSSBLLechE3Ci13zo19D+P9p8caVzD3zV85dai7egONIX+q1uZZ3rIjcScGPKTqFWrjO
 pxdx+Oefhf+MSJL79AT+K7q8ZBxU9pC008WALrNYXcFAEpV2Dt39RxtGj5QeN2AREpa0cdACkT
 OS0rRIkblkUFnxwd6r92Yq3L+kynDzQsipE7gyN/onkBtBg5I/NKQmKtKA07F5gtHB5f04vB/R
 IQk=
X-IronPort-AV: E=Sophos;i="5.70,545,1574146800"; 
   d="scan'208";a="69758854"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Mar 2020 07:29:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Mar 2020 07:29:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Mar 2020 07:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7R1ggFtElq/6SobZm1LrXeZln4UcFNIKTqlyhDDu1GlaZ4HHcCXGAbgmgtI87G7hD7nsGBYlGrXWSQJpohOG/VhvDhvdxCHxzplV7YSNt2+DoaMPbRlFElLCErvguFi5TSQAZ/POeRPnN4LdjTaAXaiyJstSD8yq9Y9695YcXEnO7Li5i0hNr6gnhIubckEVaq7rVrymMsKlyMpx6pfB9sdMbzz9LuyvosvJ9eufNCe5Uun/Acf5xcJNbugJgHNUDBGqIjDpU4YydqZYAMRdWZ62iRqqhR0LbgPMTggPEcgA+evPFLVtGWofeazi4PW9sOABBiOtPQ+XAlXR9lBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKzoQHzofPalicpvJlq7tuFQVD0xMoAsRS6nXmE5Vig=;
 b=iNFkSqu2B6/msimemAj9/dqRfsqDnP/ekf71wHn7CcU+khteRGvvfuRXvZ2/B151rnagJYJwESjXWPnKMZAErczfLCR/Z6B76WRccBc0PSUIYNWHDdHeaJg2pY7LQZ5xdBNafDXJKUh8sQF+gEwWgC9VOpc83w4dDDCrwOc7EHPNrXJrLY8D0gRfwh6gYm3oYHrmRgpf1QdrQHEwu+MLWMGV0pd1aX7pmGlORhz52gCeDbralOQaAqmppDxjNUhfPAbSVy5ePXyCI3KHHmDz+cVQVrk9hfGstXJ+jNBp62DIhjuGSBoY2U78FciA6OtjFSucAi/alWUtGDSQIsrQ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKzoQHzofPalicpvJlq7tuFQVD0xMoAsRS6nXmE5Vig=;
 b=KUTmcpxefk55nznJzV+5M9cRYp4DTyzB00HEWSjypBt+ALsvbwCiIw0BaKLNDH/wtp7DlhvhCyuKfxBunZ4SI/hpvhoVylygFL86bC7p2n7Fa9JaxZmKDUUFOdPUNO+05n43jkeQ+yetXtCQFuUOuWdF4MWdiGsAnYlbhaG8RvA=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4493.namprd11.prod.outlook.com (2603:10b6:208:190::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Thu, 12 Mar
 2020 14:29:25 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 14:29:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <adrian.hunter@intel.com>, <Ludovic.Desroches@microchip.com>,
        <ulf.hansson@linaro.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Cristian.Birsan@microchip.com>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH] mmc: sdhci-of-at91: Display clock changes for debug purpose
 only
Thread-Topic: [PATCH] mmc: sdhci-of-at91: Display clock changes for debug
 purpose only
Thread-Index: AQHV+HqhVonJfj9ooEG0j49qskyYOA==
Date:   Thu, 12 Mar 2020 14:29:24 +0000
Message-ID: <20200312142904.232822-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d601b884-d70f-4bc9-3dac-08d7c691c39e
x-ms-traffictypediagnostic: MN2PR11MB4493:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB44931A7FD53AABA12891B196F0FD0@MN2PR11MB4493.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(6506007)(5660300002)(6512007)(71200400001)(4326008)(54906003)(81166006)(36756003)(81156014)(26005)(478600001)(316002)(186003)(86362001)(110136005)(91956017)(8676002)(1076003)(76116006)(64756008)(66476007)(6486002)(8936002)(2616005)(66946007)(107886003)(66446008)(66556008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4493;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/UATGgW7aVaZpuWHLGOclxyLR1j93zPbdW7iG/T+n7+VblvAdRmo6CbifdgR+4aXZUmU1tvnHUEJ124+R5SUtHrQbacvvi/WgkBTHyFHvx4/BUKKW2sZqldZwBp207LP4fPqCfyoqnNCCRX+unEBva8IIsDeJKti4vgNILwbIvCSxjF42jUiu/HlV56FxMxVAH7J3Rig05vXwU6z/nRdUhE3eLhWw4qy1hBQtJsDhvDXW9P7BnBoexaE7WlcZ9vbk9j/w/yleQ//cqsvAO2kuf2bemo3VXXdaldH/azSYvYHja+y3uawrTRedEkot53HHhDVLcbwZF+1QlfQnJmra19pc/Lp1+HYu8rLrKzzkyrVMGtAWV7yuYSwxZ+gVaSK9z7NRIiT5uvihPl6qze4ZsSjqb835lUiLn54jRPHJPG6pujRPkAAt402qzpx7+1
x-ms-exchange-antispam-messagedata: LQrcCS3s0LEavgq69tK8dWJfDYzPE1+0pWLnsxmHXF9dNA9XpXrMdqST5qSBehih/EZScM4evWlP31IqGS3yhg1sEzRoh8wnHgQdGCCjsUN5IB2uVimG/K10TMLcF+iNiAdJfjKhVjPw1f9pHX9FUA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d601b884-d70f-4bc9-3dac-08d7c691c39e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 14:29:24.9390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KIL6w1iYXOB2qnMhwQ5qtgbs02ikad3uv5xbtE8M5bBOrlvgNLNMKIjRSVzyOBBidWzNDORBWwReT/byskB+S+nofGMuIHeg7tRaRq6gfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4493
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

The sdhci_at91_set_clks_presets() function is called multiple times
at runtime and the messages are shown on the console. Display clk mul,
gck rate and clk base for debug porpose only.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-a=
t91.c
index ab2bd314a390..88f17abb69a7 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -204,8 +204,8 @@ static int sdhci_at91_set_clks_presets(struct device *d=
ev)
 	/* Set capabilities in ro mode. */
 	writel(0, host->ioaddr + SDMMC_CACR);
=20
-	dev_info(dev, "update clk mul to %u as gck rate is %u Hz and clk base is =
%u Hz\n",
-		 clk_mul, gck_rate, clk_base_rate);
+	dev_dbg(dev, "update clk mul to %u as gck rate is %u Hz and clk base is %=
u Hz\n",
+		clk_mul, gck_rate, clk_base_rate);
=20
 	/*
 	 * We have to set preset values because it depends on the clk_mul
--=20
2.23.0
