Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F86C433EF
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Nov 2021 00:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D9C61216
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Nov 2021 00:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhKFARm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Nov 2021 20:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhKFARm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Nov 2021 20:17:42 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC23C061570
        for <linux-mmc@vger.kernel.org>; Fri,  5 Nov 2021 17:15:01 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id e144so12596656iof.3
        for <linux-mmc@vger.kernel.org>; Fri, 05 Nov 2021 17:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZU+MzU0ZEDH7nSxRtRXuJGZABom3WhI1ZlmNx15F40s=;
        b=pY7qGbnHMRsCS3LAwxMklA5Z0DdTdBWQwi/36UmDXtuFJ/Yl0dK7WXROt2yGNguafQ
         VC3vXB+dmoPfxROqSeLglz6w7Fi4g1XEWQB5Gl6HFCsSHlJByDMQmyKRLBD4/EMZT5Ed
         LNpl3OKp+tAsUj048P5Rdz808XP14vJdIAGrIE3U6Q9TTY/8a5g6cdEYDdKUg3+pP2Q0
         lxrjPfamKfVWwerk6Tm5St5MpwzSr5tEAvtFKzhfg/g8gVoxbolNsnJ2l6oc9O6CHwP7
         QOv3Riij5ih9tGRTxExOB7YxuCkYBFBz9AXpoInidncHy7vSNrrr9iOAXfd3faFu7mB2
         qxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZU+MzU0ZEDH7nSxRtRXuJGZABom3WhI1ZlmNx15F40s=;
        b=P86zZuJzxbGIWpOM8xEizfFhoR+xUsqhL/oS+0LwqKTnDDZsvOpTi9MU4FTmq4jor9
         Ga2nTzypOlOT7YKM4xXTSAeFDXA1GQ43haPDnikjxYQXIUtNA33hW75ucFUes60VUtKr
         6WObJ5mgLilbt8GsQLnUficyYQAGuQWxPdRIwhtu2isEMIwoRpSVB2ToAbPIPy8d9AK1
         mEiNGGymLT9UMH4fyhNQXdeWxoRCi+GBZMWhKhvERKb2V8zHlwhE1zMUzzti441ju5uh
         mF1CDOqgKIBbTHxd1ifYN6AscBnrWes1klbb4hQ1y10p73aNWDbdtp9Y2zAdfKB2GF30
         +45Q==
X-Gm-Message-State: AOAM531zAAGw9bcKWXf9cDB8AEvN8k7/vUy2e4eW/GQNypI4P1y0mRx8
        711WQCaZtqwURdGElB1eEeo/VSR8TUcrIntRDH0E2g==
X-Google-Smtp-Source: ABdhPJz04yfZrGtLPM3XUhfJ8xkAu4uZTHrjAdncW1+QkWx2iRLZ/lyUwRAWNkbB0Oi46x89Q9Ejsy1sxE02gEvI4V0=
X-Received: by 2002:a6b:ee10:: with SMTP id i16mr1891810ioh.98.1636157700556;
 Fri, 05 Nov 2021 17:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211103152359.24699-1-marten.lindahl@axis.com>
In-Reply-To: <20211103152359.24699-1-marten.lindahl@axis.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 5 Nov 2021 17:14:48 -0700
Message-ID: <CAD=FV=WsSPcs3ggGWNp5J288B+TBoSYuY7JmEWDii05w4tTdgw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Allow lower TMOUT value than maximum
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

On Wed, Nov 3, 2021 at 8:24 AM M=C3=A5rten Lindahl <marten.lindahl@axis.com=
> wrote:
>
> The TMOUT register is always set with a full value for every transfer,
> which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds.
> Since the software dto_timer acts as a backup in cases when this timeout
> is not long enough, it is normally not a problem. But setting a full
> value makes it impossible to test shorter timeouts, when for example
> testing data read times on different SD cards.
>
> Add a function to set any value smaller than the maximum of 0xFFFFFF.
>
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6578cc64ae9e..0d23b8ed9403 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -54,6 +54,7 @@
>
>  #define DW_MCI_FREQ_MAX        200000000       /* unit: HZ */
>  #define DW_MCI_FREQ_MIN        100000          /* unit: HZ */
> +#define DW_MCI_DATA_TMOUT_NS_MAX       83886075
>
>  #define IDMAC_INT_CLR          (SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI =
| \
>                                  SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU=
 | \
> @@ -1283,6 +1284,32 @@ static void dw_mci_setup_bus(struct dw_mci_slot *s=
lot, bool force_clkinit)
>         mci_writel(host, CTYPE, (slot->ctype << slot->id));
>  }
>
> +static void dw_mci_set_data_timeout(struct dw_mci *host, u32 timeout_ns)

The type of "timeout_ns" should match `struct mmc_data`, which is
unsigned int, not u32.


> +{
> +       u32 timeout, freq_mhz, tmp, tmout;
> +
> +       if (!timeout_ns || timeout_ns > DW_MCI_DATA_TMOUT_NS_MAX) {
> +               /* Set maximum */
> +               tmout =3D 0xFFFFFFFF;
> +               goto tmout_done;
> +       }

I don't think that the above is right. If the card clock is 50 Hz
instead of 200 Hz then 0xffffffff is actually ~83 ms * 4 =3D ~332 ms. It
would be better to attempt to program it correctly.

Can you just do the math below and if the number is greater than can
be represented then you can just put in the max?

Interestingly enough, in `struct mmc_data` this is documented as a max
of 80 ms, though I don't think your code should care about that. Just
cap to the maximum value after your math.


> +       timeout =3D timeout_ns;
> +       freq_mhz =3D DIV_ROUND_UP(host->bus_hz, NSEC_PER_MSEC);
> +
> +       /* TMOUT[7:0] (RESPONSE_TIMEOUT) */
> +       tmout =3D 0xFF; /* Set maximum */
> +
> +       /* TMOUT[31:8] (DATA_TIMEOUT) */
> +       tmp =3D DIV_ROUND_UP_ULL((u64)timeout * freq_mhz, MSEC_PER_SEC);
> +       tmout |=3D (tmp & 0xFFFFFF) << 8;

Combining your two calculations, I guess you have:

tmp =3D timeout * (bus_hz / 1000000) / 1000

Why isn't this just:

tmp =3D (timeout * bus_hz) / 1000000000

Since you're doing 64-bit math anyway I don't think you need to worry
about that calculation overflowing. Multiplying two 32-bit numbers
can't exceed 64-bits, right?


Also: I think "bus_hz" is the wrong thing to be using here. You need
to take CLKDIV into account like dw_mci_set_drto() does.


-Doug
