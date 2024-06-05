Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1811946CA
	for <linux-mmc@vger.kernel.org>; Wed,  5 Jun 2024 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582025; cv=none; b=T7ojgTZ9hXoVe52salfNvwkwg1gphl4JTSczlDw2nZf6tWgMDLYsxcpOXos9hUVd0kpdOI+m67f2aHmlRatDILu0Dgz3HzT4QUYxgQv3hGZz9qGN7/Y8/mc4nGwLKpu9K3JpJfB6qlWx/NWfjlphW84QUcEHutcOurx/JFS2hkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582025; c=relaxed/simple;
	bh=yoCPcjehplGRvqItkfrVNTdDkIJ15rb1M8qQymmm/mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teWLa7sfHIjrHdyIazj6eQHM5KZftzLJ090j5yavdZiDvz1ih7PP4/tPHjn9ZH19+DzwJ6DcSC7DJyw2se/owxNvn28z6rvcHDUJSKwWIuhFtSq4EjNXtZzW8pEo/zAR8/Y3oshqqPH+q2rhfEz9ysClOtsyxbtQKX2zoltAuoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cYWqlfhh; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cYWqlfhh"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-df481bf6680so6421207276.3
        for <linux-mmc@vger.kernel.org>; Wed, 05 Jun 2024 03:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717582023; x=1718186823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoCPcjehplGRvqItkfrVNTdDkIJ15rb1M8qQymmm/mg=;
        b=cYWqlfhhLEstKWYSTLU2sDX1lUDF77Hkg6YpPo74CAbv1Lb0RQtUOB8YlA4ZOZckYs
         IoL5LRMF7cAJ5xH8hTRIg79vVaumSCDtL8tWzpUK0uj659JIjtL6L1i28OqAhZGUNVQ1
         YrYJN0fhSPx7f+Ulmld94qQwapejkciNuv/IerqFgcgs8CoLlZ7KPHiItcenHBK3mmPI
         /qnbqR4vibarCzDshq9Tntcm/v+4T/PvAcVj8oSbzbZg7zv8tS7Vgw2EGnC4BNRZ0UsU
         AAyDN+6fpyVocG9XMlv6S988LPSr8QKFQlG2YuZ/giGmkpqw1ntluKD1X38BuH1638yq
         fseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717582023; x=1718186823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoCPcjehplGRvqItkfrVNTdDkIJ15rb1M8qQymmm/mg=;
        b=T797l114iKavm11FFDJITIQmaYELqd4MZ/bIog1KVdvWNj5lC3usrRHZPgiU9DXeyy
         9Qlpc1ECUR8hnUT8J6iNBWZWRrVCHx3aCrCq+fa2Tk9GuypIwSY7cCx/b31fI0us03LV
         v6A0m4LX+74TQfjJX/NobYMlyBcUet9qwHhRO9HvEmIyy8zMWanoBwWUDSxcLv1isJ/3
         grPYeCWO0kYQ3/pn4kK5DGh780DAitNZYD4bFWB0irgVCl96kekhVg2zXJyNI3XQWYbf
         +QRMNwUqZFtF4t2YpSu0jlzwgjOFLKjTzmh+UnKpbkiJxzdBteeCHboKmfrOaABGFo82
         yhqw==
X-Gm-Message-State: AOJu0YyM516cfaJhShMvzFxt1+/ZqD3wgVseLnOVE9PDUyX3uv5BbHAo
	cPwiYnebfg4CivP8/p9clKLyiloId2+4PTeOoM6Sh2/5v42xNx2onA4QNn0rdYNJMekk7aBTw3J
	5KaAJnB5Be0iOEogQLVbbq1kWMwsawgxM0LgdM6ItdzMKmIT/
X-Google-Smtp-Source: AGHT+IGXGYVskyljWVtN+EdLFqYpj9K68WS+hvPglGpLLOV+d5Zt7r2FHS2Vo2L/BN6pye8TqLmjZVNCssEM3UD7v8Y=
X-Received: by 2002:a25:dbce:0:b0:dfa:77bb:3407 with SMTP id
 3f1490d57ef6-dfacad254c6mr1773168276.63.1717582022832; Wed, 05 Jun 2024
 03:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABikg9z9NqFwJ5VGtHhtZY9_gNAAoSbAfmAnTHcbp2=b0M3LcA@mail.gmail.com>
 <CACRpkdZdojaNGB88OGnVO8d8-PWz1yC-8Gw509NiNdyAKPFRNw@mail.gmail.com>
In-Reply-To: <CACRpkdZdojaNGB88OGnVO8d8-PWz1yC-8Gw509NiNdyAKPFRNw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Jun 2024 12:06:27 +0200
Message-ID: <CAPDyKFoK7XDoUL-kV60jzt5Jq4pA8Fm-VcKOERKu7b84Ba7PxA@mail.gmail.com>
Subject: Re: breaking commit: mmc: moxart-mmc: Use sg_miter for PIO
To: Linus Walleij <linus.walleij@linaro.org>, Sergei Antonov <saproj@gmail.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 May 2024 at 21:53, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Sat, Apr 20, 2024 at 10:38=E2=80=AFPM Sergei Antonov <saproj@gmail.com=
> wrote:
>
> > Hello, Linus!
> > I see that commit 3ee0e7c3e67cab83ffbbe7707b43df8d41c9fe47 (mmc:
> > moxart-mmc: Use sg_miter for PIO) leads to "BUG: scheduling while
> > atomic".
> >
> > Can you suggest a way to rework the code and fix this problem? I can
> > probably make a patch then. The waiting part of this driver needs
> > improvement anyway. It calls
> > wait_for_completion_interruptible_timeout() without checking its
> > return value.
>
> I have no idea why this happens, so if it solves the problem we should
> revert the patch, because I do not think it is used on HIGHMEM
> systems so it doesn't really need to use the sg_miter() iterator.

Did we conclude that we should make a revert to fix this problem?

Unfortunately I don't have the bandwidth currently to look into this
myself, so I trust your opinion on the way forward.

Kind regards
Uffe
