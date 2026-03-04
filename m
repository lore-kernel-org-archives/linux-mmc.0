Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1735F5FC
	for <linux-mmc@vger.kernel.org>; Wed,  4 Mar 2026 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772641564; cv=pass; b=olM3NmwP+JkzJDLgB8kuDDFEk+apj8+PZ+PKEWB/9OjtGgECXWwyH4gAd+7aOeY85vndjX6Q2HjrCv41M9Ak1SRVtJ6Gw4x5Hzg0xydcTYv8QEDq4QyiP5vrmjw9VLbsx7rZ4Z4W1vNMPrdgVaW4pzYtBBvaTg3o0ReE7BDBDwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772641564; c=relaxed/simple;
	bh=I+CUmlWECLu/6NQx/jToONdpLxSF6c+SC/8SH/fkdFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LC3hFWG7VFqdpD5UdeAB/M+dpI0TYDWbCvRZTGFlEiygP7LTRikOwVQIJ5e81LKRWffG1DxCuI/wT5EB3hYCjyV6XD3zQ8de4oxeiK2QPplqaWefGWmDrExiyzeYr4UbTCQTBCo0MQf2YoRglO0t3q1rMvxQ/8jIoSFskHO4wC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bInXv+iD; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bInXv+iD"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38706f96202so96705741fa.3
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2026 08:26:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772641561; cv=none;
        d=google.com; s=arc-20240605;
        b=Ddo5/KIZws6gxrN5noPQzEDcHnsjzRKxkZsZduJ5TLVh7OYN7OzhQyUs2i+8ASKxFl
         h1R6m+nALB9B1S9DtaeZdWx3bNnq1KX9bOZaE+ERjr4iZUVqaXY6BjCgLKbj0rNXxvL0
         Rn0KZhDuj1kVf2Ocw+uig0tH1J+AKyyG9XDb9GvRe3qYPzv3qOzNWqo+XIo7gHo38E7E
         DxzIha+u0PqDlA7XFknc8njaIaHKHp3/zOgHGorlGkn1qtw85RF3GV/TQR+pKS+3gPxB
         PE+zlsJwOai0mIhbo3ShVuPW0cl4vT+Gd2DH/mSZSp6bAgFuCblrXPri4heF8m8XmDJP
         bYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XwbLgJvTsi2U6kJq+Lpy4iD/7/onsilvoss+jDdGd/4=;
        fh=dmy6u3WrvBWEcPkBRsBgpFWRLw/uWrPePJRBnVXnh7s=;
        b=M+XTpK4czToC7phKZe6dCJjlP1mLMDAZMRPjo7w8LlHRirQyi62AVvA/Cg652mO6oC
         96tyjTkBNcuezTWHveus85xXTjjgfDpH2d9GMISRmz51Pms403hRRFFsXXx1XpnUCphl
         +hgS72W5d+7dvA7NXW78blZBO32/QvB65D3JDWxYoAvbGPZCLVINVWS5dMpJ3uYN0iy/
         ou1w3co5GfwNRIVFMeqeS9OEp0w4rycg0A/GZ7nkiaWUaBwJqVzXB9Q83l2Z0GOheeFG
         VcQQBjW2JQZari1A6oNR9lmB/yg35RuucUfN6U70iWzAt10iVpPDdNfx8hQVRyZ5p+DE
         GQfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772641561; x=1773246361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XwbLgJvTsi2U6kJq+Lpy4iD/7/onsilvoss+jDdGd/4=;
        b=bInXv+iDQ25dipS1UVjSmmdS0mFN94KGIBmOqOq5NTFfkQ+HF7GtT4xgZfVCbqT5j0
         c0KFCCs7NuHcWcmyrap84a7at6Ju7Cts79E1LSELeLW6rFiqUeNnwvNAIiEbwS93I5of
         RcYH0sfdK41NFsbDhJlAfPC4vN6rE9cKt33s8aYt0E5PNS2IByKvzcHxI0ORch4NSZ74
         f3mU4VxNqgM0Dn2m712yPVZRkPakWnFwcN4HM3OWXBziNMZ2hXH2JcYj4rDhAGZlqdqJ
         JJPYWMcOVNLB4biuk5hv2xZ60DB4OOE2VJD+QCWIAyzIrePNFCZjljP39z4+0esKtY0I
         +DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772641561; x=1773246361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwbLgJvTsi2U6kJq+Lpy4iD/7/onsilvoss+jDdGd/4=;
        b=LMhqJFxe339BMBxrpCn+x+I4qMlz+XNXg/sQw9PV4+fXOQGvQ7A/t37EH2YSaEbDq5
         PjkfUa+MkLODks8Euhf9uhDUeBrK4wGeUOnrPlxIilpmf8kAioxvC/JDImpOqrectIIB
         nE3H8Ral2YNgZobf0WHFgwoCYDBcyqxK6yt+o5MQVEFkd3c0Xpd39Z/WahIbITtPJBvB
         HJ9MmRXn+dHQ2i1Tlh+t6iIVF0BB8ULuNl6xY8t6vZp1AGVLj0O892jeZ1qv0ZIUP2t8
         NV3zUh/T98G0UahE2eMb5Mow/gWOefmP4WN9Oz31FGAukNni3+nSL++95V9zriqNawXg
         14oA==
