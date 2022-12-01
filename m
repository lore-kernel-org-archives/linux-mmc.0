Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEFAC43217
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Dec 2022 10:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiLAKsw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Dec 2022 05:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiLAKsS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 05:48:18 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7423AC09
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 02:46:41 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 82so1365510pgc.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2022 02:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a6jwZZ22v6VgjNwNsN5/RPhF3k+QJnNn75TOznSm9Ko=;
        b=MR/YWUlXQ+WQLNW+qzlvV8edNDljw+t18L+sJQFNsJVYJ+y72rK30YA2YfHCty205+
         0HUJE7YNNdbF2btb1xv0zVIGoJ/8/dbklNKA1i2uLDGSCWQy6SMIr61wNhUDXvNvutVh
         866pl8a+NqwP4kYk9CKDnGzqHcgK55c843vY6o0xw3S0TfbBwDCUEHVf2k/J7Shkxj3H
         KoCOEyYHHVXeIQzdlsJIYMYlzz04FNXjyLI9wBsqGQnm8f63liRCPLXtK3BmBrLZ/dTy
         pBcVpclhnB+/uTNOjn00ZChaQSmHia9WLXeqjrfb+6Whn/pMn5PnttC5+wWuw0H1cJRN
         zeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6jwZZ22v6VgjNwNsN5/RPhF3k+QJnNn75TOznSm9Ko=;
        b=nQTp9XkCl351Kxjpnm6LWk5gqabikBJL74yq8pBq4+RVP8YlF4/ehps7x67cFSpjVn
         wjim7VWcjD+QE1dJ6WA3WxoXI3eilQmTL+qtXT91hp/In0qEkYXaJd7yNqKr1Y6d7ih/
         j0fEPMaGIbKYe+1Ep3LffLfz4pur/i/bmUx21288PTLyKz4kz6S/OkbPxKIC4n3ptNny
         KZgstviGti2ByswrKOQPxlmoLB3boNHOjtwlbgFkPyJB1vikGEPGlqqtSTcaOQjShE3m
         vQrR1rKf8QQpFyS7F7KB4wm+KtfjaSxcnS/DdRquyVZCdJal7U/qzRI8eNm/vtAZdUim
         hWeA==
X-Gm-Message-State: ANoB5pnFHBMZ5O2RO32KRyDIb2F96Ybzj2xx4IkoWBX6x6KLM+cMFbPu
        LTMApXvqBKRxxcRISvuEUuIvDpWb4C2KF0QhGvFMgQ==
X-Google-Smtp-Source: AA0mqf4foylhYdJfuCXchn159KTlnNvnmUOJ40C/LHBs5OgMlVbSw9jlycgDuF6ZmyOTvgRjJDLoTkFvh4FJH1xfWUk=
X-Received: by 2002:aa7:87da:0:b0:575:2f34:29d4 with SMTP id
 i26-20020aa787da000000b005752f3429d4mr19425069pfo.40.1669891600690; Thu, 01
 Dec 2022 02:46:40 -0800 (PST)
MIME-Version: 1.0
References: <202212010926422966197@zte.com.cn>
In-Reply-To: <202212010926422966197@zte.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 1 Dec 2022 11:46:04 +0100
Message-ID: <CAPDyKFp0joh5Hqj_iS5UPmXFUrs2Ws9an=-kfv5Yc+wvGq7L_A@mail.gmail.com>
Subject: Re: [PATCH linux-next] mmc: sdhci: Remove unneeded semicolon
To:     zhang.songyi@zte.com.cn
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 1 Dec 2022 at 02:26, <zhang.songyi@zte.com.cn> wrote:
>
> From: zhang songyi <zhang.songyi@zte.com.cn>
>
> The semicolon after the "}" is unneeded.
>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>

Please run checkpatch (./scripts/checkpatch.pl) to make sure there are
no obvious formatting problems with your patch. This time it gives the
below warning, please fix it and resubmit a new version.

WARNING: please, no spaces at the start of a line
#79: FILE: drivers/mmc/host/sdhci.c:2292:
+       }$

total: 0 errors, 1 warnings, 8 lines checked

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 42aaeabcad22..8413180a1039 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2289,7 +2289,7 @@ static bool sdhci_timing_has_preset(unsigned char timing)
>         case MMC_TIMING_UHS_DDR50:
>         case MMC_TIMING_MMC_DDR52:
>                 return true;
> -       };
> +       }
>         return false;
>  }
>
> --
> 2.15.2
