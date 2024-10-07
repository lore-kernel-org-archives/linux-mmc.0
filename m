Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EB518DF72
	for <linux-mmc@vger.kernel.org>; Mon,  7 Oct 2024 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728340531; cv=none; b=g0icqhNpIVNYYjkB8phFMFSowSElonI8XNOoQsW60mhqPFr8uYy11S3/+afPT8B438p5qO3FU4GOzk7NDPjCl7jHpRTtLzt1mzbneqOEqvy7kpzfcooYkJzjOCrCJGSYmwU7Kla5ygLmgbwOabadrrfngLAfgJHS5kvpugo0fuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728340531; c=relaxed/simple;
	bh=gesjil9Y0RZgbcjmX5qHd/S97rHztDCcedkOm+1cl0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bu5AdPzC+HFly0hwh3yMhT3CE7IbdOl8/uD/k23dKZcOJl4eZyRStdFppLGy8flHl5xYxJty478Gc0/QL+UQq9ffo5Z1Ybvo/lxyTDurszvSnnGc2znfnnxTNy0ik0B9+v+BD6eF2PjZpTwFGOS1FBx9AOBH50wW9Ng2eJVR47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e3VL5Ud8; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3VL5Ud8"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e026a2238d8so4471273276.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Oct 2024 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728340526; x=1728945326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gesjil9Y0RZgbcjmX5qHd/S97rHztDCcedkOm+1cl0k=;
        b=e3VL5Ud84GLI+E2x3bA8ztpqvuFMv57yd9aYEVQJXCzdGLPTTmXpQqv3Opq72bJmux
         KBHMo3MVO1HOzdmTO8H+pcTCfVPqaiTDnPTpbQzl0qQR7IL44jHkwS4bzBufrjeR8qhe
         DDLiaWivcex7UxcVlthWRdgNLBWzi+M8qTeDx57baSkDWFH1agIYPgvRPadbYLCLtjZu
         06qTHbdte5aRDCOnGRwQe0feCJbqguEWevqetTaa5WoZI91EWlvvh0bLcBUS4nMqHsf9
         D1KWrNcsh7YIcTiYbXUJhkPijHa5aKTMIfa20aY8luGYazLflzR5ecy/UydbOSAfiQM/
         3TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728340526; x=1728945326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gesjil9Y0RZgbcjmX5qHd/S97rHztDCcedkOm+1cl0k=;
        b=Lo32Jex0ZJCHgxooD3f5yqCNqUTpHwL5DpZgWQP9H4qC+mk7KpfACKUWMYgUHorhzC
         QgZ9/XdRn7Lzn+4TRTweYgMUMep0YDmOgUYpkpn5wujzAi6vI+euIyMjNuBYAHsyrOvc
         urGqLuv/a6qhcKAs9clqp8cYIeHfnaawQ6xCGh4fbuT3S7SZ3byIQkoD0bYwYiy1wPh+
         Ma6mKALsonY7YnO6S5RMauF8RS4t6Ivj9YNERegSWsK9oqU1luiFM5RV4XKy5e8uW/CJ
         DdSLgphdUURiDH5lgG16/VOiwpMjj07BYnJbLWq1wexI6fK1tZGOU55i3CMqs4ealdiU
         H7oA==
X-Forwarded-Encrypted: i=1; AJvYcCU5s0w9n/lyt9Ay9PyQtTsQpgm1ChnsxqO1Oqln5SY8X48HsvFptaggA4fgYoIWESaEFAvVnkLRWkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHJsi3QQG4DAfY1YyomwUb0Ks7HSxnB3gmZugyqm5qkLU4MM/4
	+s58n1IsG1chbTfADNbUpxyan4ASYRBuRidD+7vBhhc35zo84Q1duJfbJ3kQciLan7876d4P5r1
	ORVITuPiAnTgLPPg0VlXS7qmSupP+YgE+Plw8Pw==
X-Google-Smtp-Source: AGHT+IGYLLRVc3CeXKReIUVnntYlZ+ULRb29gPUl3UTx4hoqAUGdx6q2aFDzdnacRWqcM/cOYseo4GoEdp7e3a8qLZE=
X-Received: by 2002:a05:6902:2305:b0:e28:6ec7:4353 with SMTP id
 3f1490d57ef6-e2893964043mr10612649276.54.1728340526338; Mon, 07 Oct 2024
 15:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
 <CAPDyKFp0N6UJhnHS164Tdf=xkWB0jzq65L9TdvYazeBQ-6WjeQ@mail.gmail.com>
 <20241007184924.GH14766@pendragon.ideasonboard.com> <CAPDyKFpQVnF7eQv3dup8k-3EijnMjuveCG9sZ=Rpey1Y6MBJEg@mail.gmail.com>
 <20241007222502.GG30699@pendragon.ideasonboard.com>
