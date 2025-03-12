Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E4243956
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780591; cv=none; b=o3FD2lOwEwr3EAPuYKbr4AmaNKQz9QUKnfqfAOQda5o3iI3207ShuocMMub6jsPewl10fV2dv9+eSsqd71FdVR8xCOejQz9eEx/h5x61ZcDj0x8D5asO3Ne+HvogRqdUPbGKi6Wzw8/0O0FCq/Y5RT5zTp/YAcrRYX9uR1NX9Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780591; c=relaxed/simple;
	bh=8gw1vVwPGuY8kyjufKSWPJXTHl93QcoZA59F0+eLung=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e19Oxj2a88ZiPZ6Nv9/yFf1f82lj7VXu632iwMHsXMteVAeZqKg6GYnPQEFxTu5ZSldhpD4gYkEWCjRSlvqYMAThBRSxS4NGNF7zw3XSnrUJsvhWjj19N9oMmj7g8z3J4kVZ70BurC+9mUkMUR3Qs5Saq+yAjZ5FHCeA7y7Haec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kjz2KWnh; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kjz2KWnh"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6febbd3b75cso54258327b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741780588; x=1742385388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gw1vVwPGuY8kyjufKSWPJXTHl93QcoZA59F0+eLung=;
        b=kjz2KWnh9hOOYNxSjocVbJTXRnAgYr1L1Y8LMAxlleoxKsNrSuHko19dtjsa/Yk1aS
         yC41QPZ/n38Wzv5zekpIqHFPjSZ7V7mi3rxn2N2+hucRJThp1hSxtnvn2Onj9JXg4DLa
         uXzQAgBkveouqawo9rvX/2+apIv4JmNKsx/DuWP2SNzWYki+oaxhye5NM3KyzVafNC9c
         l6csjYQU7SAOdsM1bJwExRtxuGybhguWMpvTlIAhHH92RCSCk8E2V5kheU5N5NF5KufS
         JmwVxQo59iH+fv138wJ43ORvyNNFHfNw9xBKrNA0zr7RrodKMnKXAl2ig7+yFvuBZThL
         6U+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741780588; x=1742385388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gw1vVwPGuY8kyjufKSWPJXTHl93QcoZA59F0+eLung=;
        b=VVFomfkkABGgvJmrUGaK9l/Cy1rjWm0zdeG3Yn0eF24z+ea66HZUmm6HtKs197wuNH
         F8W0I+c1Q9ztpm6PZgSQR8rUjWvHaopN9HpMo+6Pcy7UZdY3+WMUd2bqQQi2+DEUd4hd
         F8lm6/+TrWQKOibs0IOWwHGNx113t9AE8h4d1CMU8mqgK3bz4sOo5qtziQmx72Wuk/Kn
         O7uw6RfdqH9zsnWxeN/hUMEBV4FpLNrhV2abnOs+ZD1qx0gXlGChOgqjWW4eY3RSaqS5
         W+VyEg+082GlvQ0hRc8oRPXF19LotNgeGIgHlq0AyGsA4m9CRU4n3FBiNqQ8MTLj0Fv+
         6PcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUur+Tj89feRM9h4nirdOEGS2ps19YKzo4b3CkXyUWdVT4NKxKfZBfQtwhcRAz2GblOoDkla8xkoQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/V/aUgolpzZX58rE9xtvLXiBg1QyOHknWdeF8s865be5VYk5T
	hLXFqwGp7HYVNSiYTbPtiNO150CJfriAXs39wx74FTx4jZrP+le1gFHFGDHdlB8QMciERFkrqCL
	dNBZHQl79U4aWud7RZr4z699yUe3/D41cVaWUJw==
X-Gm-Gg: ASbGnct5AQsM96InhDpJwrKltcwoVWJiqtQh8qoa2ZEWx1anIlB0TkbXHPz+8VHdkeL
	9nVRZ2VYPiDhtikeKYlwuUDnSV+idPgw4JxbRBU9FZCCK0MdBJOMoUIX7DWJ9+7NIVDO4XDYMge
	reJyd0Ix7IZuXyIIfYypXdu0dYbE4=
X-Google-Smtp-Source: AGHT+IFhdtyASgBjgSeabbB5ub+Jpk4OA6+GGQx9A5TlYg1fa0XNR7Fe1HMS4YVD0oiQlbV+dppYmT4Lb1S0zAt1nyQ=
X-Received: by 2002:a05:690c:4441:b0:6fd:4718:9bde with SMTP id
 00721157ae682-6febf2d84c2mr262093277b3.9.1741780588293; Wed, 12 Mar 2025
 04:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1c5f72c4-3d55-4d62-b690-8c68b76a15d2@gmail.com>
 <f6732c49-a5b1-4a13-b9f6-c2d552b5e7e8@smile.fr> <31717d89-432c-4b77-a974-99f7e6b97f97@gmail.com>
 <9168d127-06a7-46e6-a7a2-f2e60032a50e@gmail.com> <b1a369e2-938b-49ed-b743-6562f0bb46f9@smile.fr>
 <CAOCHtYiBFNY9nFjtqsFFpqRKdxUif_fC7MVqZ7cffeD8rLSe2A@mail.gmail.com>
 <CAOCHtYiujoMoPHfSmyTrv_48wUn3TfaoiPEcMFB=V++MZXvuuQ@mail.gmail.com>
 <20250226170614.18a497f0@akair> <20250307042822.GE23206@atomide.com>
