From: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Subject: [RFC 0/4] sdhci: few patches for ENE 712 support
Date: Fri, 18 Mar 2011 15:11:56 -0700
Message-ID: <1300486320-23607-1-git-send-email-lrodriguez@atheros.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.atheros.com ([12.19.149.2]:44344 "EHLO mail.atheros.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932866Ab1CRWMH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Mar 2011 18:12:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, vmehta@atheros.com, naveen.singh@atheros.com, kvalo@adurom.com, j@w1.fi, "Luis R. Rodriguez" <lrodriguez@atheros.com>

I was pulled in to help with ath6kl development work. As part
of this I was given some PCI "ENE" SDHCI card which can I can slap
on to my desktop. I was then given this dump of patches to apply
to sdhci code to get it to work:

I prefer code upstream though so here is my split and cleanup
of these patches. I've tested it with my ENE card. Since I am
new to SDHCI I would prefer someone with more experience review
these chagnes and the respective commit log messages. I've
tried to make sense of them as best as I can. Unfortunately
I was not given any explanation to these changes except the
patch I got so I tried to make the best of it.

Luis R. Rodriguez (4):
  sdhci: allow for multiple delays when sending commands
  sdhci: sanity check for triggering interrupts thread
  sdhci: cache when the MMC bus width is 4 bits wide
  sdhci: add quick for controllers with for CIRQ issues

 drivers/mmc/host/sdhci-pci.c |    3 +-
 drivers/mmc/host/sdhci.c     |   46 +++++++++++++++++++++++++++++++++++------
 include/linux/mmc/sdhci.h    |    3 ++
 3 files changed, 44 insertions(+), 8 deletions(-)

-- 
1.7.4.15.g7811d

