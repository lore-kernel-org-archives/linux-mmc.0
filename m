Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5924EC3F68F
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 11:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7EA218AC
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 11:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zoiGWUQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgATL0Q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:26:16 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37059 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgATL0P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2020 06:26:15 -0500
Received: by mail-vs1-f66.google.com with SMTP id x18so18718630vsq.4
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jan 2020 03:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+QrjNjPG/DY5+TEdC5uJWY8ByCtGQfHlt+6TWxLSsd4=;
        b=zoiGWUQLncvGKY1aPONfIIVo9eJD/fSbxnAqre/srpx1AIsJDP8FjgE7e3GNOo6Av5
         /M2+iSTfyjh44HEBZLB41qjpf2AiUyagQS8CPwv9iImXbf9jDf7KiXWd3hfVZTZGgpkR
         QOW1jHlxTMAQE15YHuWbSuH5FF40TTvlEO/8TYyjJBOj+dAdF9AWDUwIdfRjDe1RWqDH
         CquW7dewJPQ9rbFJroufRB8QhV1RvqliTijL3g37FKxzWnbEWkXItiLMBCCgk9BFIAEL
         Vdg+5CMdnTkOXnAPyQS91moWacc2LqFV4mJsWT1mAjsWklRbdA4xUtD0hIBwh77YJGHZ
         hMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QrjNjPG/DY5+TEdC5uJWY8ByCtGQfHlt+6TWxLSsd4=;
        b=hAE2n7Lm/s+3baB3goyAnVNEhCEETMH+1JFqTW8z1bYWgttv+2xddU0/cYgffRfU4C
         naakUBWRrTAHx/SaDkMKB4AcSKJnxTwucmx4O0qua7vhj8ALPOQWtq6lFiqnLhVJ0Bd3
         iN1pXKMO5tKTDqK2q8dCVc0keEwmnJluWnPQT/6e/fm7d/QxWy7IDn5sBr8yaqjC0YyA
         o+k3on4AITOjjqNI7cbZVSYWomT6CZok/5mEV3sBPLtCH2ARXEcEzX3NQGo8inEKZtsA
         UfvNDZRj4hzjLvbWvAC45Lp4E6Cm/EQBC2zU9/D+y4OIetNjut8iTeToq3ACSW1Fqbon
         83Mw==
X-Gm-Message-State: APjAAAW1237bxDzEx80kGM2pDcR13IXdKm2A26Bog4kgc7j2fpB8rGmL
        cT01p4YcK6TUwQu/zOlWCMlWU4R8nQE+/NOUgrwd1lfQ
X-Google-Smtp-Source: APXvYqzPrS1MXcvEuqxBLO8sPjfn2RusFoIONf4AdpYQaWU83tRuO628KtI5n/YR1Uw5+lIy2J5gBsGl7ibfC9txULI=
X-Received: by 2002:a67:314e:: with SMTP id x75mr11583092vsx.35.1579519574713;
 Mon, 20 Jan 2020 03:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20200120031023.32482-1-zhang.chunyan@linaro.org>
 <20200120033223.897-1-zhang.chunyan@linaro.org> <65f7272c-ecea-03de-433b-21ba2e672d20@intel.com>
 <CAAfSe-vjmFGkK5Enj9Nj_qrERJbNQTLejpVL+JVJLG7tgNhT9w@mail.gmail.com>
In-Reply-To: <CAAfSe-vjmFGkK5Enj9Nj_qrERJbNQTLejpVL+JVJLG7tgNhT9w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Jan 2020 12:25:38 +0100
Message-ID: <CAPDyKFq0PnCwcjENc+SJvkFKsuC-iWMX0t6QNqdo89JEGGk-=w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: fix an issue of mixing different types
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Jan 2020 at 09:14, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> On Mon, 20 Jan 2020 at 15:15, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 20/01/20 5:32 am, Chunyan Zhang wrote:
> > > Fix an issue reported by sparse, since mixed types of parameters are
> > > used on calling dmaengine_prep_slave_sg().
> > >
> > > Fixes: 36e1da441fec (mmc: sdhci: add support for using external DMA devices)
> >
> > That commit number is only in next
>
> Ok, so should this line be removed?

Normally yes, because I may rebase my next branch.

However, at this point in time I am not planning for a rebase, so let's keep it.

>
> >
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> > > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> Thank you!
>
> Chunyan

[...]

Applied for next, thanks!

Kind regards
Uffe
