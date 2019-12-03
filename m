Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E55C43215
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 20:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713F82073F
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 20:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLCUFU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:05:20 -0500
Received: from sauhun.de ([88.99.104.3]:34318 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfLCUFT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 15:05:19 -0500
Received: from localhost (p54B33759.dip0.t-ipconnect.de [84.179.55.89])
        by pokefinder.org (Postfix) with ESMTPSA id 6C2B92C020F;
        Tue,  3 Dec 2019 21:05:17 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/5] mmc: renesas_sdhi: prepare for recent HS400 updates
Date:   Tue,  3 Dec 2019 21:05:08 +0100
Message-Id: <20191203200513.1758-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Due to recent datasheet updates and other internal documents, HS400
support for SDHI needs some refactoring. These patches are the
prerequisites for that. The first four patches only refactor code, the
last one does a minor update already.

This series has been tested on Renesas Salvator-XS with R-Car M3-N and
H3 ES2.0 with tests I was able to carry out locally here.

I will send more advanced patches on top of this series as RFC later.

A branch with all the patches applied can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/new_manual_calib

Wolfram Sang (5):
  mmc: renesas_sdhi: keep sorting for quirk entries
  mmc: renesas_sdhi: make warning more precise
  mmc: renesas_sdhi: make quirks info accessible outside probe()
  mmc: renesas_sdhi: remove 4taps as a TMIO flag
  mmc: renesas_sdhi: use recent tap values for HS400

 drivers/mmc/host/renesas_sdhi.h               | 10 ++++++--
 drivers/mmc/host/renesas_sdhi_core.c          | 23 ++++++++-----------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  2 +-
 include/linux/mfd/tmio.h                      |  3 ---
 4 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.20.1

