Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0F230594F
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205436; cv=pass; b=bjqtQ+2M1wZNzgIBw2xf0ylK51uG+WHtlEIfz3G5b9IpKA10jFcmnziurhH2/fZUCFbfE2MyqAvF1KCrIIMvqNhYUy7U+Efn3Z0kRsnVXyTC7Cwb0bLNQPPZcwpskr2N6tNVG40RMCSl9OoWtpnTLykeyxQwCe1z19sx1jEE2ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205436; c=relaxed/simple;
	bh=24w24xAcxXEvyfw1SvkunQuS2mBWWexF4vLImz9vN8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PaH/1Yb1B6tQ3oifbOwbwzypdEte6dOekRI83dDEvTsBQUzKDZa9hZbqnU7LMP5/fFcFpmiC8ZZCGe1FlSIrXc7W8gdw3Ae32GXhw6ZcQ2osvThdcJVSuhU6yhZtJ9r408oXIUxxFzz4FlRW5tkplY/OMFDd9GwP1lMRfHcEQ5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXNEvD6J; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXNEvD6J"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6802f9c5debso8774311a12.3
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 08:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779205433; cv=none;
        d=google.com; s=arc-20240605;
        b=VtQlnqxAFlLGD5tQah74OZ9KcUwdhhGaJP5++LrtWADyaDlKtrxYk99S6FDuOvgcT3
         e70oq+2tlD3taWxoSuNWmX4oQOYq19ZagP3BXcQ4ZYI+6Q9nYh1lUVcopffbq2G7O0w/
         uk1/WXp8nB6x3zQgjuXlITCyN+/Mu6mr9yiE+j7Cd7s+VKZATELaU5UpmWz7sKFx8XoB
         +h2Uo2Z8QgKlHnTDyMoU4hIHPQGXpJcSt0KpXHRuzo+bXChNJwuooY+SgWHp/rrDq3DF
         1mIqsFMLFtR0BPK8mdb2ffhPOise675JLnBTsik1t5FMsQ3ZUg7jMXOWO0ZCEykSgP8d
         5wiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=24w24xAcxXEvyfw1SvkunQuS2mBWWexF4vLImz9vN8M=;
        fh=xr2DMEmHlqi6zwJ3vTt+HUMZF5pRWO2PAMaOU1wHDO0=;
        b=BIQL9fGJubvDAT4GAVgqmcyS+eqf/gfdjdInbCWm0jNzT9yU9rToIkbRYEdfTr9D//
         IAoIKkKsFTJJ9abz49T0Uyz/1QWRDo3hsQJwsCwTPkcfRquVyvvJhkW3ha8j8qzPbkQM
         ZLKs4nAOk8LeorFo2E6FtAG71v6GmWZ5IjllroFkmkQCYC/c1fH/6F4+plJPwcGKQLJX
         7sfSuPphz0ypIHDQ6m3MA0ROJbswRR3xHy5n7wX4n3i6AXDjz23rXvhe26yKOYcUv8Pp
         gLEvD+dZ6ADbW1svb/AVZXpTHpMQkQztXss/YL50SKeX/4vTXDDxGbm0WoajAzqjnesG
         JCTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779205433; x=1779810233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24w24xAcxXEvyfw1SvkunQuS2mBWWexF4vLImz9vN8M=;
        b=cXNEvD6JwZ78Cu9SvbGAhoNG1qiQekQRUQTNG0JmhHgr/fUltIvL+hH0btsmE6J5Kc
         Uk8lf+9TgZmk00cfkiHCdxX07LKYVfgEJVC8CctPouhjTahtlC9OkwcQY71lozYWRLVz
         MqbmZt8p2nOD4w8T00NxgCVRneGwgPNFcj8whE29l+VCKf6dOgUFX6/2uGCM7yfzE+tg
         +7/gonkH7MXgUyUFAxd3314TMEdmZMIwlntTQwLDQY3yzTHDU8xuIfxdnUWBSseXRTeK
         gKwjN4Qv48Wq3lOmSAgUFRKQ/JUTr8IIRbq+qpVMc2ZH1tRw3WpczLIhTGbrBWi8jKVG
         w/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205433; x=1779810233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24w24xAcxXEvyfw1SvkunQuS2mBWWexF4vLImz9vN8M=;
        b=oWyYbP9I7O+dJzsjyBv5BU12qoLywUNNpi1Eu50AgvyL52f6CLDvfxYqC+HZ7lS+YW
         0gqFQesu8jhXpfn0z2aC2wlyDmso3YIkAfCGm5Ju3uq2Z6qwKOJZpztjRCktvdlfa13e
         YSNuMxfZ5p2xG+8inTyRHXDW84r3HZ6YvMOdsKiuU92m010Qw+rDtg5TdeIbFURewM0i
         ZRe2h+SO+idg8QK54PeIFg3kUhXSCz4/BgFwnYyQ+O3fkFn8qlZP452RBsxCGGHifQ3j
         B+zloG3V4x9qV27sVgRMRi4AWQiaB8zoioYK+tj4a/Rwm/Np1XQED/SP9YVK7k2QFwun
         7mLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9BYgxuUk9TztDeM04MO7mx4QXnYwaGaCr7DZzqK56O4IO2iFzTnqO1xDbSW9dr9+z0iqK8ZVcjUx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSw87dYEhpg9+y8SlBXjQTa8jkGLCIdFIrlYohI0get9++n0I8
	CIzouyNhbUTckex+X/fRInWj/JimrlOh4dk7FvEPXftgz63mTHCsJTxHjiaXMOpdAfEpCOe0g9p
	0dqK2PFBZ2djrVncQvGhb1QJGiQn7TOU=
