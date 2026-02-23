Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B54C23B61E
	for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854288; cv=pass; b=Nt7H8SotEHeluUfUzLbkb0Hf/GbSamOAp/wHTqogY1staOVBu86xaEGSV4MP2b5XUMfHJ9QgKiWjGZv4LjGLnYdgHQ3rH2hT29hnU6jEMa1veBJjCKR+wv2xgMSBMEQk9j9/3Zo81Lcwzgu3cp4e2NP6pUbiT+4PtxbsOUz4Pos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854288; c=relaxed/simple;
	bh=sR1JFSsAon01OtvSAsV6/RGrd106y8rHwXlJpuS8MH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/bJ2L1cLq6gw8gpLBr70iwS81vsy9TRM6m6U2ByHkZa/Ui9yHh/QYg6qjH0xbIXpp9UmElmNLjWej1cSuYBNgX71oM+6eMs0SyV27L7OKRrbJY5LMzi/q9bUUMAhZnmy11J3izh9nAQWYHHhOI6q5DkUhCD36D7uygGSGbH2QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mn6By/yF; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mn6By/yF"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59e5eaa491cso5721129e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 05:44:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771854285; cv=none;
        d=google.com; s=arc-20240605;
        b=lGZOHiORTVgx0Nx8ugyNUJvyORjnMqRE7RW8xb1erFA8MjhyM3XX++8Bs2OuzHC5dW
         rXHcw9TCgyi5LKqiHcGPDz6S4+ub6zs42wD9fizcnCuDx7EbAzc3E7MW+69rGFYcYWV1
         hzGZm+Jdkb5RkPOoB9OR4iIbwzIUQB5V00SsgwiBr3txG7IfmSUKi9UJecY5VGID+OZd
         8yyHiP6/aFXyyj26+u9nk3+BCtq2Y2btVtqglKJWJUKpAKt0d1/kbmD8dlzGObT897e2
         cAReXoRDExbWn3PI2mZdNAsSRY2S16P4gY8nX4R6yfSHhmyqnnMtd4LpveAfpKKiVMJO
         GwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Fhetx7uwtFJRgRkUexEhKn5KeWaKODjWdb8CIbVt7HA=;
        fh=aarkJBshOvDvOZTQJmH6W7bQZZTFLHiHdYwinszvMio=;
        b=gkoXHtnVFzdVr9cRhD8ENkWoXlGjimlKROT1rS0XKaCSP/qtZDNBjjqPD1lLysQXiY
         D60OqfO0adFP0qRh3onyAb3/KG4Yk/dlEOLBD9xK79da1/WM2OFSb992uwS3boPYeif/
         XwXdkIYaWoCKhoUefcp6XU2JkZeN3Mo6L1eqkAu++dRfRF+YKR2WCTQl3+k0xHFTukoW
         KTJSzvL+KgLGdzy0SQDXqfeOmc4nMiMh7HJVg+6o2MzLe3U/ocgxtEpIOjOOy7oJTgyS
         Rx6AZ8byJfRvpdChxwwOwqj0XpofvOKy8OINCDemwBU0AAFGaF284fzr3rpOy5N416p0
         hwMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771854285; x=1772459085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fhetx7uwtFJRgRkUexEhKn5KeWaKODjWdb8CIbVt7HA=;
        b=Mn6By/yFk66UzcpBhl82x6Y1icrzzwKx9TUqEq3avBMnSHH/WPGJyCzaC3X+5e5n2K
         7bDTmcVGAZib/lFAPpQS4zMhkeXu1HrYYx1cv3XLXC2baXFEJz0XfoQAvyESmb3L+kov
         m8dOcBWKh0Nd9Dk0z+OBiGcWj3EDk5E/1l49nKJqzfTmM0RsHFeSxMB2oY8IyO5gUP3i
         9tFtVAJdHs0MvdjgqSktkuXY9C5WkZah8ldRFmKDb+zeQaNPVhQ1wVnpYdTyKVqJFi0z
         k0hdwI1KdLLql/L472glJMnAZ1CMcfcaaKq/2ndxHwGkyetsnWfyB5b+Zi5aQxebeWze
         YszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854285; x=1772459085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fhetx7uwtFJRgRkUexEhKn5KeWaKODjWdb8CIbVt7HA=;
        b=i/L/nATBf8gruR/eVp17AeZ1UWMwESlyOt6tFH+oSGPZPtjVktfcIXvoT2Hvl++2ST
         IleQHaDF8/ODKDc1DolvOGcHqzy5i3L5gcB36LGGEhqQrZ0zl80DEbbSCIbG+zUjGazH
         lEMmGCFYD3hp4+VGEzShNhICzUslb8leZuVLL7X2wQ6v/pAZ4vgrVo9uYbtHSdamiHNL
         kR2hwU7kTc5xAbb5QuE25mPxSmM4nm5iyhlV3pq93QNmWTnHthsbiTVr7qnr5DFld+NG
         +207Ts2tWw0RLxSKtsoQJt0T3jxObYRXByra2XMyPn1l4H2WpoaN0PZo1HkIn3F45kB6
         XQcw==
X-Forwarded-Encrypted: i=1; AJvYcCWIOpLj2IMeRewHgCcYoAWbxGWobVp3dqLHB+pm+wGlmjRffGOrQWHV99OJsAQ/7fk7IBASpnplgxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpyLtt5x0/NnhsF2ZuAVzJssHyN3Kmv8NudY13X+yhMjiGuTJV
	aZ/IooLt52V49VK9ClrkvZUJp18mCsqtVH42ak83zXHOy85N1aZCiDs+U3suIzz8UFdnPSFvu59
	m4U0sfIUiaZFbNDAJoEYlZ6J9phBwDytelX+DMXTDTQ==
