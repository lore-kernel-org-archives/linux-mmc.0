Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CB2C77B7F
	for <linux-mmc@archiver.kernel.org>; Thu, 11 May 2023 10:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjEKKnV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 May 2023 06:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbjEKKnU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 May 2023 06:43:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F98B359F
        for <linux-mmc@vger.kernel.org>; Thu, 11 May 2023 03:43:18 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ba696d396a1so1078429276.0
        for <linux-mmc@vger.kernel.org>; Thu, 11 May 2023 03:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683801797; x=1686393797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwK6O2GyMlAYbj1OPQtJ3JBX3Y5C0lX7LcCuPtjs1rs=;
        b=jsYN3JsF63Nz6qFKAR0lCzd0sprcKZYnTGibq/Jxwtr0by0tRyoQsdbsh/LBKTVwlE
         ykcWHCx1rycHqBtIT4qWxAmver4ZuvAYdlz2kT65MXNU2CmhgvFfteeA1HWPusU5K1f4
         iP+tWKQFU58fDlbNUSONw9ByFq1ALaOjyqtAtTu0zT8KVOP+v7o6eaKoaNTY1RR+p/fq
         V423oNRWGKth4FxHEk/kvC5Ilm/vrZYWSNuimVO13/zsEQ4tG7pfkEpXpxcfVjjoQX+I
         ZfeW4n94sh4n39vfusL/IlF89ODTJXeSvO3sLuCiccn4ooljriZ1/FVPVPxf+OnAgtTE
         BsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683801797; x=1686393797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwK6O2GyMlAYbj1OPQtJ3JBX3Y5C0lX7LcCuPtjs1rs=;
        b=IghCNlITErPt/E+qtSU42/JDsS08H4hF+C4Viwa+qrX5p1KYeXXK9EVYUflRJvqpaL
         +J7tamwNMh88pIVoSsFYcU4aPe6hn16aGXQV8T4A9fIg5tvlYy5db67UDDVl8kWW6NHl
         DV4+IHzVhNV2VDp4GkLInxsVunkXIB5rH+R0ZsiWFJPqdvK53lX+G6K2hHK0X5GdnHvx
         dtHRZLricXHwi3ZPgNXoMPayaEBKhE86FV1JPTgTrkk3oBkJNJL5a1deIZZDtihNFvQw
         wot7eFDYf3ZjOB+WjAYoGeSkX9a2KU//OgjnqsvYqotVlpMXg3c87jIdcPTBsyw38FVs
         XSbQ==
X-Gm-Message-State: AC+VfDzjIivYi8gLuVvepWrriERRlFSNgzHn48eDIZEzujg//fNPbws5
        FrQE3Kl0tDrWWgFLHgDIqqpY39hjHnbaeHJpn0YTftvivTMSponlP2A=
X-Google-Smtp-Source: ACHHUZ7GfJx9MP3qtqPM8KCkJqmfzOB1a4KjfFHMliWf8xRk0DK+bTILphb2c/JnUwR+7pXP4zKVdN4mEErExNVQqG4=
X-Received: by 2002:a25:dbd2:0:b0:b92:5a0e:d5df with SMTP id
 g201-20020a25dbd2000000b00b925a0ed5dfmr22793004ybf.46.1683801797441; Thu, 11
 May 2023 03:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
 <CAPDyKFqgYnBfm-NespEZF8AJ5Ou4Bya8jLfVEnfyZvfAZ05Q7Q@mail.gmail.com> <CAFBinCDjPJHEhN-Jx3DhhhHJ3yi8oEoW7u4-Ld6Rd1+W826ttA@mail.gmail.com>
In-Reply-To: <CAFBinCDjPJHEhN-Jx3DhhhHJ3yi8oEoW7u4-Ld6Rd1+W826ttA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 May 2023 12:42:41 +0200
Message-ID: <CAPDyKFqKSWJkJwgCO89jgKQ6AB==P9BWkuX6XtKj=ASOH15y9g@mail.gmail.com>
Subject: Re: Odroid-C1 regression with commit 4bc31edebde5 ("mmc: core: Set HS
 clock speed before sending HS CMD13")
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Luca Weiss <luca@z3ntu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 10 May 2023 at 22:54, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Ulf,
>
> On Wed, May 10, 2023 at 4:21=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> [...]
> > Thanks for reporting - and my apologies for the long delay! It's been
> > a busy period with lots of travelling for me.
> Thank you for taking the time to look into this now - no need to apologiz=
e!
>
> [...]
> > > In this state I get:
> > > # cat /sys/kernel/debug/mmc1/ios
> > > clock:          52000000 Hz
> > > actual clock:   51000000 Hz
> > > vdd:            21 (3.3 ~ 3.4 V)
> > > bus mode:       2 (push-pull)
> > > chip select:    0 (don't care)
> > > power mode:     2 (on)
> > > bus width:      3 (8 bits)
> > > timing spec:    9 (mmc HS200)
> > > signal voltage: 1 (1.80 V)
> > > driver type:    0 (driver type B)
> >
> > It looks to me that we are in the process of enabling the HS200 mode,
> > but hangs at some point. Unless I am mistaken.
> >
> > More precisely, I suspect it's either the call to mmc_set_clock() or
> > the call to mmc_switch_status(), in mmc_select_hs200(). Can you have a
> > closer look to confirm this?
> Indeed, removing mmc_set_clock() from mmc_select_hs200() also makes my
> eMMC appear again on top of Linux 6.4-rc1.
> See the attached diff in case it's not fully clear which
> mmc_set_clock() call I removed.

Thanks for the update! Removing that call restores mmc_select_hs200()
to the previous behaviour - so thanks for confirming that this is
working.

However, to find the proper solution, I think we need to understand
why we are hanging in the meson-mx-sdhc driver first. Here's a couple
of follow up questions from me:

1) Before calling mmc_set_clock() what is the actual clock rate that
has been set by the meson driver?

2) Does the call to mmc_set_clock() return or hang? Can we verify that
the clock gets set correctly?

3) If 2) seems to work above, we need to figure out why
mmc_switch_status() is hanging. If there is a problem with the eMMC
card responding in-correctly, the host driver should return with an
error code, right?

Kind regards
Uffe
