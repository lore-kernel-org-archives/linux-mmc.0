Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83931C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 23:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6291461B3F
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 23:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbhKQXdE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Nov 2021 18:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbhKQXc7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2021 18:32:59 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444F8C061570
        for <linux-mmc@vger.kernel.org>; Wed, 17 Nov 2021 15:29:59 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id a15so1501591ilj.8
        for <linux-mmc@vger.kernel.org>; Wed, 17 Nov 2021 15:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DtcDFCZbcERHHSxWFXRQr28Y3mh0GMhw13+aKbu47TA=;
        b=Q+Ky95Jvj1lLrhhol1CQeQ6zUWp4cV/CHc3TOyLHj7DpUKwWNf5YgMJFvOy9y6pA/h
         9twUuTw8MJGee8mNKAhZf+5AWfKWwNWjNrf/GiUZpWdcZnWMdkeOCP3HeOCURq4sqGLp
         PlhdtCrt694GBBU2/4S7wiYeFKik3FfKEs2kS2YtlIhp33tQDZDiEdYLaJ/aYNTsnq6Q
         4yE+vD7yttdQT1t7qoJ886FRPUaE0v1fhkLmLWJpj4i3Kv50NqurwLHwt39cgbmXDqx2
         zDOb5mgMAAQYwBnHLR7dzQc641eyRnXE8JNqiIzXPlRNsxuIE/yGbl2SA4VzCARX5P+d
         0QcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DtcDFCZbcERHHSxWFXRQr28Y3mh0GMhw13+aKbu47TA=;
        b=Tdu/JS8zA3ztr0LLqTObytPayLTukw6lTbPEniTlxPNtT/mWiu5V3XQ3nvFVWyDV3T
         Bf4EtDQt9ywMqZqTV5UtSj+Wb70PPz2XTW5r4APw7l78blDMlNjYl8lKgHGbtwzfkCCS
         cZfckG2SbGNZWUYujQXbR7ZfC8PnWFLYcymVl5LJY+Rat6oC6FeRPOXerjhvQVUrYKsb
         5zIDBU04no+1OQZb+Hvqbuy7lSjFg4V1uHW8onArXNl2xS/7AFFZfn4LY6woXoBv5Uwq
         xrNCM46qbaP8wzEljoNnmO6z94owhuL0Fb6LUDgj0tiVOt1sFCuPgpQWyJvSWlpSYqWB
         QiGg==
X-Gm-Message-State: AOAM532he972BTjWi+RjlruzpfG15jG/XLJI5UQSehBltVBPj111j+6Z
        dxwOhoG/RTTFMeSdn2b5PGaN6O7kOy0Pqpbw4DT82Q==
X-Google-Smtp-Source: ABdhPJxB9+Ujn/PXWi/o+VzfIRdn1miuwOUm35QJMKaLE4ytdmVY01EQf5RlEUgVUSR1nNbFEhP958jP3BvGW+xm8xQ=
X-Received: by 2002:a05:6e02:1a67:: with SMTP id w7mr12368256ilv.165.1637191798270;
 Wed, 17 Nov 2021 15:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20211117160859.8732-1-marten.lindahl@axis.com>
In-Reply-To: <20211117160859.8732-1-marten.lindahl@axis.com>
From:   Doug Anderson <dianders@google.com>
Date:   Wed, 17 Nov 2021 15:29:46 -0800
Message-ID: <CAD=FV=WWF9W=cXQWkcvQAgXjGZjBzgvV3jB90nZ35JYdi8YA-w@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: dw_mmc: Allow lower TMOUT value than maximum
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

On Wed, Nov 17, 2021 at 8:09 AM M=C3=A5rten Lindahl <marten.lindahl@axis.co=
m> wrote:
>
> The TMOUT register is always set with a full value for every transfer,
> which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds.
> This is normally good enough to complete the request, but setting a full
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
> v4:
>  - Prevent 32bit divider overflow by splitting the operation
>  - Changed %06x to %#08x as suggested by Doug
>  - Rephrased commit msg as suggested by Doug
>
>  drivers/mmc/host/dw_mmc.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index d977f34f6b55..8e9d33e1b96c 100644
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

didn't notice before, but nit that I usually make it a policy that
things that represent cpu registers are the "sized" types. Thus I'd
rather see these locals as u32 even though the parameter (which
represents a logical value and not a CPU register) stays as "unsigned
int").


> +       clk_div =3D (mci_readl(host, CLKDIV) & 0xFF) * 2;
> +       if (clk_div =3D=3D 0)
> +               clk_div =3D 1;
> +
> +       tmp =3D DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz, NSEC_PER=
_SEC);
> +       tmp =3D DIV_ROUND_UP(tmp, clk_div);

I guess in some extreme cases you still have an overflow. Not sure how
many people really use "div", but...

The case I'm thinking of is if the timeout is 80 ms, the bus_hz is 200
MHz, and clk_div is 20 (register contains 10). I think that would mean
you're feeding the controller a 4GHz clock which it probably couldn't
_really_ handle, so maybe this isn't super realistic. In any case, I
think the first statement would be the equivalent of 80 * 200MHz =3D
0x3b9aca000 and that blows out the 32-bit "tmp" variable.

Why not just keep it as 64-bit until you're done dividing to be safe?

-Doug
