Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79A0C77B73
	for <linux-mmc@archiver.kernel.org>; Mon, 22 May 2023 21:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjEVVxc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 May 2023 17:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjEVVxb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2023 17:53:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC411F1
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2023 14:53:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ejo@pengutronix.de>)
        id 1q1DT6-0001qo-Ag; Mon, 22 May 2023 23:53:28 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ejo@pengutronix.de>)
        id 1q1DT5-0026B3-Lv; Mon, 22 May 2023 23:53:27 +0200
Received: from ejo by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ejo@pengutronix.de>)
        id 1q1DT5-008YMt-2b; Mon, 22 May 2023 23:53:27 +0200
From:   Enrico Jorns <ejo@pengutronix.de>
To:     linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, ejo@pengutronix.de
Subject: [PATCH 2/2] mmc-utils: add error handling to 'extcsd write' input value parsing
Date:   Mon, 22 May 2023 23:53:10 +0200
Message-Id: <20230522215310.2038669-2-ejo@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522215310.2038669-1-ejo@pengutronix.de>
References: <20230522215310.2038669-1-ejo@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ejo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

So far, any value was silently accepted, even a

  mmc extcsd write 0x100 yeah /dev/mmcblk1

which resulted in write of value 0x0 at offset 0x0 since the parsing
error of 'yeah' was ignored and the returned value of 0 was taken
unconditionally.
The 0x100 was then implicitly casted down to the expected __u8 input for
the offset and also ended up as 0.

This is not the behavior one would expect when dealing with eMMC
registers that might, depending on which we write to, be writable only
once in the eMMC's lifetime.

This introduces the str_to_u8() helper function that checks if input
values are parsable and have a proper size. Internally it also uses
strtoul() instead of strtol() since input is always expected to be
non-negative. Also, use proper input variables (unsigned long instead
of int) to remove another layer of implicit down casts.

Signed-off-by: Enrico Jorns <ejo@pengutronix.de>
---
 mmc_cmds.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 154020e..e348651 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1981,10 +1981,28 @@ out_free:
 	return ret;
 }
 
+__u8 str_to_u8(const char* input)
+{
+	unsigned long parsedval;
+	char *endptr;
+
+	parsedval = strtoul(input, &endptr, 0);
+	if (*endptr != '\0') {
+		fprintf(stderr, "Invalid input: %s. Cannot parse to 8 bit integer.\n", input);
+		exit(1);
+	}
+	if (parsedval >= UINT8_MAX) {
+		fprintf(stderr, "Invalid input: Value %s too large 8 bit integer.\n", input);
+		exit(1);
+	}
+
+	return (__u8) parsedval;
+}
+
 int do_write_extcsd(int nargs, char **argv)
 {
 	int fd, ret;
-	int offset, value;
+	__u8 offset, value;
 	char *device;
 	int verify = 0;
 
@@ -1993,8 +2011,8 @@ int do_write_extcsd(int nargs, char **argv)
 		exit(1);
 	}
 
-	offset = strtol(argv[1], NULL, 0);
-	value  = strtol(argv[2], NULL, 0);
+	offset = str_to_u8(argv[1]);
+	value = str_to_u8(argv[2]);
 	device = argv[3];
 
 	if (nargs == 5) {
-- 
2.39.2

