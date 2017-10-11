From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: Fix the CTO timeout calculation
Date: Wed, 11 Oct 2017 16:55:31 -0700
Message-ID: <CAD=FV=VnFyC8Z5iD+HF7OVVAyNjOoAJZKj9SO7jaL8q+0h8qxg@mail.gmail.com>
References: <20170927205631.31559-1-dianders@chromium.org> <20170927205631.31559-3-dianders@chromium.org>
 <baeb929b-a712-0c69-2963-feb00c0165d9@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:50628 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbdJKXzd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Oct 2017 19:55:33 -0400
Received: by mail-vk0-f49.google.com with SMTP id q80so1849060vka.7
        for <linux-mmc@vger.kernel.org>; Wed, 11 Oct 2017 16:55:32 -0700 (PDT)
In-Reply-To: <baeb929b-a712-0c69-2963-feb00c0165d9@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Brian Norris <briannorris@chromium.org>, Alexandru M Stan <amstan@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Emil Renner Berthing <kernel@esmil.dk>

Hi,

On Mon, Oct 9, 2017 at 12:03 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hi
>
> On 2017/9/28 4:56, Douglas Anderson wrote:
>>
>> In the commit 03de19212ea3 ("mmc: dw_mmc: introduce timer for broken
>> command transfer over scheme") we tried to calculate the expected
>> hardware command timeout value.  Unfortunately that calculation isn't
>> quite correct in all cases.  It used "bus_hz" but, as far as I can
>> tell, it's supposed to use the card clock.  Let's account for the div
>> value, which is documented as 2x the value stored in the register, or
>> 1 if the register is 0.
>
>
> Good catch.
> Would you mind appending a new patch to fix the drto case?

I can add it to the series.  It'll be a separate patch, though, since
I wouldn't suggest backporting that one.  The DRTO timeout is so long
that it's really hard to hit it in this way so I think the argument is
much more academic there.  Still good to fix it, though.

-Doug
