From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH mmc-utils] mmc-utils: manpage: fix arguments for TH macro
Date: Mon, 22 Jan 2018 09:48:58 +0100
Message-ID: <20180122084858.6467-1-u.kleine-koenig@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:55664 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753350AbeAVI4t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jan 2018 03:56:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, Nobuhiro Iwamatsu <iwamatsu@debian.org>

According to man-pages(7) the TH macro takes the following parameters:

	.TH title section date source manual

with some recommendations for the individual parameters. Adapt the usage
of TH accordingly. The motivating change is to drop "man" in the title
in favor of "MMC".
---
Hello,

assuming that I cannot lure Chris into action with this patch given that
my previous patch series[1] already failed, I pushed this patch to my
repository on github[2] immediately.

Adding the Debian maintainer of mmc-utils to Cc:. @iwamatsu: Maybe you
know about Chris and his motivation to continue caring for mmc-utils
upstream? Do you feel like picking up patches while Chis is unavailable?

FTR: Debian also ships a patch[2] that might be worth to merge into
mmc-utils.

Best regards
Uwe

[1] https://www.spinics.net/lists/linux-mmc/msg47541.html
[2] https://github.com/ukleinek/mmc-utils
[3] https://sources.debian.org/src/mmc-utils/0+git20170901.37c86e60-1/debian/patches/fix_build_ppc64el.patch/

 man/mmc.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/mmc.1 b/man/mmc.1
index 971feae8d7f1..bdb6f09575ea 100644
--- a/man/mmc.1
+++ b/man/mmc.1
@@ -1,4 +1,4 @@
-.TH man 1 "16 November 2015" "0.1" "mmc-utils man page"
+.TH MMC 1 "2015-11-16" "0.1" "mmc-utils"
 .SH
 NAME
 mmc-utils \- Configure MMC storage devices from userspace.
-- 
2.15.1

