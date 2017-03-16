From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v4] mmc: sdhci: clarify the get_timeout_clock callback
Date: Thu, 16 Mar 2017 16:54:46 +0800
Message-ID: <4fac26fb-3ab9-1983-251a-80a9ef0d6e06@rock-chips.com>
References: <1489627251-93539-1-git-send-email-shawn.lin@rock-chips.com>
 <a436006c-6bd2-0243-8cb0-38b07ff46abc@intel.com>
 <CAK7LNASF2nzSg=T5heRSOtkNNnxSNZX528_z3EuyN41pffgXJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:55636 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbdCPIzB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Mar 2017 04:55:01 -0400
In-Reply-To: <CAK7LNASF2nzSg=T5heRSOtkNNnxSNZX528_z3EuyN41pffgXJw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Anssi Hannula <anssi.hannula@bitwise.fi>

On 2017/3/16 16:46, Masahiro Yamada wrote:
> Hi Shawn,
>
>
>>
>>> users did that), it's more nature to return the value in Hz and we
>>
>> nature -> natural
>>
>>> make a explicit comment there. Then we put the unit conversion inside
>
> While you are at it,
>
> a explicit -> an explicit
>
>

Okay, thanks.

>
>>> the sdhci core. Thus will improve the code and prevent further misues.
>>
>> misues -> misuses
>>
>>>
>>> [1]: https://patchwork.kernel.org/patch/9569431/
>>
>> + blank line
>>
>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>> Cc: Anssi Hannula <anssi.hannula@bitwise.fi>
>>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>
>
> When applied, my Cc can be dropped
> because I had already given Acked-by.

will remove it. Thanks.

>
>


-- 
Best Regards
Shawn Lin

