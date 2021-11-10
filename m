Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55231C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Nov 2021 16:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6C760FD8
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Nov 2021 16:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbhKJQPh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Nov 2021 11:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhKJQPh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2021 11:15:37 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1252C061764
        for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2021 08:12:49 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i11so3010026ilv.13
        for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2021 08:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pEJ/SCrJjaume2dLUSw04eQWyt8/jEs361CV5IViq10=;
        b=AuKKXdU9F9WRWcUPjMHAXVmID8HXlRZPMR3sCmtvpqm/SMfGzrpCDvrOG1hH7+642N
         M7A7ZKcSAL3KMjTwywNoBFApzfDloiF2T6Aufo71jcpvagaoYZC4XWxwQYldjt+29Mtg
         ZJidKmhNkODeLTAh0f33EM2A8yJgM0hRoWkbUNIAJ2mzDXz8KyeN8andV8XA8ShKBYp7
         CAMzFTTjALRLlbL10O1KQ9vDH7+GjZhUmKp5UbWqWoAzWoIpXq67Gdc+czsqBwAzJjyY
         UdWHR/2DILxJYj9jNwjkc+EpJcfw4ZgIbffPkTM8eVXpfwrYGoCqM2lL1kPdXPAVMepv
         0h/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pEJ/SCrJjaume2dLUSw04eQWyt8/jEs361CV5IViq10=;
        b=VAWo3e3TBPTvI6O6fLp5hNEiUvhfvcaawpaBcOB5n2PByXMn5t4hdsoLFLKFF91EB8
         O0TIXgwI75YJ5Bnv79VjZcSqLeNMY6B6e9vWxUqzoC5zA03Z5e/3S2OUAL2JK5KZrrrI
         6AfV8HlIfbampVDNyaSKmuh6448VpmxRTGCMR7Be1M3+ROIKuvyeePXIZCdIrKMFFi2r
         /AgF99ywyqN5GvBeYm1g4ypHE+qyfJSInfA4npqsElDE6fHrcZ/a/B4Ik7Vvskr/Jdug
         CNznrssyyM2ambkyzgYZmF5YXwTYQY8eFANd5BGtjNHTgTtDOrozVhuiskxQwQruGs52
         a6ww==
X-Gm-Message-State: AOAM530KQeOqOuICMZX71N1Id46+/5Hhx9In9H5e3zDQD9AFYPNI2SJa
        hSGYeK3Ws+OgnMZe63QnL44tMc2ul1Vze+Oi8deDZw==
X-Google-Smtp-Source: ABdhPJwSPxrY1l2fjs45by1JxOV+m/QC7W8ftGdEBCIu5Gsp7Pxop2hlXpQDFbqrDQOj4QATBMCW7VlXomFZIlrNVOo=
X-Received: by 2002:a05:6e02:1a67:: with SMTP id w7mr103719ilv.165.1636560768898;
 Wed, 10 Nov 2021 08:12:48 -0800 (PST)
MIME-Version: 1.0
References: <20211110110500.4105-1-marten.lindahl@axis.com>
In-Reply-To: <20211110110500.4105-1-marten.lindahl@axis.com>
From:   Doug Anderson <dianders@google.com>
Date:   Wed, 10 Nov 2021 08:12:36 -0800
Message-ID: <CAD=FV=U6k=nTpYS8NCBfQvu-PT7TBJDPFggUBugX5L1K5Xzryw@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: dw_mmc: Allow lower TMOUT value than maximum
To:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@axis.com,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,


On Wed, Nov 10, 2021 at 3:05 AM M=C3=A5rten Lindahl <marten.lindahl@axis.co=
m> wrote:
>
> The TMOUT register is always set with a full value for every transfer,
> which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds.
> Since the software dto_timer acts as a backup in cases when this timeout
> is not long enough, it is normally not a problem.

I'm not 100% sure about what the part about "the software dto_timer
acts as a backup in cases when this timeout is not long enough" means.
At the moment the software fallback should be set to the same as the
hardware value, right? So the software backup doesn't help make the
timeout longer...


> But setting a full
> value makes it impossible to test shorter timeouts, when for example
> testing data read times on different SD cards.
>
> Add a function to set any value smaller than the maximum of 0xFFFFFF.
>
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
> ---
>
> v2:
>  - Calculate new value before checking boundaries
>  - Include CLKDIV register to get proper value
>
> v3:
>  - Use 'if-else' instead of 'goto'
>  - Don't touch response field when maximize data field
>
>  drivers/mmc/host/dw_mmc.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6578cc64ae9e..637ae2aea9fa 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1283,6 +1283,32 @@ static void dw_mci_setup_bus(struct dw_mci_slot *s=
lot, bool force_clkinit)
>         mci_writel(host, CTYPE, (slot->ctype << slot->id));
>  }
>
> +static void dw_mci_set_data_timeout(struct dw_mci *host,
> +                                   unsigned int timeout_ns)
> +{
> +       unsigned int clk_div, tmp, tmout;
> +
> +       clk_div =3D (mci_readl(host, CLKDIV) & 0xFF) * 2;
> +       if (clk_div =3D=3D 0)
> +               clk_div =3D 1;
> +
> +       tmp =3D DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz,
> +                              NSEC_PER_SEC * clk_div);
> +
> +       /* TMOUT[7:0] (RESPONSE_TIMEOUT) */
> +       tmout =3D 0xFF; /* Set maximum */
> +
> +       /* TMOUT[31:8] (DATA_TIMEOUT) */
> +       if (!tmp || tmp > 0xFFFFFF)
> +               tmout |=3D (0xFFFFFF << 8);
> +       else
> +               tmout |=3D (tmp & 0xFFFFFF) << 8;
> +
> +       mci_writel(host, TMOUT, tmout);
> +       dev_dbg(host->dev, "timeout_ns: %u =3D> TMOUT[31:8]: 0x%06x",
> +               timeout_ns, tmout >> 8);

nit: In theory 0x%06x is slightly better written as %#08x. I wouldn't
spin the patch just for that, though.

In any case, I think this is fine to the best of my knowledge of how
this timeout is supposed to work, so I'm happy with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
