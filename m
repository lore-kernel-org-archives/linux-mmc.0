Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E668AC433E9
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 09:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B101D65220
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 09:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCIJYU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 04:24:20 -0500
Received: from www.zeus03.de ([194.117.254.33]:40624 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229881AbhCIJYG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 9 Mar 2021 04:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=4hWmqDORYnmyweeEodNvD8l/IEx
        2Ud4wi8k1ewHaD60=; b=DeX9B/7zbi2FcwjOMBbLqVDos6YmfEBpnXFZfq9yHWF
        emRTjm4Z1/ljnS50K4T+hnzRGn/TMnc8xzojD7mZELLqpkDcA8/GY9Ij8YnyYD8G
        dOB/rtoG2bIsvFuPJmEiCBAKkqdX3ahmLEHqbafScelwgs3iIlUg+rN8/SoRZUF4
        =
Received: (qmail 3419210 invoked from network); 9 Mar 2021 10:23:40 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Mar 2021 10:23:40 +0100
X-UD-Smtp-Session: l3s3148p1@ACbyGhe9noogAwDPXw8WAIb6kxwVO+fo
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/2] mmc: renesas_sdhi: reset via reset controller
Date:   Tue,  9 Mar 2021 10:23:30 +0100
Message-Id: <20210309092332.30705-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series enables SDHI to be reset via a reset controller.

Please let me know about your (and BSP team's) thoughts.

Changes since RFC v2 (thanks Geert for the review!):

* use devm_reset_control_get_optional_exclusive()
* select RESET_CONTROLLER
* given reason in commit message of patch 2

Tested on a Salvator-XS with a Renesas R-Car M3-N.

Shimoda-san: I think we need to get this series upstream first. On top
of this, I will work on the better irq_mask handling.


Wolfram Sang (2):
  mmc: tmio: abort DMA before reset
  mmc: renesas_sdhi: do hard reset if possible

 drivers/mmc/host/Kconfig             |  1 +
 drivers/mmc/host/renesas_sdhi.h      |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 15 ++++++++++++++-
 drivers/mmc/host/tmio_mmc_core.c     |  4 ++--
 4 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.30.0

