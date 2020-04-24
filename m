Return-Path: <SRS0=wlIT=6I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8A2C2BA1A
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Apr 2020 07:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354F320700
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Apr 2020 07:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMzixsUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgDXH0s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Apr 2020 03:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgDXH0s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Apr 2020 03:26:48 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFE3C09B045
        for <linux-mmc@vger.kernel.org>; Fri, 24 Apr 2020 00:26:47 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id g129so2468997vkh.9
        for <linux-mmc@vger.kernel.org>; Fri, 24 Apr 2020 00:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+BIpTFZwDV9BDmq6OiW0sWC6toNpxhZR4xYJQqWuvfA=;
        b=aMzixsUWwDAFCwL3AtMN2fxEWih8/ZmJjMxjEFOZu/vOtIdMp4LTCSRi0tDKo9cLU5
         yPoCc7MDuyUYqy0CI5Hhix53FVJXcNhM6aV3T1AkQsXHWPRMp32I9RFutRb8juCvtKlK
         WrEKM1l/JcMOScyOB5haRzFKinwBXi9R/APo0/hSdWL00fhkrffqvpB9ocEx9oFC9iyC
         6dH5W/MXVS0ABXV9JIC76VC9VNsSJJy/R/JbDZ8SH4n3p/28IM84mIsftp6B0D6xyqlp
         xGU1amGViZzeCp0ijFR4rxQOEh2Q4D7yaT7f/OHiTt8U89l+1rZcD/heYgZX4xUZdRmz
         c0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BIpTFZwDV9BDmq6OiW0sWC6toNpxhZR4xYJQqWuvfA=;
        b=qlbE30ISNxo8ydt/R1Plv15d98c+FOG0MeDDGCZHk9PzNMpOpIaB+xCY4HerA00FL3
         y4EppOTGZL+6EYBPeT2ayrVIucnulsCK1uUZM1h7lXBt2DLgO8baTgHLcwXVtqVbxV11
         GoyzWF8rj0vpna7xEBQkI4cEPODjRUYEkXnUiDefGopB16itT+5gjg2UjTwlraDrpMMr
         vNGkoxO0AjgdFQkW0tKGWXoxXNr2mNq57LtnZ2OVBCSlhWipgfnd736rj5ppYi2LgUAx
         phUcRej1TIfW4jCCg3K/nqmNMomGyAvpPhVoJSnRk5ijDSpU8hvvT9m30kdCc79XCB8g
         qBwQ==
X-Gm-Message-State: AGi0PuasCfl/jaXE3wfIm6H1cARbSlaHgBjL000f0+/t2JoKgRxOOg3f
        eo842iEd1oeGSt4iplqhGqh26DYSzkxEjHw0HGwyIQ==
X-Google-Smtp-Source: APiQypJ+QX4k9HuY0Ti1jn86JMGfvJzrpNHxNyFIg5zy6QJOWNCY6tUkgkZIhrEaWrelYNh4n71oX+ltRV6qz8CW8t0=
X-Received: by 2002:a1f:5003:: with SMTP id e3mr6616467vkb.59.1587713206237;
 Fri, 24 Apr 2020 00:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <408ebea1-725d-2f8e-7d26-a2cb4d7754d3@first-world.info>
 <20200422082836.GL25745@shell.armlinux.org.uk> <5a67104f-1286-2cb0-d01e-8aa61c9f7e48@first-world.info>
 <20200422111025.GM25745@shell.armlinux.org.uk> <50004568-09e5-719b-ec4a-c09882767a6a@first-world.info>
 <20200422113631.GN25745@shell.armlinux.org.uk> <268145c0-97de-cfd9-71bf-b698248d732a@first-world.info>
In-Reply-To: <268145c0-97de-cfd9-71bf-b698248d732a@first-world.info>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Apr 2020 09:26:10 +0200
Message-ID: <CAPDyKFraDafpJbRF9Ee9e2k1fhn7Mf1ezvUcJPEcwEBn5xBZ9g@mail.gmail.com>
Subject: Re: 2 bug repport
To:     alpha_one_x86 <alpha_one_x86@first-world.info>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ziji Hu <huziji@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 22 Apr 2020 at 20:17, alpha_one_x86
<alpha_one_x86@first-world.info> wrote:
>
> I had tested Linux 5.6.6 no change.
>
> Other idea?

