Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A49332EBC
	for <linux-mmc@vger.kernel.org>; Tue,  3 Feb 2026 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117363; cv=pass; b=WZ1R81eb9F4m1f5lRajv/1LedtDF+2/jZYMM8SY5gUF6jy6xc0y/4n7AgBaUwRAV/5YJPAL/A8hkDk6U44VDV5XbTFkslZUsjhtGiXQH99Cojv4ezmWcJ8FHTVoICLWwVVWW4P+SJBr+erczDnOaZFP2xrWSVbYlZwLHM8V93Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117363; c=relaxed/simple;
	bh=XlLzEnPV60KftLGhh8r9bSMesh/zJFyj+Qb4Ugsc2zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q785Cv1dzG3eaVwjUrmeM72XbQwD7WviBS1gZb1GKtI+GL5vrYlqljY9xU/uI09lEFiP1K5l7iaMxkBd8enL4vjzHx+FfCvxMaqxtqWLka/YW5n4dZmnePN3HH2red3vKHhy3JCXoKxkXLDva/k7CpUwUx3xyzECvV/ggQInc4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vrA8jl5x; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrA8jl5x"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59b77f2e43aso801153e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 03 Feb 2026 03:16:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770117359; cv=none;
        d=google.com; s=arc-20240605;
        b=PJ3wb/kj6/weMpy8Nxr8fpIfR9/KY2/DtMf2Vo6VlEHYVuOAjXa9DTeYTWQ3dYRT67
         gK/yNqK8IERKG4mfthYRQ6J/xVFeiElSHtFmjZsRLqJyGtegpjy0hlsi7QCi2Do3J0a5
         SKNaME5zqKtoPTx5mjdadgiDNGSXSYSO3xop65leYZhgp4FAPq1G5AdbVNNC+ISaxQbO
         7SfY7xX1cuaNaY05GPlMe+GyLcX2EeYOyH7iNEXEi2cNJuJcfNu+gnm3KWBbqlJYjR+J
         mMwxCii5WgUqjCFf2bK9RgbhsKLW5wGPbLIMsn/iG9nTUS/zMu8GbPIdDOlTv0UiBRvR
         cbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XlLzEnPV60KftLGhh8r9bSMesh/zJFyj+Qb4Ugsc2zU=;
        fh=2iKz3AqYxwGck4acAtQJ6/208mwqzO+86tu6uoAL4Eg=;
        b=UoNvqa83LTEC4f/e7VbPrqwS0e+qp+mMFr7L+so5bn9Q4KpjwftsHQSGXMVaT7vLqC
         vsJW+c6TIFm3G5KPT+YAD48etnua/kK4TYeBf3COuKGKFV2WWTADZCyHy9sKRUPAiP20
         4aG03Q7hcCF8hNVZrxkBXJGBIS+uFXbdcHaJqTzzZxgU0ONtQthDJC/stGqboqJ/V4Sb
         lQkmO7d6uFYQcrRxJ1pZVOMmMCq+96ZjSuJUlnKxW20Omk0hyJcK6FJNDck7A5cSKWQt
         2LtkQp94cR2aLbcAx61qotLzfNMx5fF5UCPEsgAhScxMTtaZ8jsfGPSTmeXmRoqdKz5v
         9wDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770117359; x=1770722159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlLzEnPV60KftLGhh8r9bSMesh/zJFyj+Qb4Ugsc2zU=;
        b=vrA8jl5xmjR48L82gkrU7z+aPu6RU0LGA6iFwOedvRarFtl7EhoZW9ejAe9qECElj5
         gYsbncm1lYoKTUYV/HRXHjcIJf+uzAjgzkhSb+IHK+NOhX+Vz5n9wTMzk2m4jZ/fsw2O
         /qB+DgtbMi+Ad4FMnI01sB0UeQylIpwrM1WY5lX6G2kZK7cNgJhwDVE2J/ViXsib6g0R
         6DSY8DHUklQtzy2qtphXBm49c6+woUyFi2/kx0GGhek3nc1TYgaj7meisQufT7L13EwY
         eUz+2qXIA+B0qcx8lWbcQ/kPyCKYDols12qddKV1D/7WtB2z6sO+nNS1g5QTV4a2eMKj
         lCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770117359; x=1770722159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XlLzEnPV60KftLGhh8r9bSMesh/zJFyj+Qb4Ugsc2zU=;
        b=De72ngGB3ugXdoszjzGljvKvU0W+64O4ml7ru5X5R8wmiviUMtGfOdpdk5mQ8lgAb2
         zd40dD83/gdY1JUIYv9Oqr8HazBleoRoeFkI22X5M/lMPH3fncbMJVX8vuy17UGJdyg4
         qQaMbntbzkSw8poA6QIWRF0qM7AEaqWMj/wPlNRpUlK3/k8DMT19cv4PHxl4/CoANynz
         QDC/eaQsy9h8yvrd80Qdn6EJ/raoNakhCi7KWArAw1NKgg/Fkbqk2VS8CpNhx5PRMaoY
         WFKbtnjIzlwof+ETDHJbIZ6bmNFZDVjT2aN0ZWIr9C720cLPmcuipGMQKwgWfDfEV25S
         T56w==
