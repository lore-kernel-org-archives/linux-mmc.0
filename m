Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0593FC4167B
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Nov 2023 14:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbjKBOTB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Nov 2023 10:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjKBOSy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Nov 2023 10:18:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B183E12D
        for <linux-mmc@vger.kernel.org>; Thu,  2 Nov 2023 07:18:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-307d58b3efbso564055f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 02 Nov 2023 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698934730; x=1699539530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0q/WyUH/RO3Ia1/awVvdyA1n//Vy7px8qroeNCo7qY=;
        b=GCtHnkUVi4Z07t3eYioJpFGjdHOzjU5Sqb1JB3zzCDcuSf/Wq7FyDNtefPADd/sOX/
         jKZWwxVugV0YNO02xDdkXmIl4yFX/ChA2tSSfNNOvOUVcpR3cMx2svPyuVjavr9iWKs6
         0w4Yqt1SmWi0cjFGxKXgSp68A0t0KFxOHt++xXuyAghOSJdX1/Wd0zDuSNwBUSmw/ddP
         JDSjoInGbHzCVfKamcQMtUnQDleVBBXuqgJXh1NFU3Xb5bDJhCRsTb90TPGsx3Z6+JZQ
         orXNmpl/Q/LJH7vfUviCpGrgq8exPihczPr1F2UmMJko2eCAKOZAWKIsd83bs8YOjjay
         w21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698934730; x=1699539530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0q/WyUH/RO3Ia1/awVvdyA1n//Vy7px8qroeNCo7qY=;
        b=PkwiS2lboOB2EfKCBMR7MhIK9pf1LcCTw4jw+Jf1WVkI6F+dAMimVFhnOC8YGIu5o/
         WaeXONg0QdnF4KGxnhaFzK4P5dpksxjiuQJWezqMlEP2sZ3xj2FJYbQmpuus4XlhM4Un
         2/zvv1iJ6JfSHLJNU+oiSL6FEuYgQKps/Ofve5pJWbguz5ErQzkRmqWr5qED0M4DRui4
         upgCqKR61oU1IoFC9DKtQaCO7R5qAV4iPu1/Y24iXGYCz/LowZoLuWlCcvVLDx7lMc/q
         IPfzn8eoQgBFLn3+gkVf6o5O7fvFQIxdFMUhuvMUKf583nbKcPSU8v0NjT10/U5fpvPz
         d8fg==
X-Gm-Message-State: AOJu0YzuJcGt51dsyFlJ/sGrEcPLxFYRZ9y5HTC/aqQg5SkcMU6vLlzX
        ERcSJjP3Zbre3AQarHGl4EeP3CoBzhdWnILRfF5fT11OwwlQ3JijKzr8LB1r
X-Google-Smtp-Source: AGHT+IE9g66qOV7GOOy1S2wL5cvjWoCQ/TUy5CUYM1yzJ8ywolWjVlb2pKYwaZJ0OWNxgmJis7/EiQjKKSB0nZgf8jE=
X-Received: by 2002:a5d:5272:0:b0:32d:be44:f70c with SMTP id
 l18-20020a5d5272000000b0032dbe44f70cmr14423665wrc.7.1698934729892; Thu, 02
 Nov 2023 07:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231027145623.2258723-1-korneld@chromium.org>
 <20231027145623.2258723-2-korneld@chromium.org> <e7c12e07-7540-47ea-8891-2cec73d58df1@intel.com>
 <CAD=Nsqzg2zRNFx7E800vnpNH6bZeHv9zdAnZksJjiRcXOQ4t=A@mail.gmail.com>
 <63e54bfd-9bb3-423b-a965-e0a9b399671c@intel.com> <ZUOtAePhW5O_40wV@google.com>
In-Reply-To: <ZUOtAePhW5O_40wV@google.com>
From:   Radoslaw Biernacki <biernacki@google.com>
Date:   Thu, 2 Nov 2023 15:18:33 +0100
Message-ID: <CAM4=RnLqQPkMNPqFPeVnzrogcWNe3j-=hBWkFHgGovd97Y_FUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: cqhci: Add a quirk to clear stale TC
To:     =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 2, 2023 at 3:07=E2=80=AFPM Kornel Dul=C4=99ba <korneld@chromium=
.org> wrote:
>
> On Thu, Nov 02, 2023 at 01:01:22PM +0200, Adrian Hunter wrote:
> > On 2/11/23 11:21, Kornel Dul=C4=99ba wrote:
> > > On Mon, Oct 30, 2023 at 8:31=E2=80=AFPM Adrian Hunter <adrian.hunter@=
intel.com> wrote:
> > >>
> > >> On 27/10/23 17:56, Kornel Dul=C4=99ba wrote:
> > >>> This fix addresses a stale task completion event issued right after=
 the
