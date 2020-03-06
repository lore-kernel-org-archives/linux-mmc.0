Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A71FC10F00
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5219D2073D
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLULudkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgCFKeq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:34:46 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45390 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgCFKeq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Mar 2020 05:34:46 -0500
Received: by mail-ua1-f67.google.com with SMTP id q17so498852uao.12
        for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2020 02:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GT0ntR2z9Q7DroDptCmU+j0smBwinzmlH6vDJL9WblE=;
        b=ZLULudkHvXV4ZvbyBv44o2dHue+GCPa6yYvaj0xzRg1d0/bVL4hPnnUTKze44/a3FH
         ntvxjbf16nm9HhFB8W5vw8AFVFc3obvUxgg7OfGwV1O8G0Jjz6Ry7ZbPbGbLY5kUWbNw
         3mL+Mr60zF9Xi0LmZma5hKELAjezG7cVcMPeBtNRvTxu1uJi4eT/9ohXb58IlPvPh6/O
         zX3y17rSqemcWGylhrV61IkDQEfO6fLJcc0VFI/mJSSoF6YQ9dD8PPeC5YwlymwsPNCs
         68mVTRf/7T3bdFbUIO+z5YVc7VzDqex5xqx+A1gRo64rNaMf/26KVgBRc/joFeoefa1v
         GlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GT0ntR2z9Q7DroDptCmU+j0smBwinzmlH6vDJL9WblE=;
        b=ZNou7z87ch9vAJEvLdmFT0teer8RoN4ByOiCUi1tjb23eiKpUD85l/78tyFL3tk99u
         xQnTaTNYUg0So81P7p4qlmaZpxMlwaIiz74AfbUGEjZEWkV/rEuDKcoDfDwL0XGpxOh0
         OUHT05l6z7JMxA7TjzQpNKYZLU5H87RIRyNJKzV4BW8OTrzPVQJmzHWXJKRiQg0aZ8dE
         qtef/XogbE2swCe38o0xmycCuhEsb+bEMlAyloW5ULsg/fGBhqygG1nkYRrCfVX1a8HG
         ER5DuTvKMyOVMNDoFacT4t+sTkhO1kPqDI2bZvICp6Gq+W/s7hLAASm/XcP/pEsWPHD9
         gPnw==
X-Gm-Message-State: ANhLgQ07JewfEylzZLIScUoWrsI0Rz05hYa4qDeqlWzw1OavhUVyCNDL
        3hr6xtUZt26FTCkHYbrPANfqubSjxQK82n3sAwwkKnWC
X-Google-Smtp-Source: ADFU+vsccrpNmQoGmWKgd27yAiKL7MMj3EMEHiKF8xGAVUuUSDA4ognzPZOwSuNT4QQpNLci0+/3pMczEX5GkpQxeBc=
X-Received: by 2002:ab0:20a:: with SMTP id 10mr1213237uas.19.1583490884114;
 Fri, 06 Mar 2020 02:34:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583470026.git.nguyenb@codeaurora.org> <a4f22132015159005c41f7cce0b361b363c7b845.1583470026.git.nguyenb@codeaurora.org>
In-Reply-To: <a4f22132015159005c41f7cce0b361b363c7b845.1583470026.git.nguyenb@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Mar 2020 11:34:08 +0100
Message-ID: <CAPDyKFreBQPCPxGM3+LZ5rzYW7e1kgm-e5Pgg26XXD76_Fe=TA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mmc: core: Add check for NULL pointer access
To:     "Bao D. Nguyen" <nguyenb@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>, cang@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 6 Mar 2020 at 05:59, Bao D. Nguyen <nguyenb@codeaurora.org> wrote:
>
> If the SD card is removed, the mmc_card pointer can be set to NULL
> by the mmc_sd_remove() function. Check mmc_card pointer to avoid NULL
> pointer access.

As stated in the other replies, this is just a vague explanation to a
*potential* problem.

Please explain the details for how this problem can occur - or a way
to reproduce the problem.

Kind regards
Uffe

>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---
>  drivers/mmc/core/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6b38c19..94441a0 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -666,6 +666,9 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
>  {
>         unsigned int mult;
>
> +       if (!card)
> +               return;
> +
>         /*
>          * SDIO cards only define an upper 1 s limit on access.
>          */
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
