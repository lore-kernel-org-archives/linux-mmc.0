From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] patches to enable SDIO interrupt support for omap_hsmmc
 for v3.13
Date: Wed, 25 Sep 2013 16:47:32 -0700
Message-ID: <20130925234544.3745.55170.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26074 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab3IYXrg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Sep 2013 19:47:36 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi all,

Here are some patches to enable the SDIO interrupt support
for omap_hsmmc. Note that this series does not do the remux,
but relies on working io chain wake-up events. So omaps that
do require remuxing for wake-up events need more work, but
let's do this first.

Regards,

Tony

---

Tony Lindgren (2):
      mmc: omap_hsmmc: Fix context save and restore for DT
      mmc: omap_hsmmc: Enable SDIO interrupt


 drivers/mmc/host/omap_hsmmc.c |  116 +++++++++++++++++++++++++++--------------
 1 file changed, 75 insertions(+), 41 deletions(-)

-- 
Signature
