Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424AEC2BB55
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 17:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC4420786
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 17:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="P8MVDNhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgDPR5Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727794AbgDPR5X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 13:57:23 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFF6C061A0C;
        Thu, 16 Apr 2020 10:57:23 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so809568edq.7;
        Thu, 16 Apr 2020 10:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JukI2qcxSNyf52yHJpjT80gtxp48IEr/CgsVukdEHTM=;
        b=P8MVDNhJHnmJHFsyNYdMUXiwT4Boy56Wj9P0YtJb/1bhSGy0Sq9YmMAwAx2VB52AFK
         Zss8GsK7Kpyp3LpBdHprlBx15LXeBhFrIkVJna99hU10FiNhstMqpfRlqIbRd4nUtUxI
         /t5t9AhsXVsn6JgUXYHApplj9PeOV9c4wc6T4gdCyoTtCSjuUiObUepbSIu9GBRBIEXJ
         Z5B4o3o4JFGnTPUil5PURBCM7zLs0u/yyH7eL5prUOV2Buf96fVQfbXTRjicCdB4xbn9
         qzxOgL7Nqnw86kl0wrZ/lqyQaHs8UDqRnaDcph/hj7J1I59KM4wmo2q9sLEai6zBMnR8
         jjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JukI2qcxSNyf52yHJpjT80gtxp48IEr/CgsVukdEHTM=;
        b=i5LbdZQk85YxNOTEvoBaNi2OIep7NfS9zftrX7PVZVqTUc0NSx8jb6wg8XNqoUynJd
         bnkD9bDSHaNUh4sHDiMWkLizhSfh8qjLum3op3mXBvR4qIqA2bzfydKz1l5A1QMaumDT
         Qn++sa8hNU+reCTxAJqFZ622zC/3RX67TXOGCVcyyu6ainJgvBt36nmcjgV/RTrXZfZr
         edEQla1+thVqlxoHdjw59bywDGtXOqKG4ZcxF7LBPPI/svnmJ9rV3Vp7ElnUcqNmszsD
         pET4lXMVXlpFrVhVl+GQ1L1+Npb53zH6r1OduLERKXxAeuIAIroJ6EkgLBIen8QJarDd
         Olaw==
X-Gm-Message-State: AGi0PuZ2iC1RXL/odBcqXE2uAGN6b9mNKPp6jF+oUgj5jIdfLkzPsLKX
        Q4cFnOoz12raJns0RM8ySvoCikzF+do9+r/3a+iqiihM32Y=
X-Google-Smtp-Source: APiQypKcDeq4UvvtUEjHkgd5bJB0lxfAAkyoWXwHMWWPoZHwjBNFu/BEW/23s3wmsXEJ4Qju54+NKGyUKcjSV132BrI=
X-Received: by 2002:aa7:d3d6:: with SMTP id o22mr4503774edr.52.1587059841831;
 Thu, 16 Apr 2020 10:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200410213043.1091851-1-martin.blumenstingl@googlemail.com>
 <CAPDyKFpsTTUaTLy--DvOr0oAB71cTBdH1pfTV63LtcKOKOsnDw@mail.gmail.com>
 <CAFBinCAhfgEdT383x61mh9E0y3-3MLA-fUmZj-4C-_VUdGWtGQ@mail.gmail.com> <CAPDyKFrj6jdHe8OSvtuT7=QdreZ1YzMt=791ABSZfos8yux71A@mail.gmail.com>
In-Reply-To: <CAPDyKFrj6jdHe8OSvtuT7=QdreZ1YzMt=791ABSZfos8yux71A@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 16 Apr 2020 19:57:10 +0200
Message-ID: <CAFBinCDT08bts6xfNkTV-aqgOq=jDo+BQHGOVOQyFjRSQJpBvA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: meson-mx-sdio: Set MMC_CAP_WAIT_WHILE_BUSY
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Thu, Apr 16, 2020 at 1:26 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
[...]
> > > First, can you double check so the original polling with CMD13 is
> > > still okay, by trying the below minor change. The intent is to force
> > > polling with CMD13 for the erase/discard operation.
> > I have tried this one and it seems to work around the problem (before
> > I reverted my change and dropped MMC_CAP_WAIT_WHILE_BUSY from
> > mmc->caps)
> > also I did not see meson_mx_mmc_card_busy being invoked (not even
> > once, but I don't know if that's expected)
>
> For eMMC it should be used quite frequently, as CMD6 is sent quite
> often, during initialization for example (see mmc_switch() and
> __mmc_switch()).
I only tested the meson-mx-sdio driver with eMMC once (a long time
ago) and it did not work.
...maybe this is the reason ;)

> For SD cards, it's being used for erase/trim/discard and while
> changing to UHS-I speed modes (1.8V I/O voltage, see
> mmc_set_uhs_voltage(). The latter also requires your host driver to
> implement the ->start_signal_voltage_switch() host ops, which isn't
> the case (yet!?)
SD cards and SDIO cards are the main use-case for this driver.
I don't know of any board which connects this controller to a card
with 1.8V (or 1.8V/3.3V configurable) I/O voltage. This is why I
didn't care about ->start_signal_voltage_switch() so far

[...]
> > > Second, if the above works, it looks like the polling with
> > > ->card_busy() isn't really working for meson-mx-sdio.c, together with
> > > erase/discard. To narrow down that problem, I suggest to try with a
> > > longer erase/discard timeout in a retry fashion, while using
> > > ->card_busy(). Along the lines of the below:
> > I have tried this one as well (before I reverted the earlier CMD13
> > patch) and with MMC_CAP_WAIT_WHILE_BUSY unset in mmc->caps
> > This doesn't seem to work around the issue - kernel log extract attached.
> > Also I'm seeing that the the current meson_mx_mmc_card_busy
> > implementation returns that the card is busy.
> > example: 0x1f001f10 & 0x3c00 = 0x1c00. the busy logic in the driver
> > is: !!0x1c00 = 1
> >
> > My conclusion is:
> > - meson_mx_mmc_card_busy is not working and should be removed (because
> > I don't know how to make it work). it probably never worked but we
> > didn't notice until a recent change
>
> I see.
>
> Depending on what your driver plans to support for the future, see
> above, you may need to come back to this in future.
I'll let future Martin deal with that - he can add it back as needed ;-)
current Martin has his doubts that it'll be needed (see above)

> > - set MMC_CAP_WAIT_WHILE_BUSY as per my initial patch
> > - use Fixes: ed80a13bb4c4c9 ("mmc: meson-mx-sdio: Add a driver for the
> > Amlogic Meson8 and Meson8b SoCs")
> >
> > Does this make sense?
>
> Yes, I think so.
thank you for double-checking!

> > Also please let me know if you want me to try something else
>
> I would also suggest adding a patch that removes the ->card_busy() ops
> from the meson driver - and that should probably also carry the same
> fixes tag as above. Just to make sure the callback doesn't get used in
> some other circumstances, when going forward.
agreed, I will send a v2 later which adds the Fixes tag, a bit more
description and an additional patch to remove ->card_busy()


Thank you again very much for the insights!
Have a great day,
Martin
