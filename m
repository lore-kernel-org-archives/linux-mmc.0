From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 03/11] mmc: kconfig: Remove blank help text
Date: Fri, 2 Feb 2018 02:09:15 +0900
Message-ID: <CAK7LNARZaB6c7BYOaP9aKU38npfOiHG7=6R0QGLAsTA8egd18g@mail.gmail.com>
References: <20180131093434.20050-1-ulfalizer@gmail.com> <20180131093434.20050-4-ulfalizer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:34828 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752544AbeBARKO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Feb 2018 12:10:14 -0500
In-Reply-To: <20180131093434.20050-4-ulfalizer@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>, Paul Bolle <pebolle@tiscali.nl>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Shawn Lin <shawn.lin@rock-chips.com>, Simon Horman <horms+renesas@verge.net.au>, Jan Glauber <jglauber@cavium.com>, Eric Anholt <eric@anholt.net>, Carlo Caione <carlo@endlessm.com>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Kishon Vijay Abraham I <kishon@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rui Feng <rui_feng@realsil.com.cn>

2018-01-31 18:34 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> Blank help texts are probably either a typo, a Kconfig misunderstanding,
> or some kind of half-committing to adding a help text (in which case a
> TODO comment would be clearer, if the help text really can't be added
> right away).
>
> Best to remove them, IMO.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---


FYI.

I picked up this patch to kbuild
because I need this to suppress warning messages
introduced by 11/11.

I am planning to send a PR for this series next week.
