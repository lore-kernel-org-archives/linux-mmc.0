From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sd: Meet alignment requirements for raw_ssr DMA
Date: Tue, 20 Dec 2016 21:41:30 +0100
Message-ID: <CAPDyKFprZQ1pCQ+8bRXMi1ArD_VJAhBMGd9=hRRwegXf3PxmyQ@mail.gmail.com>
References: <20161111142236.8270-1-paul.burton@imgtec.com> <CAPDyKFqNNP-M37_ieq2na0agsQvh8oyv=nWdSsW2nQDw+zB9WA@mail.gmail.com>
 <3676563.EjIzX52DqA@np-p-burton> <CAPDyKFqehff8FZEcom3QzVy=Yu_H3Pd4Z0excgAsw=YgvcQo1Q@mail.gmail.com>
 <ebe3c261-a1f2-3188-7d36-a85916797bb3@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f172.google.com ([209.85.210.172]:32842 "EHLO
        mail-wj0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756027AbcLTUld (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2016 15:41:33 -0500
Received: by mail-wj0-f172.google.com with SMTP id xy5so185756465wjc.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Dec 2016 12:41:32 -0800 (PST)
In-Reply-To: <ebe3c261-a1f2-3188-7d36-a85916797bb3@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Paul Burton <paul.burton@imgtec.com>, linux-mmc <linux-mmc@vger.kernel.org>, Maarten ter Huurne <maarten@treewalker.org>

[...]

>>>>> +       raw_ssr =3D kmalloc(sizeof(card->raw_ssr), GFP_KERNEL);
>>>>> +       if (!raw_ssr)
>>>>> +               return -ENOMEM;
>>>>> +
>>
>> Creating this bounce buffer does of course comes with a small cost.
>> Maybe we could neglect its impact!?
>>
>> However we could also make the card->raw_ssr be cacheline aligned, via
>> using the __cacheline_aligned attribute for it.
>>
>> Also, this isn't the only case when the mmc core creates bounce
>> buffers while reading card registers during the card initialization.
>>
>> Perhaps a better method is to use the __cacheline_aligned for these
>> buffers that needs to be DMA-able (requests which is
>> MMC_DATA_READ|WRITE)). Of course that change would affect/increase the
>> number of bytes allocated for each card struct (due to padding), but
>> since this is just a single struct being allocated per card, this
>> shouldn't be an issue.
>>
>> What do you think?
>
> The issue is now in v4.9 and is causing problems on some platforms with t=
he
> reported card name becoming corrupted (since it cid.prodname is on the sa=
me
> cacheline).
>
> I'd say go with the simple solution for the fix, which is using the bounc=
e
> buffer. If somebody wants to rework this (and all the other bounce buffer=
s)
> to use __cacheline_aligned or something else that can be done as a separa=
te
> patch series on top of this.
>
> When you apply the patch can you add
>
> Fixes: 5275a652d296 ("mmc: sd: Export SD Status via =E2=80=9Cssr=E2=80=9D=
 device attribute")

Ahh, I didn't realize this was a fix for a regression. I thought it
was a long outstanding issue that more or less never occurred.

>
> and tag it for stable?

Yes, of course. I will deal with it as of tomorrow morning. Thanks for
pinging me on this!

Kind regards
Uffe
