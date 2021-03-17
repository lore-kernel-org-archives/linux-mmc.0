Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9175FC43381
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Mar 2021 09:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E1964F6E
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Mar 2021 09:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCQJQl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Mar 2021 05:16:41 -0400
Received: from www.zeus03.de ([194.117.254.33]:58776 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhCQJQ1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 Mar 2021 05:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=k1; bh=LKuEV/Ax3lbS6y5RDllq/dTqKBA
        ydTmnURThRcugPig=; b=Hjo91Qy944BZ4B3VrF6tTolMmu5RKfxFTscGqbbeHiZ
        Ivggpus7pTEqIH7wTCsGXcv9N6xVG0ZfYaEXV+KLI3Z7teW0z8iOeZfBzRYKvCAg
        f9OYZDJE+YvuD6qvTDjZpWwLc1Aj84nNyX/WWAZnYd7LvWhHgCOTL/GxqLMcNpUA
        =
Received: (qmail 2082568 invoked from network); 17 Mar 2021 10:16:25 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Mar 2021 10:16:25 +0100
X-UD-Smtp-Session: l3s3148p1@5YXo77e90JEgARa4RUHsAfjwOo+4/zku
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 0/3] mmc: renesas_sdhi: reset via reset controller
Date:   Wed, 17 Mar 2021 10:16:19 +0100
Message-Id: <20210317091622.31890-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series enables SDHI to be reset via a reset controller. The series
is based on mmc/next and tested on Salvator-XS with R-Car H3 ES2.0 with
what I think I can do locally here. Shimoda-san, tested, too (thanks!)

Changes since v2:
* 'select' statement in Kconfig only for ARCH_RENESAS
* Shimoda-san's tags added

Wolfram Sang (3):
  mmc: tmio: abort DMA before reset
  mmc: renesas_sdhi: break SCC reset into own function
  mmc: renesas_sdhi: do hard reset if possible

 drivers/mmc/host/Kconfig             |  1 +
 drivers/mmc/host/renesas_sdhi.h      |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 35 +++++++++++++++++++++-------
 drivers/mmc/host/tmio_mmc_core.c     |  4 ++--
 4 files changed, 32 insertions(+), 10 deletions(-)

-- 
2.30.0

