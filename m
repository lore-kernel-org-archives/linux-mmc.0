From: Per Forlin <per.forlin@linaro.org>
Subject: [PATCH 0/2] mmc: clarifications on host.post_req()
Date: Mon, 29 Aug 2011 15:35:57 +0200
Message-ID: <1314624959-4634-1-git-send-email-per.forlin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33306 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655Ab1H2Ngh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2011 09:36:37 -0400
Received: by bke11 with SMTP id 11so4160433bke.19
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2011 06:36:36 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santo
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>

Fixes for 3.1.
This patchset doesn't fix any bugs in 3.1 but it improves the documentation
in order to prevent new bugs.

Per Forlin (2):
  mmc: core: clarify how to use post_req in case of errors
  mmc: mmci: simplify err check in mmci_post_request

 drivers/mmc/core/core.c  |    6 ++++++
 drivers/mmc/host/mmci.c  |    2 +-
 include/linux/mmc/host.h |    3 +++
 3 files changed, 10 insertions(+), 1 deletions(-)

-- 
1.7.4.1

