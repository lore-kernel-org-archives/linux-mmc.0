Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8E1C433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 14:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B877238E3
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 14:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbhAUOoE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jan 2021 09:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731989AbhAUOn0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2021 09:43:26 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB22C0613ED
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jan 2021 06:42:39 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id a16so723025uad.9
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jan 2021 06:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BvC/wUBpDtVC8NW/Nj6pwtaxWOyv/SI0O5/Rri37VqQ=;
        b=OKd9r/nzEr0AuQ6vKzc2QjU3BAo9z6oRKyzxyVDU6oi+Wc7I2X0g8IviviUY+5zm0t
         5McqOG5POvnEKazbg9ZEWSw1NNTbqDIzIjLOjiGt09AxU6nzi/tDv84fkgwLsQQb9FFU
         IdHw4CRyIQqztjN+a0ML5O2gEwddjItOYlyq/jh4vXlU+dM3sZH+mxbhMOKzGNgFEdv8
         zY8fv1yymEPmdGULk2Jrt+ggwfRdvDjBadqc7jMCNab0kvKxf78wIRYsoS7b4kl44Qr2
         60Deszm7RbPrVf90sQZejwVCJG1Mgqke8uAmbQTdPl/re+cGkRIgoUKmevUmIKPkkt3U
         DcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BvC/wUBpDtVC8NW/Nj6pwtaxWOyv/SI0O5/Rri37VqQ=;
        b=sbsur/S3z7mWkwYxWQHe1Fy7p+cG+LDGqkOqsYBmgCdQiNHfVoGhPUvCmCzL5+Hlht
         1OhPBzhFQbHfzFSAR/erjvAw4C4EAKxasH4ALMT+NczM/FnI9KfXRoUoyWbaP87yr4/F
         sC3BDH1Vm0uzWrqti3vAfsZSACnmE5EJj864WWaBxpLgxLK+2j/wUi4nAmRtHQskbqcW
         TZ8TsyObhUnrV0iIZkjstLjgQSuMKTck5LvrcCQSTKdlh/RuSnYFm7x0iQBOAU6tNlUD
         pd65Gnsfpebyb97hh57u10jLehyxbuEX82xx3vsFmQkfrMZ1zX4tYsi2Rj/lUG5nqVad
         2AfA==
X-Gm-Message-State: AOAM533KKRPTy2w8apxR07Vw6sg2+J1YpLLLds5sMvbWqDguVcFet4wN
        NIjuZTRaQNh/J05IO6E2xSQnIYIR7/vGpLFn+NkKcwZQAhtSPQ==
X-Google-Smtp-Source: ABdhPJweGqkbp2xqCql+HOOHoYuTVRyXbSlZWTm4qFmvWdoVmrS3QI8Z9RpNC+jjkdEC/LhoMCw/M8Q666wtUx4xi/U=
X-Received: by 2002:ab0:1c10:: with SMTP id a16mr53832uaj.100.1611240159022;
 Thu, 21 Jan 2021 06:42:39 -0800 (PST)
MIME-Version: 1.0
References: <20210121090140.326380-1-ebiggers@kernel.org> <20210121090140.326380-7-ebiggers@kernel.org>
In-Reply-To: <20210121090140.326380-7-ebiggers@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Jan 2021 15:42:02 +0100
Message-ID: <CAPDyKFoOL2Dsqb=nKw5hF5hiVLn-TDHWH4Th9icvoLY4aJtpSA@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] firmware: qcom_scm: update comment for ICE-related functions
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Satya Tangirala <satyat@google.com>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

- trimmed cc-list

On Thu, 21 Jan 2021 at 10:03, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> The SCM calls QCOM_SCM_ES_INVALIDATE_ICE_KEY and
> QCOM_SCM_ES_CONFIG_SET_ICE_KEY are also needed for eMMC inline
> encryption support, not just for UFS.  Update the comments accordingly.
>
> Reviewed-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Bj=C3=B6rn, may I have your ack on this one? I intend to queue this via my =
mmc tree.

Kind regards
Uffe

> ---
>  drivers/firmware/qcom_scm.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 7be48c1bec96d..f57779fc7ee93 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -965,8 +965,11 @@ EXPORT_SYMBOL(qcom_scm_ice_available);
>   * qcom_scm_ice_invalidate_key() - Invalidate an inline encryption key
>   * @index: the keyslot to invalidate
>   *
> - * The UFSHCI standard defines a standard way to do this, but it doesn't=
 work on
> - * these SoCs; only this SCM call does.
> + * The UFSHCI and eMMC standards define a standard way to do this, but i=
t
> + * doesn't work on these SoCs; only this SCM call does.
> + *
> + * It is assumed that the SoC has only one ICE instance being used, as t=
his SCM
> + * call doesn't specify which ICE instance the keyslot belongs to.
>   *
>   * Return: 0 on success; -errno on failure.
>   */
> @@ -995,10 +998,13 @@ EXPORT_SYMBOL(qcom_scm_ice_invalidate_key);
>   *                 units, e.g. 1 =3D 512 bytes, 8 =3D 4096 bytes, etc.
>   *
>   * Program a key into a keyslot of Qualcomm ICE (Inline Crypto Engine), =
where it
> - * can then be used to encrypt/decrypt UFS I/O requests inline.
> + * can then be used to encrypt/decrypt UFS or eMMC I/O requests inline.
> + *
> + * The UFSHCI and eMMC standards define a standard way to do this, but i=
t
> + * doesn't work on these SoCs; only this SCM call does.
>   *
> - * The UFSHCI standard defines a standard way to do this, but it doesn't=
 work on
> - * these SoCs; only this SCM call does.
> + * It is assumed that the SoC has only one ICE instance being used, as t=
his SCM
> + * call doesn't specify which ICE instance the keyslot belongs to.
>   *
>   * Return: 0 on success; -errno on failure.
>   */
> --
> 2.30.0
>