> > >>> CQE recovery. As it's a hardware issue the fix is done in form of a
> > >>> quirk.
> > >>>
> > >>> When error interrupt is received the driver runs recovery logic is =
run.
> > >>> It halts the controller, clears all pending tasks, and then re-enab=
les
> > >>> it. On some platforms a stale task completion event is observed,
> > >>> regardless of the CQHCI_CLEAR_ALL_TASKS bit being set.
> > >>>
> > >>> This results in either:
> > >>> a) Spurious TC completion event for an empty slot.
> > >>> b) Corrupted data being passed up the stack, as a result of prematu=
re
> > >>>    completion for a newly added task.
> > >>>
> > >>> To fix that re-enable the controller, clear task completion bits,
> > >>> interrupt status register and halt it again.
> > >>> This is done at the end of the recovery process, right before inter=
rupts
> > >>> are re-enabled.
> > >>>
> > >>> Signed-off-by: Kornel Dul=C4=99ba <korneld@chromium.org>
> > >>> ---
> > >>>  drivers/mmc/host/cqhci-core.c | 42 +++++++++++++++++++++++++++++++=
++++
> > >>>  drivers/mmc/host/cqhci.h      |  1 +
> > >>>  2 files changed, 43 insertions(+)
> > >>>
> > >>> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci=
-core.c
> > >>> index b3d7d6d8d654..e534222df90c 100644
> > >>> --- a/drivers/mmc/host/cqhci-core.c
> > >>> +++ b/drivers/mmc/host/cqhci-core.c
> > >>> @@ -1062,6 +1062,45 @@ static void cqhci_recover_mrqs(struct cqhci_=
host *cq_host)
> > >>>  /* CQHCI could be expected to clear it's internal state pretty qui=
ckly */
> > >>>  #define CQHCI_CLEAR_TIMEOUT          20
> > >>>
> > >>> +/*
> > >>> + * During CQE recovery all pending tasks are cleared from the
> > >>> + * controller and its state is being reset.
> > >>> + * On some platforms the controller sets a task completion bit for
> > >>> + * a stale(previously cleared) task right after being re-enabled.
> > >>> + * This results in a spurious interrupt at best and corrupted data
> > >>> + * being passed up the stack at worst. The latter happens when
> > >>> + * the driver enqueues a new request on the problematic task slot
> > >>> + * before the "spurious" task completion interrupt is handled.
> > >>> + * To fix it:
> > >>> + * 1. Re-enable controller by clearing the halt flag.
> > >>> + * 2. Clear interrupt status and the task completion register.
> > >>> + * 3. Halt the controller again to be consistent with quirkless lo=
gic.
> > >>> + *
> > >>> + * This assumes that there are no pending requests on the queue.
> > >>> + */
> > >>> +static void cqhci_quirk_clear_stale_tc(struct cqhci_host *cq_host)
> > >>> +{
> > >>> +     u32 reg;
> > >>> +
> > >>> +     WARN_ON(cq_host->qcnt);
> > >>> +     cqhci_writel(cq_host, 0, CQHCI_CTL);
> > >>> +     if ((cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)) {
> > >>> +             pr_err("%s: cqhci: CQE failed to exit halt state\n",
> > >>> +                     mmc_hostname(cq_host->mmc));
> > >>> +     }
> > >>> +     reg =3D cqhci_readl(cq_host, CQHCI_TCN);
> > >>> +     cqhci_writel(cq_host, reg, CQHCI_TCN);
> > >>> +     reg =3D cqhci_readl(cq_host, CQHCI_IS);
> > >>> +     cqhci_writel(cq_host, reg, CQHCI_IS);
> > >>> +
> > >>> +     /*
> > >>> +      * Halt the controller again.
> > >>> +      * This is only needed so that we're consistent across quirk
> > >>> +      * and quirkless logic.
> > >>> +      */
> > >>> +     cqhci_halt(cq_host->mmc, CQHCI_FINISH_HALT_TIMEOUT);
> > >>> +}
> > >>
> > >> Thanks a lot for tracking this down!
> > >>
> > >> It could be that the "un-halt" starts a task, so it would be
> > >> better to force the "clear" to work if possible, which
> > >> should be the case if CQE is disabled.
> > >>
> > >> Would you mind trying the code below?  Note the increased
> > >> CQHCI_START_HALT_TIMEOUT helps avoid trying to clear tasks
> > >> when CQE has not halted.
> > >
> > > I've run a quick test and it works just fine.
> >
> > Thank you!
> >
> > > Your approach looks better than what I proposed, since as you
> > > mentioned, doing it like this avoids some weird side effects, e.g. DM=
A
> > > to freed memory.
> > > Do you plan to include it in the other series that you posted yesterd=
ay?
> >
> > Yes I will do that
>
> Feel free to add "Tested-by: Kornel Dul=C4=99ba <korneld@chromium.org>" a=
nd
> maybe "Reported-by".

I do not want to be you advocate Kornel, but I think you earned a
Co-developed-by
That was a lot of work.
