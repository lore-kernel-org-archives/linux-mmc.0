Return-Path: <SRS0=G9E5=7V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33FCC433E1
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 14:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D28E206C3
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 14:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rz4vo/Cc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgFHOv1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbgFHOv0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jun 2020 10:51:26 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212E6C08C5C3
        for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2020 07:51:24 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id i1so4037014vkp.8
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2020 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QatI1r4zgYT60LXPJCHacRlmfL//mgtNnDdWSg8Upwg=;
        b=rz4vo/CcIIKMfmGj2Yba8XTLaA6mEYAkioCYNoLv3GuYjiHlw4n0t+WiK1ltYwI2Ev
         wfLlcfoJliIaMOduNo2jDjcpsyo12SyFARI7A669Dx9QkTz+OUGifp2zmuAw0DKflEp0
         QQENiR17FLLz7zAhF9uN83biP1s63x0onp0aIwuo5DeZ82LImsYIBLI5dhaQZMfl04Jo
         m/HeacvA+b/eZ4fDBZnBmi9bPMyIT6RbOOhXcwlJiWRubuBngrkJqqJssiKLbUj89qxH
         vcPbF+i94YMU2AJXWs94Z+tSgxsX2fa8+zWb0yT6oLCYCKmYI7+HajtpWQG0qjCDE7+G
         DBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QatI1r4zgYT60LXPJCHacRlmfL//mgtNnDdWSg8Upwg=;
        b=Pg1DHEqzO/BTjpkqV3q0qAc8NvBXLuv0xckXQedRmbaihHQkMVKir95gLQjtQizKl6
         bh17HDXVDF21jFfvhoytL4dmJ+Sg4W1I7jNmms6UJydqHKRHKKUdSZFGHePvAHZ1Fp/X
         x3xaoS7mT9ZJZCu9OSl9AfhCyHjXl91HqLqG7eK87Pt67+I4pNpqtf7/1OPxCH1u9hgl
         d6oV6RO0TM3T+BEMHFezpduYHCLjmohqoJISxdwUmfizfn4Y48WZLbWK67CDs+e/Jqn4
         RptRYOHQkJGzE5me1iMci0F/xRp3NKgn3mLCO/zSAKlRZYYagfCq/9uhrEAZIaBon5Jk
         vaLA==
X-Gm-Message-State: AOAM532/fwu/Pq7bFPaxsmE2UvOQSuVe90Jq8NAdj9tY0Xlhkby2tfJ6
        95hER+d3oS1aS11UghIOO5MXc8iAjjOxitqmlOcIeQ==
X-Google-Smtp-Source: ABdhPJzUTPIVVBVLg0YMLSJwnmUXyhDonfAtBvWnmnqEbQ8NkKDFitW9cQXtUxCUy0qvwf2etDBgySXasofAH2+z6MU=
X-Received: by 2002:a1f:25d7:: with SMTP id l206mr15744371vkl.53.1591627883182;
 Mon, 08 Jun 2020 07:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <1589887988-7362-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <TY2PR01MB3692FD4D8058D5EEFC761D47D8890@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <CAPDyKFptcUJj3u2LChz+tk61u8WcOrpaZLmDcj5Xb3HNuJv_qw@mail.gmail.com>
 <TY2PR01MB3692FAFE6FCA89538FA3AC4DD8850@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <CAPDyKFrcENub_NCP5s0v+3A09O55qGrK+gNrVswYjdqoLzPVzA@mail.gmail.com> <CAMuHMdXK2QkxMr3Lh6JnAh9RzHm4-CwpO_GLjD0+Vh-cM5a7nw@mail.gmail.com>
