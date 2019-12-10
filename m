Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C477AC43603
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 13:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95ECE207FF
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 13:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FkJVWWwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfLJNKg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:10:36 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:35250 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfLJNKg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 08:10:36 -0500
Received: by mail-vk1-f194.google.com with SMTP id o187so5570727vka.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 05:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVuDrelJPHkT9KjZ+yDkGHPcSIBa+aRtmSKrEhYG/dg=;
        b=FkJVWWwLlkLimTQI3PF07ng13Kkz6tT/cnvbsrPYSceRuIpgNc93hnqtDw9GvrPFFf
         nmjJrKLbp3RcmbcVbjD/ac2fkzVYaGrswWyLMyJ+hc7RNoHWVpI/Kz4ddb9/Jw2L1tDN
         mDhxtEvHdCpq+sM3dTxfgp9uuLOZajcNwwhnwpNpZnyAfKFpPK24qLwZ8+5gvd3YNVhs
         EdtVkov/qinLdqE/8hQtpwKenxVbWmbX3d9qK7CLtkMgz47hlJnLQGG8l3v9U3mcNoJ2
         guw7pGK2nRjvRTqWc0Ddq/3lBGLVPX4j7fqRjeOJStj2d8w8mIygrgICXcJG+ez4eLLL
         Dsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVuDrelJPHkT9KjZ+yDkGHPcSIBa+aRtmSKrEhYG/dg=;
        b=j8siPoLj5g7wsSKUZIQ8I7f4vR47SwiC7OKAAzzedOCmuz8/Mcuk2XoQddMLd+ail5
         rXFsoxnRcj42yo9BTExhe7Yo+RDDyw1VM9HpgwvZiWami7MCtBPJ7z+WRytZ9wnqZYQB
         9rrqd1Dypkpw67n6/UCUoIN5bqz12Dfb606JLzTJJilurXSfD7+ubnDiIRhmFv0z5BxV
         XFBX4JPpD8uThg8Alqlx7+CeSsBA9RkJALsmFwbg36LrY3EsrZXHmK0CdE5cndhjqECl
         lFH03X0GxUizVx7FK3gaOHYwe3liYh3kIoGNr58qjaxTQNuzW/nutIgpuRr5lyxQqayu
         caRw==
X-Gm-Message-State: APjAAAU7vflzOCRlYpnnWgkwvzMaDFhGMh5CqD1H/odUVchcD7srF0tG
        4NGQO7T3kXUcoa2W3xSMr32mLTWrH/68P1e3JWxw3Q==
X-Google-Smtp-Source: APXvYqx62Xqzh3c0mIH6kQ/su9SdAbn5smF6vBQMUWq+uiu4POpJzI6T7keATd4/cB4wTjJCdip4MUdM+0kElg2eDkY=
X-Received: by 2002:a1f:4541:: with SMTP id s62mr9019157vka.59.1575983434909;
 Tue, 10 Dec 2019 05:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20191206114326.15856-1-faiz_abbas@ti.com>
In-Reply-To: <20191206114326.15856-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Dec 2019 14:09:59 +0100
Message-ID: <CAPDyKFr-3RZUPS596HE2+Hu-FxhQ5e1Sv8DbeUtt5qLOjuxU8w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Update the tuning failed messages to pr_debug level
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 6 Dec 2019 at 12:42, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Tuning support in DDR50 speed mode was added in SD Specifications Part1
> Physical Layer Specification v3.01. Its not possible to distinguish
> between v3.00 and v3.01 from the SCR and that is why since
> commit 4324f6de6d2e ("mmc: core: enable CMD19 tuning for DDR50 mode")
> tuning failures are ignored in DDR50 speed mode.
>
> Cards compatible with v3.00 don't respond to CMD19 in DDR50 and this
> error gets printed during enumeration and also if retune is triggered at
> any time during operation. Update the printk level to pr_debug so that
> these errors don't lead to false error reports.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 296d955ede59..42a9c8179da7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2417,8 +2417,8 @@ static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>                 sdhci_send_tuning(host, opcode);
>
>                 if (!host->tuning_done) {
> -                       pr_info("%s: Tuning timeout, falling back to fixed sampling clock\n",
> -                               mmc_hostname(host->mmc));
> +                       pr_debug("%s: Tuning timeout, falling back to fixed sampling clock\n",
> +                                mmc_hostname(host->mmc));
>                         sdhci_abort_tuning(host, opcode);
>                         return -ETIMEDOUT;
>                 }
> --
> 2.19.2
>
