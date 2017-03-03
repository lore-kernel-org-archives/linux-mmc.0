From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3] mmc: sdhci: clarify the get_timeout_clock callback
Date: Fri, 3 Mar 2017 23:31:00 +0900
Message-ID: <CAK7LNARqFe+M-4RZ+rUU+1p0_CfbhA9MmGV+p=WCzkAF0KV_CQ@mail.gmail.com>
References: <1488512252-8452-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from condef-01.nifty.com ([202.248.20.66]:29279 "EHLO
        condef-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbdCCOou (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Mar 2017 09:44:50 -0500
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-01.nifty.com with ESMTP id v23EW8hJ024148
        for <linux-mmc@vger.kernel.org>; Fri, 3 Mar 2017 23:32:08 +0900
Received: from mail-yw0-f179.google.com (mail-yw0-f179.google.com [209.85.161.179]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id v23EV1NQ029561
        for <linux-mmc@vger.kernel.org>; Fri, 3 Mar 2017 23:31:01 +0900
Received: by mail-yw0-f179.google.com with SMTP id p77so81111116ywg.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Mar 2017 06:31:01 -0800 (PST)
In-Reply-To: <1488512252-8452-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Anssi Hannula <anssi.hannula@bitwise.fi>

2017-03-03 12:37 GMT+09:00 Shawn Lin <shawn.lin@rock-chips.com>:
> Currently the get_timeout_clock callabck doesn't clearly
> have a statment that it needs the variant drivers to return
> the timeout clock rate in KHz if the SDHCI_TIMEOUT_CLK_UNIT
> isn't present, otherwise the variant drivers should return it
> in KHz. So actually sdhci-of-arasan return the wrong value found
> by Anssi[1]. It's also very likely that further variant drivers which
> are going to use this callback will be confused by this situation.
> Given the fact that modem sdhci variant hosts are very prone to get
> the timeout clock from common clock framework(actuall the only three
> users did that), it's more nature to return the value in Hz and we
> make a explicit comment there. Then we put the unit conversion inside
> the sdhci core. Thus will improve the code and prevent further misues.
>
> [1]: https://patchwork.kernel.org/patch/9569431/
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Anssi Hannula <anssi.hannula@bitwise.fi>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>


For sdhci-cadence.c bit,

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Thanks!




-- 
Best Regards
Masahiro Yamada