In-Reply-To: <20241007222502.GG30699@pendragon.ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 00:34:49 +0200
Message-ID: <CAPDyKFrGNwna6Y2pqSRaBbRYHKRaD2ayqQHLtoqLPOu9Et7qTg@mail.gmail.com>
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

On Tue, 8 Oct 2024 at 00:25, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ulf,
>
> On Tue, Oct 08, 2024 at 12:08:24AM +0200, Ulf Hansson wrote:
> > On Mon, 7 Oct 2024 at 20:49, Laurent Pinchart wrote:
> > > On Fri, Oct 04, 2024 at 04:38:36PM +0200, Ulf Hansson wrote:
> > > > On Fri, 4 Oct 2024 at 11:41, Sakari Ailus wrote:
> > > > >
> > > > > Hello everyone,
> > > > >
> > > > > This set will switch the users of pm_runtime_put_autosuspend() to
> > > > > __pm_runtime_put_autosuspend() while the former will soon be re-purposed
> > > > > to include a call to pm_runtime_mark_last_busy(). The two are almost
> > > > > always used together, apart from bugs which are likely common. Going
> > > > > forward, most new users should be using pm_runtime_put_autosuspend().
> > > > >
> > > > > Once this conversion is done and pm_runtime_put_autosuspend() re-purposed,
> > > > > I'll post another set to merge the calls to __pm_runtime_put_autosuspend()
> > > > > and pm_runtime_mark_last_busy().
> > > >
> > > > That sounds like it could cause a lot of churns.
> > > >
> > > > Why not add a new helper function that does the
> > > > pm_runtime_put_autosuspend() and the pm_runtime_mark_last_busy()
> > > > things? Then we can start moving users over to this new interface,
> > > > rather than having this intermediate step?
> > >
> > > I think the API would be nicer if we used the shortest and simplest
> > > function names for the most common use cases. Following
> > > pm_runtime_put_autosuspend() with pm_runtime_mark_last_busy() is that
> > > most common use case. That's why I like Sakari's approach of repurposing
> > > pm_runtime_put_autosuspend(), and introducing
> > > __pm_runtime_put_autosuspend() for the odd cases where
> > > pm_runtime_mark_last_busy() shouldn't be called.
> >
> > Okay, so the reason for this approach is because we couldn't find a
> > short and descriptive name that could be used in favor of
> > pm_runtime_put_autosuspend(). Let me throw some ideas at it and maybe
> > you like it - or not. :-)
>
> I like the idea at least :-)
>
> > I don't know what options you guys discussed, but to me the entire
> > "autosuspend"-suffix isn't really that necessary in my opinion. There
> > are more ways than calling pm_runtime_put_autosuspend() that triggers
> > us to use the RPM_AUTO flag for rpm_suspend(). For example, just
> > calling pm_runtime_put() has the similar effect.
>
> To be honest, I'm lost there. pm_runtime_put() calls
> __pm_runtime_idle(RPM_GET_PUT | RPM_ASYNC), while
> pm_runtime_put_autosuspend() calls __pm_runtime_suspend(RPM_GET_PUT |
> RPM_ASYNC | RPM_AUTO).

__pm_runtime_idle() ends up calling rpm_idle(), which may call
rpm_suspend() - if it succeeds to idle the device. In that case, it
tags on the RPM_AUTO flag in the call to rpm_suspend(). Quite similar
to what is happening when calling pm_runtime_put_autosuspend().

>
> >
> > Moreover, it's similar for pm_runtime_mark_last_busy(), it's called
> > during rpm_resume() too, for example. So why bother about having
> > "mark_last_busy" in the new name too.
> >
> > That said, my suggestion is simply "pm_runtime_put_suspend".
>
> Can we do even better, and make pm_runtime_put() to handle autosuspend
> automatically when autosuspend is enabled ?

As stated above, this is already the case.

>
> > If you don't like it, I will certainly not object to your current
> > approach, even if I think it leads to unnecessary churns.
> >
> > [...]
> >
> > Kind regards
> > Uffe
>
> --
> Regards,
>
> Laurent Pinchart

Kind regards
Uffe
