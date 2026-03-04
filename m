Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E537189E
	for <linux-mmc@vger.kernel.org>; Wed,  4 Mar 2026 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772642762; cv=pass; b=P6qZMNPLT14ReMACfLPsm7qMl1DA/pjJ2vI6wVm/lSMpvcFGpze+pIDKz4QCbewElpFgZ1N3WN4sZLxuw2NNzwZva2rbEYoqYCXlsS8s3mhWj7aUs/2UjjaCcnvdmxt5PU+0R96vScsEMMIQTre+yH5VtdvxKon5QoxYO749QFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772642762; c=relaxed/simple;
	bh=Xn4mrHZ95N428i6MZYQDXnsrCqWWD9RHngc4Mamma+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1IMSzi//LZIJwCXF4PuzRJ2SI1Zn/6oqJQICDKs+Dd70i3tmU61w2K8XPkKMm14YWlCOqrUzK8aGioNlv2Bt3R1uTL+masnFVdIkOhwEQxx1PAapYrRia+NuHHOYeSikPUl19ntIOd1UDmkFLt6rMIaoBh0D9DmrsQ/ViRO05s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gqViPD7A; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqViPD7A"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38a1eb8b560so35680971fa.2
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2026 08:45:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772642758; cv=none;
        d=google.com; s=arc-20240605;
        b=B4oWPnkzOnsjAY/JECIorFf1XTNN9bH2cVGYk4G09wN8u3wuL3lp3vWdvrYgICgwuC
         1fF8Ku5SPXTl/1fGY940jBJ3HVM54LZgG5sLZQQZgILQL/g2lCLsPLtGvveEG3PsZA1u
         f/QYvym7P6A8Wp/xngywWRymE1qldE5ffUYcOG1EQpRQ68vpcEVp0qAkTgLCLWwEzuXs
         om2APifmxStv8/iupkmgBipV7TBXpBPcXj5ELv91cDZJvWE91+rIgHVnxYa8xk6wd4br
         l0UorYVMNqGWdHZSOoTb39kPwkckQdeu8FS+/N+pa+KIDRYDR8i0YUxW8V6uk0CTI4D+
         QCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=k3qxdlKEuPdrJH8Pte/wff3Ygvq/uxu8SZlFOQqhsHk=;
        fh=jI8xRg82FcY/xYlfW5Am5+RIrAViiQ+xDszaieeP0Yw=;
        b=RrqGrC525lxMIUms2tKwsCvnOASbfmS1Wp56GVRsBtkaRdJPBs6OD2NSoJOIY0+K1c
         zw6S85oPYdPVqh8uxwm2AH0D5KlwIBCbhrSFg6Cj8ri68oqj5+xhkW3pLQCAzZl2s0SJ
         faE0KSkSzF2EJfH0cT8xq5FOOxzfMdkUahtRLDzMILXQdg8VRcB9pgqIp3hMgCgKMtJU
         eKjfyVPEaW1OvYJyuQ/oVe0c9Mz2zQp9A6vn5mEhJOj81zYSHBRBSTu0Z3qH3z8WZ0TJ
         a6BUH9nZ6UGMz3LJOTwWlnRSJfX1FI3M88U45CmjR5CGmZyT7sCtRpRgxa1NVb6tG2Jp
         JojA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772642758; x=1773247558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k3qxdlKEuPdrJH8Pte/wff3Ygvq/uxu8SZlFOQqhsHk=;
        b=gqViPD7AjhGGcy/Uh0WRIZ9ovyrfnToge8AlufXLERIk6aooH8MwP7R1rs83cHoJx9
         Tpfc96ZhrWpRvSpm5oZAxjiUed7s/BzEWAXEQqA7XudlOQLKtgHoVBS+TxifhZLkzbL2
         XktVh31nriiTyKzf6qZmkK9JTEo3D27FEfXeKr5MtZljrRYHGB7sumlPkBjLkfiN3R7R
         +BBvQEjmWSfNPUPnRQVK5lAMoOJzltsiS82ANpGwfkyE56AdpkhPG8DWo+tfemzHScEH
         e7OVq55PXY7OA8qCqhQ5yR/IADG5MdmoTfPvmo2fhz3VbkIxVD9rNwiLa2ftp+pBwTV8
         TWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772642758; x=1773247558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3qxdlKEuPdrJH8Pte/wff3Ygvq/uxu8SZlFOQqhsHk=;
        b=KMSZrdXXiWOm58KJCnCEWkj8PMUFk1CWvzMtt28C/YzYBFlqMYAT63rWOagReFu6C2
         rSGgpJ3JE99e8MPmyn5mjOtBlXw/vLCgqTo9YfJZ+mBwctnuUdnMrdTLhdXRS5ylsVVk
         JwIZHRkIWvAv0pj5kdNR5CBl6cIsqBm25/ZyRhV7cEuhoKEfTzgYfRh7aOLLx5SMLKMB
         beJWUG0A6FskFWSM43R9aIt7KTbPc759xR+FxvpJ6a9jUd7XJWQNYYkmYNihmDHzIcwL
         OdIYLM6rrs9NQVFzLkTWq+Rm+drNWuYnqISzHkwwFAJU9vj4zpoxcDMKQroTinezFMYe
         RAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFUY8ZGLHv1ep8jTnYftto642HjKIjR5nwl761Gbd8bnl+ZYRqIhtv4hXLhpDJZzvN3EV3HDBDbo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+lMRqTE0nE9o5w6WKRiuI63+p16DQ93tzvlk3EIm2stDm+lj6
	UStWrBF4I+2kAyHE2le1N8ffiuzlJ4TT5TOVzoPTJqFx0JQ4zvgA+qxKj/bVOyLjnXATWyr+86r
	WO66WAcoQ9Co/iWiNCgOVJyzToZG8R4O2HpLXGx9oPyJICHmH/mE0vTs=
