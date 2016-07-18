From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: fix free of uninitialized 'idata->buf'
Date: Mon, 18 Jul 2016 13:19:38 +0200
Message-ID: <CAPDyKFph2uiiC66Tw6xnTWOSSjzkUz-DOHYPXuBHJEtopw9Jtg@mail.gmail.com>
References: <1467991622-11036-1-git-send-email-ville@tuxera.com> <CAPDyKFpEPW-7FrpRceJACkg9uY3FcutPtCNnpxA8uQSE4arnuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35274 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbcGRLTl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2016 07:19:41 -0400
Received: by mail-wm0-f54.google.com with SMTP id f65so98797341wmi.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2016 04:19:40 -0700 (PDT)
In-Reply-To: <CAPDyKFpEPW-7FrpRceJACkg9uY3FcutPtCNnpxA8uQSE4arnuQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ville Viinikka <ville@tuxera.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>

On 12 July 2016 at 12:07, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> + stable
>
> On 8 July 2016 at 17:27, Ville Viinikka <ville@tuxera.com> wrote:
>> Set 'idata->buf' to NULL so that it never gets returned without
>> initialization. This fixes a bug where mmc_blk_ioctl_cmd() would
>> free both 'idata' and 'idata->buf' but 'idata->buf' was returned
>> uninitialized.
>>
>> Fixes: 1ff8950c0433 ("mmc: block: change to use kmalloc when copy data from userspace")
>> Signed-off-by: Ville Viinikka <ville@tuxera.com>
>
> I added a stable tag to this and applied it for next!

Moved this to fixes!

Kind regards
Uffe
