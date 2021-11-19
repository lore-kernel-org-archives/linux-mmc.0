Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4B0C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Nov 2021 14:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF19610F8
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Nov 2021 14:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhKSOur (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbhKSOup (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Nov 2021 09:50:45 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83056C061574
        for <linux-mmc@vger.kernel.org>; Fri, 19 Nov 2021 06:47:43 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e8so10439389ilu.9
        for <linux-mmc@vger.kernel.org>; Fri, 19 Nov 2021 06:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vyHrv2e6pQ837gIoC8BixOvjhAdHd5SQTdTDSMN+sMQ=;
        b=VorNMrqVW0rCTRpxBcn/Mz3pOmkg4stpi6i2ckdhvPjav9sTulf5PD4uZWitqtGm76
         RL8Spsxw699cxk2nz7kl8OYwKMBO3qGP8Ly1hWm56pYTrlDuY5Op+LJiGghRAzlmKd5A
         vuCJ5KhDk157rNA/gniKW+9lPQZLtNQ2cbgv59KawLgQd8709kBpO6oEJEzU2ZY/y5t0
         E/+QZWL+TE8d/evdNoszlh9RtCVF+0DWCf0PDpm3g/gjb9Lc62l3fdooHUQcMYlZJBGp
         IrbwxLWPfbUigycW5x73rkF+Os/mFP28B2EOPTrZbWtZEBEIN/pP+ydcDX7tvpXB3+xM
         kdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vyHrv2e6pQ837gIoC8BixOvjhAdHd5SQTdTDSMN+sMQ=;
        b=VncsKaVX0zDbbOjDZDPl866FnTYzGqs99obfVC40aHqO9kiXxqNAHVHStduZE60SiO
         iyqH8FCVqjQQNXiZiUFS2gmmYHIcxWVQT7I4zjG8M3raBIzSp5TX16/OZE5AsJZknYpX
         Mow5P5h1dA0ak3XM71218vzlmre3iBQKwX/qSeXo3YcXul8cRIC2BrLIOdkYw+zvpRRT
         6dTBMJ3j0prj3yLGcW1BgIgELYUMF5RdZNOvSaCd48mwA3BWXjuBbBJVQqIbyG9LSptl
         Rvc53hpuE2R8ChUOS1C/eOdUSGcCrNI00K6pOlp5X70jjzcawSPI2wuqIzM0ZBfTt4sx
         14AQ==
X-Gm-Message-State: AOAM533l5Y27S/FavG8c548b9aYnXYqZQMuJ5ZB/9pVAA5EF0rn25t3y
        AW56wppBtbWiDQePprKjVd9wmzYtDtsOmGytEXMpmk5A7TAgK+yp
X-Google-Smtp-Source: ABdhPJyc6GxZjx4O5G8xY6rxfxnBMWvWjlUTjIVg7xGT/5br+rdh2ilLUTvehq4bQTXDDuw9Kxqr1PMZBOeWM6DAgVg=
X-Received: by 2002:a05:6e02:1a6d:: with SMTP id w13mr3729136ilv.165.1637333262650;
 Fri, 19 Nov 2021 06:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20211119111201.1823-1-marten.lindahl@axis.com>
In-Reply-To: <20211119111201.1823-1-marten.lindahl@axis.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 19 Nov 2021 06:47:31 -0800
Message-ID: <CAD=FV=WeM3sBHtwXNM_nreRPiCBhkOEnQ1g0xTp-6YCDaGB1Xw@mail.gmail.com>
Subject: Re: [PATCH v5] mmc: dw_mmc: Allow lower TMOUT value than maximum
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

On Fri, Nov 19, 2021 at 3:12 AM M=C3=A5rten Lindahl <marten.lindahl@axis.co=
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
> v5:
>  - Use u32 type for CPU reg access
>  - Make tmp 64bit to handle INT_MAX parameters
>
>  drivers/mmc/host/dw_mmc.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index d977f34f6b55..210252d33b95 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1283,6 +1283,33 @@ static void dw_mci_setup_bus(struct dw_mci_slot *s=
lot, bool force_clkinit)
>         mci_writel(host, CTYPE, (slot->ctype << slot->id));
>  }
>
> +static void dw_mci_set_data_timeout(struct dw_mci *host,
> +                                   unsigned int timeout_ns)
> +{
> +       u32 clk_div, tmout;
> +       unsigned long tmp;
> +
> +       clk_div =3D (mci_readl(host, CLKDIV) & 0xFF) * 2;
> +       if (clk_div =3D=3D 0)
> +               clk_div =3D 1;
> +
> +       tmp =3D DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz, NSEC_PER=
_SEC);
> +       tmp =3D DIV_ROUND_UP_ULL(tmp, clk_div);

Unfortunately I don't think "tmp" is always a 64-bit type (unsigned
long is only 32-bit on many devices). As per my response just now to
your v4, I'd be happy with going back to a normal DIV_ROUND_UP.
However, if you want to keep it extra safe and keep the _ULL version
then you should change tmp to "u64".

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
