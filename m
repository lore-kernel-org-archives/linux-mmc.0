From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Potentially invalid memory accesses in file drivers/mmc/core/block.c
Date: Mon, 7 Aug 2017 14:53:42 +0200
Message-ID: <CACRpkdYEbEbrtzH1=cyn7f+-c1yjj_kgBxn=NAVsz4A1dbVojQ@mail.gmail.com>
References: <003501d30289$89f86990$9de93cb0$@Domain> <CACRpkdZmenuHSes+o9NtuzYBtobrs7g6-X3=NG2ar1Zot2wFXw@mail.gmail.com>
 <000501d30c89$f964ebf0$ec2ec3d0$@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36721 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdHGMxo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2017 08:53:44 -0400
Received: by mail-io0-f169.google.com with SMTP id g35so2202536ioi.3
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2017 05:53:44 -0700 (PDT)
In-Reply-To: <000501d30c89$f964ebf0$ec2ec3d0$@cs.utah.edu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shaobo <shaobo@cs.utah.edu>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jens Axboe <axboe@fb.com>, Geert Uytterhoeven <geert@linux-m68k.org>

On Thu, Aug 3, 2017 at 8:54 PM, Shaobo <shaobo@cs.utah.edu> wrote:

> Thanks for your reply. While I appreciate your suggestions, I'm a little confused because honestly
> I don't know if I was pointing out a real issue since the bug occurs under certain conditions.

If you can reproduce the bug, try fixing it and see if it goes away?

If it goes away you are likely right so just include the description
with your patch.

I don't understand really.

Following the code flow as you have described it in verbatim text is too hard
as it requires us to take out the code and scrutinize it while reading your
mail.

It is much easier to read a patch, so please send a patch.

Yours,
Linus Walleij
