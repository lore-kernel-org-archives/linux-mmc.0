From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: sdhci broke in 4.14 [was: MMC fixes for v.4.14-rc4]
Date: Tue, 21 Nov 2017 17:13:13 +0100
Message-ID: <CAPDyKFrBAKUjnN372vr6sOMRpi1RJbevtmgz75zfuOnes0kKQw@mail.gmail.com>
References: <1507361610-31577-1-git-send-email-ulf.hansson@linaro.org>
 <2248b8b6-a80f-52ef-943f-54c1351d5a36@suse.cz> <CAPDyKFrzVaE=upRbJ+sq2rRcR1uitw2QEvTzt=pjtoNh1bij9Q@mail.gmail.com>
 <312d520e-9d80-4750-0ca2-df2a7c5be804@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:37401 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbdKUQNO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Nov 2017 11:13:14 -0500
Received: by mail-io0-f173.google.com with SMTP id v21so20034381ioi.4
        for <linux-mmc@vger.kernel.org>; Tue, 21 Nov 2017 08:13:14 -0800 (PST)
In-Reply-To: <312d520e-9d80-4750-0ca2-df2a7c5be804@suse.cz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Linus <torvalds@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Rzeszutek Wilk <konrad@kernel.org>

On 21 November 2017 at 16:13, Jiri Slaby <jslaby@suse.cz> wrote:
> On 11/21/2017, 04:08 PM, Ulf Hansson wrote:
>> It seems like we need something along those lines for the sdhci-pci
>> case as well. I cooked a patch, perhaps you have some time for test?
>
> Sure, but before I start, I want to double check: don't you want me to
> stick some pr_info in there to see if the computation is correct?

Yeah, that seems like a good idea. :-)

Br
Uffe
