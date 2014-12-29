From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.3.19
Date: Mon, 29 Dec 2014 15:09:42 +0100
Message-ID: <CAPDyKFo_xWz0sVdcn6FGLW=0GC_L+8Dhe9MXcEnZetfwNSD7Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35873 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbaL2OJn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Dec 2014 09:09:43 -0500
Received: by mail-qg0-f45.google.com with SMTP id f51so9197791qge.4
        for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2014 06:09:42 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>

Hi Linus,

Here is one mmc fix for 3.19.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v3.19-2

for you to fetch changes up to 1c2d26e379fc8d37d55befd8589c4c252186ee58:

  mmc: core: stop trying to switch width when only one bit is
supported (2014-12-29 14:49:28 +0100)

----------------------------------------------------------------
MMC core:
 - Fix selection of buswidth for mmc hosts supporting 1-bit only.

----------------------------------------------------------------
Alexandre Belloni (1):
      mmc: core: stop trying to switch width when only one bit is supported

 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
