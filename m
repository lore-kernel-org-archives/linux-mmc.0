From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.5 rc6
Date: Tue, 23 Feb 2016 21:27:22 +0100
Message-ID: <CAPDyKFo=3MKweao8N96mB--ufS1gu=i2gXvrvg7EQ8fCUf3mpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36608 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbcBWU1X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Feb 2016 15:27:23 -0500
Received: by mail-yw0-f176.google.com with SMTP id e63so156345409ywc.3
        for <linux-mmc@vger.kernel.org>; Tue, 23 Feb 2016 12:27:23 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Tony Lindgren <tony@atomide.com>

Hi Linus,

Here's an mmc fix intended for v4.5 rc6. It's based on v4.5 rc4.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 18558cae0272f8fd9647e69d3fec1565a7949865:

  Linux 4.5-rc4 (2016-02-14 13:05:20 -0800)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.5-rc4

for you to fetch changes up to 814a3c0c2a8dfad97089f6bdc71b374f6076490e:

  mmc: omap_hsmmc: Fix PM regression with deferred probe for
pm_runtime_reinit (2016-02-15 14:10:48 +0100)

----------------------------------------------------------------
MMC host:
 - omap_hsmmc: Fix PM regression for deferred probe

----------------------------------------------------------------
Tony Lindgren (1):
      mmc: omap_hsmmc: Fix PM regression with deferred probe for
pm_runtime_reinit

 drivers/mmc/host/omap_hsmmc.c | 2 ++
 1 file changed, 2 insertions(+)
