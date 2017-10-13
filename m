From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: dw_mmc: busy check incomplete?
Date: Fri, 13 Oct 2017 14:01:53 +0200
Message-ID: <CAPDyKFrZj8a5RxK3M0jCEdHGDCet=MkWJUZmHOVZG5-ZuRac8w@mail.gmail.com>
References: <FD897F46D140444CAB8DC80B08F0742B0185ABC5E7@PFDE-MX11.EU.P-F.BIZ> <948b84f0-b9b3-696a-4e0d-da8a8e347960@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:56103 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753320AbdJMMBz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Oct 2017 08:01:55 -0400
Received: by mail-io0-f181.google.com with SMTP id p186so2559699ioe.12
        for <linux-mmc@vger.kernel.org>; Fri, 13 Oct 2017 05:01:54 -0700 (PDT)
In-Reply-To: <948b84f0-b9b3-696a-4e0d-da8a8e347960@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Goldschmidt Simon <sgoldschmidt@de.pepperl-fuchs.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 13 October 2017 at 12:00, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> + Ulf
>
> On 2017/10/12 20:27, Goldschmidt Simon wrote:
>>>
>>> On 2017/9/22 17:40, Shawn Lin wrote:
>>> Still think that should be part of mmc core's behaviour. I try to make
>>> sure the following ugly patch could work for you? And we could move
>>> forward later to see how to do it more gracefully.
>>
>>
>> Thanks for your response and sorry my answer comes with three weeks delay.
>> Unfortunately, I had other problems with the board in question up to now.
>>
>> I can confirm the patch works for me. On the oscilloscope shots, I can
>> clearly
>> see that the next request gets delayed when R1b tells the host the "card"
>> is busy.
>>
>
> Thanks for testing.
>
>> How can we move forward to a clean fix here?
>
>
> I think mmc core haven't considered this case that we issue a R1b
> command from usersapce and check the busy(or poll the CMD13 to get it
> right). I was thinking of adding some check for that case but I'm aslo
> now thinking could we reuse the functions from mmc_ops.c instead of
> directly sending this command to the host drivers. That we better reuse
> the checking logic of the existing code, for instance, mmc_switch.
>
> Ulf, do you have some comment here?

Well, only that I fully agree with you!

Not that long time ago we also did some re-factoring of that busy
detection code for mmc switch, so I definitely think that it should
possible to re-use that code (perhaps after yet some more
re-factoring).

[...]

Kind regards
Uffe
