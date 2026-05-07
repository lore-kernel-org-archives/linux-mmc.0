Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C33264C2
	for <linux-mmc@vger.kernel.org>; Thu,  7 May 2026 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150756; cv=none; b=Au/VRKypATSpc1rDVcXm2VSbyISAbuB53pEvw4cnuFyadQ90wD/AyTKFq6Y1tmiOp7/AMO+mwR2K2c1tcAvPl069vRzKJ93Gyx2kcuki0mAb49xG0EqbfW5fGJQUf43vtRdBcMBZT2UA3R2OvRooQIq92XF+Dre8+dvhsQO0FE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150756; c=relaxed/simple;
	bh=312zN6LsAnZx88D9I1aFkKivaozIPa5muYYM2DQoykI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=T/GocanPsl+L5kMyHTxoNfAHyLyR1e/U+o4kR0rWbzCkVKprtrohHOFw4phyWF5X/yEciV86opaTpcUp0Vj5W1Q/luOGN7Gcrpf7WVLff9+etF6bapaXIoWtBfeAbqdb1E90Jy+bi26R/aLMfE8GXYdjcGe2BSxxhkBZKz+4sAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qPQvdZZ9; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qPQvdZZ9"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778150742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfLuyOPRCmmDdUHD7nj8FmD30fIBLkwBsUJFvuCmkBQ=;
	b=qPQvdZZ9NGUW5GSrDqiO42DiH/zl3tkl6A1e9fYYs1UYUXWFnjsHBfbC/scvJ2rOxMtX6M
	OU0bhSlvZDm6kNsbvILN5h9ybLDylI6fzaRmXJZBq2/GhPeAxFGOv+TbyRXdS5hXW6KeXn
	4b3UWDEyiFf1sYzQuWFt5cXI513OGmw=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 May 2026 18:45:07 +0800
Message-Id: <DICDTHYTPDSP.210EBVHTQ6966@linux.dev>
Subject: Re: [PATCH v8 8/9] riscv: dts: spacemit: k1-bananapi-f3: add SD
 card support with UHS modes
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Troy Mitchell" <troy.mitchell@linux.dev>
To: "Iker Pedrosa" <ikerpedrosam@gmail.com>, "Margherita Milani"
 <margherita.milani@amarulasolutions.com>
Cc: "Ulf Hansson" <ulf.hansson@linaro.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Adrian Hunter" <adrian.hunter@intel.com>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Yixun Lan"
 <dlan@kernel.org>, "Troy Mitchell" <troy.mitchell@linux.dev>, "Michael
 Opdenacker" <michael.opdenacker@rootcommit.com>, "Javier Martinez Canillas"
 <javierm@redhat.com>, <linux-mmc@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Anand Moon"
 <linux.amoon@gmail.com>
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
 <20260413-orangepi-sd-card-uhs-v8-8-c21c40ec16d0@gmail.com>
 <CA+Xcp4nY9GVMOmtMG-PNhY2vqP4Cc_amAMSa+M3vuDjWUkuCHw@mail.gmail.com>
 <CABdCQ=OsPva9=YPdBd=3HW1OO7=_zJtpXjvaiA0WLEDT5Scs_Q@mail.gmail.com>
In-Reply-To: <CABdCQ=OsPva9=YPdBd=3HW1OO7=_zJtpXjvaiA0WLEDT5Scs_Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu May 7, 2026 at 5:53 PM CST, Iker Pedrosa wrote:
> Hi,
>
> El jue, 7 may 2026 a las 10:20, Margherita Milani
> (<margherita.milani@amarulasolutions.com>) escribi=C3=B3:
>>
>> Good morning Iker,
>>
>> > Add complete SD card controller support with UHS high-speed modes.
>> >
>> > - Enable sdhci0 controller with 4-bit bus width
>> > - Configure card detect GPIO with inversion
>> > - Connect vmmc-supply to buck4 for 3.3V card power
>> > - Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
>> > - Add dual pinctrl states for voltage-dependent pin configuration
>> > - Support UHS-I SDR25, SDR50, and SDR104 modes
>>
>>
>> Tested-by: Margherita Milani <margherita.milani@amarulasolutions.com>
>>
>> However I noticed it only works when CONFIG_I2C_K1 is enabled.
>> Michael Opdenacker told me it's necessary to enable the regulators
>> used by the mmc controller.
>> Should we add the dependency between CONFIG_MMC_SDHCI_OF_K1 and
>> CONFIG_I2C_K1? (Unless some boards don't have these dependency?)
>> Thank you for your patchset which was really nice!
>
> Thank you for catching this! You're absolutely right about the dependency=
.
>
> From what I can see, all current SpacemiT K1 boards follow this design
> pattern where the SD card power is provided by an I2C-controlled PMIC.
> However, before adding a hard dependency, I'd like to get input from
> the community, does anyone know of K1-based boards that provide SD
> card power through fixed regulators or other means that don't require
> I2C?
if K1 needs to switch between standard and high-speed (UHS) modes,
I believe the I2C-controlled PMIC is mandatory to handle the voltage
switching (typically 3.3V to 1.8V).

I don't think any board would want to be stuck in standard mode permanently=
.
If high-speed mode is an option, why not use it? I think adding this
dependency is a good idea, but keep in mind it also needs to depend on P1.

                            - Troy
