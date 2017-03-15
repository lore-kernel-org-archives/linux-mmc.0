From: "Tobin C. Harding" <me@tobin.cc>
Subject: [PATCH 0/2] mmc: core: null pointer dereference bug
Date: Wed, 15 Mar 2017 19:48:02 +1100
Message-ID: <1489567684-22763-1-git-send-email-me@tobin.cc>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36894 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752245AbdCOIsQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2017 04:48:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, Shawn Lin <shawn.lin@rock-chips.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Various functions take as parameter an optional pointer. Pointer
should be guarded with non-NULL check before dereferencing.

While fixing this bug it was found that the file contains multiple
functions doing variations on the same thing, sdio_readb(),
sdio_writeb(), sdio_readw(), sdio_writew() etc. Although the functions
have very similar logic the code is laid out in a variety of
ways. This makes it overly complicated to read. There is a already a
nice clean chunk of code, if we use this format for all instances then
we will have cleaned up the code, reduced the line count and lessened
the cognitive load required while reading.

Patch 01 adds non-NULL check before dereference of pointer.

Patch 02 cleans up the return code to be simple and uniform.

Code has not been tested. sdio_io.c with patches applied has been
checked with checkpatch, Sparse, and Smatch. Each patch has been
applied and built on x86_64 and PowerPC

Tobin C. Harding (2):
  mmc: core: guard dereference of optional parameter
  mmc: core: simplify return code

 drivers/mmc/core/sdio_io.c | 54 ++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

-- 
2.7.4

