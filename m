From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] mmc: core: Fixup Oops for SDIO shutdown
Date: Sun, 7 Jul 2013 10:55:12 -0700
Message-ID: <CAOesGMiFmzumD5rMx8k4Tf9R=vhJqmGopABYUO79-At9yftqRg@mail.gmail.com>
References: <1372762381-18832-1-git-send-email-ulf.hansson@linaro.org>
	<51D2EEA0.1050804@wwwdotorg.org>
	<CAOesGMiL-vY2O-WdiqcYOyNDvXz83PeDij+sijxrGTx-GLV+_w@mail.gmail.com>
	<868v1i1dvz.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:59112 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab3GGRzN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Jul 2013 13:55:13 -0400
Received: by mail-qc0-f178.google.com with SMTP id c11so1906574qcv.37
        for <linux-mmc@vger.kernel.org>; Sun, 07 Jul 2013 10:55:12 -0700 (PDT)
In-Reply-To: <868v1i1dvz.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Jaehoon Chung <jh80.chung@samsung.com>

On Sun, Jul 7, 2013 at 10:25 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Sun, Jul 07 2013, Olof Johansson wrote:
>> On Tue, Jul 2, 2013 at 8:15 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 07/02/2013 04:53 AM, Ulf Hansson wrote:
>>>> Commit "mmc: core: Handle card shutdown from mmc_bus" introduced an
>>>> Oops in the shutdown sequence for SDIO.
>>>>
>>>> The drv pointer, does not exist for SDIO since the probing of the SDIO
>>>> card from the mmc_bus perspective is expected to fail by returning
>>>> -ENODEV.
>>>>
>>>> This patch adds the proper check for the pointer before calling it.
>>>
>>> Tested-by: Stephen Warren <swarren@nvidia.com>
>>
>> Acked-by: Olof Johansson <olof@lixom.net>
>>
>> Chris, I hit this on the 0705 linux-next. Can you pick up this patch
>> soonish please? Thanks!
>
> Sorry for the delay -- I merged this on Friday, so it'll be in
> tonight's -next.

Great, thanks!


-Olof
