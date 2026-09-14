Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709BF35DA79
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387785; cv=none; b=H+SwDUjRxsoGGu4k2ROeX2WhmpNrZmZZQVrSLEuLkRfP+9c0V71MLjO+EwKs5AxcCT0gBLbSAOJLZYr7FBZX+f2pVlN3tNqLlxYmTw8D4l9k65ZXkdMp9CFtjTSX/WE0VlPAt2BfbBY49dvHl1kmlE5Cm5nQL2ht5TYYZKgtric=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387785; c=relaxed/simple;
	bh=oEGonrOZlzy2M5jFRShHiryuRufZxR9C/svj2ihcOLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEuQEU+WrdmccNL6l4z8o42fK7sF+je/C02HxdfHoFZKChBhPVC9VW69JZifzh+jxEafOJwBNEsnl7NF3QOjyjBhR1ZoXrU6k3Tg/wnGC8n5nLMttUXQpJ6wS3HERIsvlFMWOf7OOOQ3rCA2mAzbjdIXmjup+VPrsuJvELGoPZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smy5MATd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smy5MATd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F067B1F00898
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 12:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789387784;
	bh=oEGonrOZlzy2M5jFRShHiryuRufZxR9C/svj2ihcOLQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Smy5MATdH0hdm95yi6FiXZU6dp3pCLMs+VPTVe5rxWQzA7RapfSmNvplbGotg1Lfs
	 AD/AIeB8E/A3NSQlOzg4bVVkHaFqEr5EMSGQOt4ndWnk+x+9fm/6qBoi6ytuE9SiT2
	 jQuDByF3kn5gwK4rLLmHoG8CXiNv9XuWIWL0ojXES0WyQELY7/kP29RgF3wzlEwxgL
	 PcbPEefs/sOEuYhdYRBEJ2cbqkk39Mn4pLHiwRfh3mY/LYboKC+0hYfTO3wlydGW/L
	 IqsqJj/QEK2E+pHOpSblHuaUcrYhoEyOxOO/zrdMWAqUxAh1goxAPuwJkSyUWkgO4D
	 YJP4mFsz40MIg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b5e907853eso3316705e87.2
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 05:09:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwMWirLHpelKJbk1whO+dvqZvuqzM+3wzYh0GeCtNfCpm75YmlOyZ80TF/IUfq197ljv4+yxh/k6Mw=@vger.kernel.org
X-Gm-Message-State: AFuF++lQLRyxdI/+m4SBHyFMVfuXp8WwbkE1qT2+T0GXGkddH58dVXwI
	1MvoRqRYGLPhgwxAcVGTFS8fX7kOkquD5x/Xm7gYl2r4PXzeA4tjKcyUgeh1A2CPmc12CNuAMzU
	HxDIr0FR4ylQOc58Z7RXkfi1sVcxlKEw=
X-Received: by 2002:a05:6512:251f:b0:5b6:1a7c:59cb with SMTP id
 2adb3069b0e04-5b8ae69c7efmr615614e87.37.1789387782673; Mon, 14 Sep 2026
 05:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-mmc-credit-ossman-v1-1-9e914bf2a57a@kernel.org> <CAPx+jO86_1EUwp6MHtJpykEDH-jby_owub6-QcYRGjew6BkSJQ@mail.gmail.com>
In-Reply-To: <CAPx+jO86_1EUwp6MHtJpykEDH-jby_owub6-QcYRGjew6BkSJQ@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 14:09:29 +0200
X-Gmail-Original-Message-ID: <CAD++jLnxb91oBCcpQuHE4hQP6Fc_DVKQvEfGjwm7k7OQeV0PkQ@mail.gmail.com>
X-Gm-Features: AcwNN1Xi-1VTM3Jq-GP2V5slsuy_4hTT8wgSCnBVg3f3dlnVpWLa6ldefEk0fy8
Message-ID: <CAD++jLnxb91oBCcpQuHE4hQP6Fc_DVKQvEfGjwm7k7OQeV0PkQ@mail.gmail.com>
Subject: Re: [PATCH] CREDITS: Add Pierre Ossman
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 12:09=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:
> On Fri, Sep 11, 2026 at 10:09=E2=80=AFPM Linus Walleij <linusw@kernel.org=
> wrote:
> >
> > Now I have a bad conscience for removing Pierre's name from
> > every dmesg without properly adding him to the CREDITS. OK,
> > it's an easy fix.
> >
> > Fixes: 366b5941566c ("mmc: sdhci: Stop advertising the driver in dmesg"=
)
>
> Not sure this deserves a fixes tag or does it?

Your pick, no big deal.

> > Signed-off-by: Linus Walleij <linusw@kernel.org>
>
> Applied for next, thanks!

Thanks!

Yours,
Linus Walleij
