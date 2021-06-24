Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A288FC49EA5
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 15:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4D5613DA
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 15:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhFXPSv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Jun 2021 11:18:51 -0400
Received: from www.zeus03.de ([194.117.254.33]:46182 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232172AbhFXPSt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 24 Jun 2021 11:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=NZ22hsvgIaplgL3JYBVdxnYvL2k
        uO66xMNJhnRWDtm0=; b=H2VfdciAHxAX3khRcipZqY699xJyGqH9fhSICGbd+98
        aM0UyqacquKGVCdUhlu9ezibLPTQLxyKdVxjCmGAaAsTQsooFxkmiqs8423t1QHS
        4c98tG2GDNE95lajZelXdtf4qx5feEnlM1N4EqidYiXO6xhdRsu/6rkE+ToMtAZc
        =
Received: (qmail 3016614 invoked from network); 24 Jun 2021 17:16:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 24 Jun 2021 17:16:25 +0200
X-UD-Smtp-Session: l3s3148p1@QsI+gYTFUMkgARa4RWOqASgLlirhLBBp
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/3] mmc: avoid vicious circle when retuning
Date:   Thu, 24 Jun 2021 17:16:13 +0200
Message-Id: <20210624151616.38770-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

See patch 1 for a description of the problem. This series implements the
alternative approach suggested by Adrian (thanks!). It also adds some
documentation and a minor cleanup which I came up with while working on
the fix. Patch 1 can go to stable as is, the rest built on top of that.

This series fixes the performance issue which we saw when injecting CRC
errors on Renesas R-Car Gen3 hardware.

Looking forward to comments!


Wolfram Sang (3):
  mmc: core: clear flags before allowing to retune
  mmc: host: add kdoc for mmc_retune_{en|dis}able
  mmc: host: factor out clearing the retune state

 drivers/mmc/core/core.c |  6 ++++--
 drivers/mmc/core/host.c | 13 +++++++++++--
 drivers/mmc/core/host.h |  6 ++++++
 3 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.30.2