X-Gm-Gg: AZuq6aJa/UMrbnvO41EtkuehJQxVtAEId35OLEck/OKDebbwbd0u6L/SryOncXrFQmQ
	rHSJt3ccegCQMFLZj/VI0yrj6Cg0p93qar/+Mt63tf6L1LUl9YKXl4ukSi2Y30zF8SGL/R5lLHQ
	dBhvuP/YFtwGXjowv17TTRxRGJePBXddzWbBZTQztNaL6vj24vnks1LZmlMtwdqG4/pj+ShkUpk
	p1oVvhF+VCW3scwt2NHuN9oeplX6YHngqB+8+/IUz3gm6UiIOuHlR77GVcqGCZTRiFlVK/emsyX
	2UTP1Lm6
X-Received: by 2002:a05:6512:318f:b0:59e:63b7:585e with SMTP id
 2adb3069b0e04-5a0ed99f1fcmr2755602e87.36.1771854284344; Mon, 23 Feb 2026
 05:44:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com> <20260212164823.mbeycqwzsy2dfq6e@skbuf>
 <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
 <f9ede0d3-6a37-449c-b62b-a5c761ece097@solid-run.com> <20260216092914.kmvl7aep7dantcsd@skbuf>
 <20260216162406.0121dd91@kemnade.info> <203a36fb-6ac9-41f6-80ce-b137b9db4ad1@solid-run.com>
In-Reply-To: <203a36fb-6ac9-41f6-80ce-b137b9db4ad1@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Feb 2026 14:44:07 +0100
X-Gm-Features: AaiRm53IT_Xzv6_ZjZsPbjTua3wzc0_3fH4fOJcUrcKMz5LLxYEEUcMyBCE8pyI
Message-ID: <CAPDyKFrtTaJ5fqqbGrE_K6SAdTZYUfp-BycGjtWs4SabwBysKA@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
To: Josua Mayer <josua@solid-run.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Vladimir Oltean <olteanv@gmail.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Feb 2026 at 13:44, Josua Mayer <josua@solid-run.com> wrote:
>
> Am 16.02.26 um 16:24 schrieb Andreas Kemnade:
> > On Mon, 16 Feb 2026 11:29:14 +0200
> > Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> >> Hi Josua,
> >>
> >> On Mon, Feb 16, 2026 at 08:19:27AM +0000, Josua Mayer wrote:
> >>>>> In the future, when you have a series with cross-tree dependencies,
> >>>>> please try to think of it as individual mini-series for each tree's
> >>>>> 'next' branch, and specify clearly that you need stable tags (to be
> >>>>> pulled into other trees).
> >>> I don't really understand how I could split my series up to avoid this
> >>> issue.
> >>>
> >>> Due to the fact that one (and now two) drivers implemented local
> >>> mux helpers, to undo that an atomic change must be made tree-wide.
> >>>
> >>> Meanwhile it must be avoided that while the mux core helpers are being
> >>> tested / reviewed, that any tree adds another driver-local mux helper
> >>> like appears to have happened here.
> >>>
> >>> Note that my patch-set did go to linux-phy@lists.infradead.org list, too.
> >>>
> >>> The second challenge for this series was that mux framework is being
> >>> enabled only by drivers Kconfig "select" - and not possible by menuconfig.
> >>> This is e.g. responsible for being unable to test =m build with arm64
> >>> defconfig - and lead to it only being detected through kernel robot
> >>> x86_64 allmodconfig.
> >> To avoid this, a combination of developer due diligence + maintainer due
> >> diligence is probably required.
> >>
> >> From linux-phy perspective, there will be some automated build testing
> >> (which did not exist at the time of your submission). This would have
> >> caught the 'hidden' devm_mux_state_get_optional() call present only in
> >> linux-phy/next, when testing patch 2/7.
> Excellent!
> >>
> >> But, to work, the build automation needs to be able to apply the entire
> >> patch set on linux-phy/next. So expect some pushback if it doesn't
> >> (hence the recommendation to send a mini-series to linux-phy first, and
> >> request a stable tag).
> It would help immensely if there was a way to get the patches renaming
> driver-local conflicting helper-functions very early, before anything else.
>
> Would this sort of patch be acceptable in linux-next now, so it can make
> it into v7.0-rc1?
>
> If not then that mini-patchset would be the first one I shall submit after
> v7.0-rc1 is released.
>
> Then I can treat the actual implementation of the devm_mux_* helpers
> as a second standalone patch-set.
>
> And finally patching all drivers with local helpers to use the new global ones
> can be patch-set number 3.
>
> Any opinions on this?
>
> > I do not think that is at all the duty of the patch submitter. I think as
> > long as every dependencies and side effects are documented, it is IMHO up to the
> > maintainers to decide how it can be merged best. They know best whether there
> > is any danger of conflicts in their working tree because that is an area
> > where people are working on. Especially this patchset is around for months.
> >
> >  In MFD where it is
> > more common practice to have cross-subsystem patchsets, once acks from
> > everyone are there, MFD Maintainer creates an immutable branch with a tag.
> > The maintainers of the affected subsystems pull it in.
> This seems like an option, if I can get the patch-set (or a partial one) ready early in the cycle.

I agree with this approach as it should provide less churns for all of
us. Especially since the changes to the consumer drivers here are few
and trivial.

I am willing to help with hosting the immutable branch (unless someone
else wants of course). Once all acks have been received for the
series, I can set it up. Then other subsystem maintainers can pull it
in if there is a need to avoid conflicts/build-errors.

Kind regards
Uffe
