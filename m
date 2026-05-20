Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0767372EFB
	for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261277; cv=pass; b=H09H05PrKB0M0n1EgEnMZm1GQaLQzLpHSPpOiZYrPsMfedE2Ht2E2leB8VWjcCN0iq+WSWeVkCfNoozGZyb9JXFGWc+2w1nZjl6jMuL/p5XXqrmfEDRojXddnw1PdiP6AtGFc+zeFyQq/tYKsnhgMeYuPzJWb4fh5c9qBx8KrFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261277; c=relaxed/simple;
	bh=9xpZ/12ODB3v8ZIlAn4vHp9b0lsPsXVlJMaviHLXZz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPVzFqf3e1lIekJzwbYLqqeYbApL5CZsN7RzMuXbzROg1I6ZZR9AqMmlae+8bH5I4fXu/MaAC/8jj11BRuJk9I1rd5MZ+K5wuexByf1qo5Rs77TQRTaEVbYcUYb0ua6Ww3MDCYZRscFEzCcmoVW3wffUFyC2v2uazeovGDksI/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8nTFi3d; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8nTFi3d"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bce386d5b85so744667666b.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 00:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779261274; cv=none;
        d=google.com; s=arc-20240605;
        b=HAeY5t1+eU4Kh1OP09VO1nhBsCYlakEhNNlXP9043xnb00Fmuw4IMelvtUaFWyhI/v
         RJLiDRrx+ItuMKM9EA87xeWScn3lpV0IRfbFgySi4BG5YCE+pM6bGaMTs9l/3pPhZfBi
         F1s6REem8UZAeS1TMqdAciGUzvWReEJDP4gMTFKoQk5DZauoNOhKqyJDWoUYoyFHSwFw
         9KU0zb/IQinBCY5rVNp17v3EfoTT3N1YHYPtwAh0yLI3SP8Cy5NzySJ6FnxOLJoAelSa
         eg6EKWx+T4j4moJH/PK+JaUUFbDip3YLvSwXGC88lNkP5PZHS6ZC98Q0u6LmfEhDEktv
         KxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N1UEgmTxd3GSZ/0aKBNuYdUPAO+vXaSo/CKQcZe/wjA=;
        fh=2+n6vQTwzfcY6qk5dTaQn0Af51AAOssYwBJMHebJTAU=;
        b=hPrbTAz9pX02iovMbX1pdHi51Ch/AzrxGEtdC255O4YMQAGcsn8eMqqrr203V7MB5s
         YFxO9mr3olbktMu83hlnYXxWXrR+xdHKsi/zfXOb3JZrAQPlbRO8gzlRJuHue24lEcE5
         OKU62nJ52zvYGwWgWGjkEuQaYDpFrdvEDqYuPkAuN2LUndZWyU4RHbsB5ci4/MGKTZtU
         PDu/WcNKmg2dWUYNFisoO1jHeJw/RjFbft9oa+qFgvaIrejMi5/obePAE/8eYVoowQQN
         blT7AaJ7eBQXayLYiErRMy8oq9exHPIhuztMESnViv91mxw3jzYIoucVSiDge+TaW4/C
         DcYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779261274; x=1779866074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1UEgmTxd3GSZ/0aKBNuYdUPAO+vXaSo/CKQcZe/wjA=;
        b=h8nTFi3dhTfkj8s95QYxk4cT+QHLVVhmR+ftezPSszjzL1y1FFGSn9vR9g6I48EJ52
         4c+a9A8OUTLgZU5iusc4BiEckWXndzQv2s/pbrCrnqEQVkcfgxURTaa+ICWEB3fT3X33
         cOp9gNQL0DqfYLpkbCGUTJFkBlv1y+KBlzGs0Krv/4fUBwrSyylkMAaQTcI8Gafk9F/c
         +sxC8p3hVP16DDPl6mRt1QcrDmrT4zITXx6+orTM6r9VadK0okepQMiyq8D6rdvYTrJA
         YF638LOf3rEVRzJ2PR5AjtV96bqI2FpIzYg4Yn/DmB1UqGesSxyQYL5PfbFBNn7UHZm9
         JchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779261274; x=1779866074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N1UEgmTxd3GSZ/0aKBNuYdUPAO+vXaSo/CKQcZe/wjA=;
        b=hdNAexovAV1rH9ggGyFW4aO9cVuPjdS7nUqrzJg/IvOI0KFT7yu52d/6FEx+UWTtJx
         lLCBodDGvgXVIONIWUasoFVdELO2M7q0DGHq4DJp7CTYOziHf2HLitPY5ljxr6Ne45pq
         709JPpHdpgO3l5t7EFvp5JdUZX6v7xMcR35s8tSHmDJysNoyOpcp6aiVnH9Fuqu2Ry+K
         wmVNuUjjAA5kw7xD9yP591v95qZMvHL6G8wmtdUjDfhel48RQAmIKCyGoKePOBjViar/
         j9iCJ3JGBQpZ5QVPrVBM9DQjNEUSdWJ2956Ineh2ycpFWAGvwSuEk3gtxUx6MVuRFGx4
         r7EQ==
