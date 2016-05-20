From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 3/5] mmc: core: implement enhanced strobe support
Date: Thu, 19 May 2016 19:19:55 -0700
Message-ID: <CAD=FV=VYsBO21iLZfQkXdFpPy5v-t+k6wP_jD3NZaCz=pEFVww@mail.gmail.com>
References: <1462871343-32361-1-git-send-email-shawn.lin@rock-chips.com>
 <1462871391-32484-1-git-send-email-shawn.lin@rock-chips.com>
 <CAD=FV=Xv-c2owh+dDT1EJYPrKsahxOoQUhJiZFprtk4FxHAK1A@mail.gmail.com> <573E6CD4.4010806@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36152 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbcETCT5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2016 22:19:57 -0400
Received: by mail-vk0-f50.google.com with SMTP id y2so56251313vka.3
        for <linux-mmc@vger.kernel.org>; Thu, 19 May 2016 19:19:57 -0700 (PDT)
In-Reply-To: <573E6CD4.4010806@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Shawn,

On Thu, May 19, 2016 at 6:48 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>>   #define EXT_CSD_BUS_WIDTH_1    0       /* Card is in 1 bit mode */
>>>   #define EXT_CSD_BUS_WIDTH_4    1       /* Card is in 4 bit mode */
>>>   #define EXT_CSD_BUS_WIDTH_8    2       /* Card is in 8 bit mode */
>>>   #define EXT_CSD_DDR_BUS_WIDTH_4        5       /* Card is in 4 bit DDR
>>> mode */
>>>   #define EXT_CSD_DDR_BUS_WIDTH_8        6       /* Card is in 8 bit DDR
>>> mode */
>>> +#define EXT_CSD_BUS_WIDTH_STROBE BIT(7)        /* Enhanced strobe mode
>>> */
>>
>>
>> nit: while your code should be OK, it seems better to be BIT(3), since
>> above is really:
>>
>
> I don't unstand here. EXT_CSD_BUS_WIDTH_STROBE is the MSB of
> BUS_WIDTH[183] which is a 8-bit reg.

I totally misunderstood.  You are correct.

-Doug
