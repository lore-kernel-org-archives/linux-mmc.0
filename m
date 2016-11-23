From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/7] mmc: core: Re-work CMD13 polling method for CMD6
 for mmc
Date: Wed, 23 Nov 2016 09:55:48 +0100
Message-ID: <CACRpkdY6Vzuav+Fz49WOjpygyinV58-ud8K+U3XhcOZGGqNFFw@mail.gmail.com>
References: <1479848173-20881-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:34629 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933699AbcKWIzt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2016 03:55:49 -0500
Received: by mail-qt0-f170.google.com with SMTP id n6so5349834qtd.1
        for <linux-mmc@vger.kernel.org>; Wed, 23 Nov 2016 00:55:49 -0800 (PST)
In-Reply-To: <1479848173-20881-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Tue, Nov 22, 2016 at 9:56 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Changes in v2:
>
>         - From discussions around the difficulties for how to support CMD13
>         polling for HS200, HS400 HS400ES, I decided to drop those patches for
>         now. It's is particularly due to the need for tuning, after a speed mode
>         switch, that makes it hard to rely on CMD13 polling for these cases.
>         Perhaps we can allow CMD13 polling when switching to the intermediate
>         speed modes, but let's deal with that outside of this series.

ALso v2 works like a charm on APQ8060 Dragonboard:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
