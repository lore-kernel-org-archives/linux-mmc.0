Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A2FC4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 May 2022 13:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbiEPN5i (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 May 2022 09:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244446AbiEPN40 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2022 09:56:26 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB0A3B2BC
        for <linux-mmc@vger.kernel.org>; Mon, 16 May 2022 06:55:57 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q130so18235115ljb.5
        for <linux-mmc@vger.kernel.org>; Mon, 16 May 2022 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MeiTmWKbfFkyUDAu36ZyhnVOygglTiIR0GOA0B1eY0c=;
        b=YSvJoVFPtG6bnfTeQxzBBXy77ERTEhTsg7XgRIV7EvSdREsTC+AE70ohYj7+FaK3bh
         OZ7sjzRe0LmR1tB7sIiFJ86bssbYh2hpR0Y+aNF/BknPMKa7voNiy1bXK6AW9VSd65yv
         v93gBe0NGiYn3Ng3ITfp5tpi4Zm9UD8CupDajz7yaQAyoxRnLxRhMZUdN71V296ixtDP
         dkyIm2FRzpKSi0w/RUH3Cd2tWDxZ+pd/bqglKQcNSg/Jn5paNs/SwNzOb+tRvGMX/LUe
         855GCPqwIABjYfRzwwNyEXTYySq0ebhv/pRlBayaA8U/7pAbULFuWXgIj151YCTknIOb
         X47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MeiTmWKbfFkyUDAu36ZyhnVOygglTiIR0GOA0B1eY0c=;
        b=jwT4J0AJqn0mJTARIvb0vlzIqVWixDDK9YCoiOcVx9gMLbbGw9WmuXIRQ7SY5w+Oiy
         pmv13A6t4EjvImaxxWpRUqMszZN1Jx0X1aO0wFeWKmtnY/3Di3z+ZVMXAbTbwE0qlvC+
         SS0eQTbabijzRaqWrFNU0VOA5rDB+nC1tC3DaUn2HVraNK9NyNQi7uYjBMb9UQyKNFWd
         I9Mh1/pqnh8WhjWFa2SJJl5GOWB+XgJEkJQhty0oIqH/yRImRDL0BAnKTLNL39DA+4GZ
         OJa486KjvwIPZLI/nxa0jJgPH3mMH/e93yXUOsMr+9WTaDjOm6HlCobkWut6TJk9YfF1
         dtPg==
X-Gm-Message-State: AOAM531yUiDKIejgLc3r9uVU8m0lMskgak/lnlSA/v9eTpDVSze7vfBi
        yLS4WscpiK3hRBYNLhJKg2ee05prizYu5VDa/bLcCK1kyeiK4Q==
X-Google-Smtp-Source: ABdhPJwZ6Em0eLu7RM1SxBb2WiY0uU1ovRh7DwLWOyrbGByueTpyFAw3U7b/oAPWL/x87mDro49Q7VbiwqbPhOi6nCM=
X-Received: by 2002:a2e:9e54:0:b0:250:d6c8:c2a6 with SMTP id
 g20-20020a2e9e54000000b00250d6c8c2a6mr11865448ljk.16.1652709355591; Mon, 16
 May 2022 06:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <1652339993-27280-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
In-Reply-To: <1652339993-27280-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 May 2022 15:55:18 +0200
Message-ID: <CAPDyKFoWdq+908f18Uz3TPj50M2eDiECC7iLU8UGGEuawCpo1w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add NULL check for data field
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com,
        saikrishna12468@gmail.com, sgoud@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 12 May 2022 at 09:20, Sai Krishna Potthuri
<lakshmi.sai.krishna.potthuri@xilinx.com> wrote:
>
> Add NULL check for data field retrieved from of_device_get_match_data()
> before dereferencing the data.
> Addresses-coverity: CID 305057:Dereference null return value (NULL_RETURNS)
>
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 6a2e5a468424..757801dfc308 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1577,6 +1577,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         const struct sdhci_arasan_of_data *data;
>
>         data = of_device_get_match_data(dev);
> +       if (!data)
> +               return -EINVAL;
> +
>         host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*sdhci_arasan));
>
>         if (IS_ERR(host))
> --
> 2.17.1
>
