Return-Path: <SRS0=lEQw=EC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433D4C388F9
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 13:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB50D21D42
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 13:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rXyuGq7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbgJ0NmW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Oct 2020 09:42:22 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34893 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1744137AbgJ0NmV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Oct 2020 09:42:21 -0400
Received: by mail-vk1-f194.google.com with SMTP id a8so365246vkm.2
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2020 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FIvGudOi7kPwId5o0/m4lZbj/CH7bqGmSDB8r0nOFw0=;
        b=rXyuGq7qrMc3UfdHaG0NoGRnZ463iXKCCb9Z1zeZou8ZCL9mRoOAEOoYRZKxv2iMz0
         JMk/jHah0Mi87BEvpK9WUXq7nADIw3a597Lk9By76iRbAn8dlPA0L8uL73vQmbyib+EM
         SrDkJqBO2pc+ZorsJrrXsKNRR0diVYZTPVsPwdxaj/skHIUjIj7eYGA/5j5k4FJBnQXz
         KVSPKM1SWNvStQUIRpgg4ikBD72nofFOOdYysrEb6wQv3OKMz5ocLqS/mWzRM/H51KrU
         pW1JT/sn6hUq0t2AMgfs6wRb6jU3syCQjnXP0F3IFkA7vSFba/+wmwa8ITNbBAFNs8OG
         kcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FIvGudOi7kPwId5o0/m4lZbj/CH7bqGmSDB8r0nOFw0=;
        b=mhq+OQhZ0bgW2lwDo02+d2v3tvXO0hFV7a/OmwP93UKPp306lHnDI20l9E99I2Jh2+
         kWRIV9N5i0Awkz35xg3XEymCRJ2j5id2YKnYSbPIcGQGeBF8fThRvDogKEo+M4d3qcB3
         gSrPPs8K+sW8t2FH869JNFEyv3ibMEzmdVmGw/lVg2K6jCsRFDtEhn8T8vdGVfq0TyL+
         OluXsuaWRu/faaVYiEpAXoGjoLcr8rXzA1e65d/aK/MBFN/Z0yHeP2yA86i7J91/zK+Z
         C2ZhqV2fQii4xPFNsl+a1I2j/S34u3saBzD6mp9a234qdmwIABllgu3xwOGFwBm2r38S
         ZDWg==
X-Gm-Message-State: AOAM530qnIr+4JqfNKB4/GHWLphSiODDpoVCdPRRjaks2+LKmxatqPmh
        GvI+3yaOFZkbWrr45l2WO0qJzD4udEyYlpP7w3QYGA==
X-Google-Smtp-Source: ABdhPJwZIaM15qKzaR9vU9aLsZgRwoKkxtpzrUHOBDcbwnnrnc/JYmY94hyCz8n6Uo0fnwZPV4Pvs8AXAWyzUB1zmvM=
X-Received: by 2002:a1f:2ed2:: with SMTP id u201mr1413348vku.7.1603806140662;
 Tue, 27 Oct 2020 06:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201026153810.89512-1-krzk@kernel.org>
In-Reply-To: <20201026153810.89512-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Oct 2020 14:41:43 +0100
Message-ID: <CAPDyKFoHdmdeMqYLzR0sDz96ffvWBbkcicQtSeb1CV5THoxGjA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: s3cmci: include GPIO descriptor consumer header
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 26 Oct 2020 at 16:40, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The driver uses GPIO Descriptor Consumer Interface so include proper
> header to fix compile test errors like:
>
>     drivers/mmc/host/s3cmci.c: In function =E2=80=98s3cmci_check_sdio_irq=
=E2=80=99:
>     drivers/mmc/host/s3cmci.c:304:7: error:
>         implicit declaration of function =E2=80=98gpiod_get_value=E2=80=
=99; did you mean =E2=80=98gpio_get_value=E2=80=99? [-Werror=3Dimplicit-fun=
ction-declaration]
>
>     drivers/mmc/host/s3cmci.c: In function =E2=80=98s3cmci_probe_pdata=E2=
=80=99:
>     drivers/mmc/host/s3cmci.c:1451:19: error:
>         implicit declaration of function =E2=80=98devm_gpiod_get_index=E2=
=80=99 [-Werror=3Dimplicit-function-declaration]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/s3cmci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 643d54eceef6..a33a7823c265 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -17,7 +17,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/io.h>
> --
> 2.25.1
>
