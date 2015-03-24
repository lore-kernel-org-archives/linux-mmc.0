From: NeilBrown <neil@brown.name>
Subject: [PATCH/RFC 0/4] Use runtime-pm to switch sdio to 1-bit when idle
Date: Wed, 25 Mar 2015 07:56:10 +1100
Message-ID: <20150324205316.20572.30538.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55406 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897AbbCXVIX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 Mar 2015 17:08:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

This is a proof-of-concept hack to demonstrate what I was
trying to describe earlier.
The last patch, in particular, takes some very ugly short-cuts
which I would never dream of proposing for upstream inclusion.

It seems to work, but I haven't tested thoroughly.  I may not even be
doing what I think it is doing...

Comments?

Thanks,
NeilBrown
---

NeilBrown (4):
      mmc: core: fold mmc_set_bus_width calls into sdio_enable_4bit_bus.
      mmc/core: add pm_runtime tracking to mmc_host devices.
      mmc/sdio: keep device awake when interrupts expected in 4bit mode
      mmc/host: use runtime_pm to switch to 1-bit mode


 drivers/mmc/core/core.c |    5 +++
 drivers/mmc/core/host.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/sdio.c |   41 +++++++++++--------------
 3 files changed, 100 insertions(+), 24 deletions(-)

--
Signature

