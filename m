From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] RFT: mmc: block: restore NULL check when retrying
Date: Wed, 1 Feb 2017 13:11:52 +0100
Message-ID: <CAPDyKFoK+fKU3HH9-1krmQJjJhZmx1gst41c4uGO+dbc6aaJnQ@mail.gmail.com>
References: <20170130132625.18296-1-linus.walleij@linaro.org> <CAPDyKFpm5AxsnbX-UMGLntB4Z1KK2TzCcCmWFJqYwku-JkOwzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37978 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdBAMLy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 07:11:54 -0500
Received: by mail-wm0-f50.google.com with SMTP id r141so35635642wmg.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2017 04:11:53 -0800 (PST)
In-Reply-To: <CAPDyKFpm5AxsnbX-UMGLntB4Z1KK2TzCcCmWFJqYwku-JkOwzw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>

On 31 January 2017 at 12:28, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 30 January 2017 at 14:26, Linus Walleij <linus.walleij@linaro.org> wrote:
>> When retrying to send a request, we used to have a NULL
>> check on the request we try to resend.
>>
>> It was removed in commit
>> c659b878689c ("mmc: block: inline command abortions")
>> but maybe that was not such a good idea. Maybe it can
>> actually be NULL?
>>
>> This might be causeing regressions in errorpath behaviour
>> seen in kernelci boot tests on the sunxi.
>>
>> I'm not sure because this state machine has so many
>> entrances and exits that I can't wrap my head around it.
>>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> I have applied this for next. Let's see what kernelci reports from the
> boot test of the sunxi boards.

Seems like this fixed the problem. Kernelci no longer reports issues
for the sunxi boards [1].

Regarding the existing sunxi mmc driver error messages, those are
still there [2].

>
> If it turns out to be a good fix, I am going to fold this change into
> "mmc: block: inline command abortions", but re-writing the changelog
> of that a bit.
>
> Please tell me if you don't think this is a good idea.
>

Folding in this change into "mmc: block: inline command abortions"....

Kind regards
Uffe

[1]
https://kernelci.org/boot/all/job/ulfh/kernel/v4.10-rc6-120-g3e05469d6088/

[2]
https://storage.kernelci.org/ulfh/v4.10-rc6-120-g3e05469d6088/arm-multi_v7_defconfig/lab-baylibre-seattle/boot-sun7i-a20-bananapi.txt
