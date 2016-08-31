From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Wed, 31 Aug 2016 10:52:55 +0530
Message-ID: <CANYu_0t0XpZPcq+Lh+z_CxERFFNkZKX9Rp8yttd7GdMcwe98Bg@mail.gmail.com>
References: <1466080509-24015-1-git-send-email-pramod.gurav@linaro.org> <CAPDyKFraYWS+ZFLAhRfnhVEac6j8+oyGz6AVwnCgvEHxxvvLpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34037 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbcHaFW4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Aug 2016 01:22:56 -0400
Received: by mail-yw0-f170.google.com with SMTP id z8so24582385ywa.1
        for <linux-mmc@vger.kernel.org>; Tue, 30 Aug 2016 22:22:56 -0700 (PDT)
In-Reply-To: <CAPDyKFraYWS+ZFLAhRfnhVEac6j8+oyGz6AVwnCgvEHxxvvLpQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Thanks Ulf for the review.

On 29 August 2016 at 19:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 16 June 2016 at 14:35, Pramod Gurav <pramod.gurav@linaro.org> wrote:

<snip>

>> +       platform_set_drvdata(pdev, msm_host);
>> +
>> +       pm_runtime_set_active(&pdev->dev);
>> +       pm_runtime_enable(&pdev->dev);
>
> I think you need to move these a bit earlier, before calling sdhci_add_host().
>
> Maybe it's just easier if you look at the sdhci-of-at91.c driver,
> which behaves nicely around runtime PM deployment. You can probably
> use the very similar code, except the ->runtime_suspend|resume()
> callbacks.
>
> And don't forget to deploy runtime PM support in the ->remove()
> callback as well, again sdhci-of-at91 is a good reference.
>

Will take a look at the said driver and do necessary changes and repost.
Thanks again.

Regards,
Pramod