X-Gm-Gg: Acq92OHxJqoMFgsAZcA3rPVzZKysUsCzcjGDfsfwe3bkYyv/N/k9xVHLpKrRsMnGuFL
	FWABTKN3rl5+JiiNOx/3ga5XcQ88AV4zfuPmDgxbowK9k4GQR+i70vJ86NlEBOL26WwW2c2qKOm
	IehjulwiIRPqPYchfX813128w+DKAgdZcn2hicEgQBLiWBZBu0D1r28W7l3132Y5n47/pY+qQ8d
	RhFXoJCu5cZdhTEcHLSY06L2Gh1AMhWI81qpXdo6DjIuDdyFO+zuWgz/ZbBMWiBPFLccKu07jJX
	5yq64iRxQziTMops+wI=
X-Received: by 2002:a05:6402:1ec8:b0:684:32dc:6639 with SMTP id
 4fb4d7f45d1cf-68432dc66b5mr8636949a12.7.1779205432874; Tue, 19 May 2026
 08:43:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518110034.142587-1-a.shimko.dev@gmail.com>
 <20260518110034.142587-2-a.shimko.dev@gmail.com> <agsfSBAmxzd1lIg8@ashevche-desk.local>
 <CAOPX746JbZamfeJcY+vT1EWDpFCSVe4zc8AHGL8sGobUnzC9ew@mail.gmail.com> <agtb1VVEaOamRnEl@ashevche-desk.local>
In-Reply-To: <agtb1VVEaOamRnEl@ashevche-desk.local>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Tue, 19 May 2026 18:43:41 +0300
X-Gm-Features: AVHnY4JdouUKAmigfkoZv4osK9SHrPnE9dyp38ZnZX7QGQ4ar848AeX8jybQL3o
Message-ID: <CAOPX744TwiwgkYA3RJQ=mNGnd+GzM2dOP8SFaY4eE6q_yd6gYQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-of-dwcmshc: improve delay handling with fsleep()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: adrian.hunter@intel.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, May 18, 2026 at 9:35=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Yep, the hint was basically about uses of usleep_range().
Just to clarify before sending V2, for example (midpoint of the range):
s/usleep_range(1000, 2000)/fsleep(1500)/ ?

> microseconds is fine as is.
Since they occur in non-atomic context
(inside set_clock and reset functions), would it be worth replacing
them with fsleep(1) as well for consistency? =3D)

Thank you!
--
Best regards,
Artem Shimko



>
> > Or is that the commit description mistake?
> >
> > Thank you for reviewing it.
> >
> > [1] https://lore.kernel.org/all/ad-mCsvOWWgqt-rc@ashevche-desk.local/
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