In-Reply-To: <CAMuHMdXK2QkxMr3Lh6JnAh9RzHm4-CwpO_GLjD0+Vh-cM5a7nw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Jun 2020 16:50:46 +0200
Message-ID: <CAPDyKFrHHJE7zc+Mz5ddZ4iy6AA-K5ba8-rmsdzW1C6fGSWgeQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] mmc: core: Issue power_off_notify for eMMC Suspend-to-RAM
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 8 Jun 2020 at 14:36, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Mon, Jun 8, 2020 at 1:47 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Mon, 8 Jun 2020 at 12:39, Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > From: Ulf Hansson, Sent: Monday, June 8, 2020 5:14 PM
> > > > On Thu, 4 Jun 2020 at 14:17, Yoshihiro Shimoda
> > > > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > > > From: Yoshihiro Shimoda, Sent: Tuesday, May 19, 2020 8:33 PM
> > > > > >
> > > > > > The commit 432356793415 ("mmc: core: Enable power_off_notify for
> > > > > > eMMC shutdown sequence") enabled the power off notification
> > > > > > even if MMC_CAP2_POWEROFF_NOTIFY (MMC_CAP2_FULL_PWR_CYCLE now) is
> > > > > > not set. However, the mmc core lacks to issue the power off
> > > > > > notificaiton when Suspend-to-{RAM,Disk} happens on the system.
> > > > > >
> > > > > > So, add Suspend-to-RAM support at first because this is easy to
> > > > > > check by using pm_suspend_target_state condition on _mmc_suspend().
> > > > > >
> > > > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > >
> > > > > I'd like to add more detail why this patch is needed.
> > > > > I think we should think some events (which are Shutdown, Suspend-to-idle,
> > > > > Suspend-to-RAM) for the Power off Notification control.
> > > > > I described these events like below.
> > > > >
> > > > > Assumption of the host : MMC_CAP2_FULL_PWR_CYCLE=false
> > > > > Assumption of the eMMC : in POWERED_ON
> > > > >
> > > > > 1) Event  : Shutdown
> > > > > - power   : going to VCC=OFF & VCCQ=OFF
> > > > > - ideal   : Either POWER_OFF_LONG or POWER_OFF_SHORT
> > > > > - current : POWER_OFF_LONG --> Perfect
> > > > > - Remarks : the commit 432356793415
> > > > >
> > > > > 2) Event  : Suspend-to-Idle
> > > > > - power   : Keep VCC=ON & VCCQ=ON
> > > > > - ideal   : issue MMC_SLEEP_AWAKE and keep the power (because the host could not change VCC=OFF)
> > > > > - current : issue MMC_SLEEP_AWAKE and keep the power --> Perfect
> > > > > - Remarks : IIUC, even if the eMMC is in POWERED_ON, a host can issue CMD5 (sleep).
> > > >
> > > > As a matter of fact, VCCQ *must* remain on in sleep state, while VCC
> > > > can be powered off.
> > >
> > > I got it.
> > >
> > > > >
> > > > > 3) Event  : Suspend-to-RAM
> > > > > - power   : going to VCC=OFF & VCCQ=OFF
> > > >
> > > > I don't understand why you think S2R should be treated differently
> > > > from S2I? At least from the MMC subsystem point of view, there is no
> > > > difference. No?
> > >
> > > On my environment, VCC & VCCQ condition differs like below.
> > >  S2I: VCC=ON & VCCQ=ON
> > >  S2R: VCC=OFF & VCCQ=OFF
> >
> > Can you explain why it differs? Who is managing the regulators and who
> > decides to turn them off?
>
> The firmware does, through PSCI system suspend.
> And what it does exactly is not standardized.

This sounds really weird. Especially, to let PSCI handle the VCC
regulator seems wrong, while PSCI is about power for CPUs and CPU
clusters (and corresponding power rails).

Oh well, nevermind.

> Perhaps we do need an "arm,psci-system-suspend-is-power-down"[1]
> DT property?

Hmm.

I wouldn't limit this to PSCI, but rather see this as a generic FW issue.

In principle, it sounds to me, like we need to dynamically allow the
mmc host to update MMC_CAP2_FULL_PWR_CYCLE, depending on what system
suspend mode we are about to enter. Or something along those lines.

>
> > Perhaps this is a regulator-enable usage count problem?
>
> Unfortunately not. Else we could fix it :-)

I see.

[...]

Kind regards
Uffe
