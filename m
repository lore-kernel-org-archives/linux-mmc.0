Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065FDC432C0
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC10A206EC
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Set/UuLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfLCMzd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:55:33 -0500
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:33645
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726079AbfLCMzd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 07:55:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MV/WzrYe5C/396jp1vNjJhno0fU+otf7nKk0UuKjJZizn5BV6hy2Nl8XqWY4tY3mMUqXTwHu3k8gyNtyrOOF9G+F2HCW51wpHmNuHNbRQyNzV6JsHweZHbA/NiJl+KckG5aXU6aqkhZ8FyEuhAN/32wiIS7aTRmWzuyrhJeHbdGomyAxhMJ4q7Gj7QRFp3+5rZNxQBQzDHE16Xh+87LgQO6V/Z+gZ3zcpMPLRv8gl2317ht9Tzec2H23jJ5ZwjuaJT3t+Hqw4y9kX+/QkDXZ5ePZ1XQzK5lefsTqtVca8Lb+wbSuPe5wxDOWe4mUjH7AMzl2pOMjjveCeVIGj4HlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr2zT+KpWb9xYimg56x7uy97fyAhfcf7MMI6RAqDEI0=;
 b=WyfouDKukUp6CSJhWn85+TjjjeVfjkxxpe0a2soaUXBfZhGr2gd5lWHWKBNw18s2i1gnq5hpl6Ldkdm7H61n7vnrEXXZdfZ+ecFt/4oLiG3aKNtl9vE1pCJYQmnX4bSPVzJAbpLnshnooXgRuRr8Vql6EB3DCxS93E3oEAi5CrjkR+KNOvNivpP6MpABXZXWaaCpYbJFNAwfhXCdRHyuSHrz17dQIV6D13Fh1liI95KcTWZ9EUFRF76SZM717Z1rJ2T9vrNsRJOoJcgqHO5NkUTsNRfXJPwv2gBirIXuI8pRb3oxh2qpZ6jPDhX06mueE7kmVFoxDZtHPJ22bX277g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr2zT+KpWb9xYimg56x7uy97fyAhfcf7MMI6RAqDEI0=;
 b=Set/UuLHovPpGOAH6MG1QcOuGnVdHJPr4T6l6eCkM0L7yJOJmJbGUp+lYI+ppj7iB8/IZS3FvUQj34feQp1oYvJnv1M/C1JxuuO16Zfby3PieLprhjVL52/WXHWc0kuBsuMgm/kHYImf5uxdFqQwni1gED3fasrozKY1lUJzf70=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4175.eurprd04.prod.outlook.com (52.133.12.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 12:54:56 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 12:54:56 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 14/14] mmc: queue: create dev->dma_parms before call
 dma_set_max_seg_size()
Thread-Topic: [PATCH v2 14/14] mmc: queue: create dev->dma_parms before call
 dma_set_max_seg_size()
Thread-Index: AQHVqdjcI3fE0jojPE6E167EE2bQ2Q==
Date:   Tue, 3 Dec 2019 12:54:55 +0000
Message-ID: <20191203130120.11511-15-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: ca5a9ae6-7723-40d3-7c62-08d777efff25
x-ms-traffictypediagnostic: VI1PR04MB4175:|VI1PR04MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4175BE6409038429D5179B0290420@VI1PR04MB4175.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(316002)(54906003)(446003)(2616005)(26005)(110136005)(2906002)(11346002)(50226002)(8936002)(186003)(2501003)(102836004)(99286004)(386003)(305945005)(86362001)(76176011)(52116002)(6506007)(7736002)(6486002)(6436002)(6512007)(1076003)(5660300002)(66946007)(66556008)(66476007)(64756008)(66446008)(14454004)(36756003)(25786009)(478600001)(256004)(71190400001)(8676002)(81156014)(81166006)(14444005)(71200400001)(6116002)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4175;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CrL7A+WqSnLFo1XqZh+8gLMlTmadPqP8iao5+pd7UinbXXC+n0G+EuJqgMt+cFAqdXVsDN7xiXL/5ps5mmAvlLYDlLjmXOcr3aU6mZLLuWk6396k1BH21gHxrc5JAnd499YW2DzlD3PDAo+icfvYQo8/c8Td5Eu6VzfrOEZT3ef0ypbx6+ppzMZ86tpGTrhhX04ueCMknrrgX4mkngWT51iVT1EH1vXaW8K51NwLhelBAHqqDY+tTZIWVi/ibiEHZhmFjInEsb9e4GspL+vft39vXMSGYYiXPJ2+2UvwDv9+RBNt/FCb6kOygmmUZGYlCRvdgDTEA1lh3GEo03+yKvzYYSztlM4Pu6s1q3WcKv8rpG+kj2SBVkscIQkPluMFaPCNCqclbwAS+lJXaGIl3tRp4UFS+PKqS3nrSuzvYk8hjY7eAR2TJ5FlbUPp2EXG
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5a9ae6-7723-40d3-7c62-08d777efff25
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 12:54:56.0528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17Rbtwiomclfd5uzyv1x3MUQboaGPRvMVTWUttFnuIeZ7uvAu5bTY/iMsGEGrHo2oncNwMaQncLkY4Ml5fGGWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To make dma_set_max_seg_size() work, need to create dev->dma_parms.

Find this issue on i.MX8QM mek board, this platform config the
max_segment_size to 65535, but this dma_set_max_seg_size do not
actuall work, find sometimes the segment size is 65536, exceed
the hardware max segment limitation, trigger ADMA error.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/core/queue.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 9edc08685e86..f74c28c58482 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -359,6 +359,7 @@ static const struct blk_mq_ops mmc_mq_ops =3D {
 static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 {
 	struct mmc_host *host =3D card->host;
+	struct device *dev =3D mmc_dev(host);
 	unsigned block_size =3D 512;
=20
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, mq->queue);
@@ -366,13 +367,12 @@ static void mmc_setup_queue(struct mmc_queue *mq, str=
uct mmc_card *card)
 	if (mmc_can_erase(card))
 		mmc_queue_setup_discard(mq->queue, card);
=20
-	if (!mmc_dev(host)->dma_mask || !*mmc_dev(host)->dma_mask)
+	if (!dev->dma_mask || !*dev->dma_mask)
 		blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
 	blk_queue_max_hw_sectors(mq->queue,
 		min(host->max_blk_count, host->max_req_size / 512));
 	if (host->can_dma_map_merge)
-		WARN(!blk_queue_can_use_dma_map_merging(mq->queue,
-							mmc_dev(host)),
+		WARN(!blk_queue_can_use_dma_map_merging(mq->queue, dev),
 		     "merging was advertised but not possible");
 	blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
=20
@@ -389,7 +389,8 @@ static void mmc_setup_queue(struct mmc_queue *mq, struc=
t mmc_card *card)
 		blk_queue_max_segment_size(mq->queue,
 			round_down(host->max_seg_size, block_size));
=20
-	dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
+	dev->dma_parms =3D devm_kzalloc(dev, sizeof(*dev->dma_parms), GFP_KERNEL)=
;
+	dma_set_max_seg_size(dev, queue_max_segment_size(mq->queue));
=20
 	INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
 	INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
--=20
2.17.1