X-Gm-Gg: ATEYQzwUfbDKoQulbQvAzDuDbK2bpTgdbOblTA6kjt1bsTjrCpbsjGbhJPgdJU0mvRK
	dS1LfUGZCuKY64NY0M7mqZ177p+XxIndJWGa+w/9YQp15SN0NV9D6naM52wyQRKqfztVpjJl3Ty
	US0rPwe2u7VfrWEnwkdaYfPYN9wqFIln9Wlc0fH7Z8D5E1wRy1D/KbDCnYApBMOD6A4OpI/2svx
	8kOot8nW4nclwUrja9azq2YrjLGqEtnm5Sxh5z6jxIirAtCiUXYPo8NFB0yATOwBVtun2TeHJFT
	rKoPgj+4
X-Received: by 2002:a05:651c:1509:b0:38a:2792:b4f7 with SMTP id
 38308e7fff4ca-38a2c5b6039mr19908311fa.24.1772642757581; Wed, 04 Mar 2026
 08:45:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com> <20260227041108.66508-34-lachlan.hodges@morsemicro.com>
In-Reply-To: <20260227041108.66508-34-lachlan.hodges@morsemicro.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Mar 2026 17:45:21 +0100
X-Gm-Features: AaiRm52dRDirGfxBP2ZwBErVxf4sLGIJPu_ID9B-Ngv6BgEM7NPLN6E8EgHqA7U
Message-ID: <CAPDyKFp6dhmpkMCs=ejYTpR9oNbNz0urtFD2HTvRwOp2Y7H3DA@mail.gmail.com>
Subject: Re: [PATCH wireless-next 33/35] mmc: sdio: add Morse Micro vendor ids
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: johannes@sipsolutions.net, arien.judge@morsemicro.com, 
	dan.callaghan@morsemicro.com, ayman.grais@morsemicro.com, 
	linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Feb 2026 at 05:15, Lachlan Hodges
<lachlan.hodges@morsemicro.com> wrote:
>
> Add the Morse Micro mm81x series vendor ids.
>
> Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>

I understand that those vendor ids will be used by the sdio func
driver to match against. Although, the way the series is ordered makes
no sense to me. Each patch doesn't compile by itself.

Anyway, feel free to add my ack, once you have sorted out how
re-structure your series.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  include/linux/mmc/sdio_ids.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 673cbdf43453..3ccfe3679c91 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -116,6 +116,10 @@
>  #define SDIO_VENDOR_ID_MICROCHIP_WILC          0x0296
>  #define SDIO_DEVICE_ID_MICROCHIP_WILC1000      0x5347
>
> +#define SDIO_VENDOR_ID_MORSEMICRO              0x325B
> +#define SDIO_VENDOR_ID_MORSEMICRO_MM81XB1      0x0709
> +#define SDIO_VENDOR_ID_MORSEMICRO_MM81XB2      0x0809
> +
>  #define SDIO_VENDOR_ID_REALTEK                 0x024c
>  #define SDIO_DEVICE_ID_REALTEK_RTW8723BS       0xb723
>  #define SDIO_DEVICE_ID_REALTEK_RTW8821BS       0xb821
> --
> 2.43.0
>
