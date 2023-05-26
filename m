Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D37BC77B7A
	for <linux-mmc@archiver.kernel.org>; Fri, 26 May 2023 08:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjEZIL1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 May 2023 04:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242278AbjEZIL0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 May 2023 04:11:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B499ED3
        for <linux-mmc@vger.kernel.org>; Fri, 26 May 2023 01:11:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1q2SXf-0003NN-9a; Fri, 26 May 2023 10:11:19 +0200
Received: from [2a0a:edc0:0:1101:1d::54] (helo=dude05.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1q2SXe-002uct-4F; Fri, 26 May 2023 10:11:18 +0200
Received: from afa by dude05.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1q2SXd-0085OO-Cy; Fri, 26 May 2023 10:11:17 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel@pengutronix.de, linux-mmc@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [PATCH] mmc-utils: support overriding CFLAGS without setting -DVERSION
Date:   Fri, 26 May 2023 10:11:01 +0200
Message-Id: <20230526081100.1741293-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Build tools like OpenEmbedded set the CFLAGS environment variable to be
in line with distro-wide decisions. Updating OpenEmbedded-core to point
at the new mmc-utils breaks, because VERSION would then be undefined.

Instead of having users workaround this by feeding in -DVERSION from
the outside, let's just move it out of environment-overridable CFLAGS
and into AM_CFLAGS instead.

This will inconvenience users that set their own VERSION a bit: The
Makefile sets -Werror and specifying -DVERSION twice will trigger it
because of the duplicate definition. This can be resolved by specifying
-UVERSION first. Given that the VERSION macro has only been there for a
month, this is deemed acceptable.

Fixes: 145c74ab6f2e ("mmc-utils: Change version string to git hash")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d8d59a4047fd..10b78ab5d7dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,8 @@
 CC ?= gcc
 GIT_VERSION := "$(shell git describe --abbrev=6 --always --tags)"
-AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2
-CFLAGS ?= -g -O2 -DVERSION=\"$(GIT_VERSION)\"
+AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2 \
+	    -DVERSION=\"$(GIT_VERSION)\"
+CFLAGS ?= -g -O2
 objects = \
 	mmc.o \
 	mmc_cmds.o \
-- 
2.39.2

