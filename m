Return-Path: <SRS0=lEQw=EC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9E9C388F9
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 13:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9342E20732
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 13:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ff5RdpQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbgJ0Nm2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Oct 2020 09:42:28 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37088 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbgJ0Nm1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Oct 2020 09:42:27 -0400
Received: by mail-ua1-f68.google.com with SMTP id 52so479578uaj.4
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2020 06:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+IdqF2kWZIatsMkx1rqiXPdMLtc7lqC33V+nAVYFq2g=;
        b=ff5RdpQJhaV4ad0Bhm5iTZaXGjMLJa3FTFpEVKmQVPt1yF0CAiJWvG1uTtz3dn8UtR
         1MEwVbDSo5SIeWCSiiHh+H0rN5GwHuCvBfMJn9Lg3NY2PLyyip6lA4gIBGD7vAsqiV0F
         JLBtIXbk5N/jrfVLZow9hdeN7bO/8/aM09TSVOOuhJ2v+QjqxNoUBSySyi8q0xW/6863
         86L8AF5RvSOSn/LtJ+Aex1Cn7PMcMm2biTHJfBnmFRKCoMYlqcjva4l6N+tpO26vLFGY
         EAh/p8X0Wb9MfVqOY/f5udHdQHFH+3RbcoharLIWefHnE/83sU2vK0NTI6uPGVPHUJ1I
         Y+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+IdqF2kWZIatsMkx1rqiXPdMLtc7lqC33V+nAVYFq2g=;
        b=qeRfVz6BscuKb942sXcuJ4OaumN/ntshzaZd46+T+TjnBCiZGn/vogB0JsVB0c18Rz
         ow1MM6V2HD1UuPrFHTKTSiv4WHvxoJH3QEwS+HFSoY2C1SAqLXHE3WDh47G9PVFGY/jB
         /HDClZ5VLQT1xwRSDO6cf1ZzmHQ9ojtH9Mv4RC/6Hd5mhnWNXSSwYbrHwa00mFiufXiM
         p2IPQbQmJO9zBVBKcIXsxCTkFPi7Qp7qebzjqTbmVLgNWrYgMEApj/Ztxg9l1QMnrfQJ
         VzKuWpOHQSZFD70enick9cO3OfY6v095H0s01NpIBdRaEh3YvrJzeIocsq5bZW8ToPEP
         zFMA==
X-Gm-Message-State: AOAM5319kvW7h4IeMNF3gl1ryz5fDamvQ3zBFCWivv0ws+mnOANtlm1+
        leKJS/+lDceeEiOOew+B5GlaJvPX/oQdKWzgMXj3NA==
X-Google-Smtp-Source: ABdhPJydS4TU6Ck4NDs6SP51ULZcsklQhQKBsqxjHnxoU9bm2tESho4QIrSHx4R+sjyHmElDzzy9KvfQ/sbozjW1+0w=
X-Received: by 2002:ab0:8b:: with SMTP id 11mr1259317uaj.15.1603806146520;
 Tue, 27 Oct 2020 06:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201026153810.89512-1-krzk@kernel.org> <20201026153810.89512-3-krzk@kernel.org>
In-Reply-To: <20201026153810.89512-3-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Oct 2020 14:41:50 +0100
Message-ID: <CAPDyKFo2DjMzozdr5PAr_A8=Oq_06_mmpTQAFd-sJ-=_=XHeOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: sunxi: drop of_match_ptr from of_device_id table
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 26 Oct 2020 at 16:40, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The driver can match only via DT table so it should be always used and
> the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant for sunxi).  This
> fixes compile warning:
>
>     drivers/mmc/host/sunxi-mmc.c:1181:34: warning: =E2=80=98sunxi_mmc_of_=
match=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sunxi-mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index fc62773602ec..6310693f2ac0 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -26,6 +26,7 @@
>  #include <linux/mmc/sdio.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> @@ -1515,7 +1516,7 @@ static struct platform_driver sunxi_mmc_driver =3D =
{
>         .driver =3D {
>                 .name   =3D "sunxi-mmc",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> -               .of_match_table =3D of_match_ptr(sunxi_mmc_of_match),
> +               .of_match_table =3D sunxi_mmc_of_match,
>                 .pm =3D &sunxi_mmc_pm_ops,
>         },
>         .probe          =3D sunxi_mmc_probe,
> --
> 2.25.1
>
