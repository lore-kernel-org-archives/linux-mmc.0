Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3DDC33CB1
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AAD2077C
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSxgzq+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgAPOkI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:40:08 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37992 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPOkI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 09:40:08 -0500
Received: by mail-vs1-f65.google.com with SMTP id v12so12810719vsv.5
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2020 06:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3YIGHWT3fy1Veg+KzKBfZ19zyPNacmTccQTpa/treE=;
        b=SSxgzq+7HrR3GDZkO0nRsy2X9FoHOe1J21IxuMfrHc3gVVeDEgAVM3JoDjjkSFA3P+
         QlnhppC32iK6mAGhHVRodr7JDULhJo3H27+0r4OrXDoQmANTGgGm3B9vc7uT0BOYPqE6
         Rt21jPuWmU3uVmxt4Hkc+oyYxFcQLqvbxHSrb7GG3L3P1gMiHawNoIbzdFykVZyzujKA
         aoyD6bx77IWca8pCJOG4LP9BsDvN0B8szhXBiV8d6mmdAPLJbBD8f2zrLSecoc5SdYmV
         L+uxus3h4dA5AdRLB1AgoAvq1BPkKi5YHQtfShkow7L6JLVlAfu56B2le7dJ6iVlCnnB
         QmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3YIGHWT3fy1Veg+KzKBfZ19zyPNacmTccQTpa/treE=;
        b=PScyRQSiG1660SUrslNkL4HpCH6Clpj9sU6eok7Boem6S6YDOToKNQnNvw3fKgWu3A
         2C1LcxNU4jTqTCXABmR47WJls4vp2/rTl+mc6yh99/9S2W1JF8CpDr/njHxVP31+YH1z
         XmOIF53HRGcYzzXZZqrTjPfME5TiEhozpCFLuSRZUm5TUvELcZa0QOMCgnk0SQSm5QWf
         CsblmU4DfStDD71rvJh0/XzTOqv8fUpMAdW4+i5GEo/v1HZPUnf9sxGpKVeOOqotp8QE
         mbYKhAc3CWPjwQEBXSW2lY5sjnnNbHoWCyC0KbzdyvkP0aZBOQHa71HwnyJuAQYNhJLi
         SnIQ==
X-Gm-Message-State: APjAAAVv6hi5rscxHnGHoL9FD50zbFB6+Eawh25fZvv2efrZ6gNA7xlt
        FyKhyJ2CECY87S1j0VFgfIHhzMBwaKVHABrWnZ0i1km/
X-Google-Smtp-Source: APXvYqzEwuNA7umNgS6Sl+Lk6g8/l+jRrZcp9a3JK/w7CFnkAEHVKqB6enB0wkQbS5W3bLUl8jC57/WkiDBbj1fYwdY=
X-Received: by 2002:a67:cd96:: with SMTP id r22mr1629717vsl.165.1579185607354;
 Thu, 16 Jan 2020 06:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20191212075219.48625-1-yangbo.lu@nxp.com> <20191212075219.48625-2-yangbo.lu@nxp.com>
In-Reply-To: <20191212075219.48625-2-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 15:39:31 +0100
Message-ID: <CAPDyKFqdkvHvTHdGP4oBJz8tZBBU8Rv7NRzj7NhDKXPJAE6+sQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-esdhc: update tuning erratum A-008171
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 12 Dec 2019 at 08:53, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> There is an official update for eSDHC tuning erratum A-008171.
> This patch is to implement the changes,
> - Affect all revisions of SoC.
> - Changes for tuning window checking.
> - Hardware hits a new condition that tuning succeeds although
>   the eSDHC might not have tuned properly for type2 SoCs
>   (soc_tuning_erratum_type2[] array in driver). So check
>   tuning window after tuning succeeds.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index cd0f21e..a99c000d 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -848,20 +848,20 @@ static int esdhc_signal_voltage_switch(struct mmc_host *mmc,
>  }
>
>  static struct soc_device_attribute soc_tuning_erratum_type1[] = {
> -       { .family = "QorIQ T1023", .revision = "1.0", },
> -       { .family = "QorIQ T1040", .revision = "1.0", },
> -       { .family = "QorIQ T2080", .revision = "1.0", },
> -       { .family = "QorIQ LS1021A", .revision = "1.0", },
> +       { .family = "QorIQ T1023", },
> +       { .family = "QorIQ T1040", },
> +       { .family = "QorIQ T2080", },
> +       { .family = "QorIQ LS1021A", },
>         { },
>  };
>
>  static struct soc_device_attribute soc_tuning_erratum_type2[] = {
> -       { .family = "QorIQ LS1012A", .revision = "1.0", },
> -       { .family = "QorIQ LS1043A", .revision = "1.*", },
> -       { .family = "QorIQ LS1046A", .revision = "1.0", },
> -       { .family = "QorIQ LS1080A", .revision = "1.0", },
> -       { .family = "QorIQ LS2080A", .revision = "1.0", },
> -       { .family = "QorIQ LA1575A", .revision = "1.0", },
> +       { .family = "QorIQ LS1012A", },
> +       { .family = "QorIQ LS1043A", },
> +       { .family = "QorIQ LS1046A", },
> +       { .family = "QorIQ LS1080A", },
> +       { .family = "QorIQ LS2080A", },
> +       { .family = "QorIQ LA1575A", },
>         { },
>  };
>
> @@ -929,13 +929,13 @@ static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8 *window_start,
>         /* Write 32'hFFFF_FFFF to IRQSTAT register */
>         sdhci_writel(host, 0xFFFFFFFF, SDHCI_INT_STATUS);
>
> -       /* If TBSTAT[15:8]-TBSTAT[7:0] > 4 * div_ratio
> -        * or TBSTAT[7:0]-TBSTAT[15:8] > 4 * div_ratio,
> +       /* If TBSTAT[15:8]-TBSTAT[7:0] > (4 * div_ratio) + 2
> +        * or TBSTAT[7:0]-TBSTAT[15:8] > (4 * div_ratio) + 2,
>          * then program TBPTR[TB_WNDW_END_PTR] = 4 * div_ratio
>          * and program TBPTR[TB_WNDW_START_PTR] = 8 * div_ratio.
>          */
>
> -       if (abs(start_ptr - end_ptr) > (4 * esdhc->div_ratio)) {
> +       if (abs(start_ptr - end_ptr) > (4 * esdhc->div_ratio + 2)) {
>                 *window_start = 8 * esdhc->div_ratio;
>                 *window_end = 4 * esdhc->div_ratio;
>         } else {
> @@ -1008,6 +1008,19 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 if (ret)
>                         break;
>
> +               /* For type2 affected platforms of the tuning erratum,
> +                * tuning may succeed although eSDHC might not have
> +                * tuned properly. Need to check tuning window.
> +                */
> +               if (esdhc->quirk_tuning_erratum_type2 &&
> +                   !host->tuning_err) {
> +                       esdhc_tuning_window_ptr(host, &window_start,
> +                                               &window_end);
> +                       if (abs(window_start - window_end) >
> +                           (4 * esdhc->div_ratio + 2))
> +                               host->tuning_err = -EAGAIN;
> +               }
> +
>                 /* If HW tuning fails and triggers erratum,
>                  * try workaround.
>                  */
> --
> 2.7.4
>
