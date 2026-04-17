Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF33B6346
	for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2026 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776422731; cv=pass; b=jMMHBh7GEZ9ecJTLSVrJIJ17gN3JquUCAV6Eobj6dgtjhK+eaN6VVB7OUPd4Mk63RjVFdFjUb/5CKvyfaK9Q0pQKZRwPvnaAkQgVb4cnsjX59BeLvS2b7PYMteGP8WlhrRlRTVgcH7GtzVzoro3DETUAjlkWrsm/MGA1j33mjlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776422731; c=relaxed/simple;
	bh=iwcIBWDwgPKPCz8o3pawV+B/U81Du6CQyOF11HWnoxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vy2jOSPxh1373VqImj4QkrbPwThyy8iA3GNEyIPBpbsR9EZcs+jAF0UN90ZBQXOrC3HKIrBgn1h+rrUMypAoHF2jI4aPzPpBTZaEoroAZz0TdLYNvtFgy+ZyxFnHfc5vJ/0kbBFGU+CJf5vJoRlUakSQZPXiq3H8Xqety++dX2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g39aiy9T; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g39aiy9T"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b93698bb57aso109705466b.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2026 03:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776422726; cv=none;
        d=google.com; s=arc-20240605;
        b=FYq4hL6u4XY3+H3yuxsWX1OKk4ppiuh2sLxDZ6vGaGlEo13CjCvviz1XF/PqKkVeXr
         Ro22p2KDmv352o8g0tAaKocv2mjKq7gTcD0KyGcgafyktAcZZBVrNzmimNlhLSTB8++P
         RlRtSh8Yv4S1zIU/XwN/+LX2JKhCaJQSzfck59WMRekZlp5FOGiN45eTVsPQEjjOgDmW
         vpGrU7TwvF4e97FqB/b0ZdQSbwt5U2Xap19qeKpMhTUOINyALtd4ZmYjztS3m7BAzmvr
         xB0VOtaIIkeI9tF8D2yHRVyTRpmvkPQkS193pJrmICTlruCMmPr0hlDTwgO0cqymLRUB
         gH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iwcIBWDwgPKPCz8o3pawV+B/U81Du6CQyOF11HWnoxY=;
        fh=79y7KnrMCl1tn75niSvdKA0ZyNUvIkwt363g3QVAUqo=;
        b=VOWW1wdTgomqM0T2FRW45ZmPHSzZ0CTbXcMfIuguc/ltXN34T+DB0Vz2ZY5TJOPyH0
         zfTrQP9k5uqj+pLpxUDiy+XWwwBSy5wV0LHl/ubXytF2+0kj9LK51Q5E4W0Ik31SzAgk
         hvoHL38M0Uaibp+rFHzpAkJ54YhlcN7Lf5t5UfDx00YKG5m7/50jDBKKqCQF4vac2tDg
         GrGCFvR+KSc/A6lt+Bzmw8p5+5uWP+9Huhinrtq/MT11gd/NRzyEL6CA0C2OwdlkgfgM
         Zt4iLTlxbx7V1vBHRh4vIIN+YcVoXpvZHzxld7EXnFQ8c1mMLIDigb1WyTcj38C/mG7n
         JmWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776422726; x=1777027526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwcIBWDwgPKPCz8o3pawV+B/U81Du6CQyOF11HWnoxY=;
        b=g39aiy9TiK5TOVJVaidVFSLv6nATQeOaJono/Uh7Ny8+eckkaX8+t8aB8isSRZ+kPy
         93auY2N8f07BdQU298bpFNkp/iweHMaysEyD0fG9TtztGgmUPAbUPjIbwa5l8PIkoKKo
         TQKX06vzKUIUlzdsq0upiZK3bpf1HM55jKaMQhJSohCGgJkGUENxFXO10X4GIyQgmqp+
         THwtCuR6btwuNBtMHTJxnJ2bovDoDbtucHx3H+tv7wE5UPtg19lCEESpsokm4NcNeMLD
         W2LHkYVMEu5KFALL1jGQgpGi3s5hpx0gP5Bn7bT4XDTXnY+Lcu7tCoceWdd4cRtMrKpQ
         8euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776422726; x=1777027526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iwcIBWDwgPKPCz8o3pawV+B/U81Du6CQyOF11HWnoxY=;
        b=rCk6MA8H4AS5Y/e+BNKYEyGWqfvFqg9chRf/0fq/B1zBgsN59Ev/rLhko/F1IPPcw0
         rCg6sybvCtq896FSQtMwBMHj+G76uj9O9UdKf2ZdjKEjv0Jjx5PXtmDH6dPlwNwOeLtV
         gscRyp9TnqFrQ8MpGjM7QjRyESnuamvCM0OGxh0QCYV1oGGnu/2mrMlg8TA3iV0fgADb
         B0KDlEokQy0DNHki0z7XgbrGQdsJhfD5PZK6YBAs4L4TGw49Js/nHZBcoeU0FWjU44n1
         spefgZXXgYogYwJjp2U1/ZomESaqB9aQ7NeoY6Iy7M0K0DEh7u++7ygrDOQHzAn2jced
         aVdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ORktcJutJmoZuPkPwPolSG9IiZhc5qO5oibxKExK+8azwdDuz5/G0B8WsSk9j9eHMD+mWUcrY1sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+vRsDDOKGzKVpph1e600no62NO/ZovcP1yNYh4dTUXbB5eLw
	PcaJnWKchlRzGnkIOwPpeJCfcpOJ9VjQbxy+0tV5DazpqE9khnBI9NfR07uHh5siA/t8BzQnue+
	hQ2oAUn13CX2XxQvycBd4X82XeGl5I50=
