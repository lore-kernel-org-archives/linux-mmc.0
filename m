Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D4B371882
	for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773598912; cv=pass; b=tZMPsd0vOYWUtp2wVwPubtBgYcB/8lccR/BA1LgCC12chW2RWC8qkvIL38tz6yBywxdzMaYfNfuBEpUyi/rZRBKZIDKQM7/+z1j1EqDriTVa3RuHKWmPtEHxQ1LS9IQwCp5yU1MyZnaPyiysgoI58XLNQqSzdgxGOwtTlMJCH+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773598912; c=relaxed/simple;
	bh=jDWU6AdGhvC5Yx0E6kUWqqP+61uOz52l7eF/UILatEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkq7SEyiqkERp1ej9LHL0gBmpjkFcLwlSUGlxuGViQzZMsGWPb9qIZV6fNQz2R9IE8vT4q+wL0Cw70od/uN3bsi3GNQkVqAaAQDaOBTQHJR1WKfCdJup5oZgm96QTcpGTs7kWKEM5L8/mj25Eq782m22FaSuupWCLHaxe5Qjer8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzAlJRqp; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzAlJRqp"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bd5658b901so244405eec.3
        for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 11:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773598910; cv=none;
        d=google.com; s=arc-20240605;
        b=BmU+tEmI5XsnLAVUzOVTgmFKHXp/UfeUA2NL5GJS4z4grV4selGLs9bWHPRvZCU/IA
         P/yxNXDS6tGn148yDjvQJkFDxSv7hEvczRZJMMknS9tpcHq/i6gx28NEvcaK/XlABFXA
         U8yqaWWJBPRTovwPmq6SkCFQn9JOt47Mh7EBAhBYmokwWBsQE3uXaxLMOcAv0xjlWg/D
         r2dLg/Zz/cw9NAhXsOkVfB2iLovha9oV8aF/IUyENyiIZCQSyp286i97vuead0CSHbwM
         yhMeIcD56wxEAN0eF3OPvHTq0XEOlOBq7s0wK4OPN0q7h2aLSyhvqs0oUgl1j6Nnb+Mp
         kIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jDWU6AdGhvC5Yx0E6kUWqqP+61uOz52l7eF/UILatEI=;
        fh=Qjrh367rrVmf4yIYBOSWw9NQMYq6wvxtzr1OuMUEXKI=;
        b=a0F8A8seUJ5Glr/TbQi5LA4hl6KOj3SPSCZTCYXxXoMfvXaJmFJu3Hjl8IcyjG4Wvw
         TJF0fmHZ8J2Uhiz85aw8vvBZXReekrfYkxAtabLzOgcGqGMG0xxBDjHS4J+234PHBE3k
         5Fbfnn6q/hNV93Eic672aAutG1vPWQh4e0H9ahP3ee2v1LSAVvyVChJo6aXApH7jNw0E
         i1s9FPAsM48sLzyy38tBHZQm2/T6L8Cj5ftG50gZYJ/dKjw1dva7m3W/W/PcCygwITuh
         YWXKC0dpV32NUuqC+fTXHb5/IqianKx0fm8cKpA+6p38xKtb6oR6LnkBW7xrot2oSIN0
         KdBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773598910; x=1774203710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDWU6AdGhvC5Yx0E6kUWqqP+61uOz52l7eF/UILatEI=;
        b=HzAlJRqpf00I5iuQt5ArG5L+zYSPg/yyi6fxZTlxjCp8CMRwrePyDzCKJL+Mh7EWTn
         4IJglDFQ2a/LlW0rB1AT2104r0NadyvffSV9BwRcGBMC5X8zdcvieSw6xmPf1J2w19CT
         MiZMlT1z7h5XQ1mjNI/XDQ3MWb9++Auq54bv+AQf90hLD1mZlQTgnWhbO+pjApY/+N8o
         7FxCHbVJDUTvRLiTdSjS8PEkoERw2lAkJFP4qHcP8JRq19iBMPtUVSy2U5oTHJ3cVLDE
         4zGE3LJSoWMPICo7qW7d6FcrHBxrUtnFzvbbGNGdtQdEN/vPrGdifYVq3oEgGc4FF4kQ
         zoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773598910; x=1774203710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDWU6AdGhvC5Yx0E6kUWqqP+61uOz52l7eF/UILatEI=;
        b=DFod5IdOjOXghSDY+Ii8CIejkXjhV+KnLDDZt7dRmZWGd0lOb4XMaE0qgj3+i0sGev
         IDNk9u6HE5JwZAwIjB/lb4CNvTwZcmQO5JMgxamqzqnUpXZQn9UoTQ3bSNqyMiRorVxJ
         335nOrZ8FuCo+KkOK/tmraXbgb0Yg8rgUR/LlWHtB2Fau+UqTR7F7bB1UC/kLNAhvFDX
         8aseJ8MvPZqgBCEsg6fxqvV9SP2C67YmcTKnxlMDhwG8hmSsr2ei+p2PWJZEXbABA99H
         /Hv6RfNhY0xt4BjPkBotw0o0bQOUjlS1hbWvhtPjRvXq1SS+2kEwawp1+ecdKTfEauTS
         7JrA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ/SGiec29YYVUpbwufyv0Hwa81UfLLLr4ihu3aQbylGSTJoN7iuH+zM9B4q97p2QY7GTR6RnI8XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxMfbOH/ZrzEwMzAEpt3g7pWVkargPJzh9oqcECYxh19caRHRl
	YSsreCfXcLDiM7Jko16y42L4PcxUYQNUk7QWC0uA1TehEN9j5TJnTvO4+s3Y1hxVw/ZHvNqCdKR
	Cd8+Bn/JNigumwp+jog1WGdwNZ7I5zDw=
