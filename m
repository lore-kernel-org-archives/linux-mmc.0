Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83072749C8
	for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654944; cv=none; b=Wq1dM8W/7uBpq5NwT5ZL5dNDtmq3U3+15ffc8WO4xlooqI9zyxbNuO29QHhOJFtjrHPs6ujkl7iLfNjrCn/UGRrbKmwPzr2dAukKHf8pfHUt+h/6LQJWTAVJcTtxnsw4Goy9jFWGUfZwe8jUndF2VuyhNofoh7xHLocOlS3Kn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654944; c=relaxed/simple;
	bh=QpvRVedBrBMy10NIbVtvjYN30CB+eR89OGKIdjlaWu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmEbyMhazRIUgNHz7/omyqDLK4NliB9F6u2QEYmxXaaQD/sNacqLgpShehghDmECw5m4AkQphGX0kbY1Qc7QPUPEXBrQ59Py5qV4vK62cocs/IrWrzpuaQgupDGBrwe+02g6l+eheCd6m5agSfh/leDHbUqZJ4NEbBWBtWkuGU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gRhhvab9; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRhhvab9"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so3734534276.3
        for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 04:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747654942; x=1748259742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xi4QP+tb++uj0FmPaNWal/Va1UBFazasXzcN4zOZKIQ=;
        b=gRhhvab9dfHz3HQ/gmOuWwP1oGHRa6gQfM8m/RBXe4D1IDBWgcr8DiNAFTUb0FB+4N
         h4XByRiKnof96q+O93WDFqoKBB1qMlMO1s2tfe2fIvEuydtdbWBXDDM/5qhHTzSV9816
         5JlMyj/0uRJqd62tg/FarSzgaVZrMQsaZnzd1Lp1GV2A///KqPs4AjbZtN6lHDmCDj20
         uokoStP58hB6g0REbHFj1Oo0wVr0AMsZYO6wBXbYSvUgzNHiwWJ7/kxBjTnS6AYP85ad
         FfU5RKpwS7dIIUZrteXjNxDQxelNSECINWQreT14wnkHbCp890gh68a/idAEyUhXvXry
         XRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747654942; x=1748259742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xi4QP+tb++uj0FmPaNWal/Va1UBFazasXzcN4zOZKIQ=;
        b=XxqUuj5gP1XiGae3bo6QkFe6j0tgd9cyRWB6Xs8zImWs3ASbNbUNrvHT8I5JjFYLz2
         AHeFQwJpv6Z4DaOCR6oIljBOqLxpso4Eb09ONsWirUfknw9r2XlMiD7h1Wf52cIov7K7
         eAnYz3eaXK92Hz4wCbDwjXZI5JEVGaSsKuqbGoaa+lTNncD8ftHwacKk4Esg2bQ31s86
         +q5RnxZGhpWhn5m1N2A98+9sGaNdfTLfnumXeORvtuFWtnzi/YWj1+zFSzAaW2Hgf/Lg
         5/1KlAvxoxZveiu64+MN3P+wh/ehj+jhrRthQb3Q9z591BY39uy8UfzsRMNhgahLK0+W
         Au7A==
X-Forwarded-Encrypted: i=1; AJvYcCXy7dTFipOhRy5EzeZ1EB6JpHErddH4Pogg0WjVXjtvF1B9c2fTVJgbkVQUcSFkuHHBn/6HrgUhq4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhaJIbGRBk+wICYJ2CisVBsz8/fttcNoD2N5eosr3eFz7tGje+
	6Nk8vujb9QWTinhb4OWgPClLpSg8D+4G9xy3RYwCw05jYVgYU4Hp8+kZ/Nc3kXPr2eMJku/QPNo
	D12UcVp4aa1jL8PCOzOp9LkHevr+PJmIgjnBmSJz1pw==
X-Gm-Gg: ASbGncsi21RsyrXnO1+qcSH1Sn79l8Ao/UsPk4ksy9u/Wi2t3rhH/wugrbQEonceisd
	ZoY5IB5pNLULYgyQfOpsPH32xl6j7DxZxtaR9E9h1pzC9tlEwtxiD9YFhHYiY3OwHIgYo059psI
	8VPT2QuueJLGf6qbFXsQw3rYw1kJX+rDcs9Q==
X-Google-Smtp-Source: AGHT+IFE9YTmql2J1EDYOQW1GURLdO1CuAEE1Qnz48P0JUcDipJN0t2wX+uqL9weWpYsYzTJL1jtg61xH036CqGhtyI=
X-Received: by 2002:a05:6902:10c3:b0:e78:f2a8:a69b with SMTP id
 3f1490d57ef6-e7b6d3dd2dfmr14389495276.17.1747654941775; Mon, 19 May 2025
 04:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-20-k1-sdhci-v3-0-526c35feaa20@gentoo.org>
 <20250509-20-k1-sdhci-v3-2-526c35feaa20@gentoo.org> <4cee9284-8f71-4214-8bc2-48bcb4030e40@intel.com>
 <20250512075631-GYA517379@gentoo> <CAPDyKFpgCMsaP=CZx210Ov=gTCkez-fwEPMwKTGHrzF51p5_TA@mail.gmail.com>
In-Reply-To: <CAPDyKFpgCMsaP=CZx210Ov=gTCkez-fwEPMwKTGHrzF51p5_TA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 13:41:46 +0200
X-Gm-Features: AX0GCFsB9fU8obeLDfkKRVtLEIl-4TRtUdQD79rwTQ1raKLz78xB0D2YGIo8yS4
Message-ID: <CAPDyKFrtH9AeHCiyJLv+F+tdVKJkhxcvcFj+wgqmAqN2CoC0jA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-k1: add support for SpacemiT K1 SoC
To: Yixun Lan <dlan@gentoo.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alex Elder <elder@riscstar.com>, Inochi Amaoto <inochiama@gmail.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 May 2025 at 13:38, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 12 May 2025 at 09:56, Yixun Lan <dlan@gentoo.org> wrote:
> >
> > Hi Ulf,
> >
> > On 09:04 Mon 12 May     , Adrian Hunter wrote:
> > > On 09/05/2025 16:22, Yixun Lan wrote:
> > > > The SDHCI controller found in SpacemiT K1 SoC features SD,
> > > > SDIO, eMMC support, such as:
> > > >
> > > > - Compatible for 4-bit SDIO 3.0 UHS-I protocol, up to SDR104
> > > > - Compatible for 4-bit SD 3.0 UHS-I protocol, up to SDR104
> > > > - Compatible for 8bit eMMC5.1, up to HS400
> > > >
> > > > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > >
> > > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > >
> >
> > If this isn't too late (as v6.15-rc6 is tagged), I'd like to seek
> > the opportunity to queue for v6.16 as no big changes during these
> > two review cycles..
> >
> > I also know people who would expect to have a full rootfs support,
> > and this driver is sufficient to bring eMMC up and will make their
> > life of development easy..
> >
> > But if you have different opinion, then I'm totally fine to delay
> > it to next merge window, thanks
>
> I have been busy the last week, apoligize for the delay.
>
> I just posted a few minor comments on an earlier version, I didn't see
> v3 sorry. Anyway, should be pretty easy to address those comments. If
> you manage to send another version within the next couple of days I
> can certainly pick this up for v6.16.

Ehh, nevermind. I don't want to hold this back. I have picked this up for next.

Please address my comments on v2 as patches on top instead.

Kind regards
Uffe