X-Gm-Gg: AeBDievv2iJm0mX3n0B8van9ZqDpvHrJTmQPKwfDIy5u1huEFDn+fcGlNdTV8qgGXzo
	IRDNgwqbFrfakNtCkrv1DtiDWlCs9Y2d1tSlX3ayBZNYekeys83grOredZ1R4WN4sp8hcRfLA2f
	6IQB9OAVX6kR95Hklz3RSAoBMTIM58Scw2YTY0KXKjfcqd0XvbK9yWsfDT3KPS2LRFXn4GXf2FP
	qlEUr4t986XeJjWQxu2BfWD9UbdfZh9Yov8gcotgBk5AS5sOIRUzyvrOw+qeQQiiwsVzNhDBGhX
	a5I2n8nnXKJFwIpR531S
X-Received: by 2002:a17:907:60d4:b0:ba3:eaf1:2743 with SMTP id
 a640c23a62f3a-ba421debcc2mr109685166b.19.1776422725529; Fri, 17 Apr 2026
 03:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415123411.437450-1-a.shimko.dev@gmail.com> <ad-mCsvOWWgqt-rc@ashevche-desk.local>
In-Reply-To: <ad-mCsvOWWgqt-rc@ashevche-desk.local>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Fri, 17 Apr 2026 13:45:14 +0300
X-Gm-Features: AQROBzCJH9qmqa693_HnCwfgz1DF9KkvxMcgsArR8zR9gmESO6Oc23oaGKbX92w
Message-ID: <CAOPX747KM+Ct8Edj__ng4GMeLvjnyaBG1T2h54LSr=SFgQcuqQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: add reset control support in suspend/resume
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jisheng.Zhang@synaptics.com, hehuan1@eswincomputing.com, 
	yifeng.zhao@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, 
	Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thank you for your review!

On Wed, Apr 15, 2026 at 5:52=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> No need to repeat the commit message in the comments. It does not add any=
 value.

Got it =3D)

> This is serious behaviour change (might not be, one needs to understand w=
hat it
> does in comparison to no reset (and in accordance with datasheet).
>
> Do you have any HW to test?

I made these changes so that our MMC controller (dwc) can handle the
reset signal not only during the initialization function, but also
during suspend and resume.
Since the reset control was previously stored in vendor-specific
private structures (rk35xx_priv and eic7700_priv), it was inaccessible
from the common PM code.
To make suspend/resume work for our platform, I had to move the reset
pointer to the generic dwcmshc_priv structure, which required updating
the Rockchip and EIC7700 variants accordingly.



> The driver seems can be refactored a lot (with no functional changes) by:
> - replacing *sleep() with fsleep() API
> - dropping unneeded checks like above, clk_disable_unprepare() is error
> pointer-aware IIRC (or it can be made so it is either NULL or valid one)
> - using 'return dev_err_probe()'
>
> This is just a side note in case you are interested.

Yes, sure, thank you!

> No need to add an extra blank line.
okay =3D)


Instead of moving the reset control directly into the common path,
perhaps a cleaner solution would be to introduce a set of platform PM
ops (e.g., suspend/resume callbacks in the variant data).
These ops could be checked for NULL in the common
dwcmshc_suspend/resume functions. For platforms that don't implement
them, the behavior remains exactly as it was before (no reset
assertion),
ensuring zero risk of regression for Rockchip and EIC7700. Our
platform would then simply implement these ops to handle the custom
reset sequence.

What do you think about it?
--
Regards,
Artem
