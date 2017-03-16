From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v4] mmc: sdhci: clarify the get_timeout_clock callback
Date: Thu, 16 Mar 2017 17:46:05 +0900
Message-ID: <CAK7LNASF2nzSg=T5heRSOtkNNnxSNZX528_z3EuyN41pffgXJw@mail.gmail.com>
References: <1489627251-93539-1-git-send-email-shawn.lin@rock-chips.com> <a436006c-6bd2-0243-8cb0-38b07ff46abc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:59003 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbdCPIqZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Mar 2017 04:46:25 -0400
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com [209.85.161.180]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id v2G8k6HC013572
        for <linux-mmc@vger.kernel.org>; Thu, 16 Mar 2017 17:46:06 +0900
Received: by mail-yw0-f180.google.com with SMTP id v76so26943857ywg.0
        for <linux-mmc@vger.kernel.org>; Thu, 16 Mar 2017 01:46:06 -0700 (PDT)
In-Reply-To: <a436006c-6bd2-0243-8cb0-38b07ff46abc@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Anssi Hannula <anssi.hannula@bitwise.fi>

Hi Shawn,


>
>> users did that), it's more nature to return the value in Hz and we
>
> nature -> natural
>
>> make a explicit comment there. Then we put the unit conversion inside

While you are at it,

a explicit -> an explicit



>> the sdhci core. Thus will improve the code and prevent further misues.
>
> misues -> misuses
>
>>
>> [1]: https://patchwork.kernel.org/patch/9569431/
>
> + blank line
>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: Anssi Hannula <anssi.hannula@bitwise.fi>
>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>


When applied, my Cc can be dropped
because I had already given Acked-by.


-- 
Best Regards
Masahiro Yamada
