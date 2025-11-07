Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE12F659F
	for <linux-mmc@vger.kernel.org>; Fri,  7 Nov 2025 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762550883; cv=none; b=Da9N6cNiSEAxb+OnOEoCdSsyDgq+J9Qg/aaHvHpEe+aArL6C4vi+KUogH3Gnl+44VBXwQKV4vwLI8agQVh2hSHaN7m9s/l/EiEXFJqgZR1IYyBiDsof1dbCPdz9o8jra0/VTusP+C9INogKKbA35iQGbLx0TzXVsRQXefuIyk3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762550883; c=relaxed/simple;
	bh=9S2bq/29roXXQP213//MJ4po97yVAGdfarXhQ7EpMmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4ShyiqHIKq8UxK8/neYCVHzEzUyXdpVBqlpJxRbCQZemJOKDHSKZC+TlQVBmzvBxcg91gd+AFGC1QAa/FbivAZUeYFP4wUwUwvSS7F/5Dws9aOGLvDauZBQqSXCrLhPsozyyBly0ejvQ9PP73sIZneJCN9OD5waNqrsVKY4k1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neKlGQ6F; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neKlGQ6F"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3d18422565eso828717fac.1
        for <linux-mmc@vger.kernel.org>; Fri, 07 Nov 2025 13:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762550877; x=1763155677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wf0Wo+91E34RuPLbAsDoo2IK5iEZKHYvFy5egqLCygs=;
        b=neKlGQ6FLQLmvriZqx9Jx0EhTPSqKF938tjpj/gJjjFpdgKNi0078wJBZHwXzm6kk4
         hRYwUFQbG5FffFvN6Oo1Tq4MJASUIvB0HMkwvG1Z7WQ6IFp6aECMBbsDLeVWtaRJ9T9s
         fiQWgEmXliIQ4hgl2ZHu0W5sLMaNzvVeNWCV+9F/GQUT3OnmNK34Nyyt2MBP3eDFPK+y
         R829aUGATkypdHG/N4rAuzBdv4x0bMi2rgCSX/GvsaCdDXWGcE/PVJKUkUOMdOBIzIhY
         dBhnGWb8py9xHWylxSeW6u2hkYlqofK3F4EfqdpvtQ8WnvY09sKiCNImYywUHyKccwcA
         Cyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762550877; x=1763155677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wf0Wo+91E34RuPLbAsDoo2IK5iEZKHYvFy5egqLCygs=;
        b=aMDO39msw+DL6QpHaKINpwy/HL+qg4/zpVRaMwggU0t6MVT+leCNglK9VU9YMeksxF
         RHOUN7dMFUoCe6z7wtcE8z8rpD6hN/KdecjlGn3zuTF+VkD3PO5h6kI42uKVGdB7YTo/
         foOhh198fmq5RXRGkm4kNblJEmwBjeb47EzYlNa/Roo0Wv53Bde621/t+DQlYe0G3RSk
         mImoPFGBiSYOUAn0Lq3w0BFAEM4kiIUQditjxPINbtrghMuo+Q/hy+ZOdN3X6jAO1Mas
         C0QySOfqWI9R+6+MgkHXBSCYrY4BdpDtg6S4hwMBw6H0Ip5dWcR2PGABRPn+Kx/PXrMY
         Efeg==
X-Gm-Message-State: AOJu0Yz3wSdbL4SnZsbUgqR/u2jgoZlkp/JCMKic5n2YIFbGchIedPjY
	H3wJByh5F9mGuYU7BYr8wBOSOvtdeCc0G/9vuw5RRuiZYZQF0wyVNh455YjwDW2/AyK6ZPTcc2G
	J4F83TPklIdcDfDEZu3Vqu5wjqQ+Dc4o=
X-Gm-Gg: ASbGncvNnUqg6QqS52HZvgFHuUz4LYemnFkXM+d/EGjisK6YFUDIcDjngnilu1yuW/9
	o9JYBQUV/bJ7zBYmFvzBpKdL+7Ah2CPQ5e6VTdSK+Shaz5QtceaIi34X79vNGBuOqJsiDTULvUS
	U5fARPkUrEuaydsW6S5LLrF/YLGE4IqJlpPoGsjCURwySz12DyncYgW1HCW7ZO6QoFMnC1WfUhM
	Wzgq1i2KpR+z1H7+na2prPxoMaBo7xB8eG9/dng4tVylJ7yMpum2FCk2kQ=
