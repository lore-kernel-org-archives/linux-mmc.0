Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3AF4E2
	for <linux-mmc@vger.kernel.org>; Wed, 28 May 2025 04:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748407357; cv=none; b=NDxZP6eD5d8/k8TXTtCxQSGIMQJQkHlN6lrBqoGqhdyLOGmWThv7LD9X6ag//wo2xfZr4XpWhJ0zSAC3uBtQzQqlhxMZhvSC43cNSISgd19TpnfpINRfXYEwoYK4/pLRSu3dLKNATkcXU96eMDMXEabgqwyV1cprqBlsWEJbH9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748407357; c=relaxed/simple;
	bh=layjEZbuK9DZgYTVOe+T5k43sSsea/w/pxaoexRdSHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8W8xzy/SN0ND/GsKSwbdlUjhjFPJPGZrRjWDr+iEAdCkRvvYlcIWJGvjfOXoJlXyxq8MT25TDqaCbZNIsuMK+UAYnBq4GDuWpcTXmSHOXuNXYf8KhrS3LhiVjAmGSteO1Q5QcYtntM+U0AM2VJVScpzivXtUnNKjKNh7SdF8eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHLRtPHO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHLRtPHO"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad51ef2424bso843423266b.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 May 2025 21:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748407354; x=1749012154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKdIaa8Maem09e2r8/gXhNTUzjBO19cqMb+s9YDilRk=;
        b=FHLRtPHO7dHWhBrN2FG9nIWf1f+6SW5LDelXm7NwkaaEAPzeVyOIyZq34lU+00ZSLm
         +134reeRatgirIP1yiSs/7NGXHRhUgnNc6If/J7mabQJSU9IWXEo/ObZzlmYf+5lG15X
         KFq1eFqrD9oD1RX0rfzFl9Gi4F0X/Pl5u7v9xW9kxg4DeyXsC9HXu80FX00Qwl9r4K1Z
         djT2MoRFREtF88dlPs9gRuPtjQqbnDR8NUdwWRGaXc1y1JjKpY3X8Ppq0tPSsBpABl/w
         bMo7SxwruJ2Syab/VbAsNDNRzBDXMmosvasd60XvOdbCeUX9rzX/BYqQcoez1zCG16IT
         Jc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748407354; x=1749012154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKdIaa8Maem09e2r8/gXhNTUzjBO19cqMb+s9YDilRk=;
        b=LOGQUFmW+3QFRruhq4X7+YwHsiofpV84M25sjVQjQSNKfwO9ZF+MaAMMDUbEgApqFq
         PJAAmISQGCgQohcKYXfyOCK5zkaf+b+k4SJCjTVvhnv70Rgc4pLMfdje+QrwU5KTXpx6
         IBcLn+8/qMJt2deXcjjdzUHKD6Zx3lQ1+9X+obS6aTZN6QVnGv4mhrEOI+2og+NYYuSO
         3b3NP4bqA9UlJ30IUH1VBgOCPQDAjAxPKmG1CirVXYSzel2TzROKs/vciS5s5/mDPssc
         PjnlMRjpklga90I9EkICJQ1mgBBw+r+FzvNGuJ7389GQeqBvOIZoKh/nmtJCidysCnOx
         FSRw==
X-Forwarded-Encrypted: i=1; AJvYcCUKF/xBBc6I6fhFdJGJfj5tHWhAoYIyTMBWAi2MDfj7s9h0VN8cxdprdXImS2k8wpqVdRBC5MXeV8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxws5IyY715MhjgtkkAz0Aq5hADffUHQDGl1S+Pz5snZ6IJDOUJ
	KJjuVQ6HYHm2VwxvjymDAB6LHitE9iLyCRfB9SIVGRMMMYE+RK4HZfhtXnZmvqA/hiwWL+HAC1+
	Q9u/EgxQ1+SScWbfjCBEeInSjtbDgTUc=
X-Gm-Gg: ASbGnctyFqeiM4ICcyU6bzlZxrHv8TwO+U9hKCLV794TgUz/e5vewS2RG6I3QMGavTQ
	UFh8ozVHW/nOIy0+Xk5E35cW4jZ+ptbhqLywkkzOGUVGVarynzhtSAASoEUyUCektQJVR0P21Gb
	jD88e7xRkbBccmnx/4OaqYPCRGwOwRNzbB
X-Google-Smtp-Source: AGHT+IGIknskN8t5Mo9Bx6fWIoVobETE5Dm+e4jPUV8dy20m2qOh347Ci6qwsLs/e3BB6jtvTCXy+Cj/Ej26l8dZAXQ=
X-Received: by 2002:a17:907:2ce5:b0:ad8:89f8:3f51 with SMTP id
 a640c23a62f3a-ad889f8419fmr552069066b.6.1748407354032; Tue, 27 May 2025
 21:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747792905.git.zhoubinbin@loongson.cn> <dfc7e01a6134e421ae3aa8da3221f67d59706d0d.1747792905.git.zhoubinbin@loongson.cn>
 <753cd65ebf659972c8a33e5f8e579b9fa8738682.camel@codeconstruct.com.au>
In-Reply-To: <753cd65ebf659972c8a33e5f8e579b9fa8738682.camel@codeconstruct.com.au>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 28 May 2025 12:42:21 +0800
X-Gm-Features: AX0GCFvNqOzXkxY_eVqYydfapsa-dE3X-UyFZQRp7gfRCGdy1sKC6L7_7xZ-rCE
Message-ID: <CAMpQs4LchvbX5-1Gr_epq42DSdfj0uegdqaG2Vh=X2DULSbaWA@mail.gmail.com>
Subject: Re: [PATCH 18/34] mmc: sdhci-of-aspeed: Drop the use of sdhci_pltfm_free()
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org, 
	Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew:

Thanks for your reply.

On Wed, May 28, 2025 at 8:44=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Mon, 2025-05-26 at 14:06 +0800, Binbin Zhou wrote:
> > Since the devm_mmc_alloc_host() helper is already in
> > use,
>
> This doesn't appear to be true? aspeed_sdhci_probe() calls
> sdhci_pltfm_init(), and following that through eventually we call
> mmc_alloc_host() (the non-devm_ variant).
>
> That said, there are some error paths in aspeed_sdhci_probe() where we
> leak the object. Improving the code would be helpful, but my
> understanding is this patch isn't right.

Sorry, I have a different thought.
In the original code, there does seem to be a leakage of objects, for examp=
le:

pltfm_host->clk =3D devm_clk_get(&pdev->dev, NULL);
        if (IS_ERR(pltfm_host->clk))
                return PTR_ERR(pltfm_host->clk);

With this error path, we should goto err_pltfm_free;

Now, I have replaced mmc_alloc_host() with devm_mmc_alloc_host() in
Patch-1[1], so I don't think there will be any error path leakage of
objects.

[1]: https://lore.kernel.org/all/6fd5afb003982bb5edbf95f76b605686223730e0.1=
747792905.git.zhoubinbin@loongson.cn/
>
> Andrew

--=20
Thanks.
Binbin
