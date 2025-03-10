Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE64226533
	for <linux-mmc@vger.kernel.org>; Mon, 10 Mar 2025 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602156; cv=none; b=Unf0NOo1o72Rjf0jm9ik7zpW8bYDE2bfdSv+vso2hqOWJgReQS8ei7QEMxNDZBzeH6CefMbm+OY15Z9SiZPuLHevOYhbpYQask3ha7n5Mm68GgnhCHsMCXZi05PNQ0YOZo/MvskZbYWpp92uxJLjWP5/w0r31Ru9Y1upPt/k8Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602156; c=relaxed/simple;
	bh=uagfGTk0D0YpVt3HNGvyQPD6kpD8RodQo8BZSAuwS8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SVpjeKWu0Qqx1hEra7BIt0J9zDwJQ0O1Qa9GlxHZHT86a6YSkw3fdS4HN9uVHJ3h7brSD7I5djpCikMybTKh9L4st/Hq71nbSDurh1EFcDY6+Ba4Muob4yXpcDOKLq3yAXBP63Q1NhaFSjhOerE4m8B9AX1C/nETlmqEdo0AQ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1traHH-00027H-Sz; Mon, 10 Mar 2025 11:22:31 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1traHG-004yr5-2w;
	Mon, 10 Mar 2025 11:22:30 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1traHG-001bYN-2h;
	Mon, 10 Mar 2025 11:22:30 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Christian Loehle <christian.loehle@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <Avri.Altman@sandisk.com>
Subject: [PATCH v4 0/4] mmc: handle undervoltage events and prevent eMMC corruption
Date: Mon, 10 Mar 2025 11:22:25 +0100
Message-Id: <20250310102229.381887-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

changes v4:
- drop HPI and SDHCI related patches

This patch set introduces a framework for handling undervoltage events
in the MMC subsystem. The goal is to improve system reliability by
ensuring graceful handling of power fluctuations that could otherwise
lead to metadata corruption, potentially rendering the eMMC chip
unusable or causing significant data loss.

## Problem Statement

Power fluctuations and sudden losses can leave eMMC devices in an
undefined state, leading to severe consequences. The worst case can
result in metadata corruption, making the entire storage inaccessible.
While some eMMC devices promise to handle such situations internally,
experience shows that some chip variants are still affected. This has
led vendors to take a more protective approach, implementing external
undervoltage handling as a precautionary measure to avoid costly field
failures and returns.

The existence of the "Power Off Notification" feature in the eMMC
standard itself serves as indirect evidence that this is a real-world
issue.  While some projects have already faced the consequences of
ignoring this problem (often at significant cost), specific cases cannot
be disclosed due to NDAs.

## Challenges and Implementation Approach

1. **Raising awareness of the problem**: While vendors have used
   proprietary solutions for years, a unified approach is needed upstream.
   This patch set is a first step in making that happen.

2. **Finding an acceptable implementation path**: There are multiple
   ways to handle undervoltage - either in the kernel or in user space,
   through a global shutdown mechanism, or using the regulator framework.
   This patch set takes the kernel-based approach but does not prevent
   future extensions, such as allowing user-space handoff once available.

3. **Preparing for vendor adoption and testing**: By providing a
   structured solution upstream, this patch set lowers the barrier for
   vendors to standardize their undervoltage handling instead of relying on
   fragmented, out-of-tree implementations.

## Current Limitations

This patch set is an initial step and does not yet cover all possible
design restrictions or edge cases. Future improvements may include
better coordination with user space and enhancements based on broader
testing.

## Testing Details

The implementation was tested on an iMX8MP-based system. The board had
approximately 100ms of available power hold-up time. The Power Off
Notification was sent ~4ms after the board was detached from the power
supply, allowing sufficient time for the eMMC to handle the event
properly.  Tests were conducted under both idle conditions and active
read/write operations.

Oleksij Rempel (4):
  mmc: core: Handle undervoltage events and register regulator notifiers
  mmc: core: refactor _mmc_suspend() for undervoltage handling
  mmc: core: add undervoltage handler for MMC/eMMC devices
  mmc: block: abort requests and suppress errors after undervoltage
    shutdown

 drivers/mmc/core/block.c     |   2 +-
 drivers/mmc/core/core.c      |  30 +++++++++
 drivers/mmc/core/core.h      |   2 +
 drivers/mmc/core/mmc.c       | 127 +++++++++++++++++++++++++++++------
 drivers/mmc/core/queue.c     |   2 +-
 drivers/mmc/core/regulator.c | 124 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     |   8 +++
 7 files changed, 274 insertions(+), 21 deletions(-)

--
2.39.5

