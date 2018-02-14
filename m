From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 03/11] mmc: kconfig: Remove blank help text
Date: Wed, 14 Feb 2018 11:11:56 +0100
Message-ID: <CAPDyKFr0sC9+3aEjyQECAKj_KLtUoubM8DTwz1ZFqLLXjJf2ag@mail.gmail.com>
References: <20180131093434.20050-1-ulfalizer@gmail.com> <20180131093434.20050-4-ulfalizer@gmail.com>
 <CAK7LNARZaB6c7BYOaP9aKU38npfOiHG7=6R0QGLAsTA8egd18g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:45216 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967050AbeBNKL5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Feb 2018 05:11:57 -0500
Received: by mail-io0-f193.google.com with SMTP id p188so24600842ioe.12
        for <linux-mmc@vger.kernel.org>; Wed, 14 Feb 2018 02:11:57 -0800 (PST)
In-Reply-To: <CAK7LNARZaB6c7BYOaP9aKU38npfOiHG7=6R0QGLAsTA8egd18g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>, Paul Bolle <pebolle@tiscali.nl>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Shawn Lin <shawn.lin@rock-chips.com>, Simon Horman <horms+renesas@verge.net.au>, Jan Glauber <jglauber@cavium.com>, Eric Anholt <eric@anholt.net>, Carlo Caione <carlo@endlessm.com>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Kishon Vijay Abraham I <kishon@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rui Feng <rui_feng@realsil.com.cn>

On 1 February 2018 at 18:09, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-01-31 18:34 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>> Blank help texts are probably either a typo, a Kconfig misunderstanding,
>> or some kind of half-committing to adding a help text (in which case a
>> TODO comment would be clearer, if the help text really can't be added
>> right away).
>>
>> Best to remove them, IMO.
>>
>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>> ---
>
>
> FYI.
>
> I picked up this patch to kbuild
> because I need this to suppress warning messages
> introduced by 11/11.

Okay. Feel free to add my ack.

[...]

Kind regards
Uffe