X-Gm-Message-State: AOJu0Yxdzgn/blRGduUqqYryxeja/t0yolmEy5+o5REydbw5CVG/8who
	5iunYyvCeiZXe6sQEMJ03xEU8VMR3P6rek67rpfCFyUgNpTqbtVYFhGSImh+b8c9qifMNhF3njb
	UrCIC0tRSZ7Se1eyhmZxUa3Qtt9Tv+Td5lc611yj31g==
X-Gm-Gg: AZuq6aLZlA02zbY3KO8XIUTHforyCqm1GAauIE8fIUj35dg0AnTwbdDvx/R5qj3+cXc
	imlrNjN7hUDtnG/JDn5pm1YhsF3JpW+VZM/HZhWaXBcWwT5qTNe0lksnK2h31cK8Nk8GImwpC4A
	yIe3dBVzF51QqcxAgSwmlyMIVxs3A5iQ9/BvV1NbqnfdC5HWkkYsG6TpHzQq4b8a/jC1tCV9bT2
	3/CiMB7pdJiUYZN1samgi2iRXr0bgsHvUAFG13RF8XoYmfgWk/O1BhcMRV4Xekz1eWtCi/A
X-Received: by 2002:a05:6512:3501:b0:59b:b021:6033 with SMTP id
 2adb3069b0e04-59e316f3351mr862425e87.25.1770117359415; Tue, 03 Feb 2026
 03:15:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131020039.45966-1-enelsonmoore@gmail.com>
 <CAPDyKFps1oX=aKuUYFbXNQXM3rGtZOwTfgCaiHgDvGOb3qGc5w@mail.gmail.com> <CADkSEUhk1TfJXvLYOrx0OvVCgCA=L+CEZXGzQAhdTgkKz3a=bw@mail.gmail.com>
In-Reply-To: <CADkSEUhk1TfJXvLYOrx0OvVCgCA=L+CEZXGzQAhdTgkKz3a=bw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Feb 2026 12:15:23 +0100
X-Gm-Features: AZwV_QhDlRnfk5JnyqDQtKTQ5qNhPGlONfXLnyMh8EiEhS4sWCK1mrSMKZnSm_A
Message-ID: <CAPDyKFrfXgCZJtFHttA1E0Tn1tSugHWsSfZvP1RAOOx5=ViWQw@mail.gmail.com>
Subject: Re: [PATCH] mmc: remove unnecessary module_init/exit functions
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Feb 2026 at 21:40, Ethan Nelson-Moore <enelsonmoore@gmail.com> wr=
ote:
>
> Hi, Ulf,
>
> On Mon, Feb 2, 2026 at 4:32=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> > The above doesn't mention that omitting the _init/exit and functions
> > also makes the module unloadable.
> I can add that in the next version.
>
> > I think this should be perfectly fine for these cases, assuming that
> > we never want to unload the modules as they are pure library
> > functions. That said, please clarify this in the commit message.
> My understanding is that modules can be unloaded if one of the
> following is true:
> - They have neither init nor exit functions

I don't think that's correct. At least this is my understanding of how
this works.

> - They have both, and the exit function returns zero
> but that if a module has an init function but no exit function, it
> cannot be unloaded.
> Therefore, this change would result in the modules being able to be
> unloaded as they are currently.
> Feel free to correct me if I'm wrong.
>
> Ethan

Kind regards
Uffe
