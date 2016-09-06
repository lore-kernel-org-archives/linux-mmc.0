From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v4 2/3] mmc: core: Factor out the alignment of erase size
Date: Tue, 6 Sep 2016 16:25:10 +0800
Message-ID: <CAMz4kuKMEAK136fE2t3yVkkDm6rJHsqovM0hBZRsurFUnDK4nA@mail.gmail.com>
References: <2b6b5b930d0f37a219d5786a6b56b17516a90abd.1473130123.git.baolin.wang@linaro.org>
 <48c332c9c688796b7ea157046b8feb68a11e60d4.1473130123.git.baolin.wang@linaro.org>
 <20160906043435.GA10158@rhlx01.hs-esslingen.de> <CAMz4kuJzqyAEam3RNJga5EERMh6TgXWFoY-uZ8pbm1OZW7uy8g@mail.gmail.com>
 <20160906071918.GA27539@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yb0-f170.google.com ([209.85.213.170]:34661 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbcIFIZM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Sep 2016 04:25:12 -0400
Received: by mail-yb0-f170.google.com with SMTP id x93so69604527ybh.1
        for <linux-mmc@vger.kernel.org>; Tue, 06 Sep 2016 01:25:11 -0700 (PDT)
In-Reply-To: <20160906071918.GA27539@rhlx01.hs-esslingen.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, David Jander <david@protonic.nl>, Hans de Goede <hdegoede@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On 6 September 2016 at 15:19, Andreas Mohr <andi@lisas.de> wrote:
> On Tue, Sep 06, 2016 at 02:26:06PM +0800, Baolin Wang wrote:
>> On 6 September 2016 at 12:34, Andreas Mohr <andi@lisas.de> wrote:
>> >> -     to = from + nr;
>> >> -
>> >> -     if (to <= from)
>> >> -             return -EINVAL;
>> >
>> > Hmm, this is swallowing -EINVAL behaviour
>> > i.e., now possibly violating protocol?
>>
>> I didn't see what situation will make variable 'to' is less than
>> 'from' since I think variable 'nr' is always larger than 0, right? If
>> so, we should remove this useless checking. Thanks.
>
> Hmm, indeed, since all participating variables are unsigned,
> the existing calculation should never hit this.
> However, one could argue that this is an additional safeguard
> against implementation source getting modified in a way
> that will suddenly result in this pathologic case becoming true
> (where a -EINVAL bailout surely will then pinpoint things
> much more visibly for some users,
> as opposed to potential data corruption or some such).

OK. I'll add this checking.

>
>
>
> I have seen another change
>
>> -     if (nr == 0)
>> -             return 0;
>
> where it gets moved out of common path
> and into MMC_ERASE_ARG-specific branch
> (likely because the subsequent common-path conditional of
>     nr > rem
> is deemed sufficient).
>
> This seems to be again a change
> where a simple yet crucial
> device geometry calculation post-condition
> (either to > from, or nr > 0)
> is then not verified specifically/separately.
>
> Ultimately, I am not sure whether or not
> these (post-)conditions should be verified
> in their most basic, simple form,
> as an extra/separate verification step.

After some investigation, I think we add this checking is more safer.
Thanks for your comments.

-- 
Baolin.wang
Best Regards