X-Gm-Gg: ATEYQzz9bquHRlKTNUPPMoqYUrfLHjoYkTlm10L/MJP1Qn106rWbYBq8/Zgr1YNWOUk
	ukr1A2LQ6rhLD2lso/8G4HgubycmPHukaRy85YzMUZTtBrz81dRazcIx3y7LsHRReRw2nj8x/3f
	MxdvpoAYlwuhk1usjdD0ujl2nOFPlucAmwgoaY8xPcizLgAQkJI/8rIrjtq7tj0j/F33IKc7L75
	WaH7iujwKkeRuF0LGJThnva2OisggsiJQAoAAI8XwC8htBCU7ieclSKwo54CgZltAZFALgDVlE/
	aRLJPsg54ASjjocjG0v2jDUqZ6bJvIKvz9RBlasY13hPxPjMR2c31av01Ad2hnnuEWHVLTAzARe
	QIpXaI1NWuNBIdb+LHaRHFA4=
X-Received: by 2002:a05:7300:4313:b0:2c0:bcca:e9ae with SMTP id
 5a478bee46e88-2c0bccaed2cmr503104eec.7.1773598909944; Sun, 15 Mar 2026
 11:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
In-Reply-To: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 15 Mar 2026 19:21:37 +0100
X-Gm-Features: AaiRm504huR_jEPQjv25PhnCGlqvxnPL_8XhiojOoKqXdkJjPbWUaTm98aG9g50
Message-ID: <CANiq72kdfYLmhojMo=vOAc5tULjjB9V4bM=iUmm5cLGpF-zj=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Optimization and alignment for MMC, Rust and iwlwifi
To: =?UTF-8?Q?Adri=C3=A1n_Garc=C3=ADa_Casado?= <adriangarciacasado42@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Boqun Feng <boqun@kernel.org>, 
	linux-mmc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2026 at 6:27=E2=80=AFPM Adri=C3=A1n Garc=C3=ADa Casado
<adriangarciacasado42@gmail.com> wrote:
>
> These changes were previously submitted as a single monolithic patch
> but have now been split into logical, atomic commits as requested.
> The code style has been verified against checkpatch.pl.

Thanks for splitting it and fixing the diff, this is way better.

However, it seems you sent v2 three times. Was that intentional?

In addition, it seems the patches here are independent from each
other, right? Patches that go together in the same series are supposed
to be related in some way and/or they need to be applied together, so
I would suggest sending them separately.

Splitting them into separate patches also means you will have a
smaller list of maintainers to Cc, since here everyone is Cc'd for
things that are unrelated to them.

By the way, I would suggest using the `--base-commit` Git option when
generating the patches (optional, but useful) and also Cc'ing
reviewers as well since that will increase the chances people will see
your patches (you may want to use `scripts/get_maintainer.pl`).

I hope that helps!

Cheers,
Miguel