X-Google-Smtp-Source: AGHT+IHyjZJeLsLteZuuZDK+5pBLZtEMRVKkcYVgU5gHfp+/kZ//VWjNj97aJLqnqpePBkyQzoaVsEierxISe5Kjt1o=
X-Received: by 2002:a05:6870:1713:b0:3e2:f463:d783 with SMTP id
 586e51a60fabf-3e7c289eb74mr593490fac.31.1762550876999; Fri, 07 Nov 2025
 13:27:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGw3uGD=jqdppGzQ9k8K6qu1znpWMrgMdcxYvtEXWi2Qwn01uw@mail.gmail.com>
 <dd3be1f2-02fd-40ef-8f52-ff5dbea3da90@intel.com>
In-Reply-To: <dd3be1f2-02fd-40ef-8f52-ff5dbea3da90@intel.com>
From: Steffen Pervold <spersvold@gmail.com>
Date: Fri, 7 Nov 2025 22:27:46 +0100
X-Gm-Features: AWmQ_blj2FZ08inPfHeu6XpyPbpNvrEra-S1kQUREU96ncWaFwZRc8p7hIlV-8Q
Message-ID: <CAGw3uGBwz3dwuxpmgUHpwk0OD6-mhiJeYQU20N3hmkOwVC_XUw@mail.gmail.com>
Subject: Re: SDHCI generic controller in Linux
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:59=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> On 07/11/2025 19:54, Steffen Pervold wrote:
> > Hi Adrian,
> >
> > I hope this email finds you well.
> >
> > Recently I have developed a SDHCI compliant host controller in System V=
erilog (for a hobby project), but I could not find any existing drivers in =
the Linux kernel (as per 6.18) that is using just the standard functions as=
 provided by sdhci.c. All the existing ones have either some vendor specifi=
c quirks or function handlers (specific to a SoC platform for example).
> >
> > So I made a "generic" SDHCI driver that should work for any SDHCI compl=
iant controller that doesn't need any special quirks or handling (other tha=
n what you can override in the device tree attributes).
> >
> > Before I post the patch to the kernel community I thought I'd ask you a=
s I see you're listed as the maintainer of the SDHCI subsystem.
> >
> > I've attached the patch for your convenience.
> >
> > Any feedback is highly appreciated.
>
> First, it is preferred to keep the development process in public.  In oth=
er words, cc the appropriate mailing list with this kind of question. For S=
DHCI it is linux-mmc@vger.kernel.org , see the archive at https://lore.kern=
el.org/linux-mmc/
>
> If you reply to this, I would prefer you cc linux-mmc@vger.kernel.org

My apologies, Cc added.

>
> Secondly, it sounds like you would be the only user of the driver.  You w=
ould need to make a case for why it needs to be in the mainline kernel.  Ev=
en Linus Torvalds has said he has code that he doesn't submit to the kernel=
 because he doesn't think it would benefit anyone else.

Yes, this is true as far as I know (for now). However I was slightly
surprised that since SDHCI is a well defined standard specification
that there was no "generic" platform driver like there is for USB
OHCI/EHCI/XHCI/UHCI.

>
> Note you can post a patch as an RFC (Request for comment) that is better =
for getting feedback on whether it is a good idea.  Even if the patch is no=
t accepted, having the patch and the discussion on the mailing list may hel=
p others.  And of course others may have had a similar requirement to the o=
ne you have, and have solved it another way, so there are plenty of reasons=
 for using the mailing list.

I will do that. Thanks for the tip.

>
> And please be sure to have a look at Kernel documentation like:
>         Submitting patches
>                 https://docs.kernel.org/process/submitting-patches.html
>         Development Process
>                 https://docs.kernel.org/process/development-process.html
>

Yes, thanks!

Cheers,
Steffen
