Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC2836D4E7
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979108; cv=none; b=g+Jknh0q9sI5z1SyWiNw8DvyBsZh9Rg5Kn9tqF3KGKOjutAoodlJwME4Xst1xMLjx2QRBbPfhKvKh48ODS4xvqd5TR93AwE4mAWj/8yhGWfbbd2tOeXJMqUUvckK4KF/nOY4kkBwxKUFSp1D/njXpbEVghYax2ZJs9O1SsdSkJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979108; c=relaxed/simple;
	bh=f6B5SW7LECquH7Dinl9RlUBMU54vE/D4a/fXNNyeTLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8KTcFtAYIZmXaey7S0jmnjFGto205peOUvWgd9UTjQm73LCh+jic0570TO8GmE31G3CxsQ2J65iTFtsmQIQEygr23V0dX0kE0nElEzT0WaHPuiWPQLGEdnWg4MhVoV58pXLmdDnyydB7v+Pj3kc748eBsvxTy6PJ7ZwiWFxwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DXJNgkXk; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXJNgkXk"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5959105629bso6051256e87.2
        for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 05:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765979104; x=1766583904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f6B5SW7LECquH7Dinl9RlUBMU54vE/D4a/fXNNyeTLw=;
        b=DXJNgkXk/KIAr8PWbJpSjdbfQPFkrQwKNfCnChjLG7X1DD8vHhpOmwzOOYWFsjvd2Q
         +gAlFc2AVxTnNtcZUm8n68OHl+WYrzUE9MMR2kYB5moRqLYCsaXwROJEH6UezpVBfcxx
         MaHNLhxww3r/hlqbN0j4E6rbikv4afndrU5OtrUth2EnWPEV3MoBk//+s9YI6xS94M+t
         Y+U21Zu7M5DJc+57nRIHRaKgs0vJNZzuadvOIrqZyF9l+uFJh4qX8mBBzQcd+JQ94Ywj
         fX+7l2S2UbfKOgEv8TmvpnV6x6cFWwraj2ZXx0O2Ce79kkZjBECgw0TtpGLHUUzevcbi
         EwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979104; x=1766583904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6B5SW7LECquH7Dinl9RlUBMU54vE/D4a/fXNNyeTLw=;
        b=THfAcksCOBK9CGCUKUFP/OxTREjPcayI5p2/kduLKywDts5s/n3au7K4gYeFUKt2F9
         XBBORcD5pwCGsSnSJn894u8s4EQ8+ZmkErt7vJ02dUwAD9XlHw7LeqjIvIiEKbtKOhGV
         JiWkJSfFHSYPkVUpKqj7J+8jECY2kbhOdCSfvxnJieM/g6JJUnaPOI4RTcYJqY4cU93d
         cdsSBQ3G2fV/kXyKgxwm/WUEeMH522S1Y+XIgi9VewGGBjHcz1KzJmMrlaH4Cl3+/FlR
         1HZU30Nk2p5aO6uggErxVTK5LmKlyPXrt2+XyrFcre6DLAd1xdL+c2lz4IdsvMYjsJi1
         6BFQ==
X-Gm-Message-State: AOJu0YyltCyp4tuYz62hvRodWrbio7iBNdj1xhur7hztieP286nfd2Ts
	QCibzTNXU4VedaL1aj9bYLkLHCXzvakWIJLfJP5MYqD7QEeb53eXOnRpuvnaiOimob/oKialn3U
	b1t/zc6K2n2qY1BmBN4UiNs2SqGxOTn+IQtnVuMfuqQ==
X-Gm-Gg: AY/fxX6iDa9nSMEN+Sr44agYajkC6tDZLa9tQiYJHsRS51vXQXUW7pokCGM3IU7/ADH
	gLK1iFjkGz54nZEN7QaaTGcWRZcABlod90ukSzs9A9oJIO9id+4j6Uk7Cc1rEuPkfPHpYGgE2R/
	/2XVKd03zYquOtlRKny6du6QPqTTA20QstJPyjO+8ZcyuUjetWBXyTvMzFp84nJyv+uMH4efxnb
	EfzzQUIEpbUnrBZIaxmhBK7Ah8tl3rNTapPWL5D8Noxgf+St0seW+3vezauv542SIFIKU8=
X-Google-Smtp-Source: AGHT+IE6H3QU/soKtgCj1SmIpi7a5VzPCSzj1rJ3p7E+A3JDLrDod8EjGZgd/BWl7aCnuLhLw1J+9LSsCRoEqYf+fBU=
X-Received: by 2002:a05:6512:2203:b0:597:dd9b:d444 with SMTP id
 2adb3069b0e04-598faa31282mr5999274e87.19.1765979103831; Wed, 17 Dec 2025
 05:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128052011.204735-1-avri.altman@sandisk.com>
 <CAPDyKFpshnLSa+GNOpFdQ6_Kc2ov_jofq56eq7WsqZMRVYs-NQ@mail.gmail.com> <DS1PR16MB6753E217F183ADF4F6800879E5ADA@DS1PR16MB6753.namprd16.prod.outlook.com>
In-Reply-To: <DS1PR16MB6753E217F183ADF4F6800879E5ADA@DS1PR16MB6753.namprd16.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Dec 2025 14:44:25 +0100
X-Gm-Features: AQt7F2qCEDvmD2RY1GVy-i9iCIMt2e2Oy7oOTht_V0HrIUORtEnxlcCAMv25j1o
Message-ID: <CAPDyKFpUVevhHDp2BEvAcwXkopAdo3Nb4MnppwSbpJ5pL6EQ=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: core: Extend manufacturing date beyond 2025
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Dec 2025 at 17:28, Avri Altman <Avri.Altman@sandisk.com> wrote:
>
> > I have applied the series for next, thanks!
> >
> > However, I noticed that the author of the patch has your gmail-address and the
> > sob has your sandisk-address. I guess we should change to your sandisk-address
> > to be in both places, no?
> Yes. Sorry for missing this.

No worries, I have amended the commits accordingly.

Kind regards
Uffe
