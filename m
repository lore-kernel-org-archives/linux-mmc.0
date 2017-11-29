From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/12 v5] Multiqueue for MMC/SD
Date: Wed, 29 Nov 2017 14:13:37 +0100
Message-ID: <CACRpkdY=C5F5t+pCtetpHwtmU-qHKMtuvKw4zowyOT=1aYJSmQ@mail.gmail.com>
References: <20171110100143.12256-1-linus.walleij@linaro.org>
 <CAPDyKFpaeRpqea6dy+3nxEtYwBTLUTYoRsYrRHrvfmNX_afxwg@mail.gmail.com>
 <CACRpkdZ-_1vFLLUcRTXWPYdDomP8Pen9wBwEMUGgr2cd_y3eBQ@mail.gmail.com> <6545b733-e28d-6a57-ae5b-293c1938b7c2@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:38694 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752480AbdK2NNi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Nov 2017 08:13:38 -0500
Received: by mail-it0-f68.google.com with SMTP id r6so4027288itr.3
        for <linux-mmc@vger.kernel.org>; Wed, 29 Nov 2017 05:13:37 -0800 (PST)
In-Reply-To: <6545b733-e28d-6a57-ae5b-293c1938b7c2@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>, Avri Altman <Avri.Altman@sandisk.com>

On Wed, Nov 15, 2017 at 2:50 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 14/11/17 23:17, Linus Walleij wrote:
>> We have the following risk factors:
>>
>> - Observed performance degradation of 1% (on x86 SDHI I guess)
>> - The kernel crashes if SD card is removed (both patch sets)
>
> I haven't been able to reproduce that.  Do you have more information?

I saw it in an earlier version of the patch set, but it might be due to
some confusion on my side.

I will try to get this series going and stress it a bit and see what happens.

Yours,
Linus Walleij
