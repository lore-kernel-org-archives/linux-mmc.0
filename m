Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DFA320CA0
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075393; cv=none; b=JriubZM1jv+cIGkaa5W5+IohMQiJg4EbbmJCNzpUlD2URUnTDoJVwpp5iUl4q+YOZW49H9oagqr4VavOHO7Du9vYEk+FP2ZKdmnMfbQkYRVAx9U0RdgmQspnov0q6YlPVaJaOxpCGK1iFMJN2+tiWQTmKiX5cOt3EuQqR8tnK6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075393; c=relaxed/simple;
	bh=Sk8TWnE1F8njHDuPB8T3xn5YhJaDrvsH8twkDSYX9cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnGvlIiAZpdBfYiL0DKfgdtXelblaXewV89aEDaSKP1yH0Hu00Ss8usUiZLA9pbLEOeuPv++dNUM30yMV+vtmzXHmTAh8BLX0Qg2SIfbEF05/AwwDLL8ynO+x3bt86iD+4GcZ8I7EKM98fx4Yt3svNr7SvOrOJhdQq6zBBNbiWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vEYj685I; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEYj685I"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78a6c7ac38fso59032537b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 04:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764075390; x=1764680190; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1nHAj4MBf6Hp5nlwpLkFtoHhFG7K6iNmZXaotwtFzZM=;
        b=vEYj685I7p9arzIuZRJ+yQGgt739jfUQzEIBUfKG1rI7uj3W02os6hi/cWEkPS8Qy3
         27sPnm9PHJyhSoh80ffamJUm/XLOtML/I8mlszUMzEeb4R2LRb0AzRHF/VLjNzQBprxw
         iyRp6CAykHfQTe8pyjmPR5+qPaZsdH6Bbse0nDreHFzDfc/iT8Cjso+F8s92oTrefJId
         8wPrXPCnw+YJal/qT+eZRhA6HGQ6l6AJcZgBclJVMH0Uw371CgXQhvrfiguXS/VFGMHi
         H2nXDMXf3HuUEm2Wj+KheirceE150ssGO/LYU0tUWYjWJu5RJZe/5wKcymFRDlqbfDyG
         IIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075390; x=1764680190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nHAj4MBf6Hp5nlwpLkFtoHhFG7K6iNmZXaotwtFzZM=;
        b=KnVDJBhqv9fvWIpKV7uNMLuVNvw6tkjvz+z5Mn5lvimwVLL4Qr2MRHrlzo6yy6WBiQ
         MQCnZgbCZU46UCA3Vmv/aWDFCtgcVSSalJLC3JCT2JcL0ylqhuxD/nBC6fo9JT3ywQkO
         I4aK6ZMhHZbSsUq3DT8KMTjuGhP1Q0bZlSIUJeelASCZ+NOsU2wVaJLGnxg3lGLXim6c
         sK9SqRLRXGAPAeC0kRzcKeh+cgnHEZuu5oqyjd9h3WOg2qc1NITpUW9R2eMT/5o8Zrlr
         iGkt6tGRzTji+Htrg8bjeDRsUROLsooPfEnKju9rjIQGLe5Y0OX/UcNp3pUrwbEOvyaI
         op4w==
X-Forwarded-Encrypted: i=1; AJvYcCUn2IfvFORdlDMlS+E1+0G4seKp7MC8mNgeHO6P+33Gh8Vj5OYzzGhqqo3EW9Q8AYSN0HYp7Pv9cnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIrdXzJ2XY9XAAcYyeZe31ImqkOYm5M8VvuX6RjM60dcgNWh80
	kP2MCpxL1A9eZTH08S31zx1gD9/x7t9Eos3Svc1F/OpPRmNkVBcuSEWv+sTM8LzO9ecqrmixo8v
	SRO+WJO38+mdaEXJGQqGL4l6HNs4TM+K/LmOZWf2EHg==
X-Gm-Gg: ASbGnctjgpF0odSjTu6WIhkyjgcY4by02uAChLn29eC0RNQZ7h/ca6Ynkhj7zOp8d51
	09Gelqt8j/Au9R6dkRgT/oj+YQPhYtWpt8aKBO/q4kDB6f0jkFTL6zL9Lj6r9lpcMN/+vyyV4fI
	vvbtklqFr863YOlPQyGS/YjBMpJhQqcL2KunyWVowQ11MppW9Punfwti4WB5xro0CMHTlKNp8h5
	ZWky7yLJIalOZWhXPziNiHoJ7wLyvl+vpAKXPIZcTaPx6RUhRNb8bn4W+BCOPJ0NrxKvJ1wvQrc
	rjEx9z4=
X-Google-Smtp-Source: AGHT+IH/p+RtR6M/oxT287AHNkeQ1hbGCodsY5CHH3YFQPKesxn30gwm0wpRAVMXcD4lqQN/Zs5GZPeC84DFD074Hm4=
X-Received: by 2002:a05:690c:74c7:b0:786:5499:634f with SMTP id
 00721157ae682-78a8b525dcemr119304847b3.41.1764075390368; Tue, 25 Nov 2025
 04:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124112908.3193211-1-neeraj.soni@oss.qualcomm.com>