Yes, try a couple releases between 5.6 and 4.20. For example, 5.5.

Kind regards
Uffe


>
> On 2020-04-22 07:36, Russell King - ARM Linux admin wrote:
>
> Adding back those who *need* to be copied.  Please be more careful
> with your replies.  As I said, those others are for your benefit,
> not for mine, as they are more likely going to be able to help you.
>
> Thanks for confirming that it is indeed a regression with 5.6
> kernels.
>
> Over to the Adrian/Ulf/others now...
>
> On Wed, Apr 22, 2020 at 07:15:18AM -0400, alpha_one_x86 wrote:
>
> Hi,
>
> On multiple hardware I had tested 4.20, 5.6.6, again 4.20, 5.6.6, again
> 4.20.
>
> The problem is only with 5.6.6, never with 4.20
>
> On 2020-04-22 07:10, Russell King - ARM Linux admin wrote:
>
> On Wed, Apr 22, 2020 at 07:00:11AM -0400, alpha_one_x86 wrote:
>
> Hi,
>
> It's regression because on the kernel 4.20 all is working.
>
> PLEASE do not drop the Cc list.  The Cc list is for YOUR benefit.
>
> You can't say that without going back and checking.
>
> SD cards are flash media, and they fail in weird and stupid ways.
> Flash media itself only has a limited number of write cycles before
> the memory irrevocerably fails.  SD cards have firmware on them to
> manage the flash media to perform wear leveling.  Firmware can be
> buggy and cause problems.  I've had SD cards become completely
> inaccessible because of a firmware failure.
>
> So, after finding a problem on a later kernel with SD cards, you
> need to confirm the regression by checking whether the previously
> working kernel continues to behave correctly (indicating a kernel
> regression) or whether it behaves the same (indicating a failure of
> the SD card.)
>
> If you're not willing to do that, I'm afraid we will have to discount
> your bug report since it doesn't contain the information necessary to
> make a proper evaluation of what may be going on.
>
> Cheers,
>
> On 2020-04-22 04:28, Russell King - ARM Linux admin wrote:
>
> On Wed, Apr 22, 2020 at 03:03:57AM -0400, alpha_one_x86 wrote:
>
> Hi,
>
> On mcbin platform I have uSD problem, repported but no reply on linux kernel
> bugzilla, https://bugzilla.kernel.org/show_bug.cgi?id=207083
>
> Any idea what patch try?
>
> I think that's a question for the MMC people.
>
> If you go back to your working 4.20 kernel, does the problem go away?
> If so, it sounds like a regression in the MMC subsystem.  If not, I
> wonder if it could be the uSD card going bad.
>
> However, I suspect the former.  I've seen one instance here where a
> Clearfog GT8k (Armada 8040 based just like the mcbin) running 5.6 with
> the rootfs on eMMC completely lost the ability to talk to the eMMC to
> the point that the machine had to be power cycled to recover it -
> merely rebooting did not.  I don't know the cause - the initial failure
> had vanished from the kernel logs, and because the eMMC was no longer
> accessible, the rsyslog files did not contain the details either.
> I've since setup remote logging, and I'm currently waiting for it to
> happen again.  I couldn't say if _that_ is a regression because I
> haven't been using the GT8k until very recently, and I tend not to use
> eMMC/uSD on the Macchiatobin that runs 24x7.
>
> --
> alpha_one_x86/BRULE Herman <alpha_one_x86@first-world.info>
> Main developer of Supercopier/Ultracopier/CatchChallenger, Esourcing and server management
> IT, OS, technologies, research & development, security and business department
>
> --
> alpha_one_x86/BRULE Herman <alpha_one_x86@first-world.info>
> Main developer of Supercopier/Ultracopier/CatchChallenger, Esourcing and server management
> IT, OS, technologies, research & development, security and business department
>
> --
> alpha_one_x86/BRULE Herman <alpha_one_x86@first-world.info>
> Main developer of Supercopier/Ultracopier/CatchChallenger, Esourcing and server management
> IT, OS, technologies, research & development, security and business department
