Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFA6C64E7B
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 21:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE72C2075A
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 21:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="SeKPG/OD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbgKYVaR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Nov 2020 16:30:17 -0500
Received: from www.zeus03.de ([194.117.254.33]:50258 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732179AbgKYVaQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 25 Nov 2020 16:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=2VwnJyg0q5/oU+QkI2NPQZ3Nvs4
        +Yi6IBsEPEV9djNw=; b=SeKPG/ODCO0HaGKwZWNHUyxf91azCxH6MAqtp22SH9P
        9LoBzsjYzQSrSHvEQq0ydOgIHTTBEhDEAgUIYFB/a2+31UCjoczNGxVNK/Rv0kpg
        MjC8qgtV+wp3l8yRwhnz6q1x7jj4wdNUIjckafszRs+0qa1Ni440jY/WuoUmvaD8
        =
Received: (qmail 3441441 invoked from network); 25 Nov 2020 22:30:14 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Nov 2020 22:30:14 +0100
X-UD-Smtp-Session: l3s3148p1@I3ySIfW0jL8gAwDPXwZjAA625bO7DiyS
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/3] tmio: set max_busy_timeout
Date:   Wed, 25 Nov 2020 22:29:58 +0100
Message-Id: <20201125213001.15003-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a follow-up to the series "mmc: tmio: honor busy timeouts
properly" which I sent out a few days ago. One of the patches there
needs more discussion, so I regrouped the series with another one, and
this is the first outcome. It is solely about max_busy_timeout:

Patch 1 is from the previous series (with the comment from Shimoda-san
addressed) and sets max_busy_timeout with what TMIO always did. Patch 2
introduces a hook and a default fallback for extended timeout ranges.
Patch 3 uses the hook for the extended range of R-Car Gen3 SDHIs.

It has been tested that the applied values make sense. I have not
measured if the MMC core really sends R1 instead of R1B when the desired
timeout value is exceeded. All on a Salvator-XS with R-Car M3N.

The patches are based on mmc/next as of today. The branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/extop

Looking forward to comments!

Happy hacking,

   Wolfram


Wolfram Sang (3):
  mmc: tmio: set max_busy_timeout
  mmc: tmio: add hook for custom busy_wait calculation
  mmc: renesas_sdhi: populate hook for longer busy_wait

 drivers/mmc/host/renesas_sdhi_core.c | 23 +++++++++++++++++++++++
 drivers/mmc/host/tmio_mmc.h          |  5 +++++
 drivers/mmc/host/tmio_mmc_core.c     | 22 ++++++++++++++++++++++
 drivers/mmc/host/uniphier-sd.c       |  1 +
 include/linux/mfd/tmio.h             |  7 ++++++-
 5 files changed, 57 insertions(+), 1 deletion(-)

-- 
2.28.0

