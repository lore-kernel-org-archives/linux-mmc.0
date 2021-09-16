Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D3DC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Sep 2021 05:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4857360F48
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Sep 2021 05:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhIPGAn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Sep 2021 02:00:43 -0400
Received: from mail3.swissbit.com ([176.95.1.57]:52816 "EHLO
        mail3.swissbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhIPGAm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Sep 2021 02:00:42 -0400
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id DBC1C462660;
        Thu, 16 Sep 2021 07:59:20 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C4BC6462579;
        Thu, 16 Sep 2021 07:59:20 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Thu, 16 Sep 2021 07:59:20 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15; Thu, 16 Sep
 2021 07:59:20 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0792.015; Thu, 16 Sep 2021 07:59:20 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: dw_mmc: Dont wait for DRTO on Write RSP error
Thread-Topic: [PATCH] mmc: dw_mmc: Dont wait for DRTO on Write RSP error
Thread-Index: AQHXqhYa44rwKgBqC0+dHpZHhUAChw==
Date:   Thu, 16 Sep 2021 05:59:19 +0000
Message-ID: <af8f8b8674ba4fcc9a781019e4aeb72c@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26410.005
X-TMASE-Result: 10--2.949200-10.000000
X-TMASE-MatchedRID: ge9e+QLSeax0/jNwxBmuZv3HILfxLV/9VCGp3g4/hjvzlv7FEwWOy4y+
        AfTlDGN11vhRvynnwhEO7ndyUgsX1eKym8zE8AgF0H8ihGEHNUfYUDvAr2Y/1zyovSwnwFVARiM
        0r5DoZkA8jxJmnRLIc1CmJTAZcDrb0bQcZcDDFnw/ApMPW/xhXkyQ5fRSh265NfN1rpdRutC/L6
        hUiqxuRE27R9Vxkzq+cIzt2e36YsNoMCLywE0ygQtuKBGekqUpbGVEmIfjf3vnPXrQtxZA4oamh
        VxhQjTYKwPdlty0plE4Syw8HpzJwi6AmL2SZCUC
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 71df0c4c-c9f1-49fc-bef3-3aecdd4d99e6-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Only wait for DRTO on reads, otherwise the driver hangs.

The driver prevents sending CMD12 on response errors like CRCs.
According to the comment this is because some cards have problems
with this during the UHS tuning sequence.
Unfortunately this workaround currently also applies for any command
with data.
On reads this will set the drto timer which then triggers after a while.
On writes this will not set any timer and the tasklet will not be
scheduled again.
I cannot attest for the UHS workarounds need, but even if so, it should
at most apply to reads.
I have observed many hangs when CMD25 response contained a CRC error.
This patch fixes this without touching the actual UHS tuning workaround.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/host/dw_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6578cc64ae9e..22cf13dc799b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2081,7 +2081,8 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
 				 * delayed. Allowing the transfer to take place
 				 * avoids races and keeps things simple.
 				 */
-				if (err != -ETIMEDOUT) {
+				if (err != -ETIMEDOUT &&
+				    host->dir_status == DW_MCI_RECV_STATUS) {
 					state = STATE_SENDING_DATA;
 					continue;
 				}
-- 
2.32.0
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

