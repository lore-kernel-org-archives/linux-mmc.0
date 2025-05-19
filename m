Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E8A2749F2
	for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654740; cv=none; b=O6A3W8KBkX1+zhX62EYQy5GwFk1H9VL9EezZjzppWPdGLTFtTe4GSTI9HM2bUFEEAwXadZpJ40472WeqPVkH+YpxUcr+uml5O+ShxnhXI9Oty49OAATWy4qRexzglIWd+saxGcqd4o7LwPC/hqvPg4Ahtnlp0jBvf5HWi0UueKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654740; c=relaxed/simple;
	bh=TMHxhEkJeLRrFVomKdfUPmg32HngiwuN7Y8XouZQTSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvoaxQ5BY9rzNqEcdQYJ0O8dl+Iqc0oFTfhwaESm1OCQek7vTWpzZBasjxl5V1HEUxaEE9vybfrkDnC8zPblvPVsomYOBjXUA92UsZJb2IRP+FIGRYVTYvFqf27dmbrFmEvr5aLHswQl25hKoDGQl1bITXnqkzxKc22UBSHpzKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qplCrzOO; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qplCrzOO"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7ba37b2b5bso808485276.0
        for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 04:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747654738; x=1748259538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jGbkzJ0eqqimJI7DwVKRZ7T05jAEAZTanGLLnplCIgc=;
        b=qplCrzOOeNGb+ExJFbmhlwgae5MQ/NMv0uqLEQIn1I1n5sVGLEbN21aaxQ3J6nqHa2
         jR8nMUxnKoAUeVh+cRd5kf2rwMaOoLNDGYVJxXkL9DnOECscng6dlzaclADb6RPbk0pn
         4oUgXaDC95CFSnqhEt+Ej3VlSZGvCbjQk/pGfQWL7BsltrNFChoLGshigd8jLbhJ3c3S
         GnQtbctZb6/i1WkiSnY4nX3EC+lf+B12Se0x9sbmzkM1JgkVJTNjzonW0h7lrg8S8qsm
         DHmbYg7EUx2INULKcSW6QPNM/PfRaMbtbjskt3dFuiHh6psBuuB/98HAl5M3MtZg7kKe
         IpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747654738; x=1748259538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGbkzJ0eqqimJI7DwVKRZ7T05jAEAZTanGLLnplCIgc=;
        b=jKH71IeGydyqfmwoIng2fFPtpCn5L1Kmkj0EBawPhYaCkieHNAdyHkmgvR0puzTSiH
         8kSu2+30em5itomnIiZpBmxlnTPcHrG0zphvxKZcmvs13rk7DzCEpUh6XtNDfO02V7C6
         vJ2tHMOoNUCT0CiPqpRTV466nJO4HRmnE9nvc53F80d7ztBeJI/IrkNJQjd5r6eLxl2k
         U+EiEiaSYOe3sna/gSB9wxfJtm9hD4H614PDDWJoUTGoREqhuLQ+k12IJmBWCJb4RnRV
         SRNUr82i7GJjAjRNjFElnDf+7cgiAfUGVdS5MITJMKXPeISXl8GNsorfDFfhFbimfWjO
         jVEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1lqP+2kaks5IbG2bUmGIr+wGmaz1lP+RvgyfT8MXg+tLho2q2PGhwHYt5ZgHW/mLQt9RUdgkYTN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJo9YnS6yp+v+8zG1c/dIws6o6vH11jrFueCtMPnWwFUcDZC/O
	FuWN6WoYrLb7ys45UVlL2oXKjJG7i5h5UMtBZ9af8Hst/lU0YpG3V0Ir9Ju2vktkSfhVP46TYMn
	qskolxVX2u+ACKFjyJ3F22Wt5QtupvFnsumPopXCl9w==
X-Gm-Gg: ASbGnct4eBpKvC0wHTcOemQEOxM27D2Va5KMbDGu8GYwnKVhcrCudw3zVHCffLYw/6b
	XvPXbOBoh0NSy/OEn4nvG8kGmv9yyZ4sRnGzeLOgV4R39RS8CSGl0VYaZ26n4x8D7yxlgtwN31O
	yaAXXr8oMUkkhYGS/Nj3ZiJvL62NVfXdoNCg==
X-Google-Smtp-Source: AGHT+IGEhk9xvOXamJcUf2c7oYgnHzt7/Q6Jc8A16RlKxL4KhnX0gE0Bk6C5w2N1j0qtNoul2O4nnkYi1A17Lqm3muU=
X-Received: by 2002:a05:6902:1547:b0:e7b:9763:6676 with SMTP id
 3f1490d57ef6-e7b97636a60mr5570580276.17.1747654737919; Mon, 19 May 2025
 04:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-20-k1-sdhci-v3-0-526c35feaa20@gentoo.org>
 <20250509-20-k1-sdhci-v3-2-526c35feaa20@gentoo.org> <4cee9284-8f71-4214-8bc2-48bcb4030e40@intel.com>
 <20250512075631-GYA517379@gentoo>
In-Reply-To: <20250512075631-GYA517379@gentoo>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 13:38:21 +0200
X-Gm-Features: AX0GCFuvP9LYuHS81_oe6T9DU2l0mF54pVYJmbBwMEiyFEMW40gm2OmA7P10SVI
Message-ID: <CAPDyKFpgCMsaP=CZx210Ov=gTCkez-fwEPMwKTGHrzF51p5_TA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-k1: add support for SpacemiT K1 SoC
To: Yixun Lan <dlan@gentoo.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alex Elder <elder@riscstar.com>, Inochi Amaoto <inochiama@gmail.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 09:56, Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Ulf,
>
> On 09:04 Mon 12 May     , Adrian Hunter wrote:
> > On 09/05/2025 16:22, Yixun Lan wrote:
> > > The SDHCI controller found in SpacemiT K1 SoC features SD,
> > > SDIO, eMMC support, such as:
> > >
> > > - Compatible for 4-bit SDIO 3.0 UHS-I protocol, up to SDR104
> > > - Compatible for 4-bit SD 3.0 UHS-I protocol, up to SDR104
> > > - Compatible for 8bit eMMC5.1, up to HS400
> > >
> > > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >
>
> If this isn't too late (as v6.15-rc6 is tagged), I'd like to seek
> the opportunity to queue for v6.16 as no big changes during these
> two review cycles..
>
> I also know people who would expect to have a full rootfs support,
> and this driver is sufficient to bring eMMC up and will make their
> life of development easy..
>
> But if you have different opinion, then I'm totally fine to delay
> it to next merge window, thanks

I have been busy the last week, apoligize for the delay.

I just posted a few minor comments on an earlier version, I didn't see
v3 sorry. Anyway, should be pretty easy to address those comments. If
you manage to send another version within the next couple of days I
can certainly pick this up for v6.16.

Kind regards
Uffe
