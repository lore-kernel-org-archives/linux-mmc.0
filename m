Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4596EC4167B
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FAC322B48
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgLDOkB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 09:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbgLDOkB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2020 09:40:01 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568CAC08E861
        for <linux-mmc@vger.kernel.org>; Fri,  4 Dec 2020 06:39:00 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id x13so1911492uar.4
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2020 06:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALFvhZ1OjbfVf/iAkbXtpPEl6kf7hFGESlUg72YwV2s=;
        b=s3Ku7AVE/9HH3DtwPJCfcA81tzqrP0dq8xSrkCN0QiwbH/+JoOwR6RvK1IlmjghAXd
         0ieHFh843CCnahnuHpDrm6y8SBYLZByGQaSbhLCTRwzXMnxueF4/+gz6e8szcZTvV3dY
         5EcmxsyWv/AMyx2WqithnYA33e8SJeiKc3wVrfky9TCUzo9wUNNKQzaScpg3jlGHPyxu
         yWWo+K37fKgomlEB96lOu2lfM7682x5HWKycXPfYejW6tbMdXcNSg5uRoNZAk89GHafO
         hyo3YXqoS10TSskEcywdeExjeoOJNwcngDBp4mfnGP7WYpySKgHPgOk1h/SWFdolhkN3
         2aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALFvhZ1OjbfVf/iAkbXtpPEl6kf7hFGESlUg72YwV2s=;
        b=tzHGSKh+m0T4Ros0IJAOhDmKnNfCCuE7yhBaJ8MywdH5A6T7X8NqNEao6X31P+EZt4
         QKS0PsPBQMG8LjJtOVfuF57xvSON3ifiIvlQegvAIMfKxqQP3l8uwoKE7dZT3NpUglIi
         83/djNu1hdWLJ5BdmR1MOTzqLQ7UZW4cOUFLiYS1WmUyKOAjlphrRsQ+0p8ncteSOTZV
         ALz05rWoaXcf6nMZe+FqRjMVP0/eUkq1dR5SfzmOvIByPNYPnTvQwHoo1qwdLj9D9cUV
         k7Q1/esLGVMK6nmX/W7G4GinoY52GNqALOAFO7KAPM7Wajs8F0Zwv/LorvFxM+RNknzh
         rntg==
X-Gm-Message-State: AOAM532g35yQ47JfvYQCpsk+GQpCZpDcYu5Dp7zQGTULbIA57poQJpzu
        sr9re5a7NY0Fue0Pl+g3THUNcAZyWxsAD5nwILZPkg==
X-Google-Smtp-Source: ABdhPJwYn0T6jy/eo/USN9DAFcjbAf/fm07eYkJrF/ELqPyes0vB0Xl/fQW8PCZhOiWLNKZ9Fig4P3TrEJKZ7fe/V1s=
X-Received: by 2002:ab0:23d5:: with SMTP id c21mr3340200uan.129.1607092739611;
 Fri, 04 Dec 2020 06:38:59 -0800 (PST)
MIME-Version: 1.0
References: <20201202202320.22165-1-huobean@gmail.com>
In-Reply-To: <20201202202320.22165-1-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 15:38:20 +0100
Message-ID: <CAPDyKFpq-45z4MdMek0jGjR88QuG8PangcHRV+CJ4u57EcSqzg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: Let CMD13 polling only for MMC IOCTLS with
 the R1B response
To:     Bean Huo <huobean@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        =?UTF-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zliua@micron.com,
        "Zoltan Szubbocsev (zszubbocsev)" <zszubbocsev@micron.com>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Dec 2020 at 21:23, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> The CMD13 polling is only needed for the command with R1B Resp. For the
> command with R1 Resp, such as open-ended multiple block read/write
> (CMD18/25) commands, the device will just wait for its next paired command.
> There is no need to poll device status through CMD13.
>
> Meanwhile, based on the original change commit (mmc: block: Add CMD13 polling
> for MMC IOCTLS with R1B response), and comment in __mmc_blk_ioctl_cmd(),
> current code is not in line with its original purpose. So fix it with this patch.
>
> Fixes: a0d4c7eb71dd ("mmc: block: Add CMD13 polling for MMC IOCTLS with R1B response")
> Cc: stable@vger.kernel.org
> Reported-by: Zhan Liu <zliua@micron.com>
> Signed-off-by: Zhan Liu <zliua@micron.com>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for fixes, thanks!

Note, I took the liberty to rephrase the commit message (and the
header) to clarify things a bit more.

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 8d3df0be0355..42e27a298218 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -580,7 +580,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>
>         memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));
>
> -       if (idata->rpmb || (cmd.flags & MMC_RSP_R1B)) {
> +       if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
>                 /*
>                  * Ensure RPMB/R1B command has completed by polling CMD13
>                  * "Send Status".
> --
> 2.17.1
>
