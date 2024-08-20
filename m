Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D3F14AD2B;
	Tue, 20 Aug 2024 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724196559; cv=none; b=D9zh8/oRtHz6Sw+3wunavMs70ZFPit5VY95xS3tXF4UdVUjq09vbClSS5irhjNx4kUCL/JeLboyLIeMG586NV0hIWPJVQJRbvJK5D2BcuTKJ7OhxYMTM+/lq3Q1x2MFkeLmlPHkOhL94Gqjy8manyyonaE5MhXJP8U1QgcKYgFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724196559; c=relaxed/simple;
	bh=0WCWP+oyVeqEVlXNjJOFlLyRPxyMA+1b22SxkKDp7XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSPJwe7udjQ/eYcWTbe0NNqtldM5vwMRhxwstRswc1Hyw1lQOjAC8mnongkSTd1eZ6+QdwWgHd+60Fzrjz1o/B6ISsmIz0tCp2v6Bki4nfj4wLd++7Rau+SGRRqitSL0DFokboFdbRKrvQK5OQK24SU7F+VzqrckfqnQzcqHz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=MGudtBeE; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="MGudtBeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1724196557; x=1755732557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0WCWP+oyVeqEVlXNjJOFlLyRPxyMA+1b22SxkKDp7XY=;
  b=MGudtBeEXYt18A0Efa5J8dr86Hek4bN4wds+VCVLtlsMAehiJUayJVFW
   iXNhgiUligN2S3S7+XKTVrq0OOXSkJ8iWfCVEnHCJp9ft78up3W7uB7ZO
   0oKNdeVOuj8AggJEFWU5USdrLZV+nSiY5cpFarSxm86Pfvjbli1HfQaFw
   R5COPCj4TUrnJGZu9ir7gx4/YQwAJdH+lbh20Ir9lsZab0217EUfUkM5b
   A6z2+mN+jh5gRo+fXuk/UKEj8C8lUt07J+6uLiuYvnaKHqDYs+Nk7wbJf
   8RVfzS0SfYelvKD8/mdnDNo2ZVj2MerXHjTm0qIyeI01zxcxHwt2CP5WL
   Q==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:19:07 +0900
X-IronPort-AV: E=Sophos;i="6.10,163,1719846000"; 
   d="scan'208";a="425268578"
Received: from unknown (HELO LXJ00013846) ([IPv6:2001:cf8:1:1611:9e7b:efff:fe46:27de])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 21 Aug 2024 08:19:07 +0900
Date: Wed, 21 Aug 2024 08:18:58 +0900
From: Keita Aihara <keita.aihara@sony.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jonathan Bell <jonathan@raspberrypi.com>, Tim.Bird@sony.com,
	Shingo.Takeuchi@sony.com, Masaya.Takahashi@sony.com,
	keita.aihara@sony.com, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core: apply SD quirks earlier during probe
Message-ID: <20240820231858.GA439714@sony.com>
References: <20240802032121.GA4019194@sony.com>
 <CAPDyKFoTdMpvuXR16OqY8G6t_4jCJDW9+wz=_fBc=kZSL1KbqQ@mail.gmail.com>
 <20240806013610.GA3438728@sony.com>
 <CAPDyKFqe2kGysPobXPKXpMhY8=nYRu9b9Om6uetrk9J858dEeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqe2kGysPobXPKXpMhY8=nYRu9b9Om6uetrk9J858dEeg@mail.gmail.com>

On Tue, Aug 20, 2024 at 12:10:36PM +0200, Ulf Hansson wrote:
> On Tue, 6 Aug 2024 at 03:36, Keita Aihara <keita.aihara@sony.com> wrote:
> >
> > On Mon, Aug 05, 2024 at 12:14:25PM +0200, Ulf Hansson wrote:
> > > On Fri, 2 Aug 2024 at 05:21, Keita Aihara <keita.aihara@sony.com> wrote:
> > > >
> > > > Applying MMC_QUIRK_BROKEN_SD_CACHE is broken, as the card's extended
> > > > registers are parsed prior to the quirk being applied in mmc_blk.
> > >
> > > In what way is it a problem to read the extended registers first?
> >
> > SD quirks are referenced by mmc_card_broken_sd_cache() in
> > sd_parse_ext_reg_perf(). If the quirk is set, SD_EXT_PERF_CACHE is not
> > set to card->ext_perf.feature_support and the cache support will not be
> > enabled.
> >
> > Therefore, SD quirks should be initialized before parsing the extension
> > registers.
>
> Makes perfect sense! Please include some of this information in the
> commit message to make this clear.

Sure.

>
> >
> > >
> > > >
> > > > Split this out into an SD-specific list of quirks and apply in
> > > > mmc_sd_init_card instead.
> > > >
> > > > Fixes: c467c8f08185 ("mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus from 11/2019")
> > > > Authored-by: Jonathan Bell <jonathan@raspberrypi.com>
>
> This tag isn't normally what we use. I suggest you change the author
> of the patch to Jonathan and keep his sob-tag.
>
> Then add yourself with a "Co-developed-by" tag and keep your sob-tag.

Thank you for your suggestion.
Removed "Authored-by" tag and added "Co-developed-by" tag to right after
the first "Signed-off-by" tag by Jonathan.

[PATCH v2] mmc: core: apply SD quirks earlier during probe

I hope the v2 patch meets the format to treat Jonathan as the patch
author.

>
> > > > Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> > > > Signed-off-by: Keita Aihara <keita.aihara@sony.com>
>
> [...]
>
> Kind regards
> Uffe

Best regards,
Keita Aihara
