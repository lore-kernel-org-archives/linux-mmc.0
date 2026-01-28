Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3459274FFD
	for <linux-mmc@vger.kernel.org>; Wed, 28 Jan 2026 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606678; cv=pass; b=eud8LJlt5n3221UIOlkBE33SQzO2K6W1zPbA0dV7ZME6IYD/IdBccOF2/1eLCRjLSDTQS40oJc5Oh/f8FHf3MeQ0zGdhPfsGCTQ+dYPD5Z9YzexVFhvk/VdWhZ8Fq1JJMe+ZBz+6o1Emv2bL4emFxS3pGbCGuG6BDc/6PHQKucM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606678; c=relaxed/simple;
	bh=snQt1T0a9y+sHnyrXThQZOGOOgRhW+QZgOceN21Q1Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1UFLXLJxqlFUMhRSPjEV5JnJqcXIcga95MrzNhOg7G1aq5BJ886Q9sY+50j1KNO1kFe8FEd9zEWe712hBCZUnNGThHbRqKGFU5yLeB4MzdV6IASiO1+l14/SDLDYUL5XtMLsSH1VL7VDDsrNr/EKikxdOVf3NPG1Nqd1TYFm/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wcetfjn4; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wcetfjn4"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64931bbf70cso5855900d50.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Jan 2026 05:24:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769606676; cv=none;
        d=google.com; s=arc-20240605;
        b=V7dS9+w0t++YiQteERT/AYUYF/+D2fm45CBqesOkf/jMJjDG0n1RgEL/PmS+5DbQpS
         C+Z1sL7+7bA5fwoTijSju2bu027rEjYAEInvQQMIOgEUNkTt/P51fE5nKvsmcEtbCn2l
         syrqpk/96KI0/KRizr4zGhDZioxPH1lzRhVgFAdeUCX7KVALK7wQaHC2/feYNAl1sJ+j
         pVtqY5ZiPzmqa27a6ThuR91SQTOaPNIFiNXxnpz9275+Y90cAJ2IKp0H4AyL7GYfBT8M
         dKtiQLJCFKLy3wyOGH3EYjaMHu49EmkvElWfoaHvwGzNGhQQ3EWDmDp+LnMX0b83Ku48
         XCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OCgXWgQkDzJYN/wgVvBzWATPV2whHO0ZsHITKLZkYGg=;
        fh=T/UbEtZGoKHa5G4EYHzNSjWhBktd5Y/vbYuY6wj840M=;
        b=EA34kEyfqOKbAPgkebbb3FxO3gzDygvfOHB607OlPyV30M1OvHsc+auvArByd07y+g
         NKD1csdsANcfrpy5H5wnc1kKU2U4ZqnharByHgkm8XZgEHjBPENg99yLXanhvdt0Yxb8
         7Jqj7K7YiqOL1aMCJ54GhypilhXla9SgHXjG+46KXtnx6qTmxfWxIqoC+8ToSIiaQC3H
         OiQ0ksfA2wFO/CPlku2d1GeXk6tXkKzHHbUgzE86JmWnAPFmT4KEWB8Emy1n6022HjMi
         Bd6sbKhl2ff/SOtYG/574um5X4xAc2VoifgRiGlWdhG0wudhP5yyXYjIJ6UOirGzCtf6
         5SEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769606676; x=1770211476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCgXWgQkDzJYN/wgVvBzWATPV2whHO0ZsHITKLZkYGg=;
        b=wcetfjn47grsNlGfLk2PReej9rQ97rP9UaF+QakEv/T8PUs7vHF7sOYXk1UWhC8CuT
         OrBv8gNfZuHpLPiI/vMlfYqD7RMTkCR9m67q+jTDVUr/G23n1D1w7EUbNZBftATakG2G
         hHC850RCZ7bs/VnYNKwUE9fftdNPtnZRApnX2nr2mAnleKRhfvkTFEpJxonW7+VjMZAt
         AvxvxlaetOwUHXCgdeVTkoerLNBbGKrb+2y360dQfGjIHh9OlzYohLLAVxH05tU9iTNa
         dS8kY06TKWdYcXe0zu263Dmx3k7fKZ4JlEEp9bU7fodZdU7iliglcW+nQQkG/gT7uA7O
         o55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769606676; x=1770211476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OCgXWgQkDzJYN/wgVvBzWATPV2whHO0ZsHITKLZkYGg=;
        b=TGsQIW3hn44pAlrTRb6TNp9QNbKdQypLDDReJro+dJuSlUpudkm8UIu2qpt8es1MAK
         Kz7BfSyqwuvuHbLdMsClRV/2NryJgjGskkSDr2NiLuNHrDLTVDDWjfqX6KmcrjZzxF3C
         qpNgdKl6aD/FKJdud+2Z6asII5D0DhNPj4YJA7BDWbWRVNyWFStyJS1MTnhaS5MRV2NT
         /ID617q9gsvGvv7VsnTK5iJMkTTpAV9B57OHrMofoNxF/CNKDuLV80eBWeWQuQHyZHal
         xsZA9QKTzSR9lRBgQrpY7zQ6a9my0++IqrPbOWM//8g+oc1wV9ttAwkes+k2eLg+aBxF
         cWhg==
