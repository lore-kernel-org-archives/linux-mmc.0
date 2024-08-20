Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE918E35C
	for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148675; cv=none; b=LDCSOBWvIzG9oKccGsqOdZvUYyg2WfPGs+nkgsDoAzM5MDU0DhxyW0Hmo1l9+tQf2EnMh5ZmgYmcdOF8fD/6LvFK3jYqP5FB9BZywSSUOUbrk5l0Bftfuvy59WGKU9qTuovu6dtYX+DQhPsvuLrxMWJ9mvR8tr6Zry233lZAh64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148675; c=relaxed/simple;
	bh=i5TYGfCUelMOBanhjpuPagP7cNtfb8cIXMZFAGteCyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyy3AedFx58Krt6de+LbGxSkSRnubAHLQvfkzHYAyKubV/PCf0eVxpxnIi+8QPaY/SjXB0/sulK+4Hoe92fa9dyAR5bojNDOBAtIWzDhsWJR8tlE9AzNzRXuByO4XSNl8leZgo8weGbYzV7NdmVvyvjAm1WkFiDBV7DAUuLX55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kbxfAV8X; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kbxfAV8X"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e04196b7603so5781295276.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 03:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724148672; x=1724753472; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i5TYGfCUelMOBanhjpuPagP7cNtfb8cIXMZFAGteCyU=;
        b=kbxfAV8X0dqS+AFl1cmgSlwAus8ZqPoGPmXsdaojAakQXAP8sAWvuYzQ/3csgJjjIM
         OYZsTRjEHIlHBQRmrW8s6NxIbdo9KWSp2MSeLhOnFY5Gw9MmCUvTWh7m+FIgVCErCWUd
         Jm4K9Irz6RI3uNqdb+094t5bJrV9CnwPDaciKdAB1j/8KsYCN3JeGeEcrB0HtLFj/fHw
         tn+NFbog97/RlslYl8GH8lLtunFYtnmBT2BqVH72+nbXLH0vpJrIM6InCq5SZbjoehDa
         tf+SVIjTzFz0QpKCQWjyfidSDILPc7Nt0ls3X2kgts/OqAiHFEe5MZhSmFsOshQ5zMzN
         46xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724148672; x=1724753472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5TYGfCUelMOBanhjpuPagP7cNtfb8cIXMZFAGteCyU=;
        b=Lz7+1IzDea1YlfnRfAJx43Yxc/BscdEOG7fdcKMv2Vs1PaeDqQxRR1WnFIeNVWg2A5
         g2B7HsuvwMIoKrvCMR0ucdkzPAE5r/ZxNwhVlnTmpLftM6caoQ7ZClOQPHOmlvNOPVx9
         foUMDFbEER/0bJdA8bHPPg8OqtHYSUMD9CKodPzkEXXVhXXJRIP0O0jhCJJFyAjDXV0f
         lPxDHPOyg+Ds3A9l7mvPzhXZzpBnGiCsFiHKPasaHnSXibUgwMZMNsP4F/P4z1EIED7o
         Niwu0T8K7MdNkb5lAtfVTV0c2Wq7PSNlJfXlz/ZxiTgPhI6g/lDQTUlsN8nOsNG/ECox
         Aaqg==
X-Forwarded-Encrypted: i=1; AJvYcCWdnvZQJcmgm629cAVIoVzIQ2OUeAWivGSLQUevYKI9b7GETAQgOe6a+HOYT2IqKc/mOrCXc66d61U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5V9PmK3YOjIHsztOAISxe7nzbn6LHTGmDrZMN4mvVAg6PBiLy
	IDHggaubYwd3S+uSkpbZ8U8IT3E9wBxJorMtX3YOBnGveijx4U2OKUdfDiWp0a0T/gxCCJYyr7e
	Nnats9HFv+1SgB2tYK3ASZomHFuHg0WrQJn1BnKqN92nNGYcnh30=
X-Google-Smtp-Source: AGHT+IErrxvxz6JT6SDgWWYPvPjCkpDVjkosUEitaQn1C0sbXlMxUXU/ZcYt+/OYNYmFQ0PXuxuRx2NWjfkW7hhPohM=
X-Received: by 2002:a05:6902:2b8b:b0:e03:a6b3:9f28 with SMTP id
 3f1490d57ef6-e1180ea3457mr17287703276.10.1724148672124; Tue, 20 Aug 2024
 03:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802032121.GA4019194@sony.com> <CAPDyKFoTdMpvuXR16OqY8G6t_4jCJDW9+wz=_fBc=kZSL1KbqQ@mail.gmail.com>
 <20240806013610.GA3438728@sony.com>
In-Reply-To: <20240806013610.GA3438728@sony.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 12:10:36 +0200
Message-ID: <CAPDyKFqe2kGysPobXPKXpMhY8=nYRu9b9Om6uetrk9J858dEeg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: apply SD quirks earlier during probe
To: Keita Aihara <keita.aihara@sony.com>
Cc: Jonathan Bell <jonathan@raspberrypi.com>, Tim.Bird@sony.com, Shingo.Takeuchi@sony.com, 
	Masaya.Takahashi@sony.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 03:36, Keita Aihara <keita.aihara@sony.com> wrote:
>
> On Mon, Aug 05, 2024 at 12:14:25PM +0200, Ulf Hansson wrote:
> > On Fri, 2 Aug 2024 at 05:21, Keita Aihara <keita.aihara@sony.com> wrote:
> > >
> > > Applying MMC_QUIRK_BROKEN_SD_CACHE is broken, as the card's extended
> > > registers are parsed prior to the quirk being applied in mmc_blk.
> >
> > In what way is it a problem to read the extended registers first?
>
> SD quirks are referenced by mmc_card_broken_sd_cache() in
> sd_parse_ext_reg_perf(). If the quirk is set, SD_EXT_PERF_CACHE is not
> set to card->ext_perf.feature_support and the cache support will not be
> enabled.
>
> Therefore, SD quirks should be initialized before parsing the extension
> registers.

Makes perfect sense! Please include some of this information in the
commit message to make this clear.

>
> >
> > >
> > > Split this out into an SD-specific list of quirks and apply in
> > > mmc_sd_init_card instead.
> > >
> > > Fixes: c467c8f08185 ("mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus from 11/2019")
> > > Authored-by: Jonathan Bell <jonathan@raspberrypi.com>

This tag isn't normally what we use. I suggest you change the author
of the patch to Jonathan and keep his sob-tag.

Then add yourself with a "Co-developed-by" tag and keep your sob-tag.

> > > Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> > > Signed-off-by: Keita Aihara <keita.aihara@sony.com>

[...]

Kind regards
Uffe
