Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ADD27EFEE
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279007; cv=pass; b=W2e1/bFAayTFmtIgAUPZvXIVlwBeW7U48ZaQOY7OwfsRdCvuG0fboXXqvIPTfPcwJrM8t84DEMm4WQZC4MuR9J5/Q4BU7xTA8y4UCPneFz9I4rwBDT7wrc647PqhSSIjgdWmM/lTultpsnA0CJ7Jz8cHAjMQieRfhUcPYP8lVWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279007; c=relaxed/simple;
	bh=836gBfI+o/qQj9Wm80ZiXK2Z8hCWuoDNwqZBhWEi0ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JX6M3zEN0dFcXGZsNkt/xugOeN6bgSenr1VwhZ8yg5u1PITDqwKWNJd4w7ZBkiMLEiUR3U/32M6NUx/bv8DVrkeXEeZczhSprkaeZOh8uRR55FXHIDGv2xKMODEIAZyE5bRic7tmbsFgJSZhaSqyVZarS+aD9Lld6GQiG3ahiuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xUign3uQ; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUign3uQ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a27c329e98so3737747e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 08:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774279003; cv=none;
        d=google.com; s=arc-20240605;
        b=atmaSifA4sSIDJZtX91O3kWXijKI1MFOfLzCvjdbqo0VcLfPrCC76LhmQcsqxS3I8b
         hNc8G5ksQthNKCwo5+9pzpMgPWQlotGV83TWZnq3X8PXhbIywvWfR0sS9/C7j1etizoG
         REpbHyBAr+ECXWG1ATU7cQWYDY5UFmCB96iJfa4aswGDFB5W7avlLaku0mMfTsSz+Ru/
         xTJrtv5+qxBzri40DZvvGOsanLZKKui8tmkR1PFyR51y5SujRJ3PEtVeeCLLMwVflzJz
         /Hfi9QI4C8U0Z2ZxFl7oPFRzSC0QesBm1aWFm6obVGVKSvth9Y5i7MXUFxl8+mmM8FWZ
         72wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PiJLdQFlhIlU3UWbgyoh9CEcw5ImMs6weAHGhpFVB4g=;
        fh=cz0WRVeOi49Bx9Fze+pvhjNsjggm3HY5LXoodu6MtlI=;
        b=GQci+T9SGx4uQcCiVIlh0YO9fg4StnsdfVFSI3L7TP8qIzLE7Vf/1AiT8itmhm31+d
         URblw7spHAQbXlsboVEaUpg9O91U8pAK9vahOlHi0oOyts3oNCshNe5m6lU57fHFXYZC
         hLWk7Vco5R2nPBd6z7mP03sj6mcyb9sTWV7ZKlod1zK1pyyJtr+AjW+O4FmKiU43oq1I
         O7F9jnAegGv0STGQq/HKzZ7KZ6fS7svGrfn7kf/Hp261UF5BKiHF2oWS2685eE2Il0B1
         irlfwWhIrcI9K0byUODK4YP+ah0/8ClIFQ1ni7OWDHtH/yeI6wjMpWzk0LtW4iam+03d
         q8ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774279003; x=1774883803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PiJLdQFlhIlU3UWbgyoh9CEcw5ImMs6weAHGhpFVB4g=;
        b=xUign3uQsneJLCtbdzdUiskjnLzlZTifP2G+Mg+7uM9suvKQBVU6Z8F9LP5htvB6aC
         LuujxyVSazHHp7EHcfaWXnJw87iKEFrOZR8Cb988nWgtVJnSWBB8Ta3xnUWNG9kXdSmn
         nKDzJ6p4DgfgrsZ5GJvri8HONqexZsSrkvwNgm9R7eNI24DG8a0wzjbM4vVBp1TAM10P
         viUxhwJaO4TRS3kxYrI9b19CHFmf7eKBhc8iuReIyTr5HoDfg7AgM4mMn5jxzY92LM5z
         ZMl61wiBWcVXwYco4HlAmxDDPz8bvG14aaz1KzfczEVL0ZExkdAF1m/B/ntnHDXepJ3c
         3HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279003; x=1774883803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiJLdQFlhIlU3UWbgyoh9CEcw5ImMs6weAHGhpFVB4g=;
        b=bDcums6p/sl49R8gT6f+BKDYqQ6yfR1GTDoUCRkzCS7KtXLm+V8JnCGgEXjgSv8YSH
         Y7t3TeRz6ZvrVX+UAhQEh0vpzBU5FsGXfKk0CtSu8nfcmcQblASWqk0dWav3RdSwR3jo
         bBTxRdqvFYEBCKGt1mT5lwuxsi02S2sUvnVMczbmjnnm4QnP2uEgZOrSd9+V17E/NdwL
         QuGDyoQ3jm2fFfjgdaUi7xqommW4asD4/hXoRe7gtFeMUs5jQpYUUyXaslE1FjPv5/al
         auBhhSJsTHvQ7Ret6QS+G7doSXpjJ3cLLPUd50CMc7xTCLA4Qq5v6vwqLEK7IotMhmRO
         npwA==
