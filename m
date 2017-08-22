From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: cast a error log for unbalanced
 mmc_blk_{open, release}
Date: Tue, 22 Aug 2017 12:14:47 +0200
Message-ID: <CAPDyKFoyxTm2wjbrzNgAy=3jE1enn3ecQnqVvZd1LA682eJOKg@mail.gmail.com>
References: <1501815102-19376-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFqoa9ec=CsW5dp30691QeGxNQeNb6RdCOcSFup78BpTaA@mail.gmail.com> <a813d678-5875-1de9-0ecd-bdcb531906f1@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33301 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932414AbdHVKOs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 06:14:48 -0400
Received: by mail-qk0-f169.google.com with SMTP id a77so94825254qkb.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 03:14:48 -0700 (PDT)
In-Reply-To: <a813d678-5875-1de9-0ecd-bdcb531906f1@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

[...]

>
>>> +               if (mmc_card_is_removable(card->host) && devidx ==
>>> -ENOSPC)
>>
>>
>> Why not print this error for all type of cards, it seems like relevant
>> information for the user.
>
>
> Only if we support booting rootfs from other media and that could
> allow modular mmc-blk for non-removable devices. But then static
> mmc_blk_ida would be freed anyway. So it won't face this situation?

Well, I wasn't thinking about the behavior of userspace. Instead, the
information would be printed if the device had more partitions than
what we support...

>
>>
>>> +                       dev_err(mmc_dev(card->host),
>>> +                               "possible unblanced mount/umount
>>> detected\n");

..perhaps then also change this to "no more device IDs available".

>>> +
>>>                  return ERR_PTR(devidx);
>>> +       }
>>>
>>>          md = kzalloc(sizeof(struct mmc_blk_data), GFP_KERNEL);
>>>          if (!md) {
>>> --

Kind regards
Uffe
