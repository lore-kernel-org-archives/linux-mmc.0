Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A2EC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 14:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9860B63210
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 14:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhKOO6A (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 09:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhKOO5x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2021 09:57:53 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F22C061570
        for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2021 06:54:57 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id v15so36273884ljc.0
        for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2021 06:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UUAPWsnoiLM3vc2JZAav9FCp/mPIHeCjDkBEZi9UNbM=;
        b=XTtutu8LfP+yFqWXSfW2K3GmweHvKPYj8G1+hQ3jBp0XGIAX+OOGxUpyfIV3z/sRBy
         bw63UfNepZcBCGJAL86Arsu0WQxJPiMUOAoFqh7RP4jLmXf99yu+g/GS5iXMDWvKU4kR
         jQJkESY4y19hw8ewWIjUaET2M5RwTGavEoD7uDD5p4K4uncnuoRxQfQpKMDzj5dYPpeI
         HTBCtpFSJaCeqO9TsoweM2XGUGbj7kVnWqLBq72t2sMvBHB4f8ybyr4Ai99Bly+Tmfw4
         EJz3o4atKj1MEA+z0Qvw/vXAa+CFfTsU/nufHBwEDAhoH5HJC0YYKTwPHBAEZE89RUER
         f4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UUAPWsnoiLM3vc2JZAav9FCp/mPIHeCjDkBEZi9UNbM=;
        b=DovfBbdLrOdsV/AnME8IcxLIiX8h8Uk0Ft5edOh4GWv+pr0yRGa+FwrjkuEwhfThjC
         GMWC0G16BFTSKcF9GPsemUv7p23zh2fp/K/80lfGdKtmi/tSFU3yLjfDmCmNbmIuTW+g
         5zI35mXDA2xpITLVVGVGqJDBpCIzLLBvyUVo3FdtO9s2Uz/uuouYsorpeQaq2CSSlNqC
         pjV2z9AUR82ASMxUFbl4tiCcC7ydp8z7+IK557ZwL8VBZHUeSL/plyAyPxsVfxgJl8hs
         9kM/KDmKzPLUYsvCrz82Bp4nYpH54VWXCfO4dG1wqC7OMkPfNMaS2KXXYkkZGR+0nBXp
         xQIA==
X-Gm-Message-State: AOAM533w0DXIh7uSnxK6AnF6y0gTtAztMAn+kEu8SBzEbOIC5rrK5bqS
        NaAM6an8MsWmoz5ulX4pShYBbP4d/UGk4PMhgLDFm5wm81Y=
X-Google-Smtp-Source: ABdhPJy94na1Vg7LReOTUtAbBxos4LZgCJzL6h9qu8RN2NomuCPrUFehfr4wpPIqiBtjy6hdOXI08Q1V/RwakWTnEII=
X-Received: by 2002:a2e:a22a:: with SMTP id i10mr39273850ljm.16.1636988096023;
 Mon, 15 Nov 2021 06:54:56 -0800 (PST)
MIME-Version: 1.0
References: <20211110110500.4105-1-marten.lindahl@axis.com>
In-Reply-To: <20211110110500.4105-1-marten.lindahl@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Nov 2021 15:54:19 +0100
Message-ID: <CAPDyKFpKbKEePYyb1fQ_cxjtJS6JuF1qFKh2KKfXpM23nvkH+g@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: dw_mmc: Allow lower TMOUT value than maximum
To:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Doug Anderson <dianders@google.com>, kernel@axis.com,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 10 Nov 2021 at 12:05, M=C3=A5rten Lindahl <marten.lindahl@axis.com>=
 wrote:
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

Applied for next, thanks!

Kind regards
Uffe


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
> +}
> +
>  static void __dw_mci_start_request(struct dw_mci *host,
>                                    struct dw_mci_slot *slot,
>                                    struct mmc_command *cmd)
> @@ -1303,7 +1329,7 @@ static void __dw_mci_start_request(struct dw_mci *h=
ost,
>
>         data =3D cmd->data;
>         if (data) {
> -               mci_writel(host, TMOUT, 0xFFFFFFFF);
> +               dw_mci_set_data_timeout(host, data->timeout_ns);
>                 mci_writel(host, BYTCNT, data->blksz*data->blocks);
>                 mci_writel(host, BLKSIZ, data->blksz);
>         }
> --
> 2.20.1
>
