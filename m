From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] mmc: host: omap_hsmmc: miscellaneous fixes
Date: Tue, 31 Jan 2017 11:51:13 +0100
Message-ID: <CAPDyKFqxmpNNdZY8P6cY0GrJfmB3wmYCLH8Gu_r7eVOWVW-vjQ@mail.gmail.com>
References: <1485771118-13748-1-git-send-email-rk@ti.com> <CAPDyKFp2rda+DHS1CWRiXxdVNQVc=R3DjEaLmPhPzTzrjwsVpQ@mail.gmail.com>
 <757e7b0d-d8ec-8c95-041a-46578cf45cf5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33876 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbdAaKvP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2017 05:51:15 -0500
Received: by mail-wm0-f45.google.com with SMTP id 196so15251348wmm.1
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 02:51:15 -0800 (PST)
In-Reply-To: <757e7b0d-d8ec-8c95-041a-46578cf45cf5@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ravikumar <rk@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Andreas Fenkart <afenkart@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kishon <kishon@ti.com>

On 31 January 2017 at 11:34, Ravikumar <rk@ti.com> wrote:
>
>
> On Tuesday 31 January 2017 03:45 PM, Ulf Hansson wrote:
>>
>> On 30 January 2017 at 11:11, Ravikumar Kattekola <rk@ti.com> wrote:
>>>
>>> A few issues have been identified during mmc testing and following
>>> set of patches fixes a couple of them related to
>>> *timeout handling and ceb error handling*
>>>
>>> Tested on DRA75X PG 2.0 Rev H EVM
>>>
>>> Kishon Vijay Abraham I (1):
>>>    mmc: host: omap_hsmmc: use generic_cmd6_time to program timeout value
>>>      for CMD6
>>>
>>> Ravikumar Kattekola (2):
>>>    mmc: host: omap_hsmmc: reset cmd line on ceb error
>>>    mmc: host: omap_hsmmc: avoid possible overflow of timeout value
>>>
>>>   drivers/mmc/host/omap_hsmmc.c | 29 +++++++++++++++++++----------
>>>   1 file changed, 19 insertions(+), 10 deletions(-)
>>>
>>> --
>>> 1.9.1
>>>
>>
>> Assuming that you target 4.10 rcs for this and you want me to add a stable
>> tag?
>
> These are not critical fixes so can be queued for next , go to 4.11.

Thanks, applied for next!

Kind regards
Uffe
