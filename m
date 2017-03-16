From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: core: null pointer dereference bug
Date: Thu, 16 Mar 2017 15:46:48 +0100
Message-ID: <CAPDyKFoJtspNN9RCLFjVrj0DHsm6HjhQTTsVEmWEyL+bqibdXw@mail.gmail.com>
References: <1489567684-22763-1-git-send-email-me@tobin.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33640 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754164AbdCPOqu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Mar 2017 10:46:50 -0400
Received: by mail-vk0-f43.google.com with SMTP id d188so25244976vka.0
        for <linux-mmc@vger.kernel.org>; Thu, 16 Mar 2017 07:46:49 -0700 (PDT)
In-Reply-To: <1489567684-22763-1-git-send-email-me@tobin.cc>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 15 March 2017 at 09:48, Tobin C. Harding <me@tobin.cc> wrote:
> Various functions take as parameter an optional pointer. Pointer
> should be guarded with non-NULL check before dereferencing.
>
> While fixing this bug it was found that the file contains multiple
> functions doing variations on the same thing, sdio_readb(),
> sdio_writeb(), sdio_readw(), sdio_writew() etc. Although the functions
> have very similar logic the code is laid out in a variety of
> ways. This makes it overly complicated to read. There is a already a
> nice clean chunk of code, if we use this format for all instances then
> we will have cleaned up the code, reduced the line count and lessened
> the cognitive load required while reading.
>
> Patch 01 adds non-NULL check before dereference of pointer.
>
> Patch 02 cleans up the return code to be simple and uniform.
>
> Code has not been tested. sdio_io.c with patches applied has been
> checked with checkpatch, Sparse, and Smatch. Each patch has been
> applied and built on x86_64 and PowerPC
>
> Tobin C. Harding (2):
>   mmc: core: guard dereference of optional parameter
>   mmc: core: simplify return code
>
>  drivers/mmc/core/sdio_io.c | 54 ++++++++++++++++++----------------------------
>  1 file changed, 21 insertions(+), 33 deletions(-)
>
> --
> 2.7.4
>

Thanks, applied for next!

Kind regards
Uffe
