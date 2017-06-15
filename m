From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: block: Move duplicate check
Date: Thu, 15 Jun 2017 13:53:30 +0200
Message-ID: <CACRpkdYLyRf_1Z1AMxWm6+SFpX0O6D+Qu4+ENvZQ84nOaXpk9Q@mail.gmail.com>
References: <20170614114851.17146-1-linus.walleij@linaro.org> <e31ca826-8391-55b0-4a9b-f5ff0b0c5882@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:35910 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbdFOLxc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jun 2017 07:53:32 -0400
Received: by mail-it0-f45.google.com with SMTP id m47so16856214iti.1
        for <linux-mmc@vger.kernel.org>; Thu, 15 Jun 2017 04:53:32 -0700 (PDT)
In-Reply-To: <e31ca826-8391-55b0-4a9b-f5ff0b0c5882@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Jun 14, 2017 at 2:22 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hi Linus,
>
> On 2017/6/14 19:48, Linus Walleij wrote:
>>
>> mmc_blk_ioctl() calls either mmc_blk_ioctl_cmd() or
>> mmc_blk_ioctl_multi_cmd() and each of these make the same
>> check. Factor it into the first call and save one chunk
>> of duplicate code.
>>
>
> Probably you still cannot save the check like what this patch
> does. Refer to commit,
>
> 83c742c344c08 ("mmc: block: fix ABI regression of mmc_blk_ioctl")

AHa I see what's happening. I guess I have to make a small
helper function to check it and inline that instead.

Yours,
Linus Walleij
