Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEB2C10DCE
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 15:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72D2206E7
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 15:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jyZqQKZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCLPqF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:46:05 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44628 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgCLPqF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2020 11:46:05 -0400
Received: by mail-vs1-f68.google.com with SMTP id u24so3968853vso.11
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2020 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHaXVjDQu931MfMKtheRNF/9m5lHabYqkXBKs26UT/Q=;
        b=jyZqQKZFWSeFoACloFA2u+0/fS9WD1pJXIFZdhMHNP9MjHIDEPGGkkLCDAYNopUb7o
         fziq0jeqhXuApxBl//vDUiQhLTLgxj/xvreTvJEpBdmxoa6TSLx74M+luhuK+wAMyBpf
         ptpt48FQZFXTSnBFNu+CQmfaLkOxwWOhvnLLuCXVTZm4P5PCcOonridqSYw71/QNLOpd
         dhtwf/XOm+q5KwQoSkTaet0lhFdRG63/W5YLDt1MYzMrOPgjC1P9YTYT/OPEAsadpUQV
         D1zacapeGEgkpAd8otM/0WOx2CrvZ81NVv+I2EkRZFXYOoFbfM940QaK69UzWcal1kQZ
         CYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHaXVjDQu931MfMKtheRNF/9m5lHabYqkXBKs26UT/Q=;
        b=W15l7apeC9XrnXNpH9RQ3X1NIPxsYljY9c6n56vsa/Z3+gEMmDQ+moLyFjPYP8UsqD
         fVsSK3d8e55LqEujgkjS1fRzq7VdhEbWM0YcbQZ/IJ6IMVNYp+rcFSo5fLjPxh7zq3OR
         mPIgU8blN1k2zEjWCyqPlFpDjme+ZriGSMLol51vCpOnq02VhIcfSYsb3CzecGD5UA2G
         Ol7OgiAiROmpxesBHBkMlfuWt34Ovg4f/BJ9s+6Bc0tPKOHIg+dHy4mpNAZ3QtOvWpAb
         BfARAWTss26/JbioNrUqPKAyK5OapN9C8SOzmInBDbCZ6kwgP3c4l4LQKmrvCuJRVTWh
         JF0A==
X-Gm-Message-State: ANhLgQ0zyraJgyVr7DjwyVZTYevQVSNA32HuFOF+iJP7uI9tduwf/zZh
        sdr9/Rz79ZDNkXQJSqndc8o288KRC4mAGGdwkr87bptSqRw=
X-Google-Smtp-Source: ADFU+vt9l6Rtb+g86ksblzRlRCEhpwBNgSEmhkGYBJ+imjtGRyFo0cRF7szcpvV8BcfCNXFnLdKUILTKZ+MKydhNJ1g=
X-Received: by 2002:a67:2ec6:: with SMTP id u189mr5955903vsu.200.1584027963853;
 Thu, 12 Mar 2020 08:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200312142501.9868-1-adrian.hunter@intel.com> <20200312142501.9868-2-adrian.hunter@intel.com>
In-Reply-To: <20200312142501.9868-2-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 12 Mar 2020 16:45:27 +0100
Message-ID: <CAPDyKFpHZDy3TvHdQBuKgu5k3QkE+Pqcu5jumWa=LAY+ixUheg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] mmc: core: Try harder if transfer mode switch fails
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Kyungmin Seo <kyungmin.seo@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 12 Mar 2020 at 15:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add extra busy wait and retries if transfer mode switch fails.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/mmc_ops.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index aa0cab190cd8..619088a94688 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -599,6 +599,12 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>                 cmd.sanitize_busy = true;
>
>         err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> +       if (err && index == EXT_CSD_HS_TIMING) {
> +               /* Try harder for timing changes */
> +               __mmc_poll_for_busy(card, timeout_ms, send_status,
> +                                   retry_crc_err, MMC_BUSY_CMD6);
> +               err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> +       }

Hmm, what do you think of moving this to the caller(s) of
__mmc_switch() and in particular only at those places were we find it
useful. Me personally, would prefer that option.

To do that, we may need to have the possibility of specifying the
number of retries that should be used in the mmc_wait_for_cmd() call
to the caller can check the error code better.

Moreover, it looks a bit risky to do the polling for all kinds of
errors - shouldn't we do for CRC errors?

>         if (err)
>                 goto out;
>
> --
> 2.17.1
>

Kind regards
Uffe
