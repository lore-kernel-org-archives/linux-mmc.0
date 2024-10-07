Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A452E1917E5
	for <linux-mmc@vger.kernel.org>; Mon,  7 Oct 2024 22:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338948; cv=none; b=QT2kgKF3df9dmcTG/E5V6TLy0bIs9W52Gf7qzLeSN0LWzZJW+Wf3VNx9GxAQbCvipl6H+mV9LwqFx2gu6sLmb4MFF7gTvgiE+RkdYbOS3pMyjIskSOBo5ju9gfkKgNzKzbgTFckgvzw7pX2/mJvFlnOx04e1EwNwTrNBsZ7mO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338948; c=relaxed/simple;
	bh=CqX9Y0dEmHgiIN61I3/zW08Bfod5n7pFQiGUVIMbBVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XI7J/AqX08Dom2iM8tylwRpwFbdCL0/V+oTqvtUe0wwiNY41gGbd3j0lwa/Jw3z+JwWgHxmr9NZWr30cGavAhEM3CC3pppgEu2kg2HpwrplhdSPy7BRfk3AdZhIJUiG09g03ADkGc1kAp3QdCm5K9IRm/SdVRtkukBZcmVPfDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i3hjBE03; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i3hjBE03"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e28e6a1b11eso706241276.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Oct 2024 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728338946; x=1728943746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CqX9Y0dEmHgiIN61I3/zW08Bfod5n7pFQiGUVIMbBVk=;
        b=i3hjBE03wtL8cwDcUk6g7y7hE6YEpfZjTNPS10LJRi7Wn9OvJ8p6AtqHXPqkdMu5Wm
         tpsEAPOVpIO4FDK1Ta14hg43azBQ8kOm8+z3p8shTOJQsaHyhlJpjsyv5fcBcivSPURQ
         07aLBKWV0wDMlR/Amj+Y6KLIBMTfYaMV7QXWzP9yOtiXIwCNEvpsNL4cnkH+/oKslLGE
         /8oM/bDugazlqytx3fQ99ZLDhAjYqTtuWcmZOium7a6LbroPL92nP1rJtGs2gJdp2a/8
         CDRIcL6q/ectAmSWgoU2ZlbZqKomVQ1k51iFupmpAstWXbFA7wx4C4ly+RK0awcZHLAt
         ZRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728338946; x=1728943746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqX9Y0dEmHgiIN61I3/zW08Bfod5n7pFQiGUVIMbBVk=;
        b=BrVvRiZOWorJvayp4CX/3PmdxI1S5/U92rskExGFhYwdChEPaeXwlWP6sEE7WtwDnI
         183JM/vXrVrP485m2wS014vbPS0GJOgygLMMVDzJ+C6HOX6wKInElwRCdBkT/26nxi5q
         0uho271frVWadqAVfTIEqLUKleeAUuUMnmOerNFVdpliHnPqb1BkVtMvFQEUV8uIGpCs
         R+A4kQwt1PfjS4hFO2LVW65q3p5zLf6owNGKsdtv8uubRoz5ZRgEa/dJns8H63pPu6h+
         tkOmtDjKb/XUR/zq+P7pUK92n5wtSM3/bWnLQ26FesU3lRGxhSgXsjyPconKm7XoQivk
         ZrPA==
X-Forwarded-Encrypted: i=1; AJvYcCUPpLLHPuKZzv6V3m7fq60/yUHb3jtAq/6VOIAWNaJzci20/OIeOJg5otf0tBavlSDFrRs/wl8Vv10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DFGh7OH77AFc+xUObYen532I6hdeNmVFYN8wMoG+o0K/UjXy
	1TGqQarB7DnKRQzHvOHIS1wdYv9lwc+D86EqQOVTpzhI8/3FSeHlYu0XAmE1OC/ET6y2kWKbIkW
	KNQgMdWQFP4xJTnHgKhT5MkofVO4U5u12uKrycg==
X-Google-Smtp-Source: AGHT+IE2nJVabbXdwibt1H0pVBms5dYTsG8RkBKKAzfdsgMhYsZ8VyWIk7HanuWHiQPQxXFBk2ezA08qlljJFN0QQR4=
X-Received: by 2002:a05:6902:848:b0:e28:edbd:765f with SMTP id
 3f1490d57ef6-e28edbd7f75mr206026276.2.1728338940867; Mon, 07 Oct 2024
 15:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
 <CAPDyKFp0N6UJhnHS164Tdf=xkWB0jzq65L9TdvYazeBQ-6WjeQ@mail.gmail.com> <20241007184924.GH14766@pendragon.ideasonboard.com>
In-Reply-To: <20241007184924.GH14766@pendragon.ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 00:08:24 +0200
Message-ID: <CAPDyKFpQVnF7eQv3dup8k-3EijnMjuveCG9sZ=Rpey1Y6MBJEg@mail.gmail.com>
Subject: Re: [PATCH 00/51] treewide: Switch to __pm_runtime_put_autosuspend()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-i3c@lists.infradead.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, patches@opensource.cirrus.com, 
	iommu@lists.linux.dev, imx@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org, 
	linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org, 
	asahi@lists.linux.dev, rafael@kernel.org, 
	Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 20:49, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ulf,
>
> On Fri, Oct 04, 2024 at 04:38:36PM +0200, Ulf Hansson wrote:
> > On Fri, 4 Oct 2024 at 11:41, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hello everyone,
> > >
> > > This set will switch the users of pm_runtime_put_autosuspend() to
> > > __pm_runtime_put_autosuspend() while the former will soon be re-purposed
> > > to include a call to pm_runtime_mark_last_busy(). The two are almost
> > > always used together, apart from bugs which are likely common. Going
> > > forward, most new users should be using pm_runtime_put_autosuspend().
> > >
> > > Once this conversion is done and pm_runtime_put_autosuspend() re-purposed,
> > > I'll post another set to merge the calls to __pm_runtime_put_autosuspend()
> > > and pm_runtime_mark_last_busy().
> >
> > That sounds like it could cause a lot of churns.
> >
> > Why not add a new helper function that does the
> > pm_runtime_put_autosuspend() and the pm_runtime_mark_last_busy()
> > things? Then we can start moving users over to this new interface,
> > rather than having this intermediate step?
>
> I think the API would be nicer if we used the shortest and simplest
> function names for the most common use cases. Following
> pm_runtime_put_autosuspend() with pm_runtime_mark_last_busy() is that
> most common use case. That's why I like Sakari's approach of repurposing
> pm_runtime_put_autosuspend(), and introducing
> __pm_runtime_put_autosuspend() for the odd cases where
> pm_runtime_mark_last_busy() shouldn't be called.

Okay, so the reason for this approach is because we couldn't find a
short and descriptive name that could be used in favor of
pm_runtime_put_autosuspend(). Let me throw some ideas at it and maybe
you like it - or not. :-)

I don't know what options you guys discussed, but to me the entire
"autosuspend"-suffix isn't really that necessary in my opinion. There
are more ways than calling pm_runtime_put_autosuspend() that triggers
us to use the RPM_AUTO flag for rpm_suspend(). For example, just
calling pm_runtime_put() has the similar effect.

Moreover, it's similar for pm_runtime_mark_last_busy(), it's called
during rpm_resume() too, for example. So why bother about having
"mark_last_busy" in the new name too.

That said, my suggestion is simply "pm_runtime_put_suspend".

If you don't like it, I will certainly not object to your current
approach, even if I think it leads to unnecessary churns.

[...]

Kind regards
Uffe
