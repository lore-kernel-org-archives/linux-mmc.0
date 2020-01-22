Return-Path: <SRS0=yZYV=3L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF81C33CAF
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 13:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A5B2071E
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 13:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P69vDtf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAVNg0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:36:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46253 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVNgZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2020 08:36:25 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so6621743edi.13;
        Wed, 22 Jan 2020 05:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPi4ROFzsj9v9Yx3fg182Uf1p3zkTl0Xvf77j31SJxw=;
        b=P69vDtf91B4HM/O3oFsfX2/LVUJ7YL0ol/zXhScdV8CW5lSOrViPcy7tmLzS+YfaZa
         Dq0qRlPCYfhg1cHeUuKEystP04xuF9APw1yeTnbApLPGPozh2/BQRWInCGMRZsdrkNbN
         ZUggkMe8zTZBy50n2xvLaywK4GZUsAYaX7Fn8ZKwe1YcH7SuV0rn8khurmzl/B1U8cSM
         VIMUuaOxfVH4eohvY6vf0Vz8SiErqehjuvp+Kf0ItQOBngf/mkKaBaD1WRyLMhVesHWk
         jc00XmmKdh4oZmWL/plV/ujY4knFUyDIdAQERWtSw8V6Uitr3twcDIeyoSVhA+/rpfC0
         wSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPi4ROFzsj9v9Yx3fg182Uf1p3zkTl0Xvf77j31SJxw=;
        b=E5MNgcreRNEzSkhKBgOK2BJK4afJfV7wlcirGl2TzRsQOpXmFw8zCQpnr4N2L1jmwY
         k5dXtPfA1I4r6TUzse5PXMnCqr4rTG+DFkKsM3Lv9u56QoogVY/a+Nn5MA7Twx0B9ieh
         byqILnWo4O4FR7EoMjz9M85cMCIqH4tBHh42RN7MmLV4vpknEgposCjXIgXss5gbKF2z
         sYYoUtvCF3lnWlYP+kz/gpnWuiMn7FBLlitJnmw4H/FAB3IFYuXlf3vz46OdK68x7CIG
         UHv2pCZ5tBoHeUsXB++pcgGDi4THD7IfB3tMgY6AvtwUDaCGEtRDVsx8qvtGZ5LE03zP
         n50A==
X-Gm-Message-State: APjAAAXDXjdUde3oBFhLanv7ixOLRVSUZuoMlkrCBGDkx0Zm7SymiO62
        CrFug8ZROn+DbyudyLjotf5X03vjK+k8gqTlKfU=
X-Google-Smtp-Source: APXvYqybpwJk49J6SOt3Kqbx+6+Q1Nsz5SCFEvvBnm/8ce9xFmLSeYtDL4RduJx+fNImMpRWBAtjAZgnAPncZErPaG0=
X-Received: by 2002:a17:906:3195:: with SMTP id 21mr2569283ejy.207.1579700183507;
 Wed, 22 Jan 2020 05:36:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578560282.git.benchuanggli@gmail.com> <CACT4zj9B8BSebZgf5-nc3zGYhsAGQ6gTRvfFf9r1DBB_mpRtHA@mail.gmail.com>
 <CAPDyKFpVN1w7sRbcSAOezVYAkq0pq6kCFo0gjT3TO4FVqDCe=A@mail.gmail.com>
In-Reply-To: <CAPDyKFpVN1w7sRbcSAOezVYAkq0pq6kCFo0gjT3TO4FVqDCe=A@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Wed, 22 Jan 2020 21:36:11 +0800
Message-ID: <CACT4zj9ecfB==BhN7fm=0AmK3Y08ey4_7SYXeAtUg-3fcGhL-w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] Add support UHS-II for GL9755
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 21, 2020 at 8:02 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 21 Jan 2020 at 10:37, Ben Chuang <benchuanggli@gmail.com> wrote:
> >
> > Hi Uffe and Adrian,
> >
> > On Thu, Jan 9, 2020 at 5:13 PM Ben Chuang <benchuanggli@gmail.com> wrote:
> > >
> > > Hi Uffe and Adrian,
> > >
> > > These patches support UHS-II and fix GL9755 UHS-II compatibility.
> > >
> > > The parts of UHS-II are based on [1][2] and porting to Linux 5.5-rc5.
> > > I have seen that Uffe comment that splitting the UHS-II parts into smaller
> > > patches. Other than splitting into small patches, could you give me some
> > > suggestions for refactoring/splitting files?
> > >
> > > Best regards,
> > > Ben
> >
> > Gentle Ping, Any comments?
>
> I coming to this, but I need some additional time. In any case, thanks
> for posting this and for pinging!
>
Thank you for taking the time and pinging back quickly. :-)
I will wait patiently for the next reply.

> [...]
>
> Kind regards
> Uffe

Best regards,
Ben