X-Forwarded-Encrypted: i=1; AJvYcCXtmt3/DfawgVoJUQCOQ4yhKW+QL3I/i942Iiuv+5OHPwYRyNTI65RRwJZrsGJ6Y/kk3qUgIdn3zns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQBTzHQTXSVn+Y3T4eQFsj7rZIBfF9CVXCG8BoDtZD1LdhLY7
	UaJTJy6B7N6QnXTElS36fo8eb3nxuQkWk9VxLPrGPIoA5na9xuEPKkn/r3yk6PR8N+w9QokNAZS
	CxxOfgr1UZ3o1AYeb2lCsVCDb7D81EeyO+u4ibxo0LQ==
X-Gm-Gg: AZuq6aK1baWxmhyT2ycfMSe+IokEOsdC4VYywzldsmOMSqOoAtpgZPvGdMjHhqjCTPP
	RmZt51J9yn/AZ0OeDb8lM77Fy3lGug07gqXCeXijQkHh0Xxv1XpqfgLTkk5zcBAHzYoiQmwKsZ8
	Lh3GgyNBuTKEc0+TfERFO16s3Q/csDBZgi8CoT3cNwkLgVYFoLqAWD+4yaS+dhQqLjmnom9pzLb
	/JyFwB1PQElq16GKQqZpwEBR1dZETOE+3+nSV4gztS9siQ7Y0xCS6i5UtgacBIzoFALOZzF
X-Received: by 2002:a05:690c:a08c:20b0:787:bf86:a161 with SMTP id
 00721157ae682-7947ab5856cmr72727327b3.30.1769606675644; Wed, 28 Jan 2026
 05:24:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev>
 <CAPDyKFrGpvjONrDmnNZXv+SME_NCNv-LK8J-Vo88RSz1fuD7rg@mail.gmail.com>
 <787171c6-0b9c-400b-8a95-b331b58e284c@linux.dev> <4777aabd-bc9e-4904-9444-892393aecb15@linux.dev>
 <9e362d5fa2604fb0848ea28866dc45fc@realtek.com> <47ed09fc-047b-4f98-8df3-d11d17678c57@linux.dev>
 <380f75c7adc04cbab38cfd2f82bd0c6d@realtek.com> <d46dcebe-ca58-44c4-87ee-cade2e478572@linux.dev>
 <4205fde06ecd4a7489b03ef25e5e4011@realtek.com>
In-Reply-To: <4205fde06ecd4a7489b03ef25e5e4011@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Jan 2026 14:23:57 +0100
X-Gm-Features: AZwV_QiXZ2iil0ZwQbSGUlHvls1cIceCexu6AgESIw00a4mlXAxanDONEE8DxlM
Message-ID: <CAPDyKFoC-dwzcsABNy9pA=GGirBWwcxQhNMeTSSStXHtXmWbcg@mail.gmail.com>
Subject: Re: [BUG] - Short freezes in gameplay due to MMC_CAP_AGGRESSIVE_PM on
 RTS525A card reader
To: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, 
	Ricky WU <ricky_wu@realtek.com>, Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ linux-block, Jens, Bart (ufs), Christoph (nvme)

