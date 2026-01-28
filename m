Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C123502B6
	for <linux-mmc@vger.kernel.org>; Wed, 28 Jan 2026 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604205; cv=pass; b=HlNCZhIatNs5Yw0C22hgjFBDmnp80TFFwZzTkjtm7ayz0IZ/pIVB/8qrYJUH2ZxIS6Mk9uk3NBn9SeaSUwdShrb1n6Ky9BMFErfUfNgZmZDmq4tczyIiYSG8ih4Li8LnmqAviQiPN4rNjJh/A+zRuG7TpczAuPJBwfWOKapzFbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604205; c=relaxed/simple;
	bh=wkQ2YLs+0d+kVlK/pgpFGmeOgl5ui9+P0hj5SK+M42o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2pO35FBbdew7xBYSjFtFfw4vfwSyrr+AIHpI+ECoJY64RvINbvPolOPhWXRJ8Ky+GVDVP5hxLUUhc0u/vb+uhRUTxXwNT2bVTQhtyTLXo5mGgr1YoM49xpNz2I7F/k3dfsPZ0YtvXyS0k/uTqhEYChmd0khB5ebBwAjH+8Hvuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zsafabXJ; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsafabXJ"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59dd263bf42so7575552e87.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Jan 2026 04:43:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769604200; cv=none;
        d=google.com; s=arc-20240605;
        b=F4DNFKG7B6iotc2fbQCv8f4QPsi7zPO4Ndx1jsdz7OCF1rKbFh9Efa7CFvcRJCYG95
         4FtSt8qAm6ElrrFLhnphQ8ao4MT/gog+dPblZEu0t9N3c8AR5rfsXT7G3TyDMhwzmGTX
         FHJUzHjA5NQSjAO/jVjYzzYmINB1XlguRXpkxpRBCswQ5iqi8s1KSq9l2bMl7gQZIUby
         QosI5ObQ3gU7bOGYB+WtDOmrUlwlNE8DbOw8YIu2BFVZ74z4HhGTO8+wUK3emTqIKmbl
         q13ufDvXcuwQksFfU3//PnnUVhpKnhV18eT0XPpzse4jG15ZmeQL5rlooiTghOK43rFM
         RrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wkQ2YLs+0d+kVlK/pgpFGmeOgl5ui9+P0hj5SK+M42o=;
        fh=7VLVzn99+nKJD7q+GjjNowmBnvzFVrHIqxI8xZI4A6I=;
        b=EH4sU8wMfuxhUPnlQjcsxY7Z7HQQyX5ZMaZG7jJfRcYj2Wbx/RgtLfmzWDSbtyfD3m
         8d4JXraf09s8u43ZLIWHgzTB0C2EPxOvWY7Kv2kfjNbaDW8f2snfUSR9owDevJUGlmw8
         Jv0r67759NhykAuKEQVdCJNxBiurSlPxFsc4cD5YIZaxqL5q5dQUwroBj39RuanDtDJ9
         xyNFaqSmtDfouCRKzRC9jyOWoLoK2h0NlEH/udzIHfvqCCd+1hbXqj/UkoNS0HAVFsMO
         LcAixdDy1czHbpowq/zUxmXDWKHs+2kASy7+Wch2X5ShgifNYQEs518hDhBPMtFZWOYw
         hCpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769604200; x=1770209000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkQ2YLs+0d+kVlK/pgpFGmeOgl5ui9+P0hj5SK+M42o=;
        b=zsafabXJPrA+mh9v+eyIOTP0iVg/MP88bHHEX0Aic4U5GN9d9rquiMXHsl3JrnQ/aD
         H+aMBFKdwMBuAaTgztogAaBgiUpCksDiusNBkKSWhDeXPIBoQq+tT4GAc9RuZ8VyNcVQ
         UAMFP+7o9iJu8451zo7s6y0TG2uhC5PI9+AXMtabYn053tX0TXU2XiRIC5I1BRpimAYO
         zscckFK//uIbyEGOTJXSdoWt8ZxLP20SnhkTA17x3VldwVkYKLk9MVVz/Uzw9KCC0td3
         Dw7ZzbRorQlNaIWth/5HhNQJqGrTl44HFze/oiUcjE0nyiw88AS0GoFLX84q3TqO52V/
         8aGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769604200; x=1770209000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wkQ2YLs+0d+kVlK/pgpFGmeOgl5ui9+P0hj5SK+M42o=;
        b=g5AGF+YpLja8PW4VzHqz0zCG0Ny8PjTLSJue25WrWMwRtCILras1OyHTYekGGOu+dw
         pK4+8rnC8MdIKVw92zqOJDNdvmJo6f6LhhMwp8W4r3RpD00oLwsV4oa7kSfkJJFdRR5q
         c5qh6bCgYhKmYMKKisf/fRKX2woXiMDQGAi1ZX7TasKVXExyfUrfiDuO7QwZ41b9iTUa
         QWA/JYyRXyLHoET/5WnBntmYOYryUhv2szTd4jKFQtZOYUEPZFGHnle4Uh6ZWYrKRmW/
         lPTaTH3YN4m+GtUnRCX8II3AuTnvARgr7d9GZWjeUsCC6w4X4wAWMoRbf9g/5JNUQwX5
         USLw==