X-Forwarded-Encrypted: i=1; AJvYcCW2+iTTj5D2ij3a2waPtar02OaLF8lM0XdID/HAC+aa1hNa5EshsJw37khSNBKPaS/jCA5IklCdTQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykgHc7BIgFz/IPbftZOeyNQ4WrawMQluhEfkNytcknErFmuelf
	aSxrcNG3z7vW7y31FMvBBchd1sQfyLYzXdze8jXpcSy1hT3krEDF9pyMkYfuaTqMLT34POaV2yE
	cz/PURZmNgrV7AFzuI1wKJGcqPC1wPWkniLpynlGW0w==
X-Gm-Gg: ATEYQzyg45QAP3jsiONsDLVGRPfxE/ugnzvzDi3MJm+iyYuaTV8S6AEWKoWm3ljhbaA
	7O8nMjlSk2grGaFmI4uy2pANTfS50T9xDwfrXVPkZsCMs65y6s1aupzQLD2HfKa5iefE0UThGrF
	JXwLXC+ysrBUKWMwJUnHtidQoNv4i7xEIux3eNagZR9G+0PSnFduibrvuq/Nk/aC5XSnEQ4KDat
	5IiIUDwqtiqwqoo19yHtzpBCqYSC7kAeHI9DPAgpEX4GN4H4R4P7/VS5t9qKWC3jkTloYOPYYrs
	Af1J9NY2sPno4bPCTdE=
X-Received: by 2002:a05:6512:1388:b0:5a2:8513:8a98 with SMTP id
 2adb3069b0e04-5a285b03660mr3907173e87.5.1774279003114; Mon, 23 Mar 2026
 08:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313081548.3556577-1-neeraj.soni@oss.qualcomm.com>
In-Reply-To: <20260313081548.3556577-1-neeraj.soni@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Mar 2026 16:16:07 +0100
X-Gm-Features: AQROBzBFsi259UlzFHDI-rrUpPXTS-yTjb65_nNw5jK2htXtPesNWqWkUT8UrHA
Message-ID: <CAPDyKFqRG1_1aYavfrA0Ss85B0kcTnjVBeqLgq8PUJUcSx5LUg@mail.gmail.com>
Subject: Re: [PATCH v5] mmc: host: sdhci-msm: Add support for wrapped keys
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: adrian.hunter@intel.com, ebiggers@kernel.org, abel.vesa@linaro.org, 
	linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wenjia.zhang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Mar 2026 at 09:15, Neeraj Soni <neeraj.soni@oss.qualcomm.com> wrote:
