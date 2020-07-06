Return-Path: <SRS0=mNiq=AR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD209C433E1
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7EC206E6
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnPmmVS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgGFOuI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbgGFOuH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jul 2020 10:50:07 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AC6C061794
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2020 07:50:07 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id x205so519695vsc.11
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2020 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0jgzx8S2zel50+AI2lNsRTv/LDC6V8ujl1bHkcaYHdg=;
        b=tnPmmVS3iWzXBi2KxDXNk1ixWHlWq/ttuWoD79PgGPCxKO0NQ2ZGtrlUb3nLd5cG4I
         p1tBScUMOyN1WqqfRFVENjE3Qzqy4RpF7zR1rJahW0SYZ67sSo7O7kSxJlr/vaBZQaRU
         7lZpjjiMTinVy+5/fWb4jUSzydLCh7thAPRJKGSwhGY0ZE7KlInuOwwXWiKbwl5Vh8OZ
         fyZ0VikOC+jHkJTYtjZq/tnQtszE9CHmPZIzfJ/g69pryW9LWA0o5v9ZwgobIKYB+LZm
         v97Vv88ccNIW5/hbE4o7vMhcCEVt8rJUXncp6eCUSEwu8Oqm1nh5Hbe/yiIiYwcj1MRK
         vBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jgzx8S2zel50+AI2lNsRTv/LDC6V8ujl1bHkcaYHdg=;
        b=LK8garowgf39tzIzgNjwk20FuCfcIDS9sQN7l/rQdVCfgX34BwTHAFQvN2okoVUiXh
         O0965pqtr5qFESHKw3XjpB5H2L9ECE/aJr11IwLD02z9Q38gFc3xtl9HuX5HVSlZBSoI
         zvKM7mpsngRZ1zwSowEGU4jAPTn/7UuUGmW2MZRCUq/a6TL0Kk5ltYR3KCxvNdPT0S31
         g4785u8bfPeaQxGJzgYgWBysXHu7OWlYevUGpiUazg8eSnzhjYmERfuVKwZGxiW8Xx9r
         Y+cs3fD7F1XAm2fNGremux3JWiGstoFJX6/F12RjYlTUW2P8Nk8XAkc33qBbDOlx9PHK
         v2sQ==
X-Gm-Message-State: AOAM532am3Hqm8wfQS6B6PKij6nSkNYQyB8P0I9s5+Ef7mzQtff5iERU
        5RY+zO3oToBEkSC/M+qm7ZbVkxmhyMfntbvPNEsdrw==
X-Google-Smtp-Source: ABdhPJzOFx3QfsC8+J2WvA203K0R/jNjTQwyfi62ngWT1XbOsrJp1wOj7GDIwC7amY0tc7W9xU7oKwmdoJzYUdTGQU0=
X-Received: by 2002:a67:f888:: with SMTP id h8mr15844401vso.165.1594047006751;
 Mon, 06 Jul 2020 07:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200702020347.77214-1-weiyongjun1@huawei.com>
In-Reply-To: <20200702020347.77214-1-weiyongjun1@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Jul 2020 16:49:29 +0200
Message-ID: <CAPDyKFrxqdOG6c=E4Lhaa-h7Jp9qsX_ZqBnYcz7cEyGe=g-oHw@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-msm: Make function sdhci_msm_dump_vendor_regs()
 static
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Hulk Robot <hulkci@huawei.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 2 Jul 2020 at 03:53, Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> From: Hulk Robot <hulkci@huawei.com>
>
> Fix sparse build warning:
>
> drivers/mmc/host/sdhci-msm.c:1888:6: warning:
>  symbol 'sdhci_msm_dump_vendor_regs' was not declared. Should it be static?
>
> Signed-off-by: Hulk Robot <hulkci@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 15c42b059240..66f755f94d2c 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1885,7 +1885,7 @@ static void sdhci_msm_reset(struct sdhci_host *host, u8 mask)
>  #define SDHCI_MSM_DUMP(f, x...) \
>         pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
>
> -void sdhci_msm_dump_vendor_regs(struct sdhci_host *host)
> +static void sdhci_msm_dump_vendor_regs(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>
