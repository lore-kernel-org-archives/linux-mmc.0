Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA517C77B73
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 15:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjEXPQU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 11:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjEXPQT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 11:16:19 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAB310B
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 08:16:17 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565014fc2faso14673047b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684941377; x=1687533377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Prxo6uRVHuwACd4AHAlZan5NVrjpCNqCsnrPag0CTJ4=;
        b=SrYs6GwHEKCl+j+vxznDk0KIJ+CfcLzlh9jX0lxnqVHdk0EI20J74dTfQz+jMQPV+o
         HRGFE4MffhRxT10JMc9EenmytTMKdPU3gHLZdOcbFXp3QZAG5AUW9GZItHDP9G1OPn+t
         llTFDOc+LAitqp30xuBPosPVrjcODNOUKNy0MRJajEaIcCIFCrcuH4/yAm6H3yXKWK/v
         oI4cYgY0sb4dtNpEZVPNrFvFNdwRuh0w3A/SmWb5rL2HYzpmxxFR7RxzlVB+oWd7JKQ3
         Y+CfjD+KIdLgzr+Rd3wWyE7m2qcp/oX2qCTfKmEYPF9cuMbI+k5bYX97mB/xMOQCwOtS
         ICgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684941377; x=1687533377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Prxo6uRVHuwACd4AHAlZan5NVrjpCNqCsnrPag0CTJ4=;
        b=YXTDnhvthlvuyoAAauxQFpSEAMvK1QyeYCGmdAR0Ss1brxQ1RTwhsdS3ec31GXtJWu
         om1Ds081PEhddLCQECKfNEAHQd9w2q22KyIx4YHIa/3vvvFqTihWvWmIOhczdxnR2uCQ
         HoyZcnrgFnGTNO5s1dTraKURUTmKiP2y1BwhmuZv3n+AdOvnC299fyEuBKH6S8cnfZ+R
         XNAKEoSavpdT98RWNZ0H2I/rQiJQdsrR0Skhyn6U9Hj8O0sryFEL0/iiQD1IjpugXBKa
         X0t5FKveRMy6NrR2K0EE4J4a0YK2OzulyuR9FEs9WOJoDlaI4eICTriPsIVU90JMUXfK
         qiJA==
X-Gm-Message-State: AC+VfDwYr/Oa7W06EceqwrogADUkKnXYToaLbDOjwsE79tbz/R51mrqP
        upNBeN7nqcdEPu8y7q+JLRsy13nACp5yy0GAUcBWEqKHk8F3Ozsp
X-Google-Smtp-Source: ACHHUZ5P/Mdy88v9mAy1DqgiuPymj83PL0vLQ0M8XlENkn+B5Biu3PvmUeyP+OHTz3j+k1+qs88x6vZum90YUDZ78dw=
X-Received: by 2002:a81:77d6:0:b0:565:62eb:db6 with SMTP id
 s205-20020a8177d6000000b0056562eb0db6mr2357786ywc.42.1684941377158; Wed, 24
 May 2023 08:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230522214818.2038252-1-ejo@pengutronix.de>
In-Reply-To: <20230522214818.2038252-1-ejo@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 May 2023 17:15:40 +0200
Message-ID: <CAPDyKFpV-Ff-0uuZPq0LA2oJDTuNEweaG1s1jsmRqaNUFfMZUw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc-utils: add SanDisk to manufacturer database
To:     Enrico Jorns <ejo@pengutronix.de>
Cc:     linux-mmc@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 May 2023 at 23:49, Enrico Jorns <ejo@pengutronix.de> wrote:
>
> Signed-off-by: Enrico Jorns <ejo@pengutronix.de>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>  lsmmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/lsmmc.c b/lsmmc.c
> index 55da3aa..da9d69e 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -239,6 +239,11 @@ struct ids_database database[] = {
>                 .id = 0x44,
>                 .manufacturer = "ATP",
>         },
> +       {
> +               .type = "mmc",
> +               .id = 0x45,
> +               .manufacturer = "SanDisk Corporation",
> +       },
>         {
>                 .type = "mmc",
>                 .id = 0x2c,
> --
> 2.39.2
>
