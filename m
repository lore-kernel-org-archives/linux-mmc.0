Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0390BC4361B
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 09:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03222311B
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 09:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgLPJsS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Dec 2020 04:48:18 -0500
Received: from mail.actia.se ([195.67.112.82]:47806 "EHLO mail.actia.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgLPJsR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 16 Dec 2020 04:48:17 -0500
X-Greylist: delayed 942 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Dec 2020 04:48:16 EST
Received: from S036ANL.actianordic.se (192.168.16.117) by
 S036ANL.actianordic.se (192.168.16.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 16 Dec 2020 10:31:52 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2106.004; Wed, 16 Dec 2020 10:31:52 +0100
From:   John Ernberg <john.ernberg@actia.se>
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "chris@printf.net" <chris@printf.net>,
        John Ernberg <john.ernberg@actia.se>
Subject: [PATCH][mmc-utils] rpmb: Zero-init MMC_IOC_MULTI_CMD structures
Thread-Topic: [PATCH][mmc-utils] rpmb: Zero-init MMC_IOC_MULTI_CMD structures
Thread-Index: AQHW045JWSYYsHHtu06c2XUZxYoGWQ==
Date:   Wed, 16 Dec 2020 09:31:52 +0000
Message-ID: <20201216093146.6218-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.29.2
x-originating-ip: [10.11.250.72]
x-esetresult: clean, is OK
x-esetid: 37303A29A33D5D686D7465
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On our board we would occationally see what looked like a
kernel hang while doing RPMB operations, some additional
printk debugging revealed that in the trouble case data
such as this was being sent to the kernel:

    [  109.076981] idata[0]->ic->opcode = 0x19
    [  109.077027] idata[0]->ic->arg = 0x0
    [  109.080954] idata[0]->ic->write_flag = 0x1
    [  109.084691] idata[0]->ic->is_acmd = 0x0
    [  109.089007] idata[0]->ic->flags = 0xb5
    [  109.092949] idata[0]->ic->blocks = 0x1
    [  109.096865] idata[0]->ic->blksz = 0x200
    [  109.100791] idata[0]->ic->postsleep_min_us = 0x7473696e
    [  109.104745] idata[0]->ic->postsleep_max_us = 0x34383370
    [  109.110167] idata[0]->ic->data_timeout_ns = 0x7265632d
    [  109.115494] idata[0]->ic->data_ptr = 00000000e7ddd4cd
    [  109.120832] idata[0]->rpmb = 00000000ffab5640
    [  109.126077] idata[1]->ic->opcode = 0x12
    [  109.130622] idata[1]->ic->arg = 0x0
    [  109.135451] idata[1]->ic->write_flag = 0x0
    [  109.139153] idata[1]->ic->is_acmd = 0x0
    [  109.143437] idata[1]->ic->flags = 0xb5
    [  109.147553] idata[1]->ic->blocks = 0x1
    [  109.151420] idata[1]->ic->blksz = 0x200
    [  109.155251] idata[1]->ic->postsleep_min_us = 0x652d6873
    [  109.159166] idata[1]->ic->postsleep_max_us = 0x35353264
    [  109.164561] idata[1]->ic->data_timeout_ns = 0x632d3931
    [  109.169915] idata[1]->ic->data_ptr = 00000000bc641ed4
    [  109.175152] idata[1]->rpmb = 00000000ffab5640

Therefor, zero-init the MMC_IOC_MULTI_CMD structures to
avoid the obscene sleep values.

Signed-off-by: John Ernberg <john.ernberg@actia.se>
---
 mmc_cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index fb37189..884cdf8 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1922,7 +1922,7 @@ static int do_rpmb_op(int fd,
 
 	/* prepare arguments for MMC_IOC_MULTI_CMD ioctl */
 	mioc = (struct mmc_ioc_multi_cmd *)
-		malloc(sizeof (struct mmc_ioc_multi_cmd) +
+		calloc(1, sizeof (struct mmc_ioc_multi_cmd) +
 		       RPMB_MULTI_CMD_MAX_CMDS * sizeof (struct mmc_ioc_cmd));
 	if (!mioc) {
 		return -ENOMEM;
-- 
2.29.2
