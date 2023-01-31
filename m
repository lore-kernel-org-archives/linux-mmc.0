Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28015C38142
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Jan 2023 14:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjAaOGY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Jan 2023 09:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjAaOGK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2023 09:06:10 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5155E51C48
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2023 06:05:34 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id o187so1716294ybg.3
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2023 06:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fDjexyMzNvSWzbZOjcSUrIsvimVayUVIVulpD45BwHw=;
        b=cf1Y5AEH7VSp4QLHdtUgf5uu+wUcXYJ0MzdbAo9QRFxAHSKlH/xjQDnpcAkIgnxQ/j
         a40nX8u9Gp+ViNPT5RUVqsC8voD1R+Zl9t68zEwsBqeynRJFLJlIPsSozBy6L87hHd6b
         xbztv58AP1ajdW3e7mgZwM4vbiVXOodwQOBNDX3MP4eiW+x7ABhYnM2BSCfn6G24YWkz
         FDdIzT4rw5vLVGW4e01EFyfsqRGEUZcRQQHOgp682izMyDN6oBqwb1Tj6h3gJji85VRS
         mLPHLzm3aPpfar1kyMY4EwfW7IvEXLqYK2cX8j3f+MD5aVUQqwIUNmVv6zp0ffSlaYdA
         NGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDjexyMzNvSWzbZOjcSUrIsvimVayUVIVulpD45BwHw=;
        b=LbkCZxM9SAbnI58nCZ9fGt18UlW8hjYcABltOE4w01WxDYn00La5hdrVh+6I3w4hD8
         Gevd0OHSpR+Wx55MfSEgt1cEF/+q5XUTuy//jMPkss2Eg3/NRvABZpuOW8PqQt43Su5H
         LwFiulNbs+ySVfWCnePNIxug1v20QAMBQTR6yIDy2FENSFDsV+wG6ZoKFsgWMGw7H+Ky
         FHamrVQvzJ9ZeMg5yyX2fJjsVp7mt6OuHi8GH7lC2KboZ3/P3kM15hnObU270UpsY2Q6
         vUt3MupCgDq0NXjUyvdh0ceuGNNDDP/PR4vrywfQy/JjuJ0Z++En4uBzXkYZC3QD6fvE
         efcw==
X-Gm-Message-State: AO0yUKUOhypuK+1x3PzM34pfT+cDMq8LTIvNpFcWC3ApxF9aTv8oiCYd
        9FmMDTyB1d+BOHhEZP6xUmG9x82NKJPMp5feiYPhdg==
X-Google-Smtp-Source: AK7set/VdWZzotO7LJ+R2m/4W0Q6bwEgHQqWz885BlR06FKPA5XnvyaHHZunejS2q/d3LjKTH+NpmgGWZEEqytFTgIo=
X-Received: by 2002:a25:d884:0:b0:80b:66c5:9fc5 with SMTP id
 p126-20020a25d884000000b0080b66c59fc5mr3398261ybg.210.1675173932611; Tue, 31
 Jan 2023 06:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20230131084742.1038135-1-linus.walleij@linaro.org>
 <Y9jY2zsNbSCWluZG@infradead.org> <CACRpkda3mk8wkdxWQFev9PrK6bPsxR6qLJo_gXnK+_jaTCFfjg@mail.gmail.com>
 <Y9kVrh9VEz4/T76f@infradead.org>
In-Reply-To: <Y9kVrh9VEz4/T76f@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Jan 2023 15:05:20 +0100
Message-ID: <CACRpkdbd73PEAaNYr2cz=pmw7guHK0-hiPCYXgpgQfy-d9TTTQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Imply IOSCHED_BFQ
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 31, 2023 at 2:20 PM Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Jan 31, 2023 at 10:57:38AM +0100, Linus Walleij wrote:
> > Now it doesn't require it, it will just perform better, so thus I use
> >
> > imply IOSCHED_BFQ
> >
> > the point with it is to help users make the right decisions, not
> > enforce them. fs/crypto/Kconfig does the same thing for example,
> > advice not enforce.
>
> I'd really love to see how it always works better, as none of that
> has actually been documented.

I guess I would need to turn that around and ask what
kind of documentation would convince you?

I guess this isn't enough:
https://www.kernel.org/doc/html/latest/block/bfq-iosched.html

To be clear, "works better" in this context means, solving a problem
for the interactive user, preventing random freezing of the UI on
resource-limited (memory, disk throughput) systems under high
I/O load.

Not maximizing throughput in general, which is the common
misunderstanding.

I personally ran into it, and blogged about it:
https://people.kernel.org/linusw/bfq-saved-me-from-thrashing

The phenomenon of freezing UI also happens on e.g. Android
while updating the apps in the background as illustrated by Paolo
here:
https://www.youtube.com/watch?v=ANfqNiJVoVE
More demos on more devices (mostly MMC/SD):
https://www.youtube.com/user/valentepaolo/videos

He also has several practical measurements of it and a test suite:
http://algogroup.unimore.it/people/paolo/disk_sched/results.php

There are also peer-reviewed IEEE articles and what not.

>  And given the wide variety of hardware
> and workloads I also very much doubt it.

The problem it solves appears on slow single-queue
devices where the scheduler cannot distinguish importance
between processes and treat all processes the same.

It does not try to solve the problem of maximizing throughput
on a real fast MQ device.

For MMC/SD-based systems this is very real, and that is why
this is implied by a patch to the MMC/SD subsystem.

Embedded interactive devices use MMC/SD-cards, while enterprise
storage systems does not.

This is why the udev rule in RedHat/Fedora looks like this:

60-block-scheduler.rules

ACTION=="add", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", \
  KERNEL=="mmcblk*[0-9]|msblk*[0-9]|mspblk*[0-9]|sd*[!0-9]|sr*", \
  ATTR{queue/scheduler}="bfq"

Targetting most slow single-queue devices with BFQ.

SuSE has something similar:
https://github.com/openSUSE/udev-extra-rules/blob/master/60-io-scheduler.rules

Yours,
Linus Walleij