X-Forwarded-Encrypted: i=1; AFNElJ8i1Do88Ip85D0FhyV6wGUyT0SW6eiMcTVAFK3oPB6K4b+kP+63mOsb41iNimcKGOolxEoPZntCXrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkI6Fvqj5Qh+dLpJEd9Bjr5C8nByGM6WOgAsklmGozN83ggo4o
	KGcKH9dC+YUFoLsKVnA0xyoU5Tkl4x/bSdcuvfFBhm10tzGyVvpYrLnQyyLPutFG6U1sMZtv/6K
	dRvIsMUcIiXHrzyjvb7Pp8Sgc0vAxWlA=
X-Gm-Gg: Acq92OFyHoGK+bJNZnU1nUgINumIT2r8tloGdmjJ7FZ+4eNdSPBm65XzSKZVs4wQScQ
	ujNDFdPgyQr2QpQ0TLW2sQo3K0QbgzUhYnz8r+68AGyeq89+wvULgef72PvGchMgWLvzi+jAtXR
	LTP08KFd15B+Uacl7CuW6N9MY7YwPw6nw+wKN4ZaNiGnMetJlMoHLKxxQwFMkhVahi649yT66nF
	M4VAQILeSqyxVJZDdORjc5UqyEHnmGcAT9xavXTwLoWd+erJHHrOBeKP9dGDtcQP9maWTKuVduo
	Fj5xRUqg7XNV1U29H6Q=
X-Received: by 2002:a17:907:9c04:b0:bda:d08:35ea with SMTP id
 a640c23a62f3a-bda0d08384dmr252993866b.48.1779261273141; Wed, 20 May 2026
 00:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518110034.142587-1-a.shimko.dev@gmail.com>
 <20260518110034.142587-4-a.shimko.dev@gmail.com> <1fd00df1-9529-43b1-886f-7aa7b3d9c334@intel.com>
In-Reply-To: <1fd00df1-9529-43b1-886f-7aa7b3d9c334@intel.com>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Wed, 20 May 2026 10:14:19 +0300
X-Gm-Features: AVHnY4KT8NYpso0t3DWsVM8XRkvDDswzBxBdb5CrhlV0iyAVkeX4OwJjx2a2_Vg
Message-ID: <CAOPX746xKhqSEASzvhV8ukQwy8DuK_Nf8SJcqnwGi0Gbq79DFw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-dwcmshc: use dev_err_probe() to
 simplify error paths
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: andriy.shevchenko@intel.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Wed, May 20, 2026 at 9:18=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:

> > +     if (!pltfm_data)
> > +             return dev_err_probe(&pdev->dev, -ENODEV,
> > +                                  "Error: No device match data found\n=
");
>
> "Error: " is especially redundant with dev_err_probe(),
Missed that.
> and it can all be on 1 line e.g.
Got it.

Thank you for your review!
--
Best Regards,
Artem
