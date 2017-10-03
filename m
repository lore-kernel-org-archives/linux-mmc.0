From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: block: Fix bug when removing RPMB chardev
Date: Tue, 3 Oct 2017 15:47:27 +0200
Message-ID: <CACRpkdbF-VL5nyriAv=P1kgXOMKqELjLqjCO+z6y8rdiZXgDAg@mail.gmail.com>
References: <20171002115918.11035-1-linus.walleij@linaro.org>
 <94d90383-c6de-910d-627e-f445f242f6f1@intel.com> <CACRpkdZ5=u3YtdgGFj1gk+4mSP36Cj2YD6z-nm7SEbM5cgkFWg@mail.gmail.com>
 <2d54cc9e-7c2c-20b8-9bc9-64f4c0605db7@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:56156 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdJCNr3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Oct 2017 09:47:29 -0400
Received: by mail-io0-f171.google.com with SMTP id z187so7646328ioz.12
        for <linux-mmc@vger.kernel.org>; Tue, 03 Oct 2017 06:47:28 -0700 (PDT)
In-Reply-To: <2d54cc9e-7c2c-20b8-9bc9-64f4c0605db7@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, Oct 3, 2017 at 1:07 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 03/10/17 13:00, Linus Walleij wrote:

>> Since I'm still supporting the old refcounting with md->usage
>> as described above, it should behave the same as the old
>> codebase, which might not be very good behaviour but atleast
>> it is not a regression.
>
> How do you know you are not dropping the last reference when you do
> md->usage-- ?

Ah dammit what was I thinking... OK converting to mmc_blk_get()
+mmc_blk_put() that should do it.

Sorry for silly mistakes. :/

Yours,
Linus Walleij
