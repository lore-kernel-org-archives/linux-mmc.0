From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.15-rc9
Date: Thu, 18 Jan 2018 08:59:41 +0100
Message-ID: <1516262381-9118-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33861 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753888AbeARH7p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jan 2018 02:59:45 -0500
Received: by mail-lf0-f67.google.com with SMTP id k19so5107914lfj.1
        for <linux-mmc@vger.kernel.org>; Wed, 17 Jan 2018 23:59:45 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Linus,

Here's a PR with one MMC fixes intended for v4.15-rc9. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 2bd7b4aacdb6efa5ccd4749c365c171b884791d2:

  mmc: s3mci: mark debug_regs[] as static (2018-01-04 12:42:31 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.15-rc2-3

for you to fetch changes up to 499ed50f603b4c9834197b2411ba3bd9aaa624d4:

  mmc: sdhci-esdhc-imx: Fix i.MX53 eSDHCv3 clock (2018-01-15 13:50:19 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-esdhc-imx: Fixup clock to make i.MX53 Loco (IMX53QSB) boot again

----------------------------------------------------------------
Benoît Thébaudeau (1):
      mmc: sdhci-esdhc-imx: Fix i.MX53 eSDHCv3 clock

 drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
