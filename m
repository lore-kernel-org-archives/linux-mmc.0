Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9991C7619A
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Apr 2023 15:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjDLPE6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Apr 2023 11:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjDLPEx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Apr 2023 11:04:53 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C246759FF
        for <linux-mmc@vger.kernel.org>; Wed, 12 Apr 2023 08:04:46 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 9E4DE3A2A49
        for <linux-mmc@vger.kernel.org>; Wed, 12 Apr 2023 17:04:44 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 93A143A29DF
        for <linux-mmc@vger.kernel.org>; Wed, 12 Apr 2023 17:04:44 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail5.swissbit.com (Postfix) with ESMTPS
        for <linux-mmc@vger.kernel.org>; Wed, 12 Apr 2023 17:04:44 +0200 (CEST)
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] mmc-utils: Change version string to git hash
Thread-Topic: [PATCH] mmc-utils: Change version string to git hash
Thread-Index: AdltUARvBiL2VeGFT72atndJjK3WqA==
Date:   Wed, 12 Apr 2023 15:04:42 +0000
Message-ID: <28623fa7390242e9b003a44016c0235f@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27562.000
X-TMASE-Result: 10--3.221500-10.000000
X-TMASE-MatchedRID: xRVQIH6ETKCYeahZNqaGC6k29rFswht+K1zvw58EecuAI7Mvq/sL59vS
        BpmBATJqjx5X3FdI4UDmn3xyPJAJoh2P280ZiGmRnXdphQTSK/JIvK4LrXs1aXhPzhoND77Mo8W
        MkQWv6iUijR+AXJl/FY2j49Ftap9EOwBXM346/+z6ln6r9ohFMad6GkDgEUDmmB1zWnhauRRS8r
        Pmbk7Uzs8AUIAOPTsj
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: ba64ca2d-05fb-4d49-92de-05a29b3ecc75-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since mmc-utils versioning has always been 0.1 and changes are not
made frequently and formal releases do not happen, packaged versions
are just pulled from git anyway, using the git hash for version is
probably the best idea for now.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 Makefile | 3 ++-
 mmc.c    | 6 ++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index aa27ff2..d8d59a4 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,7 @@
 CC ?= gcc
+GIT_VERSION := "$(shell git describe --abbrev=6 --always --tags)"
 AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2
-CFLAGS ?= -g -O2
+CFLAGS ?= -g -O2 -DVERSION=\"$(GIT_VERSION)\"
 objects = \
 	mmc.o \
 	mmc_cmds.o \
diff --git a/mmc.c b/mmc.c
index b9aa478..795b4e3 100644
--- a/mmc.c
+++ b/mmc.c
@@ -26,8 +26,6 @@
 
 #include "mmc_cmds.h"
 
-#define MMC_VERSION	"0.1"
-
 #define BASIC_HELP 0
 #define ADVANCED_HELP 1
 
@@ -319,7 +317,7 @@ static void help(char *np)
 
 	printf("\n\t%s help|--help|-h\n\t\tShow the help.\n",np);
 	printf("\n\t%s <cmd> --help\n\t\tShow detailed help for a command or subset of commands.\n",np);
-	printf("\n%s\n", MMC_VERSION);
+	printf("\n%s\n", VERSION);
 }
 
 static int split_command(char *cmd, char ***commands)
@@ -500,7 +498,7 @@ static int parse_args(int argc, char **argv,
 	}
 
 	if(helprequested){
-		printf("\n%s\n", MMC_VERSION);
+		printf("\n%s\n", VERSION);
 		return 0;
 	}
 
-- 
2.37.3


Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

