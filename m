Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD16C433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 11:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7D761458
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 11:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhEGLfy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 May 2021 07:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhEGLfx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 May 2021 07:35:53 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC3AC061574
        for <linux-mmc@vger.kernel.org>; Fri,  7 May 2021 04:34:54 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id x17so198475vsc.0
        for <linux-mmc@vger.kernel.org>; Fri, 07 May 2021 04:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f55cQFhONZr0u6mB8Fak6qVyDt1MOUtBrLmIIiZqgic=;
        b=f6t3iVYg1du6X2O2OD9hfE4OJA+8L2O1WZcrXR4Uk+Yfx0uvFNEMEhcSicqhhR0I5x
         3+eT2YG4YV9zi7Uabg64d8kppicafuFBh+7hevH59fqd7Gvbdc4Cek1DwxEmC/+ir/Q6
         x8+kdx0t/LwoEyq5pTeh2FmhCZrCr1OSu+ui4IEdKVRG8vX8/QDWwJab4yZNm6XmAJGo
         CxIyakTIj7pvDvqSVsBFIVRRiSZR0oPvF0XJ3+KZm/C5sUA+QUhYvd1WGnylkcYPxkLL
         ZtBR8k8f9yxVVdhO4OpuF+2ZecT/AFDAkFxs376iHHRe0b4nL75+ku+m1gtzi9kkIzzZ
         CT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f55cQFhONZr0u6mB8Fak6qVyDt1MOUtBrLmIIiZqgic=;
        b=JlNqaHh/zQcNDcKE/qjVEZoVFAMqew4g67mk0vPaEoKpFRpCWe3ujsT8C5ttQZPjc9
         zIXenyt3jVfbSsOcQ6bHNqoinQSPH7dDYMWRPTMUWe9fm7YhdgewYFZWbbZnmMuuvYz3
         WoyhidMgrB0HTGtkdxr+tcYn/H8hi0SI+HDoTV5iPAHkKxjeMkerRJlZ6KWeBTcw9ZMC
         5rEM5VQRLop02d37PICeR7TJUJuJMnoF4aoP4ESUpTJyaAfYb3L/8VSUVO+VG5BpL6M5
         oo+39tXMrr+Oi1SgQijIBbeVwdT47K1LVlcHpccsChtT+oq/zc6F1wtal7YI4YVcA+kp
         UVqA==
X-Gm-Message-State: AOAM532Y3Ibu0rQVkobQtAGE2JD7neOJ+MDe0CsWiG2exS6DW1ix528U
        aeHqWfFkMn/prBCke7BgPhz0qdCR+4+uH+rW9nAOYA==
X-Google-Smtp-Source: ABdhPJwro9iiUXBzJksekcHR64mnGQzCbCuQxyc4w947+AePVKlKZA0jPNEe9ZK7h67oJNNfYLW18xvRXCge6iJLG3Y=
X-Received: by 2002:a05:6102:505:: with SMTP id l5mr4387167vsa.55.1620387293243;
 Fri, 07 May 2021 04:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <CWXP265MB2680DC98B32CD4B49AA8A224C4599@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <DM6PR04MB657570DB58E7ABBE2C3B0449FC589@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CWXP265MB2680A8DD0FFA6FECBFDFB027C4579@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB2680A8DD0FFA6FECBFDFB027C4579@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 May 2021 13:34:17 +0200
Message-ID: <CAPDyKFqZ580uHgfob5wfn7a_+Y-q3h0YrvirrNYSFT5Q_St2SA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: block: ioctl: No busywaiting of non-TRAN CMDs
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "zliua@micron.com" <zliua@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 7 May 2021 at 12:34, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> Prevent busywaiting for TRAN state indication
> after issuing a command that will not transition
> to TRAN state.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 689eb9afeeed..48be2ca5e3d1 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -446,6 +446,20 @@ static int card_busy_detect(struct mmc_card *card, u=
nsigned int timeout_ms,
>         return err;
>  }
>
> +static inline bool is_tran_transition_cmd(struct mmc_command *cmd,
> +                                         struct mmc_card *card)
> +{
> +       /* Cards will not be in TRAN after completing identification comm=
ands
> +        * or MMC_SEND_STATUS if they are not selected.
> +        */
> +       return !(cmd->opcode =3D=3D MMC_SEND_CID
> +                       || cmd->opcode =3D=3D MMC_ALL_SEND_CID
> +                       || cmd->opcode =3D=3D MMC_SEND_CSD
> +                       || (cmd->opcode =3D=3D MMC_SEND_STATUS &&
> +                        MMC_EXTRACT_INDEX_FROM_ARG(cmd->arg) !=3D card->=
rca));
> +
> +}
> +
>  static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_dat=
a *md,
>                                struct mmc_blk_ioc_data *idata)
>  {
> @@ -593,7 +607,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card,=
 struct mmc_blk_data *md,
>
>         memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));
>
> -       if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) =3D=3D MMC_RSP_R1B) =
{
> +       if ((idata->rpmb || (cmd.flags & MMC_RSP_R1B))
> +                       && is_tran_transition_cmd(&cmd, card)) {

None of the commands you are checking for should have an R1B response
according to the spec, I think.

That said, I don't think we should do these kinds of sanity checks in
the kernel for the mmc ioctls, that just doesn't scale.

>                 /*
>                  * Ensure RPMB/R1B command has completed by polling CMD13
>                  * "Send Status".
> --

Kind regards
Uffe
