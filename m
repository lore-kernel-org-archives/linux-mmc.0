Return-Path: <SRS0=F8Hu=5Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F553C2BA1A
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Apr 2020 09:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084232082D
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Apr 2020 09:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgDHJqw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:46:52 -0400
Received: from sauhun.de ([88.99.104.3]:39634 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgDHJqw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 8 Apr 2020 05:46:52 -0400
Received: from localhost (p54B334FE.dip0.t-ipconnect.de [84.179.52.254])
        by pokefinder.org (Postfix) with ESMTPSA id E6CED2C1F39;
        Wed,  8 Apr 2020 11:46:49 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 0/3] mmc: renesas_sdhi: improve TAP selection if all TAPs are good
Date:   Wed,  8 Apr 2020 11:46:35 +0200
Message-Id: <20200408094638.10375-1-wsa+renesas@sang-engineering.com>
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
Saito. It is built on top of mmc/next. For convenience, a branch is
here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/new_manual_calib

It has been tested on Renesas Salvator-XS boards (R-Car M3-N and R-Car
H3 ES2.0). There were no regressions detected. HS400 could be tuned the
same way, and checksumming large files still works.

And while this series is useful by itself, it is also the last
prerequisite to implement some 'bad tap avoidance' on top which is what
we are originally aiming for.

Note about backporting: The super useful iterator
bitmap_for_each_set_region() is only available since v5.6. If you want
that before, you need to backport the needed bits of e837dfde15a4
("bitmap: genericize percpu bitmap region iterators"), too.

Thank you to Shimoda-san for his valuable input since the RFT version
of this patchset (see patch 1 for details)!

Kind regards,

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

