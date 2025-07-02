Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545132F7D14;
	Wed,  2 Jul 2025 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481632; cv=none; b=re8lV1yVYcfYnvgFzUp8UxK3N2VOt3Ee9KIBApyDwMkQyogVMPi4yp3qBEdBLmF26G9Zzkc+2BehAbA3yX7Jzjz1vGlWMzMene1ADCo8/uziJM4iQ6/US/4V7a6yzNMMx4yYaGaYThqEOI6cZ8obdE54pIvrWAufRvJKwKaQWN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481632; c=relaxed/simple;
	bh=JD88yMHNIqJLGJNkFMm447HbjKIEZj0pTYj6EiAF6fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQHZ813vZCeByAZ26had87hsxlebbCoMSlLk8IW39LSoB9tL3w1XlgwytUjEgGMz90fBPh15NOoabPRNbmKHvrs6xp6epUtnDf3yBHqOEDn2Y9Mni4xSccnpC8Pan9PAyQXbuLKBYjmwb8hz4KJBZbyX3sVecwBp7dvY2EVaDIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kGAy9CNP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kGAy9CNP"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23c703c471dso2299635ad.0;
        Wed, 02 Jul 2025 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1751481630; x=1752086430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JD88yMHNIqJLGJNkFMm447HbjKIEZj0pTYj6EiAF6fU=;
        b=kGAy9CNPt7ZisOyQHlRAK9+/BnBge2i474Gabm97NMobHNZPUHatGM1osUaQivd2ur
         sd80npVlPngyYXTd2OuGOp6K1jX8pabEh+FWwJOhB+B+cF6y0sVxMSoSlRVlBDCnY0ja
         0tvA3qim3moghcoQox0F2kYgMmXAOEKSGcwNyUfbFlVaRDzg9d9ZJxN2v+P2SerNPtcf
         mijnWuJVIFQFr05lu9fN2sOodRPfa9UoPIwf8cVz3ka0KYPX1B0EHX46bQR7xKzyxIPg
         YhB5ZpxswXp4mNvJ9/KbqfRXlUhCJJFGVX0zIPhDTEKiyxCgoniOiJbkCz0NJLIwbTzE
         RU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481630; x=1752086430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JD88yMHNIqJLGJNkFMm447HbjKIEZj0pTYj6EiAF6fU=;
        b=pli2UtHEKaPl5M+6apcj131DUUsAqL/yKzPVjH9mxm090AWf3QFim9FrRzNJoGv07H
         fOX4mpp+JYzCFPJy7y7MXDIjMfuNAM08rDLdBFnTeD2wxg6oWDCOgozSciMkIJQyrc4Q
         Z4y8CVD8mXyJDhuF/RmvvYMDZoNEnxUv7MW4iOVVYPbOfXa3JcuTjqY4RLVQqp2x9w4E
         FKSH3qRs4JDjj2OljuyRALsIDqi/S2eDn7nlJ8WNSmokNk0s9S5Q8jyo76nbjUn0GT3B
         G79FQEZ+w8EDRRoa8ukRe3LmjfKrAleoYmrHl1fzfEzH+Ys0jiGhyxe9IA6UC7Mo+Naq
         tMxg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3MXVSxkfYBqzqC1NpPzQNX6+VTCZ6/+a/ZHlm1i2wk/CC0OjiBjwPEy6VCMocoR85BC24TKAvSryijs=@vger.kernel.org, AJvYcCUiHTIqpWXjlj4GuGgg9bxI7Quk+PGyrh5EgaGu7z0rkN3v0NClJSlPfO5TFhDOUKfoqJC4oTocLz/I@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3p7iphhesN4VHnDN+QTsCx7tOyVTVXIL4OofKlQig5S4SvS6d
	3V8CAUahqgCxNvVHk/sZVqSnulA9IS3Yq0HWOv67B9MV656tnhZGoTU6HvGFcBTl/8r4sFSKUnh
	ecmmV4Kr0qao9K8n56AAoBIbWGpn8hAs=
X-Gm-Gg: ASbGncvU/9Bul2yHWLCXqLH5sN0QjzA8M7t/Q10AK+xAkICXKUV70K6NVixEyVe76Lm
	LEdElHFBxYbAwa7tjXmW5crmg/kOTWJxsr7btNAvupLOHiDTjf+sFzh2Iy/sBCxIRiS97h/FH5S
	Empj0+4Ereawhj3QzzEublYGWxFldmG67orvLdP7GE8/zY4GfNK3Hlt1CAcQIJTzN17QM/P6482
	BAgl/bdsfgNoF8=
X-Google-Smtp-Source: AGHT+IG65z5JM5OzIy1s20zy0osr0gbaem7rZyJo8s4662EGg8M9d+IcT5RnhEheXmCheH3vHusHJ+Ckhe0dlVQMHpE=
X-Received: by 2002:a17:902:fc4c:b0:215:b1e3:c051 with SMTP id
 d9443c01a7336-23c793c0efcmr7045825ad.11.1751481630377; Wed, 02 Jul 2025
 11:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628015328.249637-1-da@libre.computer> <CANAwSgTH67T9SBQSFQgFjvyrxNCbtfd9ZaCDZFACWA=ZQ-PYtQ@mail.gmail.com>
 <CAFBinCBwTkVwcBTWOzS+G13+rRM2eftMXZ3GHzW+F+BY0bBBzg@mail.gmail.com>
 <1j4ivued2q.fsf@starbuckisacylon.baylibre.com> <CACqvRUa8EqMbCd2x=di-a6jbMWW8CMo4kgLH=0qnsqHdO16kxA@mail.gmail.com>
In-Reply-To: <CACqvRUa8EqMbCd2x=di-a6jbMWW8CMo4kgLH=0qnsqHdO16kxA@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 2 Jul 2025 20:40:19 +0200
X-Gm-Features: Ac12FXyR3mTzwKK3QsWJnUHD7XVn0YOVkSs2GNj-PlIQxt00gwgIj8Cr0AYFXDE
Message-ID: <CAFBinCAkW+G9oV+SOJdac50oLezQnbc358dBgs56-RfjPd-zgA@mail.gmail.com>
Subject: Re: [RFC] mmc: meson-gx-mmc: add delay during poweroff
To: Da Xue <da@libre.computer>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Anand Moon <linux.amoon@gmail.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 7:22=E2=80=AFPM Da Xue <da@libre.computer> wrote:
>
> On Wed, Jul 2, 2025 at 1:07=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.co=
m> wrote:
> ...
> > If, as the description suggest, the regulator framework somehow ignore
> > the timing set in DT, maybe this is what needs to be checked ?
>
> The regulator framework only cares about timing for regulator on.
> Regulator off just turns off the regulator and returns without delay.
There's an exception to this: gpio-regulators without an enable-gpios
property. My understanding is that regulator_disable() is a no-op in
that case (meson_mmc_set_ios() even has a comment above the
switch/case statement), see [0].

> The code makes incorrect assumptions. Then the kernel resets the board
> without having enough time.
Can you please name the board you're testing? I'm worried that I'll be
looking at one .dts but you're looking at another one.


Best regards,
Martin


[0] https://elixir.bootlin.com/linux/v6.15/source/drivers/regulator/core.c#=
L2980
