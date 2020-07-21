Return-Path: <SRS0=zOov=BA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3805C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 21:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3302072E
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 21:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595366630;
	bh=d91pGLQB2CXvVCmM9xXj6Dvn3IH9iEgDu/DKvgJpBFo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iOA356SsbhfIBnfhvOnUGDxGyoLIa1Da6uOLTmqk+X5sGAehgx0OPbDC9DQIf7fau
	 GvrhHgz4Z5GhZnKIbvsF3nFoV4jDpX1xBhu7Hy67bwIXA3nfHr+ZA5U0KY9X7PLllb
	 sqhqyd/hssfJegUMKu4kNbpMjtNnx/GyVwChmdj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgGUVXt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbgGUVXt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Jul 2020 17:23:49 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9D5A20717;
        Tue, 21 Jul 2020 21:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595366629;
        bh=d91pGLQB2CXvVCmM9xXj6Dvn3IH9iEgDu/DKvgJpBFo=;
        h=From:To:Cc:Subject:Date:From;
        b=gU7VcWswDJWCFO/BstoE0v0SsBBgsPXGW5TuTJYa05QbTT1YJul2qIbgwrJC2NBa7
         GKyHuL8ld516La4SR2fSJ3OoxLIN9Dz8RNPrji92JCssxfqP9izFcoZdOdn6Lhgdp9
         SVURcFK9+Nmg5SrHmuEIEceQbt7vxVmS4AiUKbnE=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ricky Wu <ricky_wu@realtek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rui Feng <rui_feng@realsil.com.cn>, Klaus Doth <kdlnx@doth.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/5] minor rtsx cleanups
Date:   Tue, 21 Jul 2020 16:23:31 -0500
Message-Id: <20200721212336.1159079-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Clean up some needlessly device-specific stuff in the Realtek card reader
drivers.

This implements some of my suggestions from
https://lore.kernel.org/r/20200720220651.GA1035857@bjorn-Precision-5520

This will conflict with Ricky's post here:
https://lore.kernel.org/r/20200706070259.32565-1-ricky_wu@realtek.com

I'll be happy to update this on top of Ricky's patch after it's applied, or
Ricky could pick up these patches and base his on top.

Bjorn Helgaas (5):
  misc: rtsx: Use pcie_capability_clear_and_set_word() for
    PCI_EXP_LNKCTL
  misc: rtsx: Remove unused pcie_cap
  misc: rtsx: Remove rtsx_pci_read/write_config() wrappers
  misc: rtsx: Find L1 PM Substates capability instead of hard-coding
  misc: rtsx: Use standard PCI definitions

 drivers/misc/cardreader/rtl8411.c  |  8 +++++---
 drivers/misc/cardreader/rts5209.c  |  5 +++--
 drivers/misc/cardreader/rts5227.c  |  5 +++--
 drivers/misc/cardreader/rts5229.c  |  5 +++--
 drivers/misc/cardreader/rts5249.c  | 28 ++++++++++++++------------
 drivers/misc/cardreader/rts5260.c  | 23 +++++++++++++--------
 drivers/misc/cardreader/rts5261.c  | 32 +++++++++++++++++++-----------
 drivers/misc/cardreader/rtsx_pcr.c |  7 ++++---
 include/linux/rtsx_pci.h           | 22 --------------------
 9 files changed, 68 insertions(+), 67 deletions(-)

-- 
2.25.1

