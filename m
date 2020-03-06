Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D17C10F26
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 09:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92062070A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 09:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgCFJcI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:32:08 -0500
Received: from sauhun.de ([88.99.104.3]:55980 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgCFJcI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 04:32:08 -0500
Received: from localhost (p54B33158.dip0.t-ipconnect.de [84.179.49.88])
        by pokefinder.org (Postfix) with ESMTPSA id 597F82C1F2C;
        Fri,  6 Mar 2020 10:32:05 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RFT 0/3] mmc: renesas_sdhi: improve TAP selection if all TAPs are good
Date:   Fri,  6 Mar 2020 10:31:56 +0100
Message-Id: <20200306093159.6155-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SDHI (with SCC) has a mechanism to select an optimal TAP even if all
were considered good during the tuning process. This series implements
support for it. Before that, some refactoring of 'best TAP selection' is
done to avoid code duplication and get more understandable code.

This work is based on BSP patches by Masaharu Hayakawa and Takeshi
Saito. It is built on top of mmc/next with two more patches added which
will be applied separately:

"mmc: renesas_sdhi: simplify execute_tuning"
"mmc: renesas_sdhi: Use BITS_PER_LONG helper"

For convenience, a branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/new_manual_calib

It has been tested on a Renesas Salvator-XS board (R-Car M3-N). There
were no regressions detected. HS400 could be tuned the same way, and
checksumming large files still works. Note that I couldn't test the 'all
TAPs are good' case without hacking the code. So, maybe the BSP team has
a setup where this happens without tweaking? This is why the series is
marked as 'RFT' still.

And while this series is useful by itself, it is also the last
prerequisite to implement some 'bad tap avoidance' on top which is what
we are originally aiming for.

Note about backporting: The super useful iterator
bitmap_for_each_set_region() is only available since v5.6. If you want
that before, you need to backport the needed bits of e837dfde15a4
("bitmap: genericize percpu bitmap region iterators"), too.

Looking forward to comments,

   Wolfram


Wolfram Sang (3):
  mmc: renesas_sdhi: refactor calculation of best TAP
  mmc: renesas_sdhi: clarify handling of selecting TAPs
  mmc: renesas_sdhi: improve TAP selection if all TAPs are good

 drivers/mmc/host/renesas_sdhi.h      |  2 +
 drivers/mmc/host/renesas_sdhi_core.c | 64 ++++++++++++++--------------
 2 files changed, 34 insertions(+), 32 deletions(-)

-- 
2.20.1

