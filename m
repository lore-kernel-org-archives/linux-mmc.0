Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AFE10FD
	for <linux-mmc@vger.kernel.org>; Sun,  5 Jan 2025 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736104859; cv=none; b=nWn7J05ZpUl8g5/1j9t1GLWcY9SvvlVEqb7YxGjOgNw0wfV1Cgb2lPkc5QOHVm2Hq5ewIBJYLY6pR8jS46MYZxUeM8/TvPxsZi1fMh3w7SfQirJymt7PE4BdX5cVzcWaclqgB6XgVOQya0uIDea8aHz+pQ7xOyKdTMnhUkVxNcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736104859; c=relaxed/simple;
	bh=3XQCSAp8YRCYLriKPB2JIDUBT/SJx2atyFbngWQeP+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CUM0caRjhu7Pptfb0WzR2ASbvZl5FX4xE/Axa/TP9IINh53Fs12l6aIX91ltpcQUMmYVsfqxxNgViekFaIzf4G5Rc8RXf/gKloefKF/chxA/zBIxA+bJhGvGnILWg+03woBLJOwfwYPbo4mlXYmkD/kiBTCcET6QMo4wJOEtApA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA9gXdAJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA9gXdAJ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so136641185e9.1
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jan 2025 11:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736104856; x=1736709656; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KShl5Zi+bBGDerutPfGXw13ejU83Oxg5mqUMC9Vx/Co=;
        b=aA9gXdAJmYxWhZ1QD9RJ1dOH901mfVtdOBc+y9TVDyMgoIlDqEgl9UHCDYW7lZ5p3p
         fOn4Vpr17NqomjuEnuxU4fcmC8D7a7lJzzcXwrxMnTmOwGE/glnus/go1Uk9XI6rFWTx
         dacVJWKGIHFRR4WJfNojuH51iAItCVU/M5z0dgiMUzQqX1/kAl5ahQPITyrTwDGE8hC1
         FqsBKA3zXrzYjqzrIjm0TyY3JzygiLFNmW5fqj1MDEcCgVKnBBqJV/OLyOYx02aSRPco
         VNG59mJjEstmc/WR2XKNhn2tfo26MlhOGQhDJ+F4vzxt4kRpqf6HkyWALL8VqS32l8ne
         V5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736104856; x=1736709656;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KShl5Zi+bBGDerutPfGXw13ejU83Oxg5mqUMC9Vx/Co=;
        b=pUaiyvKixoeqgss/RFZY5Lpq57Qsbt/LVbAYwqM1DoApyNio4V5oZFaKj+VLUewZvk
         M7AxYKBN0NuRm3QexIl6LCo5Csr/RfEDKeXZRvIjCP4zVovsFYDlw8ezgjcB6dvWFSbB
         eOHjGTZ4kQnzs772LZBKRwtwKVLd1oNBnJCqzYF1oe6iVtshxuGHJ6PzGjxbeB9tYtFx
         apZd7jf2nR6K7p+qLIEx+x1GnYyYxgxPZM2LrcQzg3rF2F53g5XgvGIb+1V/w2kojMdg
         7gZ8BwakFno8PNY9INx0qRxoU2kFo3j+e0l9uzP+BqP+gcZAqM1P7tJf2tiQsWhNYeS0
         Yc2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/T1tH9/Eb7iXcxdg0l+j0LgDtkabNozX5Owg382eQ6sSoXryQu8qKV25AVPHTMEPhBxwjd9w5dSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTs5KKHpuiKxFSGUG+qe7aZZK0vnf8LEW8R+fytskVvc/HEYXt
	fqokhtmpM7WeYhBRyW3x6eRVbYGVkF+LCUAEzLXzZqexF0cip1mC
X-Gm-Gg: ASbGncseWiGKkzkF2raPKmW06f8dNn1VIPStKGHx3S0BTYtXt3+0ivrRK3Uqx6/2NNw
	joKYt9qTfBiOy+dGZBeATmuj7gIUe95sqlae8hiIWnbnPJRPdO6tHnz9eQJf0S0q7lLm03Nx9CT
	F/nKj3bIMQxYDEVe39+kPpFqAEX45WKDI1pOOzjuQJeToLfhrxLLwMNkrBrfgWFxHDMm91+Eek7
	h8UqRCaS2+lfS/+/c6mBYT7wKLYFqe/KG9OsY2dJ8Ez7Vljgl5j7iwHFgydygFsR7IxoQK3N3fS
	0yEFgOG38GPU69h3iSJr9iWhm5M6Zi1ViJ82IAO877bYv2t5VpyqP4Y2gn2Nh+AOX5Uz/WJdfF9
	PkGcYpk9lKDlP6WuC7A==
X-Google-Smtp-Source: AGHT+IHTZRZVffUHbXvcoNg4R6UCDXG3o0uAdgNq1GOPa91UR+EIMBIAyRlFLHfWXlHWV2gaUy6BEw==
X-Received: by 2002:a05:600c:470b:b0:434:a75b:5f59 with SMTP id 5b1f17b1804b1-43668547127mr506835755e9.3.1736104855655;
        Sun, 05 Jan 2025 11:20:55 -0800 (PST)
Received: from p200300c587184a232593d53d00a852e9.dip0.t-ipconnect.de (p200300c587184a232593d53d00a852e9.dip0.t-ipconnect.de. [2003:c5:8718:4a23:2593:d53d:a8:52e9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e2f9sm47262618f8f.81.2025.01.05.11.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 11:20:55 -0800 (PST)
Message-ID: <014650a0988089c7b2364c356a065690604c4d1c.camel@gmail.com>
Subject: Re: [PATCH] mmc-utils: Add ffu modes documentation
From: Bean Huo <huobean@gmail.com>
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
  linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Date: Sun, 05 Jan 2025 20:20:54 +0100
In-Reply-To: <20250105121407.71566-1-avri.altman@wdc.com>
References: <20250105121407.71566-1-avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-01-05 at 14:14 +0200, Avri Altman wrote:
> Add documentation entries for the recently added optional ffu modes,
> specifically, to exist in
> https://mmc-utils.readthedocs.io/en/latest/.
>=20
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> Cc: Bean Huo <beanhuo@micron.com>

Thanks for adding this,  Avri, with you have an amazing new Year filled
with success, happiness, and exciting projects!=20

Reviewed-by: Bean Huo <beanhuo@micron.com>
