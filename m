From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: slow eMMC write speed
Date: Thu, 29 Sep 2011 09:33:30 +0200
Message-ID: <CACRpkdaDG+NvQNfe+TXT=yuLCo_L8u7mi--w3rrYmoZw0=gZAg@mail.gmail.com>
References: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com>
	<CACRpkdYamRVpBbhAcgn7rXBGcgHUp7+9PCrmOUkXV1BvZ+4pDw@mail.gmail.com>
	<CAHzg1A9H31hWdEKR5+_p8HuA_oq6o8EkESpJ22kQ4e4oFDH8GQ@mail.gmail.com>
	<4E837C89.9020109@linux.intel.com>
	<CAHzg1A8Cgz8DNje_We9MKJ90E4=9BDw9XzvEQU5h2et8HPHBjw@mail.gmail.com>
	<CACRpkdZh-9HTTs1BnH_ncT2S10gvuODXLSG-pOjsAdJOApmaMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33748 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab1I2Hdc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2011 03:33:32 -0400
Received: by yxl31 with SMTP id 31so350430yxl.19
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2011 00:33:31 -0700 (PDT)
In-Reply-To: <CACRpkdZh-9HTTs1BnH_ncT2S10gvuODXLSG-pOjsAdJOApmaMg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Praveen G K <praveen.gk@gmail.com>
Cc: J Freyensee <james_p_freyensee@linux.intel.com>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <jon.medhurst@linaro.org>

On Thu, Sep 29, 2011 at 9:05 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> Have you tried to make a deeper analysis of the card
> characteristics using Arnd Bergmanns "flashbench" tool?
> http://git.linaro.org/gitweb?p=people/arnd/flashbench.git;a=summary
>
> There you will see for sure if there are some problematic
> read boundaries on this specific card.

For comparison here are:

Condensed card survey:
https://wiki.linaro.org/WorkingGroups/Kernel/Projects/FlashCardSurvey

Tixys detailed benchmarks for some specific SD cards:
http://yxit.co.uk/public/flash-performance/doc/cards

Yours,
Linus Walleij
