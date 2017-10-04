From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: block: Fix bug when removing RPMB chardev
Date: Wed, 4 Oct 2017 08:14:51 +0200
Message-ID: <CACRpkdaG_HuzHqDrz8JsifY5EOg7qibCRxZiVyoa=gvVDuRBvg@mail.gmail.com>
References: <20171002115918.11035-1-linus.walleij@linaro.org>
 <94d90383-c6de-910d-627e-f445f242f6f1@intel.com> <CACRpkdZ5=u3YtdgGFj1gk+4mSP36Cj2YD6z-nm7SEbM5cgkFWg@mail.gmail.com>
 <2d54cc9e-7c2c-20b8-9bc9-64f4c0605db7@intel.com> <CACRpkdbF-VL5nyriAv=P1kgXOMKqELjLqjCO+z6y8rdiZXgDAg@mail.gmail.com>
 <DM5PR04MB108533F77C559DB949093B32FC720@DM5PR04MB1085.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:54059 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdJDGOw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Oct 2017 02:14:52 -0400
Received: by mail-io0-f177.google.com with SMTP id q11so9599156ioe.10
        for <linux-mmc@vger.kernel.org>; Tue, 03 Oct 2017 23:14:52 -0700 (PDT)
In-Reply-To: <DM5PR04MB108533F77C559DB949093B32FC720@DM5PR04MB1085.namprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, Oct 3, 2017 at 11:57 PM, Avri Altman <Avri.Altman@wdc.com> wrote:

> Multiple simultaneous accesses is forbidden.
> So maybe direct recounting is better for controlling it?

That is already handled by patches:

commit 614f0388f580c436d2cf6dc0855de91d13ddc23d
"mmc: block: move single ioctl() commands to block requests"
commit 3ecd8cf23f88d5df1c545a5c04217987abb28575
"mmc: block: move multi-ioctl() to use block layer"

Since all ioctl()s are not sent in through the block queue
they get serialized by the very nature of how block requests
work, i.e. one at a time. I have even tried to send RPMB
commands from two consoles while a huge dd work was already
working in the background. No problems with that.

Yours,
Linus Walleij
