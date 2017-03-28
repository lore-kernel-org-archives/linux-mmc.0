From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/3] The uncontroversial patches
Date: Tue, 28 Mar 2017 10:40:28 +0200
Message-ID: <20170328084031.11995-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36250 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754537AbdC1Il2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Mar 2017 04:41:28 -0400
Received: by mail-lf0-f47.google.com with SMTP id x137so33900092lff.3
        for <linux-mmc@vger.kernel.org>; Tue, 28 Mar 2017 01:40:41 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

These are the three patches from my "stop flushing the queue with NULL
and convert to MQ" patch series that are uncontroversial. I send them
separately so (hopefully) Ulf can apply them and shrink my patch stack
a bit.

Linus Walleij (3):
  mmc: core: move some code in mmc_start_areq()
  mmc: core: refactor asynchronous request finalization
  mmc: core: refactor mmc_request_done()

 drivers/mmc/core/core.c | 126 +++++++++++++++++++++---------------------------
 1 file changed, 54 insertions(+), 72 deletions(-)

-- 
2.9.3

