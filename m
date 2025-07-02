Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE630114E
	for <linux-mmc@vger.kernel.org>; Wed,  2 Jul 2025 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476948; cv=none; b=AIJFT8BBWNlQZX6oIWcATDMsxLd5d5shaIV6Zg5Hjqe7cC/mxSUaY2I9AZn/tB8RnG+aRvd9gHOwwakV6e7pTz2feuSkYpslabGsgxMg2NR5oOtAsnTVohyVOI8uaj/kUuXXghivqy4lEtebEz7zfUa2zCh5ajPZHe0b/9l3nZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476948; c=relaxed/simple;
	bh=/SkwY6ne+g8BY+F31MtkqlGaiDXb8coPhVMth5244qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1xGX1J0wrBl4vGVncmEcHOD9HdnNcuL+bqkygyse32a9gTGVR8vpB6wFfIDvb8OMIUrN5JM7LSr+Q2q4xbLvZBZ3RfYdHLufElCr1kw4h7U9nneWK+osfyXnbaRcdcF9367CzPCAd2usNDPWLQLUjiiuDEsP1VLILpsJhPjwGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer; spf=none smtp.mailfrom=libretech.co; dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b=WaJ1TA29; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=libretech.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b="WaJ1TA29"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-711a3dda147so77533217b3.2
        for <linux-mmc@vger.kernel.org>; Wed, 02 Jul 2025 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1751476946; x=1752081746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SkwY6ne+g8BY+F31MtkqlGaiDXb8coPhVMth5244qs=;
        b=WaJ1TA29Tz82XkVznEqYNerS0pddA1Rb3Yajbi9mj2RuAzt7iPaY0FZN8dU4b0B1ey
         TQDFtb1KSmqMWvJY50Ed/NYxNxuL8zuW3kBijeMI9RhsjkxfXzNK1FFqDqBk+5LvXn/l
         0nf2O1MjOouuTBMH93s0MclMJGAhMxNokKO7TJubOd+Xj6zdgHMlpo+S6R2FLGtQGPSK
         Y3G0qSvGI/ooX0JfTKB0kW+kjB7MN3QHxTCFmYhMj7zNJeZ3IttBQzSuv0tu8ykHSLkd
         LowgbQpkEUu/Ne3gqLjyoHqk2oK1MBtRpdgboF2g4GHYHwkjycOKQv9XRsv52Qn5BglD
         ovPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476946; x=1752081746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SkwY6ne+g8BY+F31MtkqlGaiDXb8coPhVMth5244qs=;
        b=dY3hPk+8PfaFwPXyYjTpdb3vV6CxxqmP2F1I26quEnuKsW/9l8CghYRAqlBg4uiWhP
         bNw03/LW9YHS+QV42SvbLv1VHCeXoRLwEMcwjGySZ2uIkGtiYW+vxqe8yg4y6t7QmOMO
         YmUT3DaoTcPZNNcQf2Sbag1dU2I6iawJ6x8XunuUS6TTWD+yiwlKQ+fSj7l7HjRCeq0P
         wXSRbghCjiS7MJdVCdwkEM6ZWnAfEZyJqlTINdOTes36QhfXJh5792L/l6Y95rnncDLU
         WQKkTox+gKlOrVw/8F+6wa3wzDCODtgIo6hN5Nyi6fgPuZLNeoUuK0fvH8HAkuglHH2k
         GZnw==
X-Forwarded-Encrypted: i=1; AJvYcCWeoACRpOQV8gq+CUamcLYtmd5a6tgvClhuzdd41vesGAlliumomCckNOJeDtC/AQ5OD5wlx0XZqjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTIvTg80SuqFBnPWw6qoIlFDGK4XipIcE5xbdih+ZVF3e80uE
	6B0XP5Np/PxYgfERY/bcTjsCOOWHeAEwHmiseGdMJ23yguboH8+43GY05w05DQjssqDSFc+QXDq
	h8z2nlNbZ3VVqa2ypkS+dAvL2Vyl08hADH8RKpegG
X-Gm-Gg: ASbGncveI7rw5NV26oorwb7srXnZJvsKoFFZXPObuss09P6ZcuMMeX6xuBaiYOS7mRs
	oB5KSS2yvEkLNGAZpX7Eo+siPiVtqR55JmPp99e5etKbMhBADhrjiQW1v7LIW7GSWW3BRAIkOxW
	BE9GGWKAlrhWny9ZRczsLM8o8aIZdaY10XU6kPIAvso3mhNyucCVOQJkV7cfMpxQN+99/CJNpN/
	Mjm
X-Google-Smtp-Source: AGHT+IH+2cHiDRkSexobKNpcDsdKZBCYRCcLg4PJcbDmEq49ClTbY7a3qJRhpGa/9rwzq7pB1ZCDPnILu5cCdmgnzFU=
X-Received: by 2002:a05:690c:7487:b0:712:d70b:45eb with SMTP id
 00721157ae682-7164d539984mr52498477b3.31.1751476946103; Wed, 02 Jul 2025
 10:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628015328.249637-1-da@libre.computer> <CANAwSgTH67T9SBQSFQgFjvyrxNCbtfd9ZaCDZFACWA=ZQ-PYtQ@mail.gmail.com>
 <CAFBinCBwTkVwcBTWOzS+G13+rRM2eftMXZ3GHzW+F+BY0bBBzg@mail.gmail.com> <1j4ivued2q.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1j4ivued2q.fsf@starbuckisacylon.baylibre.com>
From: Da Xue <da@libre.computer>
Date: Wed, 2 Jul 2025 13:22:15 -0400
X-Gm-Features: Ac12FXzMF1aM5Sb75d0lCCLP5TcPQJxcLdk716xFOwxeZ7EpHXVjogygUeOUfJs
Message-ID: <CACqvRUa8EqMbCd2x=di-a6jbMWW8CMo4kgLH=0qnsqHdO16kxA@mail.gmail.com>
Subject: Re: [RFC] mmc: meson-gx-mmc: add delay during poweroff
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Anand Moon <linux.amoon@gmail.com>, 
	Da Xue <da@libre.computer>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 1:07=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com>=
 wrote:
...
> If, as the description suggest, the regulator framework somehow ignore
> the timing set in DT, maybe this is what needs to be checked ?

The regulator framework only cares about timing for regulator on.
Regulator off just turns off the regulator and returns without delay.
The code makes incorrect assumptions. Then the kernel resets the board
without having enough time.
I can patch the regulator framework with the same code for regulator
on but that seems very hazardous given how many things might already
depend on the original behavior of returning immediately.

>
> TBH I would suspect the delays before the regulator framework itself.
>
> Those assert/de-assert delays tend to be just copied from boards to
> boards. Maybe some boards need different delays. If those are too short
> for the actual HW, an ON -> OFF -> ON could result in a NOP.

50ms should be sufficient for all boards as many boards don't even
have this functionality. < 30ms is sufficient most of the time.

>
...
>
> --
> Jerome
