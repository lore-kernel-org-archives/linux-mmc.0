Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B127C433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACF964F88
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbhCDAAO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350431AbhCCLAi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 06:00:38 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604FAC06178C
        for <linux-mmc@vger.kernel.org>; Wed,  3 Mar 2021 02:59:58 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id v66so5129616vkd.10
        for <linux-mmc@vger.kernel.org>; Wed, 03 Mar 2021 02:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYeQ+NFtTLUpACjemsdiHMG/NCOie4ro9CLEsAjhtuI=;
        b=jcFAKEL534YPyAxFXGKOJVFO2btNyVhC6s5kEAGYFX+670ERVHjaZ33CMDqb+GM/ZJ
         dQQ9GvY200Q9Q7o0oQqNRVvOHoYqJzk1ZHQ9nxYT8hGZ3/wcc4DWIadFydb6N8HR8p+f
         oDZ7Y0nCg5PJseN48pPsKbXWrHFuNTLQjoAZmhWuDILwU+Ce28YePQSxnoLfhyEoO7FX
         SoT11MqTSP16MWfiiJ339biCFDTouJwIaP7Ydbz94Zot1OhsE43ejjVFsW760badaGgW
         +3caVh/CiRrAwO9YZfOoPnWtL1ZuE0wnuYl4es+eqC5RK15eMUPiF2cHuFWn2A0ePtWf
         UhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYeQ+NFtTLUpACjemsdiHMG/NCOie4ro9CLEsAjhtuI=;
        b=oqZlQUhrHqaWpCizzE2cZbpVKa1kDAmllqUXxQB+WO8aL7MidOhhtfGrkBf9Zkl0PP
         AR9z8Ob4iAxtYSLjzL6bKjl5rM1ioYU3M7MYkkg79GUvf3oRXsvJcaKK0LtA2aUJFlwF
         lUaetF9PcXtGR9CeOoSox6Rk0FcX6WR9H6oQ+z2yz6rodH3gquZIhjCdVO+7PXgv/Wr5
         SOoIu06yRTEYfsV4yTG3abXm0T8VEHcOPhNhqEOynvbv+oGNdsEn+NweOgGqlNvtLxMW
         SPbfPExQvEdioeBDOxlM8x27dZdZtat/7ARv2TJmC3ov1BFZs12We/zCbtMGC9N4qf5z
         mqRw==
X-Gm-Message-State: AOAM531RVIorX+z5BUh6ZgRoM/nyO05SNIQmxjCM2ZIBzLbT9tL3fGX6
        sjd1eV7yWUO0Z74yx3BwfwNvUOC37nTG6+fbZJHlNQ==
X-Google-Smtp-Source: ABdhPJySAeA/1d5EsayQ94SdoHcpOpkYbKU8KfewwcSREocfquLPnUDq8QChpEe3WhrUC3jF6gQ8uPYeZU7qfB62W/U=
X-Received: by 2002:a1f:a68d:: with SMTP id p135mr5747751vke.6.1614769197495;
 Wed, 03 Mar 2021 02:59:57 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210210051209epcas1p3e55c0cbab7313731bc6e425da6189bb4@epcas1p3.samsung.com>
 <20210210045936.7809-1-dh0421.hwang@samsung.com> <CAPDyKFpQyoNELdh3FrFF++HXKjH_Tn9oaY=PzUXHcE8o=KK-hg@mail.gmail.com>
 <01df01d70ff6$bc9dd230$35d97690$@samsung.com>
In-Reply-To: <01df01d70ff6$bc9dd230$35d97690$@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 3 Mar 2021 11:59:19 +0100
Message-ID: <CAPDyKFpVjxKziPmyF+MXG--LKNSVOYaCUuaNBHCzMGCvSzE--Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: add a power cycle when CMD11 fails
To:     DooHyun Hwang <dh0421.hwang@samsung.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Satya Tangirala <satyat@google.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        junwoo80.lee@samsung.com, jangsub.yi@samsung.com,
        Seunghui Lee <sh043.lee@samsung.com>,
        Chanwoo Lee <cw9316.lee@samsung.com>, sh8267.baek@samsung.com,
        wkon.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 3 Mar 2021 at 07:30, DooHyun Hwang <dh0421.hwang@samsung.com> wrote:
