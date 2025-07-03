Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2602EA14B
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545205; cv=none; b=rC2zYfzY7wFxftERmUpdNIGARFLId0cf5MHdTJkASs6Pq9elTiI8BaZcHGO+YCgRwIs1qC1+6l/tOK0IBkmNe4vlFy6qXYHkOGRm5lKn0lVCVzgVRjO5enpMbZFtz/CHzYunxs5jc+pj/LRWNVJLCettC/gyJtcR+rUUH+dCldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545205; c=relaxed/simple;
	bh=yfakIDfW4JaD8n7YspMzq+XGk78JLy1DRAAuWtmLotM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnQthZMIDn+R3AG8h6vSjp3eiE6+8G4JWmDG4iYgqJJARbRRCDPi/1sWlSA4a7DtO1l9XiCRmLMrqxak5MYE+9sNpNyCbPHkmqfJxtlKmucsOwGFqtxrBQUxumRFnWhhW6ycMyKaXPQJjXMFbA4vuyasu0hdNSUEPCjDUIZl/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ef/8cPjT; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ef/8cPjT"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e3e0415a7so9887037b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 05:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751545203; x=1752150003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/xgkdQ256Gr+SWkG7Kp5pwf29/+EIB0KaUypu7ps1M=;
        b=Ef/8cPjTtwC9xWc0C8A9jG7t2jd9BSfNxvR4+C9Kz/NgDT/URRT0hfuaNFvx4EJQ/3
         wK8h/MyY0PbG155WlSYDLFJfZotu0Q5ljO/M/CGppIYRIj9pRJFfRXGiG7fL5VGkzh2D
         4Dqj+FYDQsJLMNGRTxRjcg7Cse0e+07QagohJUj1np/CDWKlcHa8YWUbBXYe5k56PJtU
         OonRMJvVS+Bk4Dt8dUVnqLR7cxq/AYJVzx/KLmAxNFUuBa7cD6zknKy3C+jR03pwD7lU
         oDwUdZnXLLJMbjXgiyw926+fy3u0Q+d5H+EY0zd+tIlCW4g5zJpNr8n/O2qzcZ+YIfUg
         uMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545203; x=1752150003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/xgkdQ256Gr+SWkG7Kp5pwf29/+EIB0KaUypu7ps1M=;
        b=BnLYafIoV9HFYqu9UptqB+g57XqmXYmLw/CG11LRZ0J/FI1OaMe6Nzsw39andlpQQH
         HSpJLte57VT3Z/3AWFewTPkFI2iP6EmS7Svs1/m69/WNQo3cGcCA6MQriq3XB07r1aTm
         KStL0spNcvr2vlbm3bIZmM2W53mOSumMaez7L0QypmMYHrpXXkezQx9tA9k/uwZl51yl
         a2zs03por2dX4EG1xh4OKJt4jm06UC0mvKsSpWl4KvXAhp6qiIcnmDeMAkC5uHbS7UrI
         2z5I0ScRNEE1FFQMaoMYhgEzbjwevQUO8e3Drg9EskKrfZSfuKnn/N4JUiOYa2R5oP+7
         wLFg==
X-Forwarded-Encrypted: i=1; AJvYcCU3fN1XLj4PP5JZ5khU60c3NLWfhJaNqSTAoZzqZwV8siuUPEnMFDL9ETzz7oMlnZm5Jui6LH6rC4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJYcjZIFb+dEAGkdaN9QSpLOHl+5RAWkt1+DekElC+SSkXjGe
	DJYRn7fZWb0NIRzTqJuKe3DYW3k02KynV6OwmWpBs8eIDrL8ixpbly0fZ4PFJ98NFMOlxDZJkRy
	xEbBQzvsQv7hcIQfdR5/J9JuXpRqs4a/id+lnfVeIQw==
X-Gm-Gg: ASbGncsNiCyJ6RtOMyZpzQH8kbprcEIvEK3jo8X1inE2UM9z3NplXA++ssR/vtXUCrG
	Gia+Zg/ujVAM4rwqjXZgiTDxlc/VIz7QiFl1D1THiTX9oA4jZPRWGqMIIK/sOnev7kxhDDQnmKu
	pfl+Buxwhk1TjE3hFjhLyXhFHFiwCM43y6KsC1CYWh6Moq
X-Google-Smtp-Source: AGHT+IFc/Dp3srh5iqd7hq8Ngg5hON3p7e6BHwMds3WkJexDoH4IJZlEeKBa5tr6EgM89aB4l//e8QnBGEKWzYq/55s=
X-Received: by 2002:a05:690c:4d09:b0:712:c295:d01f with SMTP id
 00721157ae682-7165ca33154mr27601697b3.3.1751545203096; Thu, 03 Jul 2025
 05:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750943549.git.benoit.monin@bootlin.com> <e244c1377f7b2ad5d026c9d9368a08de3887129f.1750943549.git.benoit.monin@bootlin.com>
In-Reply-To: <e244c1377f7b2ad5d026c9d9368a08de3887129f.1750943549.git.benoit.monin@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Jul 2025 14:19:27 +0200
X-Gm-Features: Ac12FXzupRsyUUbucdgXsXSWaJncWw9XABSgjzl6JCKdNXeKvxiGKlgWFyEkj0s
Message-ID: <CAPDyKFopr_xPEkxZdT5JALTM16SCYiaj1A=_n-805HNPooBQGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-cadence: use of_property_present
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	=?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Jun 2025 at 16:44, Beno=C3=AEt Monin <benoit.monin@bootlin.com> =
wrote:
>
> Instead of using of_property_read_bool to check the presence of the
> cdns,phy-* properties in the device tree, use of_property_present in
> function sdhci_cdns_phy_param_count.
>
> This silences the following warning messages since the cdns,phy-*
> properties are all u32, not boolean.
>
> OF: /soc/sdhci@d8010000: Read of boolean property 'cdns,phy-input-delay-l=
egacy' with a value.
> OF: /soc/sdhci@d8010000: Read of boolean property 'cdns,phy-input-delay-m=
mc-highspeed' with a value.
> OF: /soc/sdhci@d8010000: Read of boolean property 'cdns,phy-input-delay-m=
mc-ddr' with a value.
> OF: /soc/sdhci@d8010000: Read of boolean property 'cdns,phy-dll-delay-sdc=
lk' with a value.
> OF: /soc/sdhci@d8010000: Read of boolean property 'cdns,phy-dll-delay-sdc=
lk-hsmmc' with a value.
>
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-cadence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-ca=
dence.c
> index a94b297fcf2a..27bd2eb29948 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -144,7 +144,7 @@ static unsigned int sdhci_cdns_phy_param_count(struct=
 device_node *np)
>         int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++)
> -               if (of_property_read_bool(np, sdhci_cdns_phy_cfgs[i].prop=
erty))
> +               if (of_property_present(np, sdhci_cdns_phy_cfgs[i].proper=
ty))
>                         count++;
>
>         return count;