X-Gm-Message-State: AOJu0YwTFP4gy8QZwC1y/NoePUgzw83mTCHg2gvlxla0r//f98EViFs2
	UF4hEjFjgIFY6Enbcwt77SSriqRB9QMiglfip9TzbTRbA7w9qnps31hkJcTYfJeutWw45JsfqdT
	0ZWd62Vo4b+4i48FATFD+L1fw7M0lMTxkhMNHCt61AA==
X-Gm-Gg: ATEYQzw+0Y69H5twHOY0rlGZGoVHg1p5OwTIZnx+2EDhH/1Rkl5Gxxbd9GwtWzehTWx
	73lQkpL8uZYYWGv9qM7hEiNEAh7fLjzYB0eT7ASl0QE0g6gsN2myAb6qZzXGofL+7LPurNsoGui
	VV5G/QPIuzhZCMmYlB1RjcGbU59mHxUZubWhxxTENtrvbWbrNWo2HxAX2xDRJxgxgmI2k/xEoLw
	9Qt7PjLnLPL5zNvGmH2ph5xfK+K+N4Jem+jL2PK8+Ipu/OAnSYh7iO/5BEPVGVS96BE3qIaMMKg
	9rkmATNj
X-Received: by 2002:a2e:3210:0:b0:385:d6b2:f4cc with SMTP id
 38308e7fff4ca-38a2c7b197bmr15368291fa.19.1772641561056; Wed, 04 Mar 2026
 08:26:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026022351-badness-custody-28ad@gregkh>
In-Reply-To: <2026022351-badness-custody-28ad@gregkh>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Mar 2026 17:25:25 +0100
X-Gm-Features: AaiRm53J-AoiBR1L1TyoKeF-eRWGW0Itxwr6bBBRzughSniz5Gi46MmhSvRONQQ
Message-ID: <CAPDyKFp=9qL2XROcTXDsv106FdoFwzziFU6YpBCB85aQ5ZFZRA@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: fix potential use-after-free on remove path.
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Feb 2026 at 14:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Just like in commit bd2db32e7c3e ("moxart: fix potential use-after-free
> on remove path"), we should wait until after we are finished writing to
> the mmc host device before removing it, otherwise it could have been
> already freed.

mmc_remove_host() doesn't actually free the host, but it reverses what
mmc_add_host() did during probe.

Since the moxart driver uses devm_mmc_alloc_host() the last reference
to the host will be dropped after ->remove() completes, leading to
mmc_free_host() to be called for it.

However, improvements can still be made in the ->remove() callback. See below.

>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_2000

What's this?

> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/mmc/host/moxart-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 3dd8f232052f..256e16390ef3 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -690,12 +690,12 @@ static void moxart_remove(struct platform_device *pdev)
>                 dma_release_channel(host->dma_chan_tx);
>         if (!IS_ERR_OR_NULL(host->dma_chan_rx))
>                 dma_release_channel(host->dma_chan_rx);
> -       mmc_remove_host(mmc);
>
>         writel(0, host->base + REG_INTERRUPT_MASK);
>         writel(0, host->base + REG_POWER_CONTROL);
>         writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
>                host->base + REG_CLOCK_CONTROL);
> +       mmc_remove_host(mmc);

Rather than moving this to the bottom of the function, it would be
more correct to move it to the beginning.

This way, we ensure things have been closed down properly before
releasing the dma channels.

>  }
>
>  static const struct of_device_id moxart_mmc_match[] = {
> --
> 2.53.0
>

Kind regards
Uffe
