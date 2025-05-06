Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1171865E3
	for <linux-mmc@vger.kernel.org>; Tue,  6 May 2025 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517759; cv=none; b=WNrQFLGxudt3VTd1yfqznQt0IlvPnWyHvxfnpcUN5FD3zwePG5EoJwfdXUd0Mv/kLUppx018ddoJAgjDIlKWAee28YwOQfhIhlSL6tkUO9jpfIi8nWZu8/dClG+e4vUBgsg3/PA7hrvARrYoqIjMKYNdu+mQ1g3v9EtNAz8DkCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517759; c=relaxed/simple;
	bh=2s4awz1pq6AtOnxGpTgUA0plXoOmwpwHHRh+n0HME8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPtwHBeWYcNsTQS4mU/z0pJtNCOASPLfm9XzANiieNQIqR9iGC9DxOI5bsUJE8Yo1YthC6+TpKUgMxgetYhFlLoSNKtIHOos+yLTY9L1Jb/1BSJOt2kq2ZjfV6srZ0kYI7za2SKqtmQj6qVhxsKFUKvcn06zCzbK3RLKdDVuV/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=lVLaDQrE; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lVLaDQrE"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6fead015247so47692277b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 06 May 2025 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1746517755; x=1747122555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2s4awz1pq6AtOnxGpTgUA0plXoOmwpwHHRh+n0HME8E=;
        b=lVLaDQrECaweQYzHcuEnrn4h0nYxDU5DZQPA4sYVvzQpFvNfJ8F1peqyTy2pX5JR0I
         K/w4yolF/9QiKRRM1BS4VV51QPA3u1IbDyO67/iTQFvFalaEXFFAb5qWPa4EZLGW6daJ
         hiZ1kVVpyw49+TL8ZYI8zpEWldbfHyrLzsazo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746517755; x=1747122555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2s4awz1pq6AtOnxGpTgUA0plXoOmwpwHHRh+n0HME8E=;
        b=bPpXl+0WqHPums/53oN1YNMehY+ldALmXNKpUArp0JrD0SIQ75uTqoF/EYmmI62X5c
         8GGuD8z/Fhxa7d8lQ8Vhr1ud4VQeFXqlTPcuBmGH8XmItbp63Qh/7dRhWLgN6rT1MPP6
         0QcOEpElXFrfWiJcQ8smunoTodg2NxI6iJ+43V2G0q+L92O7NQo6bWWTx2MxJd/w0flb
         1WkhXdL7McyAMfxlp94F7plwkyU8CtEOwZLWc8Tgy70smAEGQax3760OAx/vbGwMtQ6C
         9DXi7G3EHFSYK9URfEU+4YlHvVIWN2ZCXBsBtWV5nLoqbgbtVeLFheLjKrrOWqE6VxuY
         IrTA==
X-Gm-Message-State: AOJu0YxS6asXusWHOHNWAto91a9xvVqoR6XCFZhRPK5mmEagHKfusEuW
	NzD0yLSduLfu6W1LtBcSObiZ9+MgpJR6QfacG7t39kyCrNDnA9Lg0JALW9keenRjQlDzrXMQnrD
	9EV4DHTt4XyNb6u/z0xxcajwFYaMg5y6eAZTvrg==
X-Gm-Gg: ASbGnctdnRIBcrpGvqgDi9EPuFp2qivNXR/bRXSy+pEgHjCHU93kzx1hCDl7hyPBjD7
	Vi8PeX2S1BrHISZ78dNXNBtuISuv3qiG0NEIzAkVNuZEsDoaOf6bmSK/xe9T6LolzIGHl61GAEn
	dbY0iGCwCzzQtQTXdqxhK/Uei2BfejKw==
X-Google-Smtp-Source: AGHT+IG/mu3CpdjkKTUwmHgQG1stWfab87juNB8A51aCqpzBhgiz/eoy4qBG3MFH7fc2Dw0Zc+sON13BcgurKmteqN0=
X-Received: by 2002:a05:690c:4a07:b0:708:11c7:d200 with SMTP id
 00721157ae682-708eaeceb4fmr118978097b3.4.1746517755119; Tue, 06 May 2025
 00:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABGWkvp-peEfhc57-+g+_w4DWWqdWVgw6CFF0tS7yjGsTtTufQ@mail.gmail.com>
 <CAPDyKFqWRDTqXjkb84BG=Kid+MQO_R-cJNcYFB3scnEhhsX46g@mail.gmail.com>
In-Reply-To: <CAPDyKFqWRDTqXjkb84BG=Kid+MQO_R-cJNcYFB3scnEhhsX46g@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Tue, 6 May 2025 09:49:04 +0200
X-Gm-Features: ATxdqUHZUyCh4YVBOgn8b4xlgUzdnb2ism4TsFOHJVReG3TwNlvw0LE3LebvnKQ
Message-ID: <CABGWkvr2TPKkqQKYZkx7u0rhf4xyg7WNg6H7+hdpETSqv6MF2w@mail.gmail.com>
Subject: Re: RFC: mmc-utils versioning
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Avri Altman <avri.altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ulf,

On Mon, May 5, 2025 at 3:20=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Wed, 30 Apr 2025 at 19:05, Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
> >
> > Hello Ulf and Avri,
> >
> > Would it be possible to tag future releases? That way, Buildroot's auto=
build
> > service would automatically notify the maintainers of the package of a
> > new release,
> > and in turn update the package with the latest changes.
>
> It's certainly doable. Setting a tag is simple, but having a more
> formal release-cycle with release-notes, etc, is to me a bit too much.
>
> Would just a tag be okay with some kind of summary of the updates
> since the last tag?

Yes, I think so

Thanks and regards,
Dario
>
> We need Avri's opinion on this too.
>
> Kind regards
> Uffe



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
