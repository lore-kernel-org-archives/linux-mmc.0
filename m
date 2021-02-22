Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7242CC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Feb 2021 11:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 295DC64E77
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Feb 2021 11:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhBVLkr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Feb 2021 06:40:47 -0500
Received: from www.zeus03.de ([194.117.254.33]:48270 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhBVLkq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Feb 2021 06:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=NX4hEG3QsTUBLMhxk8k71hlf8Ui
        uQgfaPtEQ6WMt9bk=; b=xg+kvphvdJ6R9u3F0EeJiBIpnnCbpyO+FRd8sW7ggE5
        DimdjvQ3hdvWGRWHB5VITrjpscLzuJ0krMELChcy+/nBKMx+xHCeTSAxSIKC8yi+
        5BYO0BV7mmaLRrLTpL0jZH+hKL0N9Kjma5mEeziLtnbX7ai5XT7Oug+5gNU7FEfU
        =
Received: (qmail 2216157 invoked from network); 22 Feb 2021 12:40:04 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Feb 2021 12:40:04 +0100
X-UD-Smtp-Session: l3s3148p1@aylEQ+u7QsAgARa4RXmUARZp+YIgYjUK
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 0/2] mmc: renesas_sdhi: reset via reset controller
Date:   Mon, 22 Feb 2021 12:39:53 +0100
Message-Id: <20210222113955.7779-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series enables SDHI to be reset via a reset controller.

Please let me know about your (and BSP team's) thoughts.


Changes since (internal) RFC v1:

* moved from probe() to the reset() callback so we use it for every
  reset, not only when initializing
* patch 1 is new to make sure aborting DMA will work
* added a comment about (unexpected) polling for the reset status
* don't use atomic version for polling; reset is not a hot path

Wolfram Sang (2):
  mmc: tmio: abort DMA before reset
  mmc: renesas_sdhi: do hard reset if possible

 drivers/mmc/host/renesas_sdhi.h      |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 13 ++++++++++++-
 drivers/mmc/host/tmio_mmc_core.c     |  4 ++--
 3 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.30.0

