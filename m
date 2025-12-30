Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30031D72D
	for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767108851; cv=none; b=DjVef3X7Oy7se0O/6WHIPTsp5v8vKEZ2EYcy4j0DwlOye0C6pBkqinRFVE7FviA+0sN6p8iJ/lnBQAWpTV7UV20DnNinzoVFOTnar7iVGdxb8FmA+INTE81ki0p+wRhEhXGMjsMHIVfIEhY1jQbGmqJiM3hXk8yA0tvHPJtmaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767108851; c=relaxed/simple;
	bh=wJqD1rgj0Lm0qQqIwi8NyDHDqRvgPLdMABaqQhTMM/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0FnNtH8X1fM/6w4K4fLskqPWSIJV+vAp4iIqxmed827yZambc5vmMZiYs9awx9STY5K2CCkX5Bj+O2vKn5kdxfs5QZIKB/4qEIIYrdOBEVX/gOPY8tva4hv2SRrbXwOGI2nhHXkZsPi8e2r8WEi9YhcFmVXoztDAitEfKUvdAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fArbTTDm; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fArbTTDm"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37b983fbd45so76666591fa.3
        for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 07:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767108847; x=1767713647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WCZttmg22Qxf8kbQayNAYIvyEVoP6cFbjGsF38jBTAk=;
        b=fArbTTDm6gNr/6eisHMkkuq51PwgYUmLWR3qmmf992vdv1q2oTRnVQeuEhm43fFD2L
         T4NBnXta00VbnW0oAAfpiqMjSJxI0+g7lOJKRKWRYnVLWn+TeLujQMXEVALNAR3WNoWV
         E987H3XlVPqnRbl+iccNwe5czO0tCjFu0c2ozmeYlCc3Sdd/zRtLX83+sVusTfdtkakL
         4EeFg+LPEflg64QeY2bpBGko+cv2ELqEOLR557Paa6K65e/A4TZkWkq5a0ipfxFSn74G
         2quvR085fxQUk793crc/cxSDZRWa1PXv23GOyMqRyEcETCGIJAzNU45wueESlrDDK+Hd
         wUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767108847; x=1767713647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCZttmg22Qxf8kbQayNAYIvyEVoP6cFbjGsF38jBTAk=;
        b=NZL3Htw07ehnbUGXVXsNmGiacd1QsuYOrYPBynq4/H31FaXVenzqtjJIH7OkV13NLq
         7PkCC5DIy+oy7wrKMX+Tva3q8pQWFt0R3HWg/FC5FoT4CPymW5cuLV15986EohmbtENo
         s+FoEmtqUY0PzELrNIh1WaiuTjz2qmJGNRVgQ2psvGhZziFAk24Zti6ZCTB6wM8dh5CT
         y68veSi+VMREqEOmOesWQi8qEc88TBVPl4Z9aFgu4fYPDZOJw3a7ntJCF6NtBSYdZLOc
         /11iNsRFUecz6cjxBUIOQY/SjvItEtUMPVPtlAveIlbBvnruta5q+3rUjMlJG5JM6qor
         Y+3g==
X-Forwarded-Encrypted: i=1; AJvYcCUhkc6F2NbVwVOUK1rC35F0nj8+WB1V2NwrPPoPQrtKXnlqW4uxYceztx10QhOsI8m14UgKSbn1T9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4LRVdU5o1CVk/Zo5Hs9QIlRuQI7dOOrmEoACX9l+Fv3X+7PlS
	ouWvg8lshqC4kloObGhlIpjz5aeh+uMt7U9qaPBrAt1HR1mdeBc26XAyGVg6CM67+gyCIZf/BYT
	O9eNu6YoLmCkV5/llZ50pi96n6IGk1QJeAl8xb7dfUg==
X-Gm-Gg: AY/fxX5roh7w9drLgmXMKOHb4i2qCanF9miWrQ43580Evrdv+x7LDC6bZzJdqLfhOfc
	5eWFNJZuM84GsQMNPWnBfPHhGumEIgsRPV1NhWNZ3cxOe9111HxtwWpwfU8wEe6vz68IF7CKSp9
	aPJYI6rh0GgFLuVH89Zm0rbAbxwAy7F4i+AGV30Zk74kxUZgS93q8iEPWfy2oeWr9H5BM9YnJnZ
	Et6HY1v3LPcALuCddk1qrenmwdvN+Z3GssJpLi6Rvdr7Hqo2OvIY1X2IOHpGvH0X9eP9z8GSuNT
	pKnRa1E=
X-Google-Smtp-Source: AGHT+IF1ZRydGvnYPXNTIWd90sRtt2p02hzltXR1ku+l7cYxr8qnrN9mS9q3/OVh3HOPCTKVsuN3YUyPy/J2hA4MPVw=
X-Received: by 2002:a2e:be20:0:b0:37f:8332:6ae0 with SMTP id
 38308e7fff4ca-381216428e4mr110761501fa.33.1767108847296; Tue, 30 Dec 2025
 07:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222100338.634144-1-thorsten.blum@linux.dev>
In-Reply-To: <20251222100338.634144-1-thorsten.blum@linux.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Dec 2025 16:33:31 +0100
X-Gm-Features: AQt7F2ovKt5puI0EigUj07IJmrdmNcqNK0t9LEP-gJ38HKXpGP4Lo9BsIk2bUfQ
Message-ID: <CAPDyKFoYNRNwo8UUzwSqKF_=RM21DwTa90MFj96wPaMK24qjdg@mail.gmail.com>
Subject: Re: [PATCH] mmc: cavium: Use clamp to simplify cvm_mmc_set_clock
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Robert Richter <rric@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Binbin Zhou <zhoubinbin@loongson.cn>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Dec 2025 at 11:03, Thorsten Blum <thorsten.blum@linux.dev> wrote:
>
> Use clamp() to simplify cvm_mmc_set_clock() and improve its readability.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
> index 9a55db0e657c..37a88f2a0c86 100644
> --- a/drivers/mmc/host/cavium.c
> +++ b/drivers/mmc/host/cavium.c
> @@ -905,9 +905,7 @@ static void cvm_mmc_set_clock(struct cvm_mmc_slot *slot, unsigned int clock)
>  {
>         struct mmc_host *mmc = slot->mmc;
>
> -       clock = min(clock, mmc->f_max);
> -       clock = max(clock, mmc->f_min);
> -       slot->clock = clock;
> +       slot->clock = clamp(clock, mmc->f_min, mmc->f_max);
>  }
>
>  static int cvm_mmc_init_lowlevel(struct cvm_mmc_slot *slot)
> --
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
>