X-Forwarded-Encrypted: i=1; AJvYcCVnVAGFV787GXZl5r94X5l7x98YGdSmBeJojfyjVYuHtafk6v1j6SnE85UMfRVoH68iUrPbFrzaiqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkJ3eJZzcaBnmisd/EGwzedbJ0d8u1wZz3uLpBEa48wCTTMvqy
	UIen2TE2pMySkGk3tvjsAbXfXBId8hBfVrXoAt5aT+hp9mwkXGL8a4SzKpRN+rXqQrF7qMeSgYv
	BPZcLZjShXNLNm6gqOgPPbOxBYiHE8GFeqYiScSixEA==
X-Gm-Gg: AZuq6aKvaDNJQD9Eyx9MianOkd6pE6CWcPVfHvUYcABpgzrSVSXnwfhz9EehL39eX2u
	UYrn6ZaRfeaIrkYHvmuKaMh+3nrUxKS7mLj+Hg5UDAcM5PctR89XwdiAm3GiqlOVUGZps+8KIxI
	gbHYR8fTomYFASb+e1i2pR6HyICG0aFgo90afqsZTeE9mskX3PNmKxiE918adbkYFjQ1CgUN8DV
	UsUM/K7WsQeHrqKdD3OB1bAB45yTAzM8/e8DLZmMZpbhoSd5p/9YIC5rROfapBkUcIyHhRY
X-Received: by 2002:ac2:4e08:0:b0:598:eed4:ec6c with SMTP id
 2adb3069b0e04-59e0401878fmr1999420e87.13.1769604200306; Wed, 28 Jan 2026
 04:43:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229204526.2850803-1-matthew.schwartz@linux.dev>
 <220bd61b3ab743b492632764a38f95f0@realtek.com> <CAPDyKFpt_7SgXKEqpGSYYNcdhrNYLsYEKM0N=sG7YeVxVaYzfg@mail.gmail.com>
 <2cc743fae59d44b68effe8b51152cfe3@realtek.com>
In-Reply-To: <2cc743fae59d44b68effe8b51152cfe3@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Jan 2026 13:42:44 +0100
X-Gm-Features: AZwV_QjDqckcoa2zGEbL1RuXz_abyHELQmJ11eqlk8zc4m743SXD3mXRB_mHPec
Message-ID: <CAPDyKFqMs8UEqCRiFg6L8Xw=qZ0V7TXwTUaoqKkE7rRXvz0Q+A@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx_pci_sdmmc: implement sdmmc_card_busy function
To: Ricky WU <ricky_wu@realtek.com>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Jan 2026 at 04:06, Ricky WU <ricky_wu@realtek.com> wrote:
>
> > > >
> > > > Hi Matthew,
> > > >
> > > > Thanks for working on this patch.
> > > >
> > > > We=E2=80=99ve tested this change on our platforms and can confirm t=
hat
> > > > adding the
> > > > card_busy() callback does resolve the =E2=80=9Ccannot verify signal=
 voltage
> > > > switch=E2=80=9D issue for us =F0=9F=91=8D.
> > > >
> > > > That said, while reviewing the change we noticed a potential
> > > > redundancy in the existing driver logic. In sdmmc_switch_voltage()
> > > > we already perform explicit DAT line stabilization checks via
> > > > sd_wait_voltage_stable_1() and sd_wait_voltage_stable_2().
> > > >
> > > > Once card_busy() is implemented and used by the MMC core during the
> > > > voltage-switch verification phase, these two stabilization steps
> > > > appear to be partially overlapping with what the core now validates
> > > > via card_busy(). In our testing, with card_busy() present, the
> > > > stable_1 /
> > > > stable_2 logic no longer seems strictly necessary and could likely
> > > > be simplified or removed with some adjustment.
> > > >
> > > > From a process point of view, we=E2=80=99re not sure which approach=
 you=E2=80=99d prefer:
> > > >
> > > > Land your patch as-is first, and then we can follow up with a
> > > > separate cleanup/modification patch to adjust
> > > > sdmmc_switch_voltage(), or
> > > >
> > > > We can prepare an additional patch that builds on top of yours and
> > > > share it with you for review, so the changes can be aligned togethe=
r.
> > > >
> > > > Please let us know which option you think makes more sense for
> > > > upstream,
> > > or
> > > > if you=E2=80=99d prefer a different approach.
> > > >
> > > > Thanks again for the fix and for looking into this driver.
> > > >
> > > > Best regards,
> > > > Ricky
> > > >
> > > > > rtsx_pci_sdmmc does not have an sdmmc_card_busy function, so any
> > > voltage
> > > > > switches cause a kernel warning, "mmc0: cannot verify signal
> > > > > voltage
> > > switch."
> > > > >
> > > > > Copy the sdmmc_card_busy function from rtsx_pci_usb to
> > > > > rtsx_pci_sdmmc
> > > to
> > > > > fix this.
> > > > >
> > > > > Fixes: ff984e57d36e ("mmc: Add realtek pcie sdmmc host driver")
> > > > > Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> > >
> > > I have applied this for fixes and by adding a stable tag. I am also
> > > adding Ricky's reviewed/tested-by tag, according to the above.
> > >
> > > Let's deal with the potential improvement on-top, as agreed.
> > >
> > > Kind regards
> > > Uffe
> > >
> > >
> >
>
> Hi All,
>
> Just a gentle ping on the patch below.
> This change is intended as a follow-up cleanup on top of Matthew=E2=80=99=
s
> card_busy() patch, which has already been merged. I wanted to check
> whether this additional adjustment to the voltage-switch path looks OK,
> or if there are any comments or concerns from the maintainers.
>
> We=E2=80=99re happy to rework or rebase the patch as needed.

I suggest that you re-submit the patch (formatted correctly with a
commit message) separately and ask Matthew if he has the time to
review/test it, then will happily apply it.

[...]

Kind regards
Uffe
