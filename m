From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: sdhci broke in 4.14 [was: MMC fixes for v.4.14-rc4]
Date: Tue, 21 Nov 2017 16:13:22 +0100
Message-ID: <312d520e-9d80-4750-0ca2-df2a7c5be804@suse.cz>
References: <1507361610-31577-1-git-send-email-ulf.hansson@linaro.org>
 <2248b8b6-a80f-52ef-943f-54c1351d5a36@suse.cz>
 <CAPDyKFrzVaE=upRbJ+sq2rRcR1uitw2QEvTzt=pjtoNh1bij9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38075 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdKUPN0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Nov 2017 10:13:26 -0500
In-Reply-To: <CAPDyKFrzVaE=upRbJ+sq2rRcR1uitw2QEvTzt=pjtoNh1bij9Q@mail.gmail.com>
Content-Language: en-GB
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Rzeszutek Wilk <konrad@kernel.org>

On 11/21/2017, 04:08 PM, Ulf Hansson wrote:
> It seems like we need something along those lines for the sdhci-pci
> case as well. I cooked a patch, perhaps you have some time for test?

Sure, but before I start, I want to double check: don't you want me to
stick some pr_info in there to see if the computation is correct?

thanks,
-- 
js
suse labs
