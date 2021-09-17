Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03311C433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 07:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C996113A
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 07:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhIQHwL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 03:52:11 -0400
Received: from mail4.swissbit.com ([176.95.1.100]:39472 "EHLO
        mail4.swissbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhIQHwJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2021 03:52:09 -0400
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id B74541221B6;
        Fri, 17 Sep 2021 09:50:45 +0200 (CEST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 9EB541221B3;
        Fri, 17 Sep 2021 09:50:45 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Fri, 17 Sep 2021 09:50:45 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15; Fri, 17 Sep
 2021 09:50:44 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0792.015; Fri, 17 Sep 2021 09:50:44 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "marten.lindahl@axis.com" <marten.lindahl@axis.com>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: dw_mmc: avoid long timeout if register invalid
Thread-Topic: [PATCH] mmc: dw_mmc: avoid long timeout if register invalid
Thread-Index: AQHXq5f2H1xcZooo4kGJdi3JsFt1Dw==
Date:   Fri, 17 Sep 2021 07:50:44 +0000
Message-ID: <bf19053cf6f547bcbb364975cda84c30@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26412.006
X-TMASE-Result: 10--3.581400-10.000000
X-TMASE-MatchedRID: w2TFuZOvAteFZxY3FrzYQ5XIRfiL5JZTMI2NtA9qrmJjLp8Cm8vwF0Ac
        6DyoS2rIj6kCfX0Edc76DhgT3dBZd1J0kimQOcFwOGTV4fFD6yB+kAcS0i53MMVsL38cyo+71c2
        BC6YLibNlnUu9VvrsFbdPv7Ky46Z9vSIe1ujjRZpZlN4HS2qim30tCKdnhB58Caz7A70l7zb6C0
        ePs7A07Y6HM5rqDwqtXomTel6u7G6hafoaHrRGKSrSwg0z4VM27/Sq3IZtUTzdnuG7sq6lkA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 15e4f564-3b29-48d8-a01e-f8b6c63752c6-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


Set the limit to 1s if the register is at reset value.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/host/dw_mmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6578cc64ae9e..cd9a6e0a7449 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1983,6 +1983,14 @@ static void dw_mci_set_drto(struct dw_mci *host)
 	/* add a bit spare time */
 	drto_ms += 10;
 
+	/*
+	 * If TMOUT register still holds the reset value the above calculation
+	 * would yield a timeout of over 167 seconds, limit it to 1000ms.
+	 * Normal reads/writes should not take anywhere close to 120s.
+	 */
+	if (drto_ms > 120000)
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

