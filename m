Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2E6C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Feb 2022 17:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiB1RFT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237499AbiB1RFR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2022 12:05:17 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D68286E1D
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 09:04:38 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j15so22448181lfe.11
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 09:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIdq0xDa5SoPSxzAGTemiHfQ1WhVcvzkPC8IThSINzA=;
        b=DspDnAfRiAw2/8sOryQqZ05e2H7MMu1/Fzinh2vhH418uJZn+bTF9LC4dXcr8AzBC5
         SN3Yv21IbqS+X+xBDEEAzEj78Ho/vuMmrN+Ed5HQz22qDK4UJ40TBf3whlVCwkYbGVHW
         rkhvErM1Qfur9LKi1ZRSXNg3Xh9Caz/+F1d6jyhafsu5qmJdGPJs2Hl/BrY4PPQC3Llp
         EAU1bDalFvvdutjL2iHCNdv4gzHtTZY9UF5e3G6W5vjJTXGGVGqVvUgSEuJiI3Q0sxlA
         3ZFbWMmdXAA6GNlDXiqNCBqrZGIpQyr61kkowWx13aWKrXuMmYv/MewPouWWt+HVrmax
         jNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIdq0xDa5SoPSxzAGTemiHfQ1WhVcvzkPC8IThSINzA=;
        b=vNyRO8IHs/N3rJtLtEDAB0pG+wjIOhl0OBKZa2SMSRlN5bzyTsM1dcjSBx7SuWz30p
         YQFiTvATDdR9vFaGzizUBRYm3L8K3AljBPzNkDzqAZlOU7lRjGvTH8mWTeUT8yRBnRHf
         8GiqoPP3woSD6qGNd6/RM1UDkY27ru5IwD2Bggf7Q7Va5Qk9zRTkjwvg5KA8Xwk5YNH6
         FbNDvGfQWDyJwot6YQvY6z++LeLxFcTNegV35hpaP1qITQ2ZTzhaErUCQv3eCFt/UJUK
         7xf69o4Jq7eRw+SxL8aPxCXkoeZek+skUPbUPcy7lEYN3qzNZmFVMBVfu1txOWJZyaZG
         eTtQ==
X-Gm-Message-State: AOAM531bnm+uF7UwegTnI7K91WG7BcDDSaer63rHFdq6u1YrpnRk83mB
        bFp7kEODf/3gDp7/vEgjtWdhsRNe5fK58+lwc+e1uw==
X-Google-Smtp-Source: ABdhPJz9RUZwJ8mORaL4cPamANxjVL0XmzpuvxgMDMuvfL0KaGeivTo02ZgSgXlFrroGwKFIiVaG5nG00YiDsTVuEOE=
X-Received: by 2002:a05:6512:3d2a:b0:443:3198:cb95 with SMTP id
 d42-20020a0565123d2a00b004433198cb95mr14015061lfv.233.1646067876428; Mon, 28
 Feb 2022 09:04:36 -0800 (PST)
MIME-Version: 1.0
References: <20220225125553.1185108-1-benchuanggli@gmail.com> <20220225125553.1185108-2-benchuanggli@gmail.com>
In-Reply-To: <20220225125553.1185108-2-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Feb 2022 18:03:59 +0100
Message-ID: <CAPDyKFq5MdGWefVW6Uwe74Ef5giW+68qRS2hmXNmHLqpfqav8A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Add runtime PM for GL9763E
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, greg.tu@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw,
        Kevin Chang <kevin.chang@lcfuturecenter.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 25 Feb 2022 at 13:56, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> Add runtime PM for GL9763E and disable PLL in runtime suspend. So power
> gated of upstream port can be enabled.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Tested-by: Kevin Chang <kevin.chang@lcfuturecenter.com>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 54 ++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 97035d77c18c..cf99b6af792d 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -873,6 +873,55 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>  }
>
> +#ifdef CONFIG_PM
> +static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot = chip->slots[0];
> +       struct sdhci_host *host = slot->host;
> +       u16 clock;
> +
> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> +
> +       return 0;
> +}
> +
> +static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot = chip->slots[0];
> +       struct sdhci_host *host = slot->host;
> +       ktime_t timeout;
> +       u16 clock;
> +
> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +       clock |= SDHCI_CLOCK_PLL_EN;
> +       clock &= ~SDHCI_CLOCK_INT_STABLE;
> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> +
> +       timeout = ktime_add_ms(ktime_get(), 150);
> +       while (1) {
> +               bool timedout = ktime_after(ktime_get(), timeout);
> +
> +               clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +               if (clock & SDHCI_CLOCK_INT_STABLE)
> +                       break;
> +               if (timedout) {
> +                       pr_err("%s: PLL clock never stabilised.\n",
> +                              mmc_hostname(host->mmc));
> +                       sdhci_dumpregs(host);
> +                       break;
> +               }
> +               udelay(10);
> +       }
> +       clock |= SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> +
> +       return 0;
> +}

Both functions above look very similar to what sdhci_set_clock() does.
Can you use that, rather than open coding the above?

Other than that, I would appreciate it if Adrian could have a look at
this too. For example, I wonder if perhaps
sdhci_runtime_suspend|resume_host() should be called in these paths
too.

> +#endif
> +
>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>  {
>         struct pci_dev *pdev = slot->chip->pdev;
> @@ -982,6 +1031,11 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
>  #ifdef CONFIG_PM_SLEEP
>         .resume         = sdhci_cqhci_gli_resume,
>         .suspend        = sdhci_cqhci_gli_suspend,
> +#endif
> +#ifdef CONFIG_PM
> +       .runtime_suspend = gl9763e_runtime_suspend,
> +       .runtime_resume  = gl9763e_runtime_resume,
> +       .allow_runtime_pm = true,
>  #endif
>         .add_host       = gl9763e_add_host,
>  };
> --
> 2.35.1
>

Kind regards
Uffe