[...]

> > >>>>>>>
> > >>>>>>> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > >>>> b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > >>>>>>> index 1e5170435cf8..a7c7daf66d5c 100644
> > >>>>>>> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > >>>>>>> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > >>>>>>> @@ -1499,7 +1499,7 @@ static void realtek_init_host(struct
> > >>>> realtek_pci_sdmmc *host)
> > >>>>>>>         mmc->caps =3D MMC_CAP_4_BIT_DATA |
> > >>>> MMC_CAP_SD_HIGHSPEED |
> > >>>>>>>                 MMC_CAP_MMC_HIGHSPEED |
> > >>>> MMC_CAP_BUS_WIDTH_TEST |
> > >>>>>>>                 MMC_CAP_UHS_SDR12 |
> > MMC_CAP_UHS_SDR25;
> > >>>>>>> -       if (pcr->rtd3_en)
> > >>>>>>> +       if (pcr->rtd3_en && PCI_PID(pcr) !=3D PID_525A)
> > >>>>>>>                 mmc->caps =3D mmc->caps |
> > >>>> MMC_CAP_AGGRESSIVE_PM;
> > >>>>>>>         mmc->caps2 =3D MMC_CAP2_NO_PRESCAN_POWERUP |
> > >>>> MMC_CAP2_FULL_PWR_CYCLE |
> > >>>>>>>                 MMC_CAP2_NO_SDIO;
> > >>>>>>> --
> > >>>>>>> 2.52.0
> > >>>>>>>
> > >>>>>>> I think what's happening here is that RTS525A shuts off power t=
o the
> > >> card
> > >>>> reader when games are idle for 10 seconds or more, and then when t=
he
> > >> game
> > >>>> goes to load new assets it has to go through the whole re-tuning p=
rocess
> > >> which
> > >>>> takes 1-2 seconds. The other brands of card readers I have keep th=
e
> > device
> > >>>> powered the whole time so they do not have this issue, and that's =
what
> > >>>> untagging MMC_CAP_AGGRESSIVE_PM seems to mimic.
> > >>>>>>
> > >>>>>> Right, MMC_CAP_AGGRESSIVE_PM does exactly what you think. If
> > there
> > >>>> are
> > >>>>>> an idle period of no requests for the SD card, the mmc core may
> > decide
> > >>>>>> to power-off the card for those mmc host drivers that has set
> > >>>>>> MMC_CAP_AGGRESSIVE_PM. The idea is that we want to avoid
> > wasting
> > >>>> power
> > >>>>>> when the card is unused, which is typically important on some ba=
ttery
> > >>>>>> driven devices.
> > >>>>>>
> > >>>>>> The main problem however, is that we are lacking a common policy=
 for
> > >>>>>> how to handle this generically for all eMMC/SD cards. Ideally it
> > >>>>>> should be independent of what mmc host drivers that is managing =
it,
> > >>>>>> but that's not the case.
> > >>>>>>
> > >>>>>> That said, without changing the code you can use sysfs to either=
 tweak
