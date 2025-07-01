Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787BB21771F;
	Tue,  1 Jul 2025 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364014; cv=none; b=NmQPQYSGt+Q47IXt5kYVKA/OuGbksjO7Cq96hGeubowJzExPJkSB+13Aa+mG+k4KbNuPDeT7ybHWBJnm3y98w8rx5eJapl5IvMfBKT0Q6LaRe25Z4OMlKiFuwb9UFQIofnZ5oQvfJnnLWYNnlrdmRmzj44/0BgoQFev/7jOGrWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364014; c=relaxed/simple;
	bh=dcd4NU6FYr604eOyyCsaYvr/dR8yRtKW86HNNymhJ7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofQEjEwbVgrN+zFE6Kqr3W4mQBcdMhr9cRB/2vTo5ox+lBZLIv2jwX6sqzMAWCq4/TBq8AQgUB28DRqKyW7IMtws55J7Pfb25CgOxoPjlO27+Mg6tDU1BiZAAiv9uD+ATbBWUHBdfP0c37qZI0eN3i6UMXvmj8gQgbzH2QMt0Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOJCjmXS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOJCjmXS"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-addda47ebeaso1149667366b.1;
        Tue, 01 Jul 2025 03:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751364011; x=1751968811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dcd4NU6FYr604eOyyCsaYvr/dR8yRtKW86HNNymhJ7U=;
        b=bOJCjmXS6Zc8sbVwJBaUJLLsMBaa9B4FzolbHCuvVUb90Ku7nEiCmIW9UTh8U1Z1PY
         5zAmIhWIzbKrSbLsVAh7cJbgiRfuIiX281mMKvrr54ix3q0tU8G4XSTw4rrgq6jx/Aj8
         KcAE2c2l2XdHq81v8XfSlOS85T+6OZxArgyeoiwn2XBG7hsaPdREr6ofYZSfk4FgJL1m
         bJ1JKLrhc0UVFBhLA9USj7fXcMykM4WwsqAcPNg83LcrEZNc1/bD2KIVixfX1xdC5Pkg
         iquaOL+fDF0gqOVT25AkYV+hr1Oov+Bw55rbqgEOx/8n5I3iNAFGbZxWZqVeiWqHEnCQ
         d05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751364011; x=1751968811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcd4NU6FYr604eOyyCsaYvr/dR8yRtKW86HNNymhJ7U=;
        b=FNtVnXm3ocbST34c1LsLqBrhaago1s3sonoRWDObT/zNK3k3SvgDFK/JTSyO602c/o
         NUU2KMErO5+u6FKp6hyvn7idz/NNdeSuVNS4B2hvs58wtffaNGDVgy1ET5fZo0yBo9YA
         rUxm3yCdoGIz+JYjrYdWG0eHlIwb41bNjqbZUgddm+9B5V/8gfVtfOcjD9IBQiKeFr5F
         NZ6cw7pzbTMjZjgHXokaObwMDpOnKbP+fQ9TuLNR0RdnmwHuZP/C2k+Nls8x7+rXrPQu
         6dS+w/0fsK9Ddo+ea51q/a2y9LlAgfSX9nDF2Y69hEf+TVqSIZhsaKZBjLkZQgv+obVy
         KHEw==
X-Forwarded-Encrypted: i=1; AJvYcCVss6CNNbLHM/XeURZ3ZHaGjKTEJ0iP9UQ7VaZ16Tqr6unXONNsWV99G5sDgam66qQytEber3mxHl+CXLI=@vger.kernel.org, AJvYcCWvEJXH5cicruF7f83l8FlziI3IZsDl+tUMBU5cw8j1MTNK4qYYSVJ11xNie4QzSkH6nm5+ZgxfU+vQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiu1yQgihrOfVkRF3EJP+H9EpblBLNNetrNSB0QMg8ZNFJgtP5
	WJMu7BTk3C8EQYyrrGefFbMSASF+HbKv14r583Ww9+IwuoU6rH2LUKOcD40MmD3Ft1dwETF81Ns
	t8gXLWqpGRZmtfbVx+cY0mdFkQ9ndCOU=
X-Gm-Gg: ASbGnct5PcdJgF5CSwj6CT8H35H5HpdEneE+SGtwFyEh83g1TssCX8XnF9bvC42klW2
	EhaqSzQvlg3FosO183sFEqYgMkXpuVRa5DoBY/8KtTOoNlaZS9RfoiunM/eCRGveu7Gdurn+vo5
	3XflQ/+NyJxmYi+h9SZ9z5O+HocWlaOImonBxElK5B
X-Google-Smtp-Source: AGHT+IFVGg9I7ij138HqjSz3k5NX/sRlfBODxu7bE94U+eCEWNa8PihnyeL2ytQK8bGikHE/btLURU84ZtWswTf1e94=
X-Received: by 2002:a17:906:7308:b0:ae0:ce90:4b6c with SMTP id
 a640c23a62f3a-ae3501a6b84mr1520367566b.49.1751364010417; Tue, 01 Jul 2025
 03:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628015328.249637-1-da@libre.computer>
In-Reply-To: <20250628015328.249637-1-da@libre.computer>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 1 Jul 2025 15:29:53 +0530
X-Gm-Features: Ac12FXyQuaHFFKC-1pIWDliDfzZokX1a7f9rk99GbHKLqTGFlt79NOp9T2kO1fE
Message-ID: <CANAwSgTH67T9SBQSFQgFjvyrxNCbtfd9ZaCDZFACWA=ZQ-PYtQ@mail.gmail.com>
Subject: Re: [RFC] mmc: meson-gx-mmc: add delay during poweroff
To: Da Xue <da@libre.computer>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Da,

On Sat, 28 Jun 2025 at 09:15, Da Xue <da@libre.computer> wrote:
>
> Regulators controlling the SD card power need some settling time for SD
> cards to fully reset from UHS modes. The regulator framework seems to
> ignore falling times set in the device tree causing a few boards with the
> same hardware implementation to hang on reboot because the SD card still
> had some voltage and did not reset properly to be initialized again.
>
> Add a delay sufficiently long for the voltage to drop so that the SD card
> can reset properly. Otherwise the reboot will hang at missing SD card
> especially with Samsung cards.
>
Although the driver defines reset identifiers such as
RESET_SD_EMMC_A, RESET_SD_EMMC_B, and RESET_SD_EMMC_C,
It does not implement proper reset controller functionality,
specifically lacking support
for reset_control_assert() and reset_control_deassert() operations.

Thanks
-Anand
