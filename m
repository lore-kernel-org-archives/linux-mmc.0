From: Laszlo Fiat <laszlo.fiat@gmail.com>
Subject: BayTrail-T SDIO PM issue
Date: Wed, 27 Jul 2016 19:57:27 +0200
Message-ID: <CA+7w51jySmwSnMaVr_7vVsAzD0d11QY7+GaVWjd88adoe4DO6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32888 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979AbcG0R5a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 13:57:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so7580544wme.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 10:57:29 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hello,

Historically we had to add some out-of-tree mmc patches [1] for
BayTrail-T to run stable.
This was reduced to only 1 patch [2] by linux v4.6.4 thanks to the
work of Adrian and Ulf.
Without patch [2] we get: irq 187: nobody cared [3] and instability.

However patch [2] cannot be applied to v4.7 any more, as patch [4]
removed the base of it.
I can partly revert patch [4] and reapply patch [2] on linux v4.7 to
achieve stability, but it would be nice to have a proper solution for
this, and get rid of out-of-tree patches once and for all.

I can help with testing.

Thank you.

Bye,

Laszlo Fiat


[1]: https://github.com/hadess/rtl8723bs/tree/master/patches
[2]: https://github.com/hadess/rtl8723bs/blob/master/patches/0001-mmc-sdhci-get-runtime-pm-when-sdio-irq-is-enabled.patch
[3]: https://github.com/hadess/rtl8723bs/issues/76#issuecomment-226897659
[4]: https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=15e82076a0edbebedbe12652b4ad8f1d93bcb7fe
