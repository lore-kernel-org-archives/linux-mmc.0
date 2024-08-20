Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8B191F8B
	for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166273; cv=none; b=p2cUgLie/NQLKQZu9ieXQUn8jYvl1aDdBNfxh23bXOYhjeboGKhHhLZyM173qCrmqjcWQbsUFUMCUpxUrkagQdKWw5N1FwU4YfhIe1MXnI1GdA8EJj+2/xyjofo0KUT1+otu1MswatC2SybVPIfc5Kt1nH0Sllvqkls8HJJFDFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166273; c=relaxed/simple;
	bh=ah7+7BkSfB911Enb39ddRA57gc04wb8bQEKuZp49XdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MM9a1hxgRjXxoeN0QaDj+t/qdJ+BqlVW9fACs719GRcH8lQR3abb90nmCKSqk/01O8fxa++Adh/+NrFnJ3WJ5epB5JxsYYi6KLN1IzKUPih8IUB+LL/mJZVtsxCE0sJv8Uz8eT2cuVjWI1PxkNzabzzIKJpE++dJuwtdjluDwQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eX3IUulk; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eX3IUulk"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e13cda45037so3800681276.3
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724166271; x=1724771071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QymlgjTNRqIV3rZop0Kitq2l8ztNw7AyLvkCeJKN2Tw=;
        b=eX3IUulkgCWJ0dltsWnS4LO3QIhgYnHAp/tLVRvbZNmIJtgIgyxWomBravJ+Ev2/w1
         LUKpmuBNt0xR98aA5L2RmLV72U86YPjWot9RIIqS/48xSFVVqWWg2wB81ikXi9nBfWOX
         24k7B8sLGyN1jKj55OQg8EUMnmPogk/wPVZFBsr2hFrZqXiYdBKVadt5oIgyT667pDFF
         GOQ7BuNLVN5D/D8CUgRX0+vDsKolDt0pTo02FUm/to3Zk2fwGvKSAeUy4HLQn4Bew6Pi
         OfqOrIz0iFR+Mj+P1AbpwB3tCQvGpa777gl/R+VJrAbUlrRfqSHlYuO560fl9/tQwM8q
         5dBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724166271; x=1724771071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QymlgjTNRqIV3rZop0Kitq2l8ztNw7AyLvkCeJKN2Tw=;
        b=EToeVmZRZZikAh3Od0g1qgTOhKQ4uF+lyzocV4ROOfCjuUa+nc7BfluSPEkI+7Xxae
         OyA1g/DJRbBDFWok98N/dRwx/gGHettFKVAbzKXW6gEKA6D3zdxwb8Z9H6/rQqon502h
         1vk00esVTW2zo3bZeWKXtbHNYGblwTrC6ygEq8Ds5j0VCK9brY9inLdo449fXHLJQMCM
         ibg07L46vTkdyVpwe/SU60iHGFERDXtta8Ggtu7WOIFjYbddkLOSN0iRaktIEhwYLCvK
         ASdOj+5Gb3qAytU7ZupPgTAQsywvStQ2mW+Jc3+VSqCPAuM0H4t7RkW/wvMeARs73Z4t
         81oA==
X-Forwarded-Encrypted: i=1; AJvYcCXRZz0nSBnl1iwThGDauAiHWcLmUdnxwjlfqLyBFs+PQ5seCjxKNpQM5od/SMbkosEIizHP8fasotlTYbT9LUi7aljGccz/N0jw
X-Gm-Message-State: AOJu0Yyvnb2Cek1UMCp9KjVsctCCbOSCcPXLk86kUW2M7xBJaTSDI238
	tI7DNdx0YvZXhB3/apYicbODz6WgLZsrcP9edhXIyzDUZQKX0qAzAOF8jaXVQ6UMdl9KlN69pXF
	M66aDalSehYw26ILwKZ55q5vtK1EhfmzbjEHGukBPRgiic0k9
X-Google-Smtp-Source: AGHT+IHRPogyQeifNNpdcrG/2P/91T40oKsMgqm1u9P+z3SSUiAdkrzhHiYd4En0abFAGkoCse3nJ+T5VYE9Y+owePc=
X-Received: by 2002:a05:6902:270a:b0:e13:da55:4e5d with SMTP id
 3f1490d57ef6-e13da5559c9mr11273007276.38.1724166270614; Tue, 20 Aug 2024
 08:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815201542.421653-1-jm@ti.com> <20240815201542.421653-3-jm@ti.com>
 <CAPDyKFpb0o2w9=nRp98XnqoLKtFOCDssJzy+53mg1bW8y0UmUw@mail.gmail.com> <acbf7997-6989-4de6-bf25-3b5589ad2eb9@ti.com>