In-Reply-To: <20251124112908.3193211-1-neeraj.soni@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 25 Nov 2025 13:55:54 +0100
X-Gm-Features: AWmQ_bkNGbp0sdGlVhqlYzK6csz9kqff9YvYTFYI-n19jTeHRLOi7kIWRZck88c
Message-ID: <CAPDyKFpOuwofFGTEqkCUDXLRJ90vEypkrtg+f01KY5S=cW03Wg@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: sdhci-msm: Add support for wrapped keys
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Nov 2025 at 12:29, Neeraj Soni <neeraj.soni@oss.qualcomm.com> wrote:
>
> Add the wrapped key support for sdhci-msm by implementing the needed
> methods in struct blk_crypto_ll_ops and setting the appropriate flag in
> blk_crypto_profile::key_types_supported.
>
> This is a reworked version of the patchset
> https://lore.kernel.org/all/20241101031539.13285-1-quic_spuppala@quicinc.com/
> that was sent by Seshu Madhavi Puppala.
>
> My changes rebase it to use the custom crypto profile support.

Part of the above is good information but doesn't belong in the commit
message. Instead make them part of the patch-information below "---".

>
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>

Please add Eric Biggers and Abel Vesa for any changes related to ICE.
At least, if they have the time we would appreciate their input to
these kind of changes.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-msm.c | 51 +++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4e5edbf2fc9b..351f2a77068b 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1911,11 +1911,6 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>         if (IS_ERR_OR_NULL(ice))
>                 return PTR_ERR_OR_ZERO(ice);
>
> -       if (qcom_ice_get_supported_key_type(ice) != BLK_CRYPTO_KEY_TYPE_RAW) {
> -               dev_warn(dev, "Wrapped keys not supported. Disabling inline encryption support.\n");
> -               return 0;
> -       }
> -
>         msm_host->ice = ice;
>
>         /* Initialize the blk_crypto_profile */
> @@ -1929,7 +1924,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>
>         profile->ll_ops = sdhci_msm_crypto_ops;
>         profile->max_dun_bytes_supported = 4;
> -       profile->key_types_supported = BLK_CRYPTO_KEY_TYPE_RAW;
> +       profile->key_types_supported = qcom_ice_get_supported_key_type(ice);
>         profile->dev = dev;
>
>         /*
> @@ -2009,9 +2004,53 @@ static int sdhci_msm_ice_keyslot_evict(struct blk_crypto_profile *profile,
>         return qcom_ice_evict_key(msm_host->ice, slot);
>  }
>
> +static int sdhci_msm_ice_derive_sw_secret(struct blk_crypto_profile *profile,
> +                                         const u8 *eph_key, size_t eph_key_size,
> +                                         u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
> +{
> +       struct sdhci_msm_host *msm_host =
> +               sdhci_msm_host_from_crypto_profile(profile);
> +
> +       return qcom_ice_derive_sw_secret(msm_host->ice, eph_key, eph_key_size,
> +                                       sw_secret);
> +}
> +
> +static int sdhci_msm_ice_import_key(struct blk_crypto_profile *profile,
> +                                   const u8 *raw_key, size_t raw_key_size,
> +                                   u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +       struct sdhci_msm_host *msm_host =
> +               sdhci_msm_host_from_crypto_profile(profile);
> +
> +       return qcom_ice_import_key(msm_host->ice, raw_key, raw_key_size, lt_key);
> +}
> +
> +static int sdhci_msm_ice_generate_key(struct blk_crypto_profile *profile,
> +                                     u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +       struct sdhci_msm_host *msm_host =
> +               sdhci_msm_host_from_crypto_profile(profile);
> +
> +       return qcom_ice_generate_key(msm_host->ice, lt_key);
> +}
> +
> +static int sdhci_msm_ice_prepare_key(struct blk_crypto_profile *profile,
> +                                    const u8 *lt_key, size_t lt_key_size,
> +                                    u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +       struct sdhci_msm_host *msm_host =
> +               sdhci_msm_host_from_crypto_profile(profile);
> +
> +       return qcom_ice_prepare_key(msm_host->ice, lt_key, lt_key_size, eph_key);
> +}
> +
>  static const struct blk_crypto_ll_ops sdhci_msm_crypto_ops = {
>         .keyslot_program        = sdhci_msm_ice_keyslot_program,
>         .keyslot_evict          = sdhci_msm_ice_keyslot_evict,
> +       .derive_sw_secret       = sdhci_msm_ice_derive_sw_secret,
> +       .import_key             = sdhci_msm_ice_import_key,
> +       .generate_key           = sdhci_msm_ice_generate_key,
> +       .prepare_key            = sdhci_msm_ice_prepare_key,
>  };
>
>  #else /* CONFIG_MMC_CRYPTO */
> --
> 2.34.1
>
