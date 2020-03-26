Return-Path: <SRS0=y6Wy=5L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B0BC43331
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Mar 2020 14:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944E32077D
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Mar 2020 14:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0AYeRSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgCZO2E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:28:04 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45758 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgCZO2E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Mar 2020 10:28:04 -0400
Received: by mail-vs1-f66.google.com with SMTP id x82so3913864vsc.12
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2020 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nwrqr8fUwcczi1tkKbhoCAaTj0Lz9vANHD/lv6450Ik=;
        b=s0AYeRSme5ZYMG5Hj00MtSphy+ZF1hJEIT/x2laNKAPH6uwyawibNxjdwbP2n3VcAz
         csHlsS0gxGoa5DicQVyRyza5fvlnbU7gXob7YwmrF1iP6Arowk1BTPlr0kz4O3XeecgF
         1zk9ZTQ+jv4zeHagRLkhqZrvKEFdH+oNeK135nUnNRS91hY2ue714O+FEjcV14/4YNSF
         LfEKcr0FypAkSBknWreQBXQ7JbSB7qSlCdDz+6IHoDYmn4ebQwicF5K71DOR0GD0cCFh
         bCHWHd0BIGOXrsyTGs9lNM+SLJBnuSpHOhufi/2mLRvJCbJQ5z5/y/CztJiv8Q92tTQi
         xs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nwrqr8fUwcczi1tkKbhoCAaTj0Lz9vANHD/lv6450Ik=;
        b=ErhvujkcIl0jAbTv23FTAxpbAHnXqeLjtHDBdLEjCOfG7ZmHApo9S2C5OOxDJK/42X
         FtHAAJD76JRhQrluRSFNCHKH2MVrcsGFEMpNv4YmfI61wZz/1Pqg1B73aC8yol2qsk70
         vo081QrGLHqAWvCtVkMdJBl7ZRixk/DUkId37Z1EqJmCQDnnrTq694Qi6ckRD2eQHSVh
         FEAJh6GCvBYHKLy764PdBxmSj2ZNTrzPuT2SUisxuZxpGw8NalNvePOHsbTy6j4zescz
         aLuVUJcGDytaIZWsgEz5a+/pZBAwiPjvBrx4MzJGahaVvdzjyiRxwrgN/M7SfC+MmsbC
         J04A==
X-Gm-Message-State: ANhLgQ2IETN/bIv3mE5Uqna+FemtAvqB6r/Er7lNnqKGDhcq06JVgp/P
        SNi6H/U0rf9oiaxdlE7LPp7twpor7wgWW4bcuuQevV6P
X-Google-Smtp-Source: ADFU+vsDl0E1ShxlqFNIKGgRphr3dXzKQ2BouqsiqJSyqwn2BTjEQZNw7vYZJmX1XaoteUXkIePuQWywtUNQtEW50KM=
X-Received: by 2002:a67:2ec6:: with SMTP id u189mr7072856vsu.200.1585232883289;
 Thu, 26 Mar 2020 07:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200325143409.13005-1-ludovic.barre@st.com> <20200325143409.13005-3-ludovic.barre@st.com>
In-Reply-To: <20200325143409.13005-3-ludovic.barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 26 Mar 2020 15:27:27 +0100
Message-ID: <CAPDyKFpO40Ois8pNwYOeqZrJbV9UeCLok=i8z4GWML+A7TP2-w@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mmc: mmci: initialize pwr|clk|datactrl_reg with
 their hardware values
To:     Ludovic Barre <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 25 Mar 2020 at 15:34, Ludovic Barre <ludovic.barre@st.com> wrote:
>
> In mmci_write_pwr|clk|datactrlreg functions, if the desired value
> is equal to corresponding variable (pwr_reg|clk_reg|datactrl_reg),
> the value is not written in the register.
>
> At probe pwr|clk|datactrl_reg of mmci_host structure are initialized
> to 0 (kzalloc of mmc_alloc_host). But they does not necessarily reflect
> hardware value of these registers, if they are used while boot level.
> This is problematic, if we want to write 0 in these registers.

It could be, but I don't see that we ever needs to do that - at least
not before we have written some other non-zero values to them (through
the helper functions).

>
> This patch initializes pwr|clk|datactrl_reg variables with their
> hardware values while probing.

Hmm, so in principle this change seems quite okay, but I am hesitant
to pick it up - unless it really addresses a problem that you have
observed.

The reason is, this change may lead to avoiding to re-write the
register with the same value it got during boot - and who knows what
is best here.

Kind regards
Uffe

>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 647567def612..f378ae18d5dc 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -2085,6 +2085,10 @@ static int mmci_probe(struct amba_device *dev,
>         else if (plat->ocr_mask)
>                 dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
>
> +       host->pwr_reg = readl_relaxed(host->base + MMCIPOWER);
> +       host->clk_reg = readl_relaxed(host->base + MMCICLOCK);
> +       host->datactrl_reg = readl_relaxed(host->base + MMCIDATACTRL);
> +
>         /* We support these capabilities. */
>         mmc->caps |= MMC_CAP_CMD23;
>
> --
> 2.17.1
>
