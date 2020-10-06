Return-Path: <SRS0=uM1y=DN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C40C41604
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Oct 2020 09:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11AE206B5
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Oct 2020 09:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5Rh3Gsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgJFJkq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Oct 2020 05:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgJFJkp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Oct 2020 05:40:45 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D86C0613D1
        for <linux-mmc@vger.kernel.org>; Tue,  6 Oct 2020 02:40:45 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id x26so2608776uan.11
        for <linux-mmc@vger.kernel.org>; Tue, 06 Oct 2020 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5nhSGxhA9uz8Ft9GREAxCtZHHJmDvOkIBqfBZxSQUQc=;
        b=d5Rh3GsqWVOEsSGIgUUTyAjJm0P+Wv5GQFJEDL9MxmaZsXdGAh4nwLV/vq3skzIrtS
         IEcL2ssPSpMYtDh2mLiuMki+RTteGfFxqdNCsf4pVGZVMUht62qfstbEUyARHsGiq9qc
         O7MUSE9Xx1eZGoWPC5kQGd7Pbd7zF4z0XbF/7uo8tcFQ+umpF12cVtKvBDqD7JarEu10
         ICabh3VWw/DNvXm3zbzsRjbSfZ6r9gHAwmHdceBj43gJXPRkqEMUxV59n1mz4rD1whDJ
         YyPEDfbdf+xVBQ7kaLq7jGeKZs9Eb4MKFoKp1DEc7QhrIKMYmMcbDr/5HjGNz+I7vQ4v
         7ZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nhSGxhA9uz8Ft9GREAxCtZHHJmDvOkIBqfBZxSQUQc=;
        b=WyCQeQONZPw6pq1wGRDzIrxuI10gc2HLhLJW49ClMz96YdCbPlVhRoKdGKlLNDcMQA
         ASfxilJjYzKg3V+GB+KGZRY6WVP1DUXt+PCBwD72NybibqNtToSt9KGyeclTyK2SGMU1
         YY1cMrlFmhJz/TVOZ/9MrH9cFpksg4baHWpq26LLcfgpqpzIqRxcYGns8BYTYvWAF0v5
         1KD+dUOQaWAhq7F1I7FPy0OnYCVpqlN3fBFq5KR9OxReTsjfUl7h5h5zWoTjyyKy6glR
         YiFu7pssEw2NHvip9RnkLfFWbjIiBfpo+jU31KU9zgCkFi5D5s2zPonb8vGPkSM68KFO
         E5rw==
X-Gm-Message-State: AOAM530IW3tDhIGaHgOY4nJUhp3Jozq75pI/8PmcKbatwIoAnnoqd5HG
        zBmBfUM5eyhSAD9JjU9qjP7fk9Hpd4gPNCVVk20JUg==
X-Google-Smtp-Source: ABdhPJz8GNHGQQrwmDU+lxhCe8cW0kMkvGFg2+wKVFRUzdvFpcGjkxvcQ7MEfy6BW6qrau4zs5Sr5AbdQa1mp7qXnbc=
X-Received: by 2002:a9f:21ce:: with SMTP id 72mr510048uac.129.1601977244664;
 Tue, 06 Oct 2020 02:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200928154718.1.Icc21d4b2f354e83e26e57e270dc952f5fe0b0a40@changeid>
 <20200928154718.2.Ic6b6031366f090393d00a53fd69e1ada31ceb29e@changeid> <CAPDyKFrVtz29w=gONGO8_sGDQU-ZSXH2NyMuwRL7-27ae=jt_A@mail.gmail.com>
In-Reply-To: <CAPDyKFrVtz29w=gONGO8_sGDQU-ZSXH2NyMuwRL7-27ae=jt_A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 6 Oct 2020 11:40:08 +0200
Message-ID: <CAPDyKFqdnRoFseNsy+FhT+xWw+3ni9hiQgSq4gRmo=n8nP8xhA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-acpi: AMDI0040: Allow changing HS200/HS400
 driver strength
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, Shirish.S@amd.com,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Wang, Chris" <chris.wang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 5 Oct 2020 at 14:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 28 Sep 2020 at 23:59, Raul E Rangel <rrangel@chromium.org> wrote:
> >
> > This change will allow platform designers better control over signal
> > integrity by allowing them to tune the HS200 and HS400 driver strengths.
> >
> > The driver strength was previously hard coded to A to solve boot
> > problems with certain platforms. This driver strength does not
> > universally apply to all platforms so we need a knob to adjust it.
> >
> > All older platforms currently have the SDR104 preset hard coded to A in
> > the firmware. This means that switching from the hard coded value in
> > the kernel to reading the SDR104 preset is a no-op for these platforms.
> > Newer platforms will have properly set presets. So this change will
> > support both new and old platforms.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
>
> Applied for next, thanks!

Turned out that this doesn't build, hence I am dropping it from my
next branch. Please submit a new version.

[...]

Kind regards
Uffe
