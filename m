Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F589C433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5096A22B45
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GH+n5u66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgHEGfv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgHEGfv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 02:35:51 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11BAC06174A
        for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2020 23:35:50 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 1so17474607vsl.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2020 23:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uonOmW36XJQH6ERBJDEiOkV/Xd83b6uQ9CuqCDqqY3Y=;
        b=GH+n5u66NGqaRx+vkyRBiGeXbsSSZ4O3O0jxZV6VWv6g7No3rQBDNZjKfgGm1P64uG
         IHxq9jDlLW2YExdnF0+opYXN/gmyU0yTwb+r0iu2Cuc3+WyBkI+bj3IXNSsP5qkIdoVN
         NL0ClJWvva8eMonEUPstSrdSNxpwHVr8FtFePPMREt5gKEVJqH42PvBgV27todjv4IrD
         bH+evmcv8RguJrJ1PI9HTbWfkeNRtJDh2Utb3IapEqurPrRvtCmzGQJ1B6X93fw2nCJm
         VDL/CksT29cmw/5gNj569aa8RwYXztrM4Xe+vaDNkbKC5zspvrdfObDpxg8UkO4NNOW8
         Qmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uonOmW36XJQH6ERBJDEiOkV/Xd83b6uQ9CuqCDqqY3Y=;
        b=hHG/kt5TkkfIkRqDFsSu35rRO8w1aFKL+NY4eufXCbE5ZiKBk0WcLSBFRwzOLWyRp8
         QAisch5wlEC5bUAzwdTkojZf3tVxmLpM3UCYzl+/w1v45+WKffPYvST2RRsHNULMVXml
         ioF1hA8qPKJRpab41HavJ1FGaKduiF675FmKx/RGRkLf0pOW1YHbQo2Zynqb4GAzMDV+
         s9fxBhwyGtvBPCnnweTPKqrEOSpUptDkfWq8EdzFlJLJI6hXBimmQItOYGcJg8KPPJWC
         Knj/87lFEWqUi1SB/Jdzj/FNMRhEG/4jXuwIcO8n3b2fZpBlAom4OHx/9QjqgiMn852e
         ISBw==
X-Gm-Message-State: AOAM5331idiJfLDUqQkhG3Q5yM4zMSzzCSPP7367XnJZSk6Ergv3H7Tc
        +Dt4I50SISn4exhnRtTFL+tkp++29Ry1qcLWlSBAhQ==
X-Google-Smtp-Source: ABdhPJzEtFM13M3YwlfkPlgZ9Anpw7bZdT49Yy928V+va9TgY5SOlVUD46185T0PzyGouSiD99+VEFcRfcjbSdapqT4=
X-Received: by 2002:a67:e45:: with SMTP id 66mr866561vso.191.1596609350177;
 Tue, 04 Aug 2020 23:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200714141410.GB314989@mwanda>
In-Reply-To: <20200714141410.GB314989@mwanda>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Aug 2020 08:35:13 +0200
Message-ID: <CAPDyKFp6PBT4h+pwv2fzifvDFtngOSoTZ+-KwJXuUA3qU0VY2Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Fix a potential uninitialized variable
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 14 Jul 2020 at 16:14, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Smatch complains that "ret" can be used without being initialized.
>
> drivers/mmc/host/sdhci.c
>   4383          if (!IS_ERR(mmc->supply.vqmmc)) {
>   4384                  if (enable_vqmmc) {
>                             ^^^^^^^^^^^^
>   4385                          ret = regulator_enable(mmc->supply.vqmmc);
>                                 ^^^^^
>   4386                          host->sdhci_core_to_disable_vqmmc = !ret;
>   4387                  }
>
> "ret" is only initialized when "enable_vqmmc" is true.
>
> Fixes: b13099a4dea6 ("mmc: sdhci: Fix potential null pointer access while accessing vqmmc")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied for next (a while ago), thanks!
Kind regards
Uffe



> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8db06da55602..3ad394b40eb1 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4104,7 +4104,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>         unsigned int ocr_avail;
>         unsigned int override_timeout_clk;
>         u32 max_clk;
> -       int ret;
> +       int ret = 0;
>         bool enable_vqmmc = false;
>
>         WARN_ON(host == NULL);
> --
> 2.27.0
>
