From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 0/3] sdhci-dove GPIO support for card detection
Date: Thu, 22 Nov 2012 23:54:26 +0000
Message-ID: <20121122235426.GT3332@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49183 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab2KVXz5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Nov 2012 18:55:57 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mike Rapoport <mike@compulab.co.il>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following three patches allow sdhci-dove to use a GPIO for card
presence detection.  This is a three stage process:

1. Clean up error paths by using devm_clk_get().
2. Use the two-stage sdhci initialization.
3. Implement the GPIO card detection support.

A very similar patch has been tested by Sebastian on the cubox; since
that version, I've changed the error printing slightly and dropped the
non-DT support for this feature as mainline doesn't have non-DT cubox
support.

 drivers/mmc/host/sdhci-dove.c |  108 +++++++++++++++++++++++++++++++++--------
 1 files changed, 88 insertions(+), 20 deletions(-)

