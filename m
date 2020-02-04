Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594A9C2D0B1
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 12:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7462084E
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 12:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pftp3HPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgBDMaM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 07:30:12 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35274 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgBDMaM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Feb 2020 07:30:12 -0500
Received: by mail-vk1-f195.google.com with SMTP id o187so5108294vka.2
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2020 04:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBxb8ipzgRQ+TPw0PfltDu/6A8Y/sJwOnRag8CswWiQ=;
        b=pftp3HPWFrzJ+nM082RVEP/3qxqGrCrrK63HgxZatNhHJMQt4swrhizc6zxRaMif/Y
         68MEqB/3xmL7bnMCXkIDVy1s70kEISAp7/DxndS64RxliiDeJaPayvbZTd7rLnsXUffI
         TcdQEwiuZykgI3odG8um786U0m7zR8BoZJ0TlGFCt6GLVe9AmffcCgYX8B1BPn1Tpv1i
         bkpWBCFGAQ7N6T+Jd2+etjSuts4n/eg+eq23HaSu41jbUJFTz8gVFBPQepZksDel2PSs
         G4L7fAtaKe7OJFSjENVVnY/4AiDGlxWs+x26QUfOdgTbnIc9xYPsQZXhgXxdS2TyPmlC
         uMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBxb8ipzgRQ+TPw0PfltDu/6A8Y/sJwOnRag8CswWiQ=;
        b=NH5w+svnXqH/BtymYHCRMwVa/cSSxJ5Xd3eZExrNOSzHVl5g6e6emo9dGiGTHQtngM
         cFFrASgK6Hi+0ZFqfLLBe4dOjjFZgJ6Cwd9kbVbGdN8Bkzu0MB3pJWuAU/7WrfCPV2b0
         fEB1WNBGHAo607a2Ytu9taGjZVoPI6dr9/G6JSJrW6z8W2jDcgWKzsQF5mgd0mwecUjz
         fCuH1CnnmS4xITcJfqbttm+T5d648Jzks5+Qg7i+2+gWRtyVsj8FTAyYNmGGQiVDWCIr
         Hs/tvcKjQ/VzIxyMxeXzaGVu2yhSQScp55lEtXlSOh5y14fcoKSgcc8Eh2aDSyt9LU8h
         41Ww==
X-Gm-Message-State: APjAAAVLO0RrsKkQARaCm8FSvOmp2YcrbR8f3LSZEKQntaK/n/Te95xV
        pl2nnBgO+TAXi2gWWR4kgfaqVkAgqx7lClHRGhV6tA==
X-Google-Smtp-Source: APXvYqxYGFqnJQo7zKASrHj0432bv9Emj2fu3sw1yKpzLrKSeqw4SjD1C/fS2qFnfju3rbOTUHqFJn5eaw1Ppq9t95c=
X-Received: by 2002:a1f:914b:: with SMTP id t72mr17403010vkd.101.1580819410057;
 Tue, 04 Feb 2020 04:30:10 -0800 (PST)
MIME-Version: 1.0
References: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
 <1579602095-30060-5-git-send-email-manish.narani@xilinx.com>
 <99fd3904-37fa-f070-f7ac-e1dcb5bf43de@intel.com> <0d7e7a44-91dc-baef-5dcf-4ff683e98581@xilinx.com>
In-Reply-To: <0d7e7a44-91dc-baef-5dcf-4ff683e98581@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Feb 2020 13:29:34 +0100
Message-ID: <CAPDyKFosDoABbHaoEtyay-uMKpq6QXsoby631gK-1f6iAS0mgg@mail.gmail.com>
Subject: Re: [PATCH 4/4] sdhci: arasan: Remove quirk for broken base clock
To:     Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, jolly.shah@xilinx.com,
        rajan.vaja@xilinx.com, nava.manne@xilinx.com,
        tejas.patel@xilinx.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 4 Feb 2020 at 12:42, Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 03. 02. 20 12:31, Adrian Hunter wrote:
> > On 21/01/20 12:21 pm, Manish Narani wrote:
> >> This patch removes quirk which indicates a broken base clock. This was
> >> making the kernel report wrong base clock of ~187MHz instead of 200MHz
> >> even as the measurement on the hardware was showing 200MHz.
> >>
> >> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> >> State: pending
> >
> > Huh?
>
> It shouldn't be here. It is internal patch labeling.
> Manish: Please send v2 with all lines you got and remove this above.

No need for a resend, I can fix this before applying, which will be
when rc1 is out.

>
> >
> > Otherwise:
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> These patches requires firmware changes. Feel free to take it directly
> via your tree. If you want me to take it via arm-soc tree please let me
> know.

Thanks, I pick them up via my mmc tree then.

Kind regards
Uffe
