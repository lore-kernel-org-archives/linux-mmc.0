Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB54BC7EE22
	for <linux-mmc@archiver.kernel.org>; Mon, 15 May 2023 09:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbjEOJpe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 May 2023 05:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241191AbjEOJpQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 May 2023 05:45:16 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F728173F
        for <linux-mmc@vger.kernel.org>; Mon, 15 May 2023 02:44:22 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-55a8019379fso114871177b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 15 May 2023 02:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684143861; x=1686735861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ld/YrdRTBdqdy0pycTOaYtPC+M6ZVb33T18X0mOr9Mg=;
        b=cdlIzyrsvetkTBgU08Y1Zelpxa56GODDdbsv30gwuNa8JEHUikUeME5gj5LxzLdcnh
         JhTkJZK0daAJTRkH2g6IGjb/OKRvMOI6GQ2lTBoQvER4C20TAim7bO+I1ewvZeZoiC+r
         A2szzK6gbrCcQ+IirtzC+xqkMQkp6wdHOJNU/WRzKarJKQAfC7J2GhPKvowZxLYQt16x
         by/DrsnkKSIq9swDO7fWi9lIUnZsSJIQp2YfOpev6cQa8uHVyQPZBGOaBhnUfeQDEmyR
         I7DKwJ8AWwa3k9uU/GgUAMl4q+bGuA/lw9/++LmVHvc3Bwpig03INeOHTgc2NygNBx7L
         Rvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684143861; x=1686735861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ld/YrdRTBdqdy0pycTOaYtPC+M6ZVb33T18X0mOr9Mg=;
        b=IOF2m7fh3KRFlvMiitNQlPN622rw9qfBQCkV2l3zcWmvZYiGZU8LNdXB2Vhqt6qdLg
         J4e4WpY/YQSU/CmtDm2Jw2qW9aXFmCiSDUMPPXVFFGMJukmjnRfGZmIzzd03id/HFv9J
         ePRKR/4qWpn16wopYYSJpiJWGDWVHRuBuaFdGM3BsmpJ2ij1qlrmkredgFUTg6q9sf70
         zqiHz7KhDC8+85mKevV7knIjBXezn/IfhblWAhM5r1qSdHuHe55Ly6064YRthWdVwe+o
         PlB/P8PgMkgNf2xXP+BSdpwXq4mDJCK9C2yT5Rc93PWSu6f2id/HUo1sgl0C1NjxBfre
         Gziw==
X-Gm-Message-State: AC+VfDyzlNFMtMM2zvqeQjS3REWGJyXLuMEHsXMx/faoFaTxyqNvItHY
        4AOlOmH8pcey/D5P7nCP29WMNrpV7wJVsGxhWuRPpTESsZ7cyl97
X-Google-Smtp-Source: ACHHUZ57dks5NjzFar8XRoWSvpAHCu8E9cPpJwR08uZWn7Cc1zaJGCLurbzr8wy+whRxVo1xguA1MuYqy9fFb0+g7Cc=
X-Received: by 2002:a81:6d04:0:b0:55a:abf7:636e with SMTP id
 i4-20020a816d04000000b0055aabf7636emr27580098ywc.24.1684143861270; Mon, 15
 May 2023 02:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
 <CAPDyKFqgYnBfm-NespEZF8AJ5Ou4Bya8jLfVEnfyZvfAZ05Q7Q@mail.gmail.com>
 <CAFBinCDjPJHEhN-Jx3DhhhHJ3yi8oEoW7u4-Ld6Rd1+W826ttA@mail.gmail.com>
 <CAPDyKFqKSWJkJwgCO89jgKQ6AB==P9BWkuX6XtKj=ASOH15y9g@mail.gmail.com> <CAFBinCDwgYw3v31hP4AtV3+Z1o+esDqMKugRwMMMLqSX0Acjzw@mail.gmail.com>
In-Reply-To: <CAFBinCDwgYw3v31hP4AtV3+Z1o+esDqMKugRwMMMLqSX0Acjzw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 May 2023 11:43:45 +0200
Message-ID: <CAPDyKFr+hQo+N31r=3f58taf9sYW0UF0ApCJhwz9vRsyNizcvg@mail.gmail.com>
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

On Sun, 14 May 2023 at 22:42, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Ulf,
>
> On Thu, May 11, 2023 at 12:43=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> [...]
> > > Indeed, removing mmc_set_clock() from mmc_select_hs200() also makes m=
y
> > > eMMC appear again on top of Linux 6.4-rc1.
> > > See the attached diff in case it's not fully clear which
> > > mmc_set_clock() call I removed.
> >
> > Thanks for the update! Removing that call restores mmc_select_hs200()
> > to the previous behaviour - so thanks for confirming that this is
> > working.
> >
> > However, to find the proper solution, I think we need to understand
> > why we are hanging in the meson-mx-sdhc driver first. Here's a couple
> > of follow up questions from me:
> >
> > 1) Before calling mmc_set_clock() what is the actual clock rate that
> > has been set by the meson driver?
> >
> > 2) Does the call to mmc_set_clock() return or hang? Can we verify that
> > the clock gets set correctly?
> I used the attached diff to answer these two questions. See the
> following log extract (full log is attached):
> meson-mx-sdhc c1108e00.mmc: Trying to set MMC clock to 400000Hz
> meson-mx-sdhc c1108e00.mmc: Actual MMC clock to 399812Hz
> mmc1: mmc_select_hs200 switching to clock from card->ext_csd.hs_max_dtr..=
.
> meson-mx-sdhc c1108e00.mmc: Trying to set MMC clock to 52000000Hz
> meson-mx-sdhc c1108e00.mmc: Actual MMC clock to 51000000Hz
> mmc1: mmc_select_hs200 mmc_set_clock returned
>
> > 3) If 2) seems to work above, we need to figure out why
> > mmc_switch_status() is hanging. If there is a problem with the eMMC
> > card responding in-correctly, the host driver should return with an
> > error code, right?
> You're right: it's indeed hanging in mmc_switch_status()
> I don't get any interrupts (timeout, CRC error, ...) for it.
> Do you have any suggestions what to check next?

So the mmc_switch_status() is sending a CMD13. Even if the card
doesn't reply, I would expect that the meson mmc controller would
raise some kind of error condition, probably via a timeout-irq.

Did you verify that the driver is actually waiting for an IRQ to
happen, which also means waiting for a CMD13 response?

Kind regards
Uffe
