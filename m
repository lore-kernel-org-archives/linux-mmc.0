Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5808347C3
	for <linux-mmc@vger.kernel.org>; Fri, 15 Aug 2025 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755260777; cv=none; b=DVza1uybfBdT6f78fenQx80IURouMOtGbK0GstyxTMzG+5NLTzHyoVUOAMAIun6E8ORFW/WrHYSVM5Cq+nK4A+BEGPz6q95HhZsOevzIzQibWS2F98k7TRjeagC75yY8nUMOQOhqR3lEpWLrlQoAWiDDA5SDIt3z1o/koOtWsrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755260777; c=relaxed/simple;
	bh=DQX/325BTJnKHkvFsWcPtvM5Q7ywGneVXSiEXQCqUS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzwgmCoaVbysb9SYtTGw6XXdjAp6/Gqc+PuGxLzqMvxHZ2MpIHpvmUxbzF3dJrCcq+ZnbxEgkkepUMoankJfS2zdAtMGeZwQ7DO/Tx9duNQHGBvnmDtAj9vJ9TmOglfuoCNf9V73s/PUJGpBywafOdZaGjETK2nmBbZUn4/YYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iht3SdZa; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iht3SdZa"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71e6eb6494eso2995747b3.3
        for <linux-mmc@vger.kernel.org>; Fri, 15 Aug 2025 05:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755260775; x=1755865575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQX/325BTJnKHkvFsWcPtvM5Q7ywGneVXSiEXQCqUS8=;
        b=iht3SdZas2mQXu3/dhjbElUy4wg0D7jCLT4ogv3RCeCd7qTGPHIaqJ8MzfLMsKYWdD
         w58TDST0AK6JUacwn+bTqrEGcOn7y9WQOxoKfDx/Miuh8SxdmOR2+7ho3URk1r5XhbBA
         GeiTKvGTHUM1RoBtpYqj2MPZlCs7h4T5RvjiCHrTyUbdafAKoQAmmO0k1ITxtYouGvcI
         rHBm9n1MK2bo0sQRR5ig+7lZxT0lEq3IEdd4XDar3t88LLeE8gFG6vW9D0V5ffDd5TT7
         Yvzel+n1HDoOrIp83HGvwaenw/YjsO22L4+qq2CQVGV2PJbCvcGyxjt8USuXXakO2vw0
         dOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755260775; x=1755865575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQX/325BTJnKHkvFsWcPtvM5Q7ywGneVXSiEXQCqUS8=;
        b=Ajr/ioZnTtTiWc/Qsy45zn+3SaOJ90AuI00rhcphfiopLmrdZSeE6qdLH2NrdILYFe
         ms3Tu+EkG20Kd6/HPa65DVx09x//ucM0xgQ+1654K2GThmNpOQNkIiKE2pET1Yfx1qaF
         gB6wi6KpwZXZ8UZe4DVVa46DmwJ8AcGzCk+Djs+zmqTv5m6/XqqpaPl5WTTGKmPXZbjH
         W7I1jAzs4TwDOToBOd8QhiAWTTWv9WwNWq8b869bNvWOxleADDiYCu+liVKo8U+4dVkU
         bKuhXJhU9PZCON/ipZkaPnqbAYIZ9E/UMCES2PnuRQJMq0QYyfqwu3GuNj0epJwA0cn4
         4HEQ==
X-Forwarded-Encrypted: i=1; AJvYcCULD9aLL/kEGqTI0u9dQIJMjkkNljqq0cD1OkZOeFWOV9PVVf1tSOzoiCm77k+zLHtTSyMXL5TAWqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIXPtYcsdGwZ4q6pYjPhdBr4Il2ORARW39dFK7rGT79oIWLZqm
	kRQ+qsRAbO6VmRcfp7LPgeLnq++I1UANTHhhA8tZfYGc7rTN2355xg64p77nkUB4F9Cd/Jpmm7O
	gvACY7SbbU8zOWIC2eu9F9Dj5Qn3idLp/6LJDW3Kgjw==
X-Gm-Gg: ASbGncu16gGVNNDz+tnjPFzoJt8a3LwoDR9IEaHBQuVg4Y1EmrrSf7OjHXImv8XfptZ
	DFGAgpz5m3sIKb+mdKp4pW9TbX/X48abR7N/7qnus+nPnq/NoKhdXcEnuMI7sXM3/iBaRAwCSFU
	T+Ey8NKuLZBKtMAiZRH9LzJS7f0nQbmsUN6m8owmz6tTGOkKFLPsoFj06qPjq3YRW7pophftJj6
	fsCWPiH
X-Google-Smtp-Source: AGHT+IGVoF64dU58ys34hvl+sIzQbOqcLwGqOY2pYfPr1ee69oOhAIvxgZmb6HK1gQ9HxhwTtrIryKzZXt5l7++Kafc=
X-Received: by 2002:a05:690c:4b8b:b0:71a:1c70:c20a with SMTP id
 00721157ae682-71e6de43d96mr25006987b3.35.1755260774882; Fri, 15 Aug 2025
 05:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com>
 <CAPDyKFqa6ut25uaDN6pP50wGi2+DZ8MJ6_OZ6ujtgjfHz4hxzg@mail.gmail.com> <4977174.OV4Wx5bFTl@benoit.monin>
In-Reply-To: <4977174.OV4Wx5bFTl@benoit.monin>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 15 Aug 2025 14:25:38 +0200
X-Gm-Features: Ac12FXx4tr2FImgs2XwKqj-A11Qn4v2kO0YkD0oNl-AEmBzNU2XnHeUCkbheHm4
Message-ID: <CAPDyKFrfV_VpX0dRJGMHLNgfYPW5njGCHZghtb3Oos-6CjV5DQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] mmc: introduce multi-block read gap tuning
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Aug 2025 at 16:07, Beno=C3=AEt Monin <benoit.monin@bootlin.com> =
wrote:
>
> Hello Ulf,
>
> On Friday, 18 July 2025 at 15:04:18 CEST, Ulf Hansson wrote:
> > A quick review made me feel a lot better about this, thanks!
> >
> > Although I will need a few more days for review and possibly it's
> > getting too late for v6.17 for me, but let's see, I will do my best.
> >
> Any update on the review?

Sorry for the delay. Just a minor comment on patch5, but the rest
looks good to me!

>
> I have a new version with the small changes suggested by Adrian. I can se=
nd
> it but I'd rather wait if you also have some comments to avoid doing two
> separate versions of the patchset.

Thanks for pinging me! I will try to be quicker next time.

Kind regards
Uffe
