From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] RFT: mmc: block: restore NULL check when retrying
Date: Wed, 1 Feb 2017 13:34:06 +0100
Message-ID: <CACRpkdbTFwq93bi0p0m=RyqqZuzeH6PDmXcCho8-A5SFnL=juw@mail.gmail.com>
References: <20170130132625.18296-1-linus.walleij@linaro.org>
 <CAPDyKFpm5AxsnbX-UMGLntB4Z1KK2TzCcCmWFJqYwku-JkOwzw@mail.gmail.com> <CAPDyKFoK+fKU3HH9-1krmQJjJhZmx1gst41c4uGO+dbc6aaJnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:34957 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbdBAMeN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 07:34:13 -0500
Received: by mail-io0-f175.google.com with SMTP id j18so154991749ioe.2
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2017 04:34:13 -0800 (PST)
In-Reply-To: <CAPDyKFoK+fKU3HH9-1krmQJjJhZmx1gst41c4uGO+dbc6aaJnQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>

On Wed, Feb 1, 2017 at 1:11 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 31 January 2017 at 12:28, Ulf Hansson <ulf.hansson@linaro.org> wrote:

>> I have applied this for next. Let's see what kernelci reports from the
>> boot test of the sunxi boards.
>
> Seems like this fixed the problem. Kernelci no longer reports issues
> for the sunxi boards [1].

Phew! At least my patch churn is not causing *new* regressions...

> Regarding the existing sunxi mmc driver error messages, those are
> still there [2].

That still sucks :(

> Folding in this change into "mmc: block: inline command abortions"....

Thanks. I will resend the rest of my cleanup patches, with some new
on top. You can disregard my previous patch series posted on the
26th for now.

Also feel free to push all of it until after v4.11-rc1! I understand that it's
getting hectic due to the imminent merge window.

Yours,
Linus Walleij