>
> On Tue, 2 Mar 2021 at 10:38, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >On Wed, 10 Feb 2021 at 06:12, DooHyun Hwang <dh0421.hwang@samsung.com>
> >wrote:
> >>
> >> A power cycle is required if CMD11 fails.
> >> CMD11 failure should be handled as no response.
> >>
> >> If there is a timeout error that means no response to the CMD11, do
> >> not send the CMD11 again and the power cycle is required.
> >> Any other errors for CMD11 are the same because CMD11 failed.
> >>
> >> On some bad SD Card, CMD11 may fail but the card may have already
> >> invoked the voltage switch sequence.
> >> In this case, it is necessary to retry without voltage switching after
> >> power cycle.
> >>
> >> Signed-off-by: DooHyun Hwang <dh0421.hwang@samsung.com>
> >
> >Applied for next, thanks!
> >
> >I took the liberty of updating the commit message a bit, to try to clarify
> >things. Moreover, I have tagged this for stable kernels.
> >
> >BTW, did you try to force the error to -EAGAIN, to keep retrying for a
> >couple of times? If so, did it end up with the same kind of errors?
>
> Thank you for reviewing this.
>
> Yes. I tested with 2 SD cards.
> I think the power cycle is needed before retrying
> because SD card doesn't respond SD_ROCR_S18A when retrying without power cycle.

Thanks for sharing the logs and the details below!

If I understand correctly, forcing the error to -EAGAIN combined with
the power cycle when the CMD11 fails, actually makes us succeed with
the voltage switch in the second retry. Correct?

In that case, it seems like a good idea to extend $subject patch to
return -EAGAIN in case we get an error from the CMD11, right?

[...]

>
> #4. SD card responded with SD_ROCR_S18A from ACMD41 after power cycle, and change CMD11's error value to -EAGAIN
> // send ACMD41 + with SD_OCR_S18R (bit[24])
> <7>[  156.884623]  [0:    kworker/0:1:    7] mmc0: starting CMD41 arg 51040000 flags 000000e1
> // resp ACMD41 + with SD_ROCR_S18A (bit[24])
> <7>[  156.884975] I[0:    highpool[3]: 5440] mmc0: req done (CMD41): 0: c1ff8000 00000000 00000000 00000000
> // send CMD11 and error occurs
> <7>[  156.885051]  [0:    kworker/0:1:    7] mmc0: starting CMD11 arg 00000000 flags 00000015
> <7>[  156.885759] I[0:    highpool[3]: 5440] mmc0: req done (CMD11): -84: 00000000 00000000 00000000 00000000
> // retry with power cycle (tested with this patch)
> <7>[  156.885834]  [0:    kworker/0:1:    7] mmc0: Signal voltage switch failed, power cycling card
> <7>[  156.885875]  [0:    kworker/0:1:    7] mmc0: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
> <7>[  156.920185]  [0:    kworker/0:1:    7] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 18 width 1 timing 0
> // change CMD11's error value to -EAGAIN
> <3>[  156.932288]  [0:    kworker/0:1:    7] mmc_sd_get_cid: rocr=0xc1ff8000, retries=10. err=-84 -> -11.
> <7>[  156.932336]  [0:    kworker/0:1:    7] mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 18 width 1 timing 0
> <7>[  156.933834]  [0:    kworker/0:1:    7] mmc0: starting CMD0 arg 00000000 flags 000000c0
> <7>[  156.934101] I[0:ung.android.mdx:10229] mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
> <7>[  156.935562]  [0:    kworker/0:1:    7] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 18 width 1 timing 0
> <7>[  156.937009]  [0:    kworker/0:1:    7] mmc0: starting CMD8 arg 000001aa flags 000002f5
> <7>[  156.937372] I[0:ung.android.mdx:10229] mmc0: req done (CMD8): 0: 000001aa 00000000 00000000 00000000
> // send ACMD41 + with SD_OCR_S18R (bit[24])
> <7>[  157.044190]  [0:    kworker/0:1:    7] mmc0: starting CMD55 arg 00000000 flags 000000f5
> <7>[  157.044924] I[0:ung.android.mdx:10229] mmc0: req done (CMD55): 0: 00000120 00000000 00000000 00000000
> <7>[  157.045023]  [0:    kworker/0:1:    7] mmc0: starting CMD41 arg 51040000 flags 000000e1
> // resp ACMD41 + with SD_ROCR_S18A (bit[24])
> <7>[  157.045389] I[0:ung.android.mdx:10229] mmc0: req done (CMD41): 0: c1ff8000 00000000 00000000 00000000
> // send CMD11 and complete
> <7>[  157.045467]  [0:    kworker/0:1:    7] mmc0: starting CMD11 arg 00000000 flags 00000015
> <7>[  157.045855] I[0:   Binder:798_2:  805] mmc0: req done (CMD11): 0: 00000320 00000000 00000000 00000000
>
>
> >
> >> ---
> >>  drivers/mmc/core/core.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> >> 1136b859ddd8..a6674df2a7bb 100644
> >> --- a/drivers/mmc/core/core.c
> >> +++ b/drivers/mmc/core/core.c
> >> @@ -1207,7 +1207,7 @@ int mmc_set_uhs_voltage(struct mmc_host *host,
> >> u32 ocr)
> >>
> >>         err = mmc_wait_for_cmd(host, &cmd, 0);
> >>         if (err)
> >> -               return err;
> >> +               goto power_cycle;
> >>
> >>         if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
> >>                 return -EIO;
> >> --
> >> 2.29.0
> >>

Kind regards
Uffe
