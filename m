Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4507E3A5426;
	Fri,  8 May 2026 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280824; cv=none; b=XtBvAH72VbwxxMdGOB9WS5PLT0BIS9uslJnoH1/h/YZHrsd3/J8ygFyu2m4e2IjOF3/u5uFqC9Rt/5kc9Om3Ir18YQcQKjKkzG9AC/gevwm6SKP4sVcytk+oNiz314MJomK1jv8Ut8bgOZJdj1iKQmOEWKmHZ12HRjrlwO7e3zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280824; c=relaxed/simple;
	bh=Z5WQpb+zG4G33yJj25V1N+RhuvaxlLgROCG8p0ek70k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdbgFCHBT3BN/UAUXwnJSdh/70NCDkoEawp1tHd5gpg3hwRl0oWagTrALuA0q4tu87jKFxftZxsWNgZG6g2GIPvO9hW5gL6LOVeVdr9QkamfF+qeWzRAnoV479zeBRz9Zvx452f3Io0K9481yGDzodjNbn+z+LXVfzB69uX/pgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6rodGnX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6rodGnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74681C2BCB0;
	Fri,  8 May 2026 22:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280823;
	bh=Z5WQpb+zG4G33yJj25V1N+RhuvaxlLgROCG8p0ek70k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6rodGnXzFO5fLA2F6JvLhozKTvSQAgFt5h9gxycbIS81LrClQFRAwWBva2odBhlr
	 EUBj8Wj05n5iXvQl45xOziN5x8j5oSr0nHKbZOtq9i9R/5z1XH3HE4bbzAZFsDFPQa
	 oqDXZwOh7B0vh6KEXpIZhS1T1/J3WZ9hLasCugGnf4ZqFWbvI6BzP8Z8EzwadcFA/7
	 Xgl/xwGbzOzgow50cvBYxgqqqIirmEDCxBuYz7S/H1sNZx++cuCCY0mv1EULhhT3xh
	 lwH1P1hn4UqSKsfCbqcnpDWUHJOxzi8veIwidTZ5qppZX9so2PWQf9aoV6t4ORRONw
	 3Z6LDKIJ53AnA==
Date: Fri, 8 May 2026 22:53:41 +0000
From: Yixun Lan <dlan@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
	Troy Mitchell <troy.mitchell@linux.dev>
Cc: Margherita Milani <margherita.milani@amarulasolutions.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v8 8/9] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
Message-ID: <20260508225341-GKB3590877@kernel.org>
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
 <20260413-orangepi-sd-card-uhs-v8-8-c21c40ec16d0@gmail.com>
 <CA+Xcp4nY9GVMOmtMG-PNhY2vqP4Cc_amAMSa+M3vuDjWUkuCHw@mail.gmail.com>
 <CABdCQ=OsPva9=YPdBd=3HW1OO7=_zJtpXjvaiA0WLEDT5Scs_Q@mail.gmail.com>
 <DICDTHYTPDSP.210EBVHTQ6966@linux.dev>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DICDTHYTPDSP.210EBVHTQ6966@linux.dev>

Hi Iker, Troy,

On 18:45 Thu 07 May     , Troy Mitchell wrote:
> On Thu May 7, 2026 at 5:53 PM CST, Iker Pedrosa wrote:
> > Hi,
> >
> > El jue, 7 may 2026 a las 10:20, Margherita Milani
> > (<margherita.milani@amarulasolutions.com>) escribió:
> >>
> >> Good morning Iker,
> >>
> >> > Add complete SD card controller support with UHS high-speed modes.
> >> >
> >> > - Enable sdhci0 controller with 4-bit bus width
> >> > - Configure card detect GPIO with inversion
> >> > - Connect vmmc-supply to buck4 for 3.3V card power
> >> > - Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
> >> > - Add dual pinctrl states for voltage-dependent pin configuration
> >> > - Support UHS-I SDR25, SDR50, and SDR104 modes
> >>
> >>
> >> Tested-by: Margherita Milani <margherita.milani@amarulasolutions.com>
> >>
> >> However I noticed it only works when CONFIG_I2C_K1 is enabled.
> >> Michael Opdenacker told me it's necessary to enable the regulators
> >> used by the mmc controller.
> >> Should we add the dependency between CONFIG_MMC_SDHCI_OF_K1 and
> >> CONFIG_I2C_K1? (Unless some boards don't have these dependency?)
> >> Thank you for your patchset which was really nice!
> >
> > Thank you for catching this! You're absolutely right about the dependency.
> >
> > From what I can see, all current SpacemiT K1 boards follow this design
> > pattern where the SD card power is provided by an I2C-controlled PMIC.
> > However, before adding a hard dependency, I'd like to get input from
> > the community, does anyone know of K1-based boards that provide SD
> > card power through fixed regulators or other means that don't require
> > I2C?
I would object to add CONFIG_I2C_K1 as hard dependency, the reason is
that the spacemit sdhci driver (sdhci-of-k1.c) has no used i2c
api/function, it's just need I2C function via an indirect requirement,
which sdhci -> regulator(p1) -> i2c, besides, from the hardware design
perspective, it just happens that K1 use P1(via I2C) as PMIC, it's
totally possible(even in theory) to use other PMIC as power supply
control which may not be I2C interface (maybe use SPI, for example)

If we want to solve this more gracefully, I'm in favor to add explict
option enabled in defconfig..

> if K1 needs to switch between standard and high-speed (UHS) modes,
> I believe the I2C-controlled PMIC is mandatory to handle the voltage
> switching (typically 3.3V to 1.8V).
> 
> I don't think any board would want to be stuck in standard mode permanently.
> If high-speed mode is an option, why not use it? I think adding this
> dependency is a good idea, but keep in mind it also needs to depend on P1.
> 
No, as above
>                             - Troy
> 

-- 
Yixun Lan (dlan)