> > >>>>>> the idle-period or to simply prevent "runtime_suspend" (meaning
> > >>>>>> power-off) for the SD card.
> > >>>>>>
> > >>>
> > >>> Hi Ulf, Matthew
> > >>>
> > >>> In our Windows card reader driver, the idle period time is set to
> > >> approximately 10 seconds.
> > >>> Is there any recommended way to control or configure this idle peri=
od
> > time?
> > >>
> > >> I tried adjusting pm_schedule_suspend(device, 10000); in rtsx_pcr, b=
ut this
> > just
> > >> increases the time until you inevitably run into the issue. There ar=
e some
> > >> games that can go a very long time in runtime_suspend without loadin=
g
> > new
> > >> assets, but when they inevitably go into runtime_resume after say 3 =
or 5
> > >> minutes, this hang in gameplay seems unavoidable with
> > >> MMC_CAP_AGGRESSIVE_PM in particular. I found an old laptop of mine
> > with
> > >> an RTS5261 reader and that has the same issue unless I disable
> > >> MMC_CAP_AGGRESSIVE_PM.
> > >>
> > >>> Or is it possible to introduce a capability tag that is less aggres=
sive than
> > >> MMC_CAP_AGGRESSIVE_PM?
> > >>
> > >> Full disclosure: This is my first time looking at mmc/rtsx code, so =
I'll defer to
> > >> Ulf on this.
> > >>
> > >>> Since most notebooks have very strict power-saving requirements dur=
ing
> > idle
> > >> states,
> > >>> we are not able to avoid using the MMC_CAP_AGGRESSIVE_PM capability=
.
> > >>
> > >> The only other comparison I have is from card readers in other devic=
es of
> > mine,
> > >> a Genesys Logic GL9767 in a ROG Ally X and an O2 Micro in my Steam
> > Deck.
> > >> For both of these, the card reader drivers do not seem to implement =
any
> > form
> > >> of runtime power management on Linux, so the experience when playing
> > >> games off of them has been flawless.
> > >>
> > >> Matt
> > >>
> > >
> > > Since our driver is designed to be a general-purpose driver for all r=
eaders,
> > > the scenarios you mentioned =E2=80=94 ROG Ally X and Steam Deck =E2=
=80=94 are gaming
> > handheld devices.
> >
> > The drivers they use were not designed to be gaming-focused either, the=
y are
> > general purpose.
> > O2 Micro has been around since before handheld gaming PCs were even a
> > thing. Personally,
> > I disagree with classifying gaming as falling outside of "general purpo=
se"
> > parameters.
> >
>
> What I=E2=80=99m referring to here is the product positioning =E2=80=94 w=
hether the device is categorized as a gaming handheld or a notebook PC.
>
> > > For Realtek reader usage on handheld platforms,
> > > we would recommend disabling this power-saving function(pcr->rtd3_en)
> > through BIOS settings/guidelines.
> >
> > Just to clarify, is the recommendation to disable this feature for ever=
y device
> > with a Realtek card
> > reader that might be used to play games from an SD card? My MSI Raider
> > GE67HX laptop with RTS5261 has
> > this same freeze in gameplay if I use an SD card. Using an SD card as a
> > portable library is very
> > common.
> >
> > Thanks,
> > Matt
> >
>
> Over the past few years, the vast majority of notebook manufacturers have=
 placed strong emphasis on power consumption,
> requiring support for S0ix with very strict power efficiency targets.
> As a result, we updated the driver to further reduce power consumption.
>
> To address this issue, it seems necessary to provide a mechanism that all=
ows games or user-mode applications to dynamically enable or disable the po=
wer-management (PM) functionality.
>
> Ricky

I have looped in the linux-block list and a couple of maintainers for
other block devices, to see how if they may have some input around
this topic.

Jens, Bart, Christoph, let me summarize:

For eMMC/SD, we have implemented runtime PM support for the card to
allow us to save power by putting the card into a low power state when
card has been idle for some period (3s is the default idle-period).

When we introduced this code in the mmc core several years ago, it was
kind of experimental, so we decided to have it default disabled. To
enable it, the mmc host driver needs to set a specific capability flag
(MMC_CAP_AGGRESSIVE_PM), statically at build-time (probably a not the
best idea in hindsight, but the use is still quite limited).

Now, to the problem. For the rtsx_pci_sdmmc mmc driver
MMC_CAP_AGGRESSIVE_PM is set. This works fine for most use-cases and
helps to save power, although for some gaming use-cases this fails.
More precisely, restoring the power to card introduces latency (of
course) - and this latency isn't acceptable for gaming.

To address the problem, there are a couple of ways for user space via
sysfs to control the behaviour.
1) It can prevent runtime suspend of the card via sysfs, before the
gaming use-case starts.
2) It can put a PM QoS latency constraint to prevent the lower power
state of the card (we don't obey to these constraints in the mmc core
today, but we could extend it to do it).
3) Increase the runtime PM idle period of the card (may not be
sufficient for gaming, but still an option for user space).

Another, completely different option is to change the behavior in the
mmc core, to default keep the card runtime resumed until user-space
allows runtime suspend via sysfs.

How does other block device drivers do this? What are their default
behaviors in regards to runtime PM?

[...]

Kind regards
Uffe