In-Reply-To: <20250307042822.GE23206@atomide.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:55:52 +0100
X-Gm-Features: AQ5f1JopWLOeYGYCz_4MrDz2D-Dvj3jAOEGRd0VjfRR07Fg7DNOJPsGHxfVHElc
Message-ID: <CAPDyKFo-ODVL0JUmeZj5-PgcYwT8Gab6-US9LNSOUGwn_-prPQ@mail.gmail.com>
Subject: Re: sdhci-omap: additional PM issue since 5.16
To: Robert Nelson <robertcnelson@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Romain Naour <romain.naour@smile.fr>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Jason Kridner <jkridner@beagleboard.org>, 
	"Aldea, Andrei" <a-aldea@ti.com>, David <daowens01@gmail.com>, linux-omap@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Mar 2025 at 05:28, Tony Lindgren <tony@atomide.com> wrote:
>
> * Andreas Kemnade <andreas@kemnade.info> [250226 16:06]:
> > Am Wed, 26 Feb 2025 09:36:40 -0600
> > schrieb Robert Nelson <robertcnelson@gmail.com>:
> >
> > > On Mon, Jan 27, 2025 at 3:20=E2=80=AFPM Robert Nelson <robertcnelson@=
gmail.com> wrote:
> > > >
> > > > > Thanks for testing.
> > > > >
> > > > > I'm able to reproduce the issue locally (using a kernel 6.1.112).
> > > > > It fail after the first sleep 20...
> > > > >
> > > > > If I remove MMC_CAP_AGGRESSIVE_PM from the sdhci-omap driver the =
issue is gone.
> > > > >
> > > > > About sdhci-omap driver, It's one of the only few enabling
> > > > > MMC_CAP_AGGRESSIVE_PM. I recently switched to a new project using=
 a newer SoC
> > > > > but the eMMC driver doesn't event set MMC_CAP_AGGRESSIVE_PM.
> > > > >
> > > > > I'm wondering if MMC_CAP_AGGRESSIVE_PM is really safe (or compati=
ble) for
> > > > > HS200/HS400 eMMC speed. Indeed, MMC_CAP_AGGRESSIVE_PM has been ad=
ded to
> > > > > sdhci-omap driver to support SDIO WLAN device PM [1].
> > > > >
> > > > > I've found another similar report on the Beaglebone-black (AM335x=
 SoC) [2].
> > > > >
> > > > > It seems the MMC_CAP_AGGRESSIVE_PM feature should only be enabled=
 to SDIO cards.
> > > >
> > > > We've been chasing this Bug in BeagleLand for a while. Had Kingston
> > > > run it thru their hardware debuggers.. On the BBB, once the eMMC is
> > > > suspended during idle, the proper 'wakeup' cmd is NOT sent over,
> > > > instead it forces a full reset. Eventually this kills the eMMC. Bee=
n
> > > > playing with this same revert for a day or so, with my personal set=
up,
> > > > it takes 3-4 Weeks (at idle every day) for it to finally die.. So i
> > > > won't be able to verify this 'really' fixes it till next month..
> > >
> > > Okay, it survived 4 weeks.. We really need to revert:
> > > 3edf588e7fe00e90d1dc7fb9e599861b2c2cf442
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D3edf588e7fe00e90d1dc7fb9e599861b2c2cf442
> > >
> > > On every stable kernel back to v6.1.x, this commit is `killing`
> > > Kingston eMMC's on BeagleBone Black's in under 21 days.
> > >
> > > By reverting the commit, I finally have a board that's survived the 3
> > > week timeline, (and a week more) with no issues.
> > >
> > Is there any simple way to restrain it to only sdio devices to go
> > forward a bit?
>
> Best to revert the patch first until the issue has been fixed.
>
> Based on the symptoms, it sounds like there might be a missing flush of
> a posted write in the PM runtime suspend/resume path. This could cause
> something in the sequence happen in the wrong order for some of the
> related surrounding resources like power, clocks or interrupts.

SDIO is entirely different in this regard compared to eMMC/SD. So if
there are no reports of issues I suggest we keep the SDIO part.

Let me help out and cook a patch for this. I send it out in a few minutes.

>
> Regards,
>
> Tony

Kind regards
Uffe
