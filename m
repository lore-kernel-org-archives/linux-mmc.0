Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FD1C433E6
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 15:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4035A206FA
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 15:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Xyf7yP3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgIAPDA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:03:00 -0400
Received: from www.zeus03.de ([194.117.254.33]:44196 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728418AbgIAPC5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Sep 2020 11:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=DL6NFyOKpUaIvPMuHk7soZwzuQh
        V7fucyf3pAdXHfs0=; b=Xyf7yP3/xTJz3RAeTs9v1L5q+MoqqcNFmzFlm10+Qfo
        4KlSaRH/0lhfnswSv4qQA9q69wRL3lTV/eal4dizDOSub235UI538SwK4TA0YZbd
        jmzKp1xGADAdudtz5+3Ktdw8ASyFI9hCc63VYOLf67vsCagbbFQ74xr7+hd5Zqn0
        =
Received: (qmail 2554147 invoked from network); 1 Sep 2020 17:02:55 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Sep 2020 17:02:55 +0200
X-UD-Smtp-Session: l3s3148p1@PPNZ0EGuWowgAwDPXxBIAL7SzoTwUEK2
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 0/4] renesas_sdhi: fix hang when SCC loses its clock
Date:   Tue,  1 Sep 2020 17:02:46 +0200
Message-Id: <20200901150250.26236-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This again took a while since v1 because the issue was so hard to
trigger. But I finally found a way to inject the flaw, so this series
could be tested and it fixes the issue.

Changes since v1:
	* introduce a new flag to MMC core indicating any kind of tuning
	  not only retune
	* use the new flag to keep SCC flag active
	* new patch 4, minor cleanup to MMC core

A branch including the DEBUG patch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/new_manual_calib-for-5.10

If you revert patch 3, you should have the SCC hang during boot again.
For the record, let me copy some findings I mentioned in another thread:

===
Interesting news: The hang comes from a code path I would have not
expected. It is not because of accessing an SCC register, it is this
line from renesas_sdhi_set_clock() which causes the issue:

186         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);

I mean I can guess that the clock setting has something to do with the
SCC, but I can't see the direct connection with the documentation I
have.
===

Tested on R-Car H3 ES2.0 and M3-N and patches based on mmc/next.

Another hope this is gone for good now...

Kind regards,

   Wolfram


Wolfram Sang (4):
  mmc: core: when downgrading HS400, callback into drivers earlier
  mmc: core: add a 'doing_init_tune' flag and a 'mmc_doing_tune' helper
  mmc: renesas_sdhi: keep SCC clock active when tuning
  mmc: core: simplify an expression

 drivers/mmc/core/mmc.c               | 16 ++++++++++------
 drivers/mmc/host/renesas_sdhi_core.c |  8 ++++++--
 include/linux/mmc/host.h             |  6 ++++++
 3 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.20.1

