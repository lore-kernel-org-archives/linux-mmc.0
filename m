Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6991BFE1A
	for <linux-mmc@vger.kernel.org>; Thu, 10 Oct 2024 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559353; cv=none; b=eTPZoNCPWMTNttfaY4EeBgitEE5s1rP0NJz45Xx/PH4rfMTLi6H8drbcE1QbHkewc9t4jAsQ/RpyuFVn5p/YIRTEtQkzuG7uk8aVCrr9rythJ+QUQen+2Ztdi7391svJpA9wkcjqAbBvkOi67zm0CGaVQzqHNOVEycmnPT5ks0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559353; c=relaxed/simple;
	bh=Y+Hc+ZWBOz2/aG+Bofr74fDrP5zo529TaNwbqre/62k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kjfn8dksryhPvfgSOQvDqicC31sACljSTq8yIoMpNsTY02aIXzbE3u5zQocnQEyhJUerqTp0V19+/T1JZtj5MufBfIe7QlZVNWj0Uvvm87B21LcyXUfwO7Pc2pFN58I4k6+r1WfCY0ZsoVE0wkvbhjbbTjc4EwbjXrlk21+WqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ajISk5eU; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajISk5eU"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e29072f194aso696309276.3
        for <linux-mmc@vger.kernel.org>; Thu, 10 Oct 2024 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728559350; x=1729164150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nLx+rERdJDl4IU0VN9dgmu8DY3d7fHIrreLdsnM/QYI=;
        b=ajISk5eU+bHg2ovM0ND/Vjv0IMgJFnfP4zs+GxjwbscIpQDF6H7U9zj4R6y3yLoZaL
         zUQYTnuj6wc3iJOvmmiyxwN8JSwD7EPAi7CRvsrfGP3aV0SjsN9zgCVNfR/skT9/jnVP
         Jccg0mN6YfjZidSq9M+2ipLwr9GVBAhwX3an12o2vdgSGV4YjSV7kkcmxNmr0m/faRV7
         oJ61456gZmriKLY1T78VBW7Da0c9GU1QgSyY6M/ZsSrl4s5JGIbY4lzQHFrVOzFNdTUm
         8SLtv9VXto1SHpkhKFhANd50lD3cZ63+8L7E2Wh5E6tA3d3YXt04U/gdg0faT2lOC49a
         jn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728559350; x=1729164150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLx+rERdJDl4IU0VN9dgmu8DY3d7fHIrreLdsnM/QYI=;
        b=C74HkZb/eheSu/ijibbMKL/jCTqfDI4gPu7SWG0x1V7CxHcWZMvR51Z3XPdzFr6C6e
         1Vvke8MVbeLHoN7s0wt2QYffeyfpaMXIu+BEtIef4H2uZFAyVbX44lrGsID3TUZEESfU
         /pn0gilQhcQQP0GRynW9ZWGE+X3eFDmBufh0vf68ISb133rrxVzNoUv9AMREFV45yo3h
         m597r55f2McmPbgWglu2D93ov36H6VvzSTTEMIl39eelmz6zC9KL+Ucl6NPeX/Ww15ah
         aLfHEI9cQ4rvYWYGgQOb5vgRnbr/WCjK7Ezy0hIklyVIWMf9KIaD7ydr9YCNrjF1TiLu
         wYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGitAj+h+B8v+db5LeX6NAVVUzXmjtQQ+WewtFmsymrnZdbz/vHK/fioXj0z5uKQ2vtsvGNUp1vN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu/wODZ/ZjFJP4RLyiLkaLJphIsyf0JbrXS8SKXtyt9G9xaPM7
	ecchRVk/ZmmCKU4/ymQVdCaRlGlnvPU4lr7/ghjOGPQZ03YFWOagaoknmi4/9dNuXXuZAf5pEAe
	h8j/H7syQz2JGPcaCdeXC6RNxk0Yq/QCaB+UxVQ==
X-Google-Smtp-Source: AGHT+IEn9AYzbWx83wuvr4kMycaOrv54Vxz9NQ0aUIHG5PldBfbqBk8c1R1lTibs7vN5ovyALWCZcyq0+AHYnMkCmtE=
X-Received: by 2002:a05:6902:722:b0:e28:f696:f611 with SMTP id
 3f1490d57ef6-e28fe4338bbmr6548879276.4.1728559350534; Thu, 10 Oct 2024
 04:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913102836.6144-1-victorshihgli@gmail.com>
 <20240913102836.6144-8-victorshihgli@gmail.com> <CAPDyKFrbVY3OGmCn0wx8yv2n61ALAa54-vkUVqU8+bLo_=y=6w@mail.gmail.com>
 <CAK00qKDC6yciJS9JEjGjmqwEe4FRYGmppkYyFG72b3SFxzu1Zg@mail.gmail.com>
In-Reply-To: <CAK00qKDC6yciJS9JEjGjmqwEe4FRYGmppkYyFG72b3SFxzu1Zg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 10 Oct 2024 13:21:54 +0200
Message-ID: <CAPDyKFp8jCf9dq2WyC_4ss4KvQXx6TFv9f-6fkQFQDjKHnA55Q@mail.gmail.com>
Subject: Re: [PATCH V22 07/22] mmc: core: Support UHS-II card control and access
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Jason Lai <jason.lai@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

[...]

> > > +
> > > +       /*
> > > +        * NOTE:
> > > +        * Should we read Externsion Register to check power notification feature here?
> > > +        */
> >
> > Yes, this is needed too.
> >
>
> Hi, Ulf
>
> We have the call sd_can_poweroff_notify() in the _mmc_sd_suspend() and
> _sd_uhs2_suspend.
> If we need to check the power notification feature here,
> do you have any suggestions for the type of power notification that
> needs to be confirmed?

Right, I see what you mean! It's been a while since I read these parts
of the SD spec, apologize for my ignorance.

In UHS-II mode, the power-off-notification is *not* supported. This
means that we should not use it from _sd_uhs2_suspend().

In UHS-II mode we should instead use the so-called "hibernate" mode
(hbr bit in the GO_DORMANT command), which allows us to turn off
clocks and VDD1 (corresponds to the vmmc regulator). Note that the
support for hibernate mode is optional for an UHS-II SD card. Thus,
the support must be checked via the corresponding field in the PHY
capabilities, before we try to use it.

That said, to not make it more complicated for you to get the basic
UHS-II support landed upstream, I am fine if you decide to defer the
support for hibernate mode to later. Instead, it seems like we should
just do a regular power-off in _sd_uhs2_suspend(). In other words,
just call sd_uhs2_power_off() from there.

Moreover, reading the SD Extension Registers would still be valuable
during the UHS-II card initialization (even if hibernate isn't
supported), as it allows us to support the "cache maintenance"
feature, for example. However, the support for these features are
optional too for SD cards, so I am fine if you decide to defer this to
a later improvement too.

Does this make sense to you?

[...]

Kind regards
Uffe
