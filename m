Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A9BC4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69D661248
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbhHXO5i (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbhHXO5h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 10:57:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591F3C061757
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:56:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k5so46159333lfu.4
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94zQuF2zFbo2BHHLAgrhRLqgGBQ5k3ytOtZHfIF63W0=;
        b=W8Rag8ItQYE4QWC5Txq0wlwX2p+wPiWKoa02oBFerpiN/mYC01UTDMpgkzON3t4aCE
         2IbbGHgA4LSX4LFQ9Xq/rWEcfwGwfCiDB7lAoRo6q4za1K9XrNAqWiDzifKbNTBpV0fx
         lRkfw3lKeq2o7xjTFEnYdoaIpq97abYjok6+jQ7xmLu0y5Jk7Qzor59tFgyYnHifPfcI
         0Ohin542I9fvqfemyddJ8KSK4MyUpXI4YZur1RTiN5XIbwdiN6HEpTbpEGyNC/FEkxmT
         xehNbADUpUC66/jJy7Ct/pUUUJdQ0Qh70grYaPq81IKtya+pjY/vdSklopmbhsdHo6i3
         oKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94zQuF2zFbo2BHHLAgrhRLqgGBQ5k3ytOtZHfIF63W0=;
        b=m8n0QzqoD0Hqi8fqg96DFWXFXdZoaliML1sMcSgudRr9PqLWBxhtgOTmRWViZdo7Q/
         8qx/6WLU3MFMkrS8/EjTkLsyYUmFda10xGsBozEmr3sIZUBoi2bRVRIz2xhpoaryOJ27
         Lia2pn0l8iai3WaQmqRsoPPMaPp/yu/e6QPs0hv6yv69FORo4oJs7J+75yqcKfjaOLoj
         Y7cQ7ARlSTq/U3oiyHliGq1Nc7BMvQZT6Qvvuzy+npdqp8319NuOEpyFMdRjEzvdHQOe
         GgsSx18jUidGeRACH4IZ/j5RwefwLCBUwYgMpuoYDbzPDCsnkhTLkD8ZG903vLIBDZvK
         IGDw==
X-Gm-Message-State: AOAM533GIwakC1lBQiSi6qGCgRpRpvv/HaB5zI2cY/Z0oUoWTU0XVVNg
        GNE4pPwkVn2QAvyDicXb9XBublxQM6dJ6WZ7BeLG8Q==
X-Google-Smtp-Source: ABdhPJy9adBlM/F3xTZc5XgxXjD/A8wxGhhiHzElK6wV5vIGuoCVJ+aO9KF86RlQ7oTjrrkLEr5A/+p4ouQQOzz5G+Y=
X-Received: by 2002:a05:6512:318e:: with SMTP id i14mr29772880lfe.113.1629817011695;
 Tue, 24 Aug 2021 07:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <1628858041-1911-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1628858041-1911-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 16:56:14 +0200
Message-ID: <CAPDyKFqL2-37L6sKDC1T_cf_Kr8gR7v41C8VfYPyJSALj_zSug@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: correct the tuning command handle for PIO mode
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 13 Aug 2021 at 14:55, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> If sdhci use PIO mode, and use mmc_send_tuning() to send the
> tuning command, system will stuck because of the storm irq
> of sdhci. For PIO mode, use mmc_send_tuning(), it will trigger
> buffer_read_ready interrupt and data transfer complete interrupt.
> In current code logic, it will directly return in sdhci_data_irq,
> can not call the sdhci_transfer_pio(). So the buffer_read_ready
> interrupt storm happen. So for standard tuning method, need to
> excluse this case.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next (and by dropping parenthesis according to the comment
from Adrian), thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/host/sdhci.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index aba6e10b8605..acee54b368b0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3278,8 +3278,14 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  {
>         u32 command;
>
> -       /* CMD19 generates _only_ Buffer Read Ready interrupt */
> -       if (intmask & SDHCI_INT_DATA_AVAIL) {
> +       /*
> +        * CMD19 generates _only_ Buffer Read Ready interrupt if
> +        * use sdhci_send_tuning.
> +        * Need to exclude this case: PIO mode and use mmc_send_tuning,
> +        * If not, sdhci_transfer_pio will never be called, make the
> +        * SDHCI_INT_DATA_AVAIL always there, stuck in irq storm.
> +        */
> +       if ((intmask & SDHCI_INT_DATA_AVAIL) && (!host->data)) {
>                 command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
>                 if (command == MMC_SEND_TUNING_BLOCK ||
>                     command == MMC_SEND_TUNING_BLOCK_HS200) {
> --
> 2.17.1
>
