Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D09C4332F
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Nov 2023 14:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjKFOlX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Nov 2023 09:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjKFOlW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Nov 2023 09:41:22 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C03F3
        for <linux-mmc@vger.kernel.org>; Mon,  6 Nov 2023 06:41:19 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5afa5dbc378so48311767b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 06 Nov 2023 06:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699281679; x=1699886479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHhRL6E1QTK6GLqibFGgeqG7BAAsKilb8/i8BJs0LwY=;
        b=V/+nwwXufVLEkbfBABifJhLKD/ftO9qvmXX24Ic4wvfuMDJd8qwJnQLZhqeF2ApkD9
         WY+msP6dSBFfnaVKg1kzHXCadD8ZqdRmCk6Mh+Lz0cShZWipbVwKC3DTAt8udg+bsaR/
         NqSk5QdFHkNTrCYLVWON9hnqOGbGwGbFpn4t3qisZu6R63mKHe3OmdX5/NjwnpRSSH4o
         Se6qaJ2laYjQiKXEhvb/kQ0heyBQmcN9X2hB/7xXk2/hS+PhdAFpcEqCzD6EJo/TP3HO
         alMEp/K4zg88T7VxoXX1Hr4JP9Jh7/WTmsbJ6zv8eb8wnc2KCx67ERhC3IsjunsUeCrr
         KZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281679; x=1699886479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHhRL6E1QTK6GLqibFGgeqG7BAAsKilb8/i8BJs0LwY=;
        b=B+j+ITvMoONPENxX+b+NHwu4JNcDR5cts4ySfKBy9JM0QVrlty9VmANY0tLLW2Fiw/
         P/9DjerNCCvXNC4KcPKuaku3O7IQvYCiiLnP0ITGkzvq3JnWZNASOh09gpAb+txQ/iVy
         IVauiiLEHv2scIVU03+F6CuQidrvYc1rZ3wX+KJLumdvjf+Fn1T0aH2dG9Y9j/XMtwr+
         XnjnWgNoBK6fMP5HzDEyzjNpdCJtMqd4j02Bucz2GwTjJDGYuykRMgobtUVcl7Nj5gzZ
         zcjWztHeJX4E6U5VaE4npGl61Vf2YXzHtNww9N50kncKUBAFX4KQmTETeUdV1xW+OTIM
         J6Jw==
X-Gm-Message-State: AOJu0Yyb+gagVDBeMaNqVpZb1vJGcK5BbNUZTvryUohZBvSpkZKuhX7n
        8RkrXHnOH/YfBnpWnXM2pDVYqUFo/2MI9tViCSEnCg==
X-Google-Smtp-Source: AGHT+IHuK9urmXNM4I6o8s8Xi8/q3iaCHfOaciV+yWn+XgKe+tUw+ppiaxjedpMQtWoZzWyTKLYCMn70PbXAJfFYtGQ=
X-Received: by 2002:a05:690c:dc5:b0:5a7:b9b1:c0c5 with SMTP id
 db5-20020a05690c0dc500b005a7b9b1c0c5mr9584194ywb.3.1699281677720; Mon, 06 Nov
 2023 06:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20231018103337.34622-1-victorshihgli@gmail.com>
 <CAK00qKBH5P3naXUHhbQ3zgMzQrUxy=v8r84a8RCcdNORVoRPkA@mail.gmail.com>
 <CAPDyKFob14Tc4c0UxRfj2qbXJkDn7NRwNwRuYQ6m9t3c27Kp=Q@mail.gmail.com> <CAK00qKDvdDBJ9zrBh=9anCArOZUis8-kE5bRx=owjD_pe4ZDCg@mail.gmail.com>
In-Reply-To: <CAK00qKDvdDBJ9zrBh=9anCArOZUis8-kE5bRx=owjD_pe4ZDCg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Nov 2023 15:40:41 +0100
Message-ID: <CAPDyKFo4t8+8gW_3y3WpQphVcJG0RGF+TkWG79NA4NCW_eTHRA@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer
 timeout of AER
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        SeanHY.Chen@genesyslogic.com.tw, kai.heng.feng@canonical.com,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 6 Nov 2023 at 09:56, Victor Shih <victorshihgli@gmail.com> wrote:
>
> On Fri, Nov 3, 2023 at 6:28=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > On Fri, 3 Nov 2023 at 11:13, Victor Shih <victorshihgli@gmail.com> wrot=
e:
> > >
> > > Hi, Ulf
> > >
> > > Please help review this patch and give me some advice.
> > > I look forward to your reply.
> > >
> > > Thanks, Victor Shih
> >
> > I don't have in-depth knowledge of how to properly solve this for pci,
> > so I am relying on Kai and others to help review.
> >
>
> Hi, Ulf
>
> This is a standalone patch, this patch only solves the warning
> messages that will
>  often appear in the system log when the system accesses the GL975x PCI c=
onfig.
>
> As I discussed with Kai-Heng at the end of
> [V1] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer timeout of AER,
> Kai-Heng will be submitting a patch for the PCIe layer to solve the
> situation he encountered.
> I will also help Kai-Heng test when he submits the patch.
>
> Thanks, Victor Shih

Hi Victor,

I was just about to apply the patch for my fixes branch, when I
realized that it would be better to split it up in two patches. One
patch for GL9755 and another for GL9750.

In this way we can easier manage the back-porting to older stable kernels.

The patch for GL9755 should have the below fixes tag:
Fixes: 36ed2fd32b2c ("mmc: sdhci-pci-gli: A workaround to allow GL9755
to enter ASPM L1.2")

The patch for GL9750 should have the below fixes tag:
Fixes: d7133797e9e1 ("mmc: sdhci-pci-gli: A workaround to allow GL9750
to enter ASPM L1.2")

I think you should feel free to keep Adrian's and Kai's acks for both
of the two new patches, as the end result should end up being the
same.

[...]

Kind regards
Uffe
