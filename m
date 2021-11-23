Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9C4C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Nov 2021 19:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbhKWToL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhKWToK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Nov 2021 14:44:10 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECEEC061574
        for <linux-mmc@vger.kernel.org>; Tue, 23 Nov 2021 11:41:02 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m27so730632lfj.12
        for <linux-mmc@vger.kernel.org>; Tue, 23 Nov 2021 11:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JVDHi0leLa3tR6MyaGMKNAgXUzJaQfccRWXCKJgel14=;
        b=Vecn+r/eOzhRF2WzqenNn4zQTVh5v2W19Gg8y4d/533OxOQxTIzySB3yE6kR/BgNPj
         aSJYB1HLgGsH7IPXwksOAAQN2qNCh5aGpem03tesK9N6MSD7zyNnlnA+DLMV/XZ0b5Ev
         lN64WupSiLIqXT8EbLbTiVP1H3HGiFdbUvDWgZF4PUVEoSHCA/TpHCo1FukLVSD6T/Sa
         6IlfUWejYcPpL+HXD25mEHk4HAqyUFm8bkC7p9XiLL0j/grcYtQc/09YemCBETmQOSdo
         Ru+AuumVM2mWyUrEk25WRsw2TzLJeHoCOz0rb/dTVfPJxZAfRCM2ggPpnNCEGWjPpuMK
         Julw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JVDHi0leLa3tR6MyaGMKNAgXUzJaQfccRWXCKJgel14=;
        b=JyFa2xe5xJzFuaCMf5HTxdbitM5pJvXZgQWDssKU5CAOeUONexh6iSNd57JQ8RE0dg
         8oVAUH+ZFM3CAGwvEzvutV66h/a6L5pOGHtxhuBdrSwbtDpfDnVBi6aLs3+Pkdqc7/eW
         5VI/iaN1P8HA2zzQieuO8zh7FBCth8PIEFPzyXqqkN8dwluNnFl+pnA0yXWDRhMTIViD
         ef34xmXKjevih/AYo6bmAsi9sRX6VWIS/b7AmIpbiPb3tQm/Soq3YTqmIPDg/9GD7832
         5t2U3lCZjx67Mc9Relj9UmADaiChlJtuqYrH86oUZE5bfN8uI5vAH3QkRBMfZFqZlwvu
         g8EQ==
X-Gm-Message-State: AOAM532wsRrcmSCH33UWwJdMHTNs5Eiocw3YVBQF28BZYB4HkZceRTar
        bKKdDfIwnGV5KQPanvPIFPsJTRlsxWVxD+EO/tsCog==
X-Google-Smtp-Source: ABdhPJw9lHTL+F8I+tH4dgc7ITl9ZJv/KEduWqmIgsQgzoQRAmOFudTjc6eNZsusURtFc4beiTMylwY1wENk23nyFXA=
X-Received: by 2002:ac2:5607:: with SMTP id v7mr7562929lfd.71.1637696460348;
 Tue, 23 Nov 2021 11:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20211119155337.14341-1-marten.lindahl@axis.com>
In-Reply-To: <20211119155337.14341-1-marten.lindahl@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Nov 2021 20:40:24 +0100
Message-ID: <CAPDyKFoRmRuFRd4ZubkwkPCPuT1zAbx_YFqPm5iV4zyv8REg6w@mail.gmail.com>
Subject: Re: [PATCH v6] mmc: dw_mmc: Allow lower TMOUT value than maximum
To:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Doug Anderson <dianders@google.com>, kernel@axis.com,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 19 Nov 2021 at 16:53, M=C3=A5rten Lindahl <marten.lindahl@axis.com>=
 wrote:
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
> v4:
>  - Prevent 32bit divider overflow by splitting the operation
>  - Changed %06x to %#08x as suggested by Doug
>  - Rephrased commit msg as suggested by Doug
>
> v5:
>  - Use u32 type for CPU reg access
>  - Make tmp 64bit to handle INT_MAX parameters
>
> v6:
>  - Use u64 type for tmp
>
>  drivers/mmc/host/dw_mmc.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index d977f34f6b55..f310d9438dff 100644
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
> +       u64 tmp;
> +
> +       clk_div =3D (mci_readl(host, CLKDIV) & 0xFF) * 2;
> +       if (clk_div =3D=3D 0)
> +               clk_div =3D 1;
> +
> +       tmp =3D DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz, NSEC_PER=
_SEC);
> +       tmp =3D DIV_ROUND_UP_ULL(tmp, clk_div);
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
> +       dev_dbg(host->dev, "timeout_ns: %u =3D> TMOUT[31:8]: 0x%#08x",
> +               timeout_ns, tmout >> 8);
> +}
> +
>  static void __dw_mci_start_request(struct dw_mci *host,
>                                    struct dw_mci_slot *slot,
>                                    struct mmc_command *cmd)
> @@ -1303,7 +1330,7 @@ static void __dw_mci_start_request(struct dw_mci *h=
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
