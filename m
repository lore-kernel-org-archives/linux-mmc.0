From: Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
Subject: [PATCH 0/5] drivers; mmc: card:
Date: Mon,  2 Feb 2015 01:36:57 +0530
Message-ID: <1422821222-24079-1-git-send-email-sheetal.tigadoli@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:33852 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683AbbBAUI3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 1 Feb 2015 15:08:29 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net
Cc: joe@perches.com, linux-mmc@vger.kernel.org, ben@decadent.org.uk, kuninori.morimoto.gx@renesas.com, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org

The patches, fix some coding style err/warnings from file block.c

./scripts/checkpatch.pl  --file --terse drivers/mmc/card/block.c
drivers/mmc/card/block.c:45: WARNING: Use #include <linux/uaccess.h> instead of <asm/uaccess.h>
drivers/mmc/card/block.c:102: WARNING: line over 80 characters
drivers/mmc/card/block.c:186: WARNING: Missing a blank line after declarations
drivers/mmc/card/block.c:238: WARNING: line over 80 characters
drivers/mmc/card/block.c:251: WARNING: line over 80 characters
drivers/mmc/card/block.c:279: WARNING: simple_strtoul is obsolete, use kstrtoul instead
drivers/mmc/card/block.c:280: WARNING: Missing a blank line after declarations
drivers/mmc/card/block.c:578: WARNING: line over 80 characters
drivers/mmc/card/block.c:586: WARNING: line over 80 characters
drivers/mmc/card/block.c:620: WARNING: Missing a blank line after declarations
drivers/mmc/card/block.c:1209: WARNING: line over 80 characters
drivers/mmc/card/block.c:1333: WARNING: quoted string split across lines
drivers/mmc/card/block.c:1720: WARNING: Missing a blank line after declarations
drivers/mmc/card/block.c:1734: WARNING: braces {} are not necessary for single statement blocks
drivers/mmc/card/block.c:1881: WARNING: else is not generally useful after a break or return
drivers/mmc/card/block.c:2019: WARNING: braces {} are not necessary for single statement blocks
drivers/mmc/card/block.c:2226: WARNING: line over 80 characters
drivers/mmc/card/block.c:2285: WARNING: line over 80 characters
drivers/mmc/card/block.c:2362: ERROR: that open brace { should be on the previous line
    total: 1 errors, 18 warnings, 2587 lines checked

