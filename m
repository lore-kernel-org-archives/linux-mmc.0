From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.0 rc4
Date: Thu, 19 Mar 2015 11:50:58 +0100
Message-ID: <CAPDyKFo_ZkD8Gb0a758RDBfoKQ+rtbqEvekE1FqcHgfQOSaGxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:33585 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbbCSKu6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Mar 2015 06:50:58 -0400
Received: by qcbjx9 with SMTP id jx9so23332541qcb.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2015 03:50:58 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>

Hi Linus,

Here is one mmc fix for v.4.0, based on rc4. Details are as usual
found in the signed tag.

Kind regards
Ulf Hansson


The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.0-rc4

for you to fetch changes up to 6b7a783ebd2181aa2e0e6f9f5509da8466e321e3:

  mmc: pwrseq_simple: fix error path in mmc_pwrseq_simple_alloc
(2015-03-19 11:26:35 +0100)

----------------------------------------------------------------
MMC core:
- Fix error path in mmc_pwrseq_simple_alloc()

----------------------------------------------------------------
NeilBrown (1):
      mmc: pwrseq_simple: fix error path in mmc_pwrseq_simple_alloc

 drivers/mmc/core/pwrseq_simple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
