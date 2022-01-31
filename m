Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE5CC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Jan 2022 15:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377698AbiAaPqP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Jan 2022 10:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350284AbiAaPqO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jan 2022 10:46:14 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8797C061714
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2022 07:46:13 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id z4so27726190lft.3
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2022 07:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RRqSJJn09Nz7vur4CDO+wfsgCCFJSKAUUo5VMt5QBo=;
        b=o+HrXbzs0dBDHEZpU0ICK1TFCor6ztr1/jZCjYXTmEOVanZ2Q01NNuWJgw+xxFG2+3
         YIzUEnf1CC4FnBlMZ+KS3qMUup2Kd1kf1NGYCmGVVNMAL/ELy5+Arump/fwrqbYCHmFV
         gF7dWR9KGVS6WjyjnVez27yGExs1iJ0eVWXtL9DjfZSlTv+mwuMN8AOPxUisS+TEaCYP
         6fdfrA6Y0UWGmPzM3W9s2PnF+OKBAzTk8wjj7I/yw95N7kNVTsuL6xYr96+aT5Kklnm3
         uG4VY+tfBr9x2wC3OJYS1H853NdC+AcIhdM1ZjCxOckcThU+J0HajSyGcYZsXa87aMBQ
         dYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RRqSJJn09Nz7vur4CDO+wfsgCCFJSKAUUo5VMt5QBo=;
        b=JQV4/iKwG4HXvFli95OGbcpxuIJxAq8ovUM41hQv9ZeW86Aa0crAyZHDMcm89ZktFB
         6nnE6RmYS7Uscrqipnf9/ar+o3fnYvM+uXW6TUw1Vo5aLIxWKnbLWTmm0Pliw9rWqgGL
         5gLRRqOxR/6GyjdTAAR03pXxByGRV6/+5E7TgFikfoGZRNwJvnip+pJ2L2M9+G9m7u1t
         vbG2VaaHaqRg/jxo/jH3TVyEr9ooRwXJUeRZitskKfz7ufb+xlIZrCCnHinButT3zUW2
         OQaRZ2kMdoWuSDI+68OsX1TbnubXNm3I7GqkkAWo5BoPz/4L4YnTjszUnlInymr+vjuX
         YypA==
X-Gm-Message-State: AOAM531DqbBgkDqciWJgaW+tJSnvhpCA0E46CKLXjADrY4ZZ5GkXNx44
        BrFyhPTOaJTH3fTq/L8ABDrihjBn95PwQ/7V5deRWw==
X-Google-Smtp-Source: ABdhPJwP7VR1T0E9THzLZcEhqU9tJdN2MvSRg+Efi9ua8Zp7Lq5q0wg8SnZJLM/f4/yku7Fs71T6U8MLZx+GdWY7xZc=
X-Received: by 2002:ac2:5f71:: with SMTP id c17mr15676613lfc.167.1643643971878;
 Mon, 31 Jan 2022 07:46:11 -0800 (PST)
MIME-Version: 1.0
References: <CAGETcx_4ATDk3nNfu6kBwUVN4nfxcHHUMnCKYsLTDoA1TFLmrw@mail.gmail.com>
In-Reply-To: <CAGETcx_4ATDk3nNfu6kBwUVN4nfxcHHUMnCKYsLTDoA1TFLmrw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 31 Jan 2022 16:45:35 +0100
Message-ID: <CAPDyKFqUiydk3hHiKZ92e-W2tC4yv-XhGSz20KYYsTuZu0rWuQ@mail.gmail.com>
Subject: Re: Relation between MMC_CAP_WAIT_WHILE_BUSY and card_busy()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 26 Jan 2022 at 04:46, Saravana Kannan <saravanak@google.com> wrote:
>
> I'm trying to understand the MMC suspend path a bit.
>
> I looked at the commit message of 6fa79651cc808f68db6f6f297be5a950ccd5dffb.
>
> IIUC, if MMC_CAP_WAIT_WHILE_BUSY is set then the mmc framework is
> going to depend on the card_busy() op to ensure correctness instead of
> using the S_A_TIMEOUT value from the card.

MMC_CAP_WAIT_WHILE_BUSY indicates whether the mmc controller supports
IRQ based busy detection completion. In other words, the mmc host
driver can receive an IRQ when busy signaling is completed on DAT0 by
the eMMC card.

However, to avoid waiting for the IRQ forever, there is a maximum
timeout that is specified by the mmc core, for the particular command
in question. For eMMC sleep, the S_A_TIMEOUT.

>
> But I see a lot of mmc host drivers that implement card_busy() but
> don't set the MMC_CAP_WAIT_WHILE_BUSY flag. That doesn't seem right to
> me if my understanding is correct.

That's perfectly okay. MMC_CAP_WAIT_WHILE_BUSY is IRQ based, while the
->card_busy() ops is used to poll for busy completion.

>
> If it's supposed to be "we'll use card_busy() if
> MMC_CAP_WAIT_WHILE_BUSY isn't set", then why do we have some mmc host
> drivers that have both?
>
> What am I misunderstanding?

There are some additional complexity for the corresponding code. This
has mostly ended up there because we also need to deal with mmc
controller's HW limitations around this feature.

For example, some mmc controllers have a HW limit for the length of
the timeout that can be set. If the needed timeout is longer than what
can be supported, we can't use IRQ based busy completion.

Did this make it more clear?

>
> -Saravana

Kind regards
Uffe