In-Reply-To: <acbf7997-6989-4de6-bf25-3b5589ad2eb9@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 17:03:54 +0200
Message-ID: <CAPDyKFoekvs1XLGVewB8vA=rsGN4ikB9uw80AVw6NVRF-rgffA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci_am654: Add tuning debug prints
To: Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 16:41, Judith Mendez <jm@ti.com> wrote:
>
> Hi Ulf Hansson,
>
> On 8/20/24 6:33 AM, Ulf Hansson wrote:
> > On Thu, 15 Aug 2024 at 22:15, Judith Mendez <jm@ti.com> wrote:
> >>
> >> Add debug prints to tuning algorithm for debugging.
> >>
> >> Signed-off-by: Judith Mendez <jm@ti.com>
> >> ---
> >>   drivers/mmc/host/sdhci_am654.c | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> >> index c3d485bd4d553..a909f8de0eabe 100644
> >> --- a/drivers/mmc/host/sdhci_am654.c
> >> +++ b/drivers/mmc/host/sdhci_am654.c
> >> @@ -457,11 +457,13 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
> >>
> >>          if (!num_fails) {
> >>                  /* Retry tuning */
> >> +               dev_err(dev, "No failing region found, retry tuning\n");
> >
> > A dev_err seems to be too heavy, but I am not sure at what frequency
> > this could occur?
>
> Having no failing region is what we call a corner case, it rarely
> happens. The one case where it did happen, it took a good amount
> of time to discover there were no failing regions found. The tuning
> algorithm had to be looped 3 times before finding a failing itapdly.
>
> >
> > Why isn't a dev_dbg sufficient?
>
> I thought about using dev_dbg, but based on some feedback after coming
> upon this issue on a board bring up case, we think it would help
> enormously if we make it as obvious as possible when no failing region
> is found.
>
> The one case where this came up, the dev_err print would only print 3
> times... Now this is only one case and we are not aware of any more
> cases like this, also we cannot replicate on TI EVM's.

What happens if/when we fail here? Do we fail to detect the card or do
we end up running it in some degraded mode?

If the latter a dev_warn, the former a dev_err(). Does that make sense?

>
> >
> >>                  return -1;
> >>          }
> >>
> >>          if (fail_window->length == ITAPDLY_LENGTH) {
> >>                  /* Retry tuning */
> >> +               dev_err(dev, "No passing ITAPDLY, retry tuning\n");
> >
> > Ditto.
>
> Same idea as above..
>
> But with this print, the maximum amount of prints that could be printed
> is 20, is this too many prints in your opinion?

This sounds like dev_dbg to me. We are not really failing, as we are
making a re-try and will most likely succeed then, right?

>
>
> >
> >>                  return -1;
> >>          }
> >>
> >> @@ -505,6 +507,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
> >>          struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> >>          unsigned char timing = host->mmc->ios.timing;
> >>          struct window fail_window[ITAPDLY_LENGTH];
> >> +       struct device *dev = mmc_dev(host->mmc);
> >>          u8 curr_pass, itap;
> >>          u8 fail_index = 0;
> >>          u8 prev_pass = 1;
> >> @@ -542,12 +545,14 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
> >>
> >>          if (ret >= 0) {
> >>                  itap = ret;
> >> +               dev_dbg(dev, "Final ITAPDLY=%d\n", itap);
> >>                  sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
> >>          } else {
> >>                  if (sdhci_am654->tuning_loop < RETRY_TUNING_MAX) {
> >>                          sdhci_am654->tuning_loop++;
> >>                          sdhci_am654_platform_execute_tuning(host, opcode);
> >>                  } else {
> >> +                       dev_err(dev, "Failed to find ITAPDLY, fail tuning\n");
> >
> > The commit message only talks about debug messages, but this is an
> > error message. Perhaps update the commit message a bit?
>
> Sure will do, after we conclude the discussion above and in v2.
>
> Thanks so much for reviewing.
>

Kind regards
Uffe
