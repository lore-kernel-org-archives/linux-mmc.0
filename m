From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: host: omap_hsmmc: use generic_cmd6_time to
 program timeout value for CMD6
Date: Tue, 31 Jan 2017 11:50:34 +0100
Message-ID: <CAPDyKFpfDg9yejcaojv=9yvjFndJ00PmYNWuXOAZCw4cOevUFA@mail.gmail.com>
References: <1485771118-13748-1-git-send-email-rk@ti.com> <1485771118-13748-3-git-send-email-rk@ti.com>
 <CAPDyKFpW0fVpThS0EQhCh5kEiG96kNSGGhmnYnLKa_A06RBaFA@mail.gmail.com> <c412c9bf-fdf7-b8b9-8aab-7aa8c3d40002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38089 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdAaKug (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2017 05:50:36 -0500
Received: by mail-wm0-f44.google.com with SMTP id r141so73395592wmg.1
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 02:50:36 -0800 (PST)
In-Reply-To: <c412c9bf-fdf7-b8b9-8aab-7aa8c3d40002@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ravikumar <rk@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Andreas Fenkart <afenkart@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kishon <kishon@ti.com>

[...]

>>> +                       /*
>>> +                        * Set an arbitrary 100ms data timeout for
>>> commands with
>>> +                        * busy signal and no indication of busy_timeout.
>>> +                        */
>>> +                       if (!timeout)
>>
>> This is a bug in the mmc core if this ever happen.
>>
>> Therefore I am particularly interested to find out if this is really
>> needed or it's just playing safe?
>
> You could call it playing safe.
> We haven't hit any case where it was set to zero but per mmc_switch()
> description you are allowed to set it to zero to let the host decide what it
> wants to use.

I check the code in the core. Apparently there are some cases when
INAND_CMD38_ARG* is used, but also some cases where I think the
timeout value becomes picked from the EXT_CSD without validating its
value.

Let's keep $subject patch as is, then allow me to submit a few changes
for core to deal with this properly.

>
>>> +                               timeout = 100000000U;
>>> +
>>> +                       set_data_timeout(host, timeout, 0);
>>> +               }
>>>                  return 0;
>>>          }

Kind regards
Uffe
