Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C87FBAE
	for <linux-mmc@vger.kernel.org>; Fri, 26 Apr 2024 04:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714106962; cv=none; b=CtzlFngbfnLgTTVetSP6owF4PjdqBfSqIZJuYnOBBPE5+2ZoKf6ZUCpnyVYk3Uy09FHd9dmuvrWRs/+r7mn0WbeY0vQj5UodJxbpFtpZkZvt0pLAdcnHjJ0z9xM1ltiygA1ErsxjSnS3jDkf42S3J2zWlNS/m9PD7gUTszu/+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714106962; c=relaxed/simple;
	bh=PEOdBz3rBE61xA8RJj8Kneft4NENI8J9eiJTVPha+G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMBih9qjWWHfVbtve8hl6KELr2nb1VPTWWGilI8Cms0iJJFEygWYA6GHFst5icU0b1apRalo0pMusOAMfV+8HwpvUyM4cZAaMa9vLl+CzttB+Q9LxgUORajRJvNzBcqDqMN7a4+x8zfPSpfcDqqQPa0dfm7EvooKhzOBRJkuau8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ib1J2Mav; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ib1J2Mav"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de54b28c3b7so1964770276.1
        for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 21:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714106958; x=1714711758; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rY/c2hQHlJxJvnFu06tV7eDxiJDNiUEPqK+e33tme+8=;
        b=Ib1J2MavkZTM2xJCZdOSvsYusNPIYq8BvcQBEHkUPILsrVlS7CeQ/kDR8shflnvIKD
         9kW52iErtMX9u2xnPPphriR5ovHAGy2JOx23PacP0m2hU44Rcp7pHlXniQ4+dXqWYZ9M
         duOIOWtQo12Ej1P6UhQB8BZTad4BWEOcqgQ5Z9S+PWLDBq4wZ39mytxkwUB7eBWh7H2V
         FVATRFmmPvGrwZ5JiOvXVQBi++r7qnkyTt1Lkby7KoeAjo++8pNZuJbzwhZAL4QmCMGs
         +UIO2A8yT21HY7zsw97QSUbeFcyaMCIuF5rc5gWLESi7IWAizBsh5WPd2LETShMGrgX5
         FfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714106958; x=1714711758;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rY/c2hQHlJxJvnFu06tV7eDxiJDNiUEPqK+e33tme+8=;
        b=P8c7ZXM69/qVG9l+xch1+pz1g/aiLaw0UQ4dzuJTGqQ9rzqAxoZFFV3CGGaPmbeEb5
         InkHeisdteXG7egw+GRMDOCRY2ti7blCw7SVyLR94AMg9HIut1j0n+6ODM4XFRDBoFBK
         ARkjyMO6/LIqyQl8uOR9gXgXn18V4Apx3Vw9wKwj3Dky+9CAE4ZSeBywEBJbz/BPEUVO
         +ABnPeaASuFjNdF/ODGQy2Pcx4eXqsV7JcWiYs8F3q7ibtBNdbon8SJGzkL32m9JfXj6
         SK3Ai5CFDNM0coRAcjOJ7FCwr6SMnbwHPoFYPSuAYaBd2S/EQn6sLRaeHgVFnEC+1jDW
         LrJA==
X-Forwarded-Encrypted: i=1; AJvYcCVN+YSrp+kerdrHQFkJsM4NofjGiH9Yl8OrUQx3aVd4rDdq8HXcKE3xbYv3tMkIHJQoUT6oAJqQJhpcpUN56X+oRVkHYJrrS3h5
X-Gm-Message-State: AOJu0Yz0BCiNTcTrIpMVnS8rIU2Iiq2RVftQIEDjMgzr2afQ808JR8S8
	/MDsgwz5wpnvawQ4tZYkXbmE3Lfs/nBfurzzVZq0aT0KjGmfYOrljyBBnYFKSLbpawdye2mxqdF
	nIa+90zp9gHnZI1yjFIm73ZOfUcYud15OAyx6pUWh5avYh9Q5
X-Google-Smtp-Source: AGHT+IErT/fsXCbVqJ3OYw/9ydZQgVYROe+aIo2oX/8+uLnr9Z6fUkYr+folnvOO05V+FbI1cfo1lioyrXB+7rMEuSA=
X-Received: by 2002:a25:6885:0:b0:de5:5089:32b8 with SMTP id
 d127-20020a256885000000b00de5508932b8mr1539250ybc.63.1714106958646; Thu, 25
 Apr 2024 21:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410191639.526324-1-hdegoede@redhat.com> <CAPDyKFrkPm=JEaiwTcVdqtG0hePEu-D76ec89nzFiF2MxYOwgw@mail.gmail.com>
 <5ff49965-1e8b-409c-8110-1782143c908c@redhat.com>
In-Reply-To: <5ff49965-1e8b-409c-8110-1782143c908c@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 26 Apr 2024 06:48:41 +0200
Message-ID: <CAPDyKFrzcoWYXoe83RvnroEKG6+a6O0+gPoaYz8QV3SLb4wZ_A@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] mmc: sdhci-acpi: Add some DMI quirks to fix
 various issues on Bay Trail devices
To: Hans de Goede <hdegoede@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, linux-mmc@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 19:26, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 4/25/24 6:21 PM, Ulf Hansson wrote:
> > On Wed, 10 Apr 2024 at 21:16, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi All,
> >>
> >> Here is v3 of my series adding DMI quirks to fix various issues on Intel
> >> Bay Trail tablets.
> >>
> >> Changes in v3:
> >> - Replace "mmc: sdhci-acpi: Disable UHS/1.8V modes on Lenovo Yoga
> >>   Tablet 2 series sdcard slot" with a new patch from Adrian which
> >>   actually fixes these modes:
> >>   "[PATCH v3 2/6] mmc: sdhci: Add support for "Tuning Error" interrupts"
> >>
> >>   Note this is missing a Signed-off-by from Adrian since this started out
> >>   as a quick test patch from Adrian.
> >>   Adrian, can you provide your S-o-b for this patch?
> >>
> >> Changes in v2:
> >> - Address a few small remarks from Andy and adds Andy's Reviewed-by
> >>   to the patches
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >> Adrian Hunter (1):
> >>   mmc: sdhci: Add support for "Tuning Error" interrupts
> >>
> >> Hans de Goede (5):
> >>   mmc: core: Add mmc_gpiod_set_cd_config() function
> >>   mmc: sdhci-acpi: Sort DMI quirks alphabetically
> >>   mmc: sdhci-acpi: Fix Lenovo Yoga Tablet 2 Pro 1380 sdcard slot not
> >>     working
> >>   mmc: sdhci-acpi: Disable write protect detection on Toshiba WT10-A
> >>   mmc: sdhci-acpi: Add quirk to enable pull-up on the card-detect GPIO
> >>     on Asus T100TA
> >>
> >>  drivers/mmc/core/slot-gpio.c  | 20 ++++++++++++
> >>  drivers/mmc/host/sdhci-acpi.c | 61 +++++++++++++++++++++++++++++++----
> >>  drivers/mmc/host/sdhci.c      | 10 ++++--
> >>  drivers/mmc/host/sdhci.h      |  3 +-
> >>  include/linux/mmc/slot-gpio.h |  1 +
> >>  5 files changed, 86 insertions(+), 9 deletions(-)
> >>
> >
> > The series applied for next, thanks!
> >
> > I assume some/all these patches may deserve to get backported to
> > stable kernels, but it looks like that may be better for you to manage
> > by yourself!?
>
> From my pov the entire series is suitable for stable, so if you can mark
> them all for stable that would be great.

Alright, done!

Kind regards
Uffe
