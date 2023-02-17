Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75C7C636D4
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Feb 2023 10:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBQKtG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Feb 2023 05:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjBQKtF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2023 05:49:05 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D467CB454
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 02:48:38 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id e1so456913pgu.6
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 02:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676630915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dF9wSEnG/pmDi0OCoUdB59pDnnwR7ktou0i6CnZGcss=;
        b=XNcOCdRPlUBDkS9BuZrMFmRNlt0v9NkGEVPQRhipDqIiHiXlav4XsiPkGLkbOg7QNf
         0ArOCNqExS/98VguhV/rFgZvk1WyhbYtSM1YE7inAjJ29HxT0QCF5R7h5buzZmjXPhk0
         vcwWf7cGv/NG7fsLTwkSZeCh7sve9+kKmcmLXT2S215PZNzx12cw84+uGhAva7WEKlqo
         bfmJ1EIFI3xUrsKSRb13AAAuCjnTcpTmq2WsLvsGiFGVoYzyF+qxlQB7OA6wfTbbNFil
         JcpnjcZJeSo8rWG6a7fAvsyJnTyITKDKiRpc9BTgVMoi30MbPTYczncLyKM9Y5aaaBZs
         Kz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676630915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dF9wSEnG/pmDi0OCoUdB59pDnnwR7ktou0i6CnZGcss=;
        b=ATQJ8ASIwdvzeNbXKPJQ8e+E5ehe8X1DTG1j0EvrHeKrNVV8C159W8+tLxXdJyPTZP
         67fcBBDoScAj+ioKuUjpLezdXMKXMGSBsfq86S6Qg8QZJHP0yM0xD1cWSO9vipk/7YYu
         3MtJD0eMYED1RZAof0PvmV0YO/4AckCDlgVj23mjJ5c4rxcgD6OHDKr5PZPzHaypAQ3t
         qAGu8t+0kW6ZmkK1Pky4/2YQvND00KC2SPhu90UGGwXgy7H6ukY4c9WTgEwKQkKm1G1K
         ja7Re6Py3s2aCcghsrcFZQ9fGvGy9ln6IZZeFpsUJzjzibDCz2+9NPumB1rsQZpptLwg
         aUwA==
X-Gm-Message-State: AO0yUKUNiDB7DbjjR9ZnnsYVA/yTE48ID4qvDmEkvAkyGPwl72bqbZRN
        wVtL/NXakUhW9UJjNahQCZvxnt3l4+N84eyIVfeDjQ==
X-Google-Smtp-Source: AK7set9FzbxOqH5midfBwv8pE9z9p0qY6hnqhEYjUEOxExFohj/9qD7nGH42u0m45DFwSi3Z2IHgC+QdZ/yUe4clls4=
X-Received: by 2002:aa7:95a9:0:b0:5a8:ba5b:575 with SMTP id
 a9-20020aa795a9000000b005a8ba5b0575mr1432692pfk.40.1676630915302; Fri, 17 Feb
 2023 02:48:35 -0800 (PST)
MIME-Version: 1.0
References: <02b46550-e0b5-4251-8156-56eb0f690d89@gmail.com> <2553f3bc-b1e6-4af2-fb6c-def486dd99a3@gmail.com>
In-Reply-To: <2553f3bc-b1e6-4af2-fb6c-def486dd99a3@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Feb 2023 11:47:45 +0100
Message-ID: <CAPDyKFpCEzubkJ=roniomXHaWrY5AOqfPZmNLbMbBnubHzZrEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: add helpers mmc_regulator_set_ocr_vmmc_up/off
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Feb 2023 at 21:14, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> A lot of drivers use this code, therefore let's factor it out to
> helpers.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  include/linux/mmc/host.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 812e6b583..f93fb8c7d 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -597,6 +597,23 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
>  }
>  #endif
>
> +static inline int mmc_regulator_set_ocr_vmmc_up(struct mmc_host *mmc,
> +                                               struct mmc_ios *ios)
> +{
> +       if (IS_ERR(mmc->supply.vmmc))
> +               return 0;

Rather than adding these two new helper functions, how about adding
the similar check in mmc_regulator_set_ocr() instead?

That should allow us to simplify some code in the host drivers too, right?

> +
> +       return mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
> +}
> +
> +static inline int mmc_regulator_set_ocr_vmmc_off(struct mmc_host *mmc)
> +{
> +       if (IS_ERR(mmc->supply.vmmc))
> +               return 0;
> +
> +       return mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +}
> +
>  int mmc_regulator_get_supply(struct mmc_host *mmc);
>
>  static inline int mmc_card_is_removable(struct mmc_host *host)
> --
> 2.39.1
>
>

Kind regards
Uffe