>
> Add the wrapped key support for sdhci-msm by implementing the needed
> methods in struct blk_crypto_ll_ops and setting the appropriate flag in
> blk_crypto_profile::key_types_supported.
>
> Tested on SC7280 eMMC variant.
>
> How to test:
>
> Use the "v1.3.0" tag from https://github.com/google/fscryptctl and build
> fscryptctl that supports generating wrapped keys.
>
> Enable the following config options:
> CONFIG_BLK_INLINE_ENCRYPTION=y
> CONFIG_QCOM_INLINE_CRYPTO_ENGINE=y
> CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
> CONFIG_MMC_CRYPTO=y
>
> Enable "qcom_ice.use_wrapped_keys" via kernel command line.
>
> $ mkfs.ext4 -F -O encrypt,stable_inodes /dev/disk/by-partlabel/vm-data
> $ mount /dev/disk/by-partlabel/vm-data -o inlinecrypt /mnt
> $ fscryptctl generate_hw_wrapped_key /dev/disk/by-partlabel/vm-data > /mnt/key.longterm
> $ fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/vm-data < /mnt/key.longterm > /tmp/key.ephemeral
> $ KEYID=$(fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt)
> $ rm -rf /mnt/dir
> $ mkdir /mnt/dir
> $ fscryptctl set_policy --iv-ino-lblk-32 "$KEYID" /mnt/dir
> $ dmesg > /mnt/dir/test.txt
> $ sync
>
> Reboot the board
>
> $ mount /dev/disk/by-partlabel/vm-data -o inlinecrypt /mnt
> $ ls /mnt/dir # File should be encrypted
> $ fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/vm-data < /mnt/key.longterm > /tmp/key.ephemeral
> $ KEYID=$(fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt)
> $ fscryptctl set_policy --iv-ino-lblk-32 "$KEYID" /mnt/dir
> $ cat /mnt/dir/test.txt # File should now be decrypted
>
> Tested-by: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
> This is a reworked version of the patchset
> https://lore.kernel.org/all/20241101031539.13285-1-quic_spuppala@quicinc.com/
> that was sent by Seshu Madhavi Puppala.
>
> My changes rebase it to use the custom crypto profile support.
>
> Changes in v5:
> - Rebased on mmc-next.
>
> Changes in v4:
> - Updated the link for fscryptctl tool in commit message to "https://github.com/google/fscryptctl".
> - Aligned the indentation at few places.
> - Unwrapped few lines of code.
>
> Changes in v3:
> - Updated commit message with test details and moved "Signed-off-by" above the
>   scissors line.
>
> Changes in v2:
> - Updated commit message for clarity.
>
> Changes in v1:
> - Added initial support for wrapped keys.
> ---
>  drivers/mmc/host/sdhci-msm.c | 42 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index da356627d9de..b4131b12df56 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1944,7 +1944,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>
>         profile->ll_ops = sdhci_msm_crypto_ops;
>         profile->max_dun_bytes_supported = 4;
> -       profile->key_types_supported = BLK_CRYPTO_KEY_TYPE_RAW;
> +       profile->key_types_supported = qcom_ice_get_supported_key_type(ice);
>         profile->dev = dev;
>
>         /*
> @@ -2024,6 +2024,42 @@ static int sdhci_msm_ice_keyslot_evict(struct blk_crypto_profile *profile,
>         return qcom_ice_evict_key(msm_host->ice, slot);
>  }
>
> +static int sdhci_msm_ice_derive_sw_secret(struct blk_crypto_profile *profile,
> +                                         const u8 *eph_key, size_t eph_key_size,
> +                                         u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
> +{
> +       struct sdhci_msm_host *msm_host = sdhci_msm_host_from_crypto_profile(profile);
> +
> +       return qcom_ice_derive_sw_secret(msm_host->ice, eph_key, eph_key_size,
> +                                        sw_secret);
> +}
> +
> +static int sdhci_msm_ice_import_key(struct blk_crypto_profile *profile,
> +                                   const u8 *raw_key, size_t raw_key_size,
> +                                   u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +       struct sdhci_msm_host *msm_host = sdhci_msm_host_from_crypto_profile(profile);
> +
> +       return qcom_ice_import_key(msm_host->ice, raw_key, raw_key_size, lt_key);
> +}
> +
> +static int sdhci_msm_ice_generate_key(struct blk_crypto_profile *profile,
> +                                     u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +       struct sdhci_msm_host *msm_host = sdhci_msm_host_from_crypto_profile(profile);
> +
> +       return qcom_ice_generate_key(msm_host->ice, lt_key);
> +}
> +
> +static int sdhci_msm_ice_prepare_key(struct blk_crypto_profile *profile,
> +                                    const u8 *lt_key, size_t lt_key_size,
> +                                    u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +       struct sdhci_msm_host *msm_host = sdhci_msm_host_from_crypto_profile(profile);
> +
> +       return qcom_ice_prepare_key(msm_host->ice, lt_key, lt_key_size, eph_key);
> +}
> +
>  static void sdhci_msm_non_cqe_ice_init(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -2089,6 +2125,10 @@ static void sdhci_msm_request(struct mmc_host *mmc, struct mmc_request *mrq)
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
