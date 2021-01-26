Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F8BC4332B
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 13:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F9A6206F9
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 13:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbhAZNZb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Jan 2021 08:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391709AbhAZJ6v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2021 04:58:51 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2753C061788
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 01:58:36 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id b5so4126269vsh.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 01:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xAUX4GprPzfJpnKS+Lo2k56itTCgxOq8hTIK9hhikBo=;
        b=yMLqhusdi2aisI8n3EYsY4b7uX64DLjmgiN7ntAidBYbDsED5leOQCmJSlsCarF/T+
         Ed34AakMn7atFG1tHuru1bxCZfLwNf3/9RWXCZqJfzrhoYcYJvYvZe3JAWsNcN3mx029
         XvbZasWKe7z20SCTOhJwM5B5hOteG5k+4UWVWSTm7bDy4+lrjVJDZhlEPzteoaS36tCi
         OMPlQCWh5EfwHMGAT0qeom5wyPo9iJfFcvgT/t7wjQ5SWXN46cvFMbJ5nXx1Mbgx6RBk
         AKawWmFxBazSWcZt940JkHuyie/rMXEQA0YAypuSICTCX1A68NMG9s+JBxZurKZbKqMZ
         X7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xAUX4GprPzfJpnKS+Lo2k56itTCgxOq8hTIK9hhikBo=;
        b=MC47L9YHAOjbnfwV++4lmsfIIZm8vAgJZN8VIrVGCDvNGRJ8bEbOYmD+neZ9Jh8YxZ
         0sJOHQIpVBPqLZH+JVEoLR+OR/8u7qCYsN7zkcvRFiD8HcYAKIigbJ202nrr5eYNJBq8
         F7p4Cuq3pZE9L9XpeBDeeznogjs2CSO8ZZiJAZaZ7WbH615y7SDZFGK94qW3qKQwBsu5
         Mtt3zP1tS4dfDIcjFfP/LiKXOwJXHJk3R1APBAL3Jp7vljO3Z6YTlc+FVrZAPeR6gJEM
         MMSldWGkq+oosHKlf1T8kZ1HgWrhnQsvmOFbBpgRnq+pTsL6AkUXJkWJNX2bMn3KcDaM
         ldQw==
X-Gm-Message-State: AOAM533bT9bzx6p1Uo30O97VCOkSD4xbnIIT/M+/MN4dVNt0KtnJkDEw
        ciTqlzBbtqV/fKueyGAGgDX5pTTdvAINidJT0ADp3d6WiWv3yg==
X-Google-Smtp-Source: ABdhPJz/rKFclHqeegtULkB5WJdYhx0oUc8lnkCsoUksDa5rkBDuriXnXzAWxmfhrKfLGYMbfLPN+b1awwoLDJ9pLa8=
X-Received: by 2002:a05:6102:67b:: with SMTP id z27mr2247015vsf.19.1611655115911;
 Tue, 26 Jan 2021 01:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20210121082155.111333-1-ebiggers@kernel.org> <20210121082155.111333-3-ebiggers@kernel.org>
In-Reply-To: <20210121082155.111333-3-ebiggers@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Jan 2021 10:57:59 +0100
Message-ID: <CAPDyKFo_nsZuCX+nVBDTJ5QxZ18mQMx=MssJZtWTfJfFC=u+xw@mail.gmail.com>
Subject: Re: [PATCH 2/2] scsi: ufs: use devm_blk_ksm_init()
To:     Eric Biggers <ebiggers@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Martin, James

On Thu, 21 Jan 2021 at 09:23, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Use the new resource-managed variant of blk_ksm_init() so that the UFS
> driver doesn't have to manually call blk_ksm_destroy().
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

I took the liberty of applying this one to my mmc tree along with
patch1, as it looks trivial to me.

Martin/James - if you have objections or want to ack it, please tell me.

Thanks and kind regards
Uffe





> ---
>  drivers/scsi/ufs/ufshcd-crypto.c | 9 ++-------
>  drivers/scsi/ufs/ufshcd-crypto.h | 5 -----
>  drivers/scsi/ufs/ufshcd.c        | 1 -
>  3 files changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
> index 07310b12a5dc8..153dd5765d9ca 100644
> --- a/drivers/scsi/ufs/ufshcd-crypto.c
> +++ b/drivers/scsi/ufs/ufshcd-crypto.c
> @@ -179,8 +179,8 @@ int ufshcd_hba_init_crypto_capabilities(struct ufs_hba *hba)
>         }
>
>         /* The actual number of configurations supported is (CFGC+1) */
> -       err = blk_ksm_init(&hba->ksm,
> -                          hba->crypto_capabilities.config_count + 1);
> +       err = devm_blk_ksm_init(hba->dev, &hba->ksm,
> +                               hba->crypto_capabilities.config_count + 1);
>         if (err)
>                 goto out_free_caps;
>
> @@ -238,8 +238,3 @@ void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
>         if (hba->caps & UFSHCD_CAP_CRYPTO)
>                 blk_ksm_register(&hba->ksm, q);
>  }
> -
> -void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba)
> -{
> -       blk_ksm_destroy(&hba->ksm);
> -}
> diff --git a/drivers/scsi/ufs/ufshcd-crypto.h b/drivers/scsi/ufs/ufshcd-crypto.h
> index d53851be55416..78a58e788dff9 100644
> --- a/drivers/scsi/ufs/ufshcd-crypto.h
> +++ b/drivers/scsi/ufs/ufshcd-crypto.h
> @@ -43,8 +43,6 @@ void ufshcd_init_crypto(struct ufs_hba *hba);
>  void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
>                                             struct request_queue *q);
>
> -void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba);
> -
>  #else /* CONFIG_SCSI_UFS_CRYPTO */
>
>  static inline void ufshcd_prepare_lrbp_crypto(struct request *rq,
> @@ -69,9 +67,6 @@ static inline void ufshcd_init_crypto(struct ufs_hba *hba) { }
>  static inline void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
>                                                 struct request_queue *q) { }
>
> -static inline void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba)
> -{ }
> -
>  #endif /* CONFIG_SCSI_UFS_CRYPTO */
>
>  #endif /* _UFSHCD_CRYPTO_H */
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index e31d2c5c7b23b..d905c84474c2c 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -9139,7 +9139,6 @@ EXPORT_SYMBOL_GPL(ufshcd_remove);
>   */
>  void ufshcd_dealloc_host(struct ufs_hba *hba)
>  {
> -       ufshcd_crypto_destroy_keyslot_manager(hba);
>         scsi_host_put(hba->host);
>  }
>  EXPORT_SYMBOL_GPL(ufshcd_dealloc_host);
> --
> 2.30.0
>
