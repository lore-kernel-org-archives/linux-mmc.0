Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2711C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 06:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A636A61528
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 06:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348381AbhI3Gze convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Sep 2021 02:55:34 -0400
Received: from mail3.swissbit.com ([176.95.1.57]:56148 "EHLO
        mail3.swissbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347826AbhI3Gzd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2021 02:55:33 -0400
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 23E8A4630D4;
        Thu, 30 Sep 2021 08:53:50 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 12EFC4630B5;
        Thu, 30 Sep 2021 08:53:50 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Thu, 30 Sep 2021 08:53:50 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15; Thu, 30 Sep
 2021 08:53:49 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0792.015; Thu, 30 Sep 2021 08:53:49 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "marten.lindahl@axis.com" <marten.lindahl@axis.com>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: [PATCHv2] mmc: dw_mmc: avoid long timeout if register invalid
Thread-Topic: [PATCHv2] mmc: dw_mmc: avoid long timeout if register invalid
Thread-Index: AQHXtcfs7JUVIMDbzUazihMGnYu+Rw==
Date:   Thu, 30 Sep 2021 06:53:49 +0000
Message-ID: <5883e4a323ff4a23a786e39b947980bb@hyperstone.com>
References: <bf19053cf6f547bcbb364975cda84c30@hyperstone.com>
In-Reply-To: <bf19053cf6f547bcbb364975cda84c30@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26438.006
X-TMASE-Result: 10--2.408700-10.000000
X-TMASE-MatchedRID: xSJL/ht5SGCFZxY3FrzYQ5XIRfiL5JZTMI2NtA9qrmJjLp8Cm8vwF0Ac
        6DyoS2rIj6kCfX0Edc76DhgT3dBZd1J0kimQOcFwOGTV4fFD6yB+kAcS0i53MI4QQ2CxQC5iM5/
        OS/ZAyQxAd1p6vH9GiqBVvEjzNBpCaDAi8sBNMoGWlioo2ZbGwdmzcdRxL+xwKrauXd3MZDU4P+
        Cvnwfd4aNqf61VoahIgAeC+OqeGqy8yhW+Q81ebeurYa7EGiG9
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 4648ec11-b610-4b47-80f8-299fa8380551-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Set the limit to 1s if the register is at reset value.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/host/dw_mmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6578cc64ae9e..96b620a9fd52 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1983,6 +1983,13 @@ static void dw_mci_set_drto(struct dw_mci *host)
 	/* add a bit spare time */
 	drto_ms += 10;
 
+	/*
+	 * If TMOUT register still holds the reset value the above calculation
+	 * would yield a timeout of over 167 seconds, limit it to 1000ms.
+	 */
+	if (drto_clks == 0xFFFFFF)
+		drto_ms = 1000;
+
 	spin_lock_irqsave(&host->irq_lock, irqflags);
 	if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
 		mod_timer(&host->dto_timer,
-- 
2.32.0
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

