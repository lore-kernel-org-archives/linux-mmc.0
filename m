Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED23430E843
	for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999791; cv=pass; b=EaH5RW98W/+IRoVASfKJUkkwGKDOjmHDbhm3ypjfgxdvfV/O4c+j1v1aAbADkGU/oV7yC5daWOBAfBaG1RSaQ1r30N0cPu2yTVMRAlTYY+rJQajEG744o4C57Sg8Rh+1zID+p8ALWRB65cYiPTlE1InyEpQ9lxrFI2HBjTMGJKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999791; c=relaxed/simple;
	bh=/leKpdzd0tkUYFpF8m7LOhNWK33frnQS/IpHfEc1E20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvY7gTjb+r/esgO46gA9oYcCcT8/2TSg6fvyF4KzhTb2vgBgt+y1cZtBKL4S5fNXKRt1lT8LxFHWOSAUQVBZlG2lZ8g0iHAjyDxIbRavsGrPHGF+G7zrrBgdqxSu7CQ7tWApsgRTgOmKtAo31IK+/f2a8wqRGdnUMExYbNsoc4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PfIoeheX; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PfIoeheX"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59dd3e979ceso486845e87.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 04:49:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768999788; cv=none;
        d=google.com; s=arc-20240605;
        b=iYazlkm6VoosLiM2L8l/ROt9BXzbRXChvQaiC9yzCBqWW37iWBZQYjPAbuvKNJ9B5v
         DXsQ8YfwndicIdeYnPiZg+T+ibc5eItT43/K71E7xNsXF1Of97s2iF97KWxu1R9+LWFs
         ewAFbY3RDJSrl3hOEydzGVBe4UsCQDNGux6rv6E5WFNHKEObrPpMRZyejEN33eYHGr9f
         hwHCUdNIIkKHZGuJI8mmlmfWre6Glabqn0SwHPVwSGW74cLVYz57jh6FKqjbtQ+Lnx2i
         Zd3ujGiyB5PTBJFtzQYQ9BhNcLADOOLBDXYqPvK+vi5gLmWxq2DZ9Zz2AyEtIt6X4VSp
         I5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/FruaakY/KisDzKMK2JTyTxAa4gejOB/mYlOBZ8FvQk=;
        fh=5Zgcm42BlcyT/K+Fn6NPQLzlcm9C4/pHqXV/B40jstk=;
        b=KuSdQ5siwFrEr6+6eq+eeLKiRmTRXBpCahjyz5rml+ypXgatdBbilDL4AMF3Csrkj/
         x5THKl5N3D9kJPDNyXntZ7l/f2sUjWoKD33xAZAL0a6iegNT5gPNt5PVPYsLKnMrSl6B
         1AiZpJETI2ucadxI8ZOvkn4jXgIHEMbWxaXgIJVBsApqI2gPp771IsaemLyTBQ72v97m
         uAjXIikfi2dIDQgvKTxKH2hvImMXTC8CkFwEMKVRC/D65BC0IHhyGZUhjEfIkxF4Zi+n
         A4Mj9nJZvF4psVBxtFonI3eqBmoyBPvmVSYpK6NWBI1z9Fo6t/qxDfQY4ViK0jXvTlTN
         uTow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768999788; x=1769604588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/FruaakY/KisDzKMK2JTyTxAa4gejOB/mYlOBZ8FvQk=;
        b=PfIoeheXRLO+T+Lpr1+0EFcBEjtnfJqrsYoF6LI6LGWdrQyCkxaWWkabCaGzOFIB47
         bscS8wHHPeD+YkuI0602ZljsdxP1AmZ1Ah7/F0l7MiCz+uzVUytSIIz78yjkrcQR+C6K
         8v+3o8JTnKtrzG4xTrOITfS0rIhXsJMMil/zKaxl1eMBejM14DxWsCw9X4qgJ379tKUk
         D6Ku5qsnilBypHRDlW4nd7EIO4WAFydwmd2S0d/tNAFS6r+U+cGLkF4hDEZfFMzCI3oM
         o5Exz+VUvc6fjmgVrKia5KkwrZRLuaThIVuOo+CfhMYvjal8p5o31KrfGR0CyqSN8Vpx
         Owmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768999788; x=1769604588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FruaakY/KisDzKMK2JTyTxAa4gejOB/mYlOBZ8FvQk=;
        b=rwBeZWNfuMVDURfdipUifZDc2WHRNz006axJCKtqXDFYS9J1RZwfm/OukzcjDJvX7b
         nnoWJFTm5NtOpXm7ENbNlpHi/spuYZ9JSTbdHSbPa/7TRC5YzmvHdEuTGXwsBY52aC9T
         nF+r2hxEtC2Zvipwb0yEkwHvwohMcsQWYVV708M4PHW+L6IMXVmiUWByuIGh+j2wfpVU
         dyQTG46RvSWIZ+qnevDsDpenxazHm6KYe0gVtVmMyE0z9XkvyMPKKKS6sb31ZK1TH7qe
         MfDW403sLqSdBx4BdDOZF82dP6xBNMFCRTtribwiddVbU/S2dXnSBAlaCCU7eJN89Z6m
         USKg==
X-Forwarded-Encrypted: i=1; AJvYcCV2XMBl/bUOyAX0MqIeXPwEnNnxKzSnmvudBveTaXJuapHL/LngcNycgIB9bu4h9nCjkfTOXhdqEyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUln4e3pCApzMXZQtZc3MuMAA11sXC5gkg/zNtSkVn3Azwm4IC
	4N8L2/IzIO9vc9ADvHCnOyE1ZUzW9M9f7z/dGbgeTMrRtSxufKeTAKFhQE3WjUBYY+uulAsv9Ob
	bikn6tenqcjaiwegN/DM3ebNZyZzAJlgdWXntPcGTKg==
X-Gm-Gg: AZuq6aJYNKBRUIpun00pZqtglnyMgV0dKqpW/svYQAHKlzQm5NMV7zpn6q5/vof0Qej
	kern2GVstAzTU2KjYVPHVEQv6EWCdSm8UKTX76vYtv2JKsILDtqR+1N2C39+dTSpxn6WGy1KklF
	g1m2rQXWIIwiWhZSDtO+9natiXMY3O4N1y2jLSuC57blTF5CWzqJ6yuxX+VNUt65skb+q/sP88W
	tkhue5mWhE4ITn0YEpiFSUqMxJBXR9Vfpp/jKNUHoyM8ulaLLtZg+s4gpW4Z8nYyiaW+oXd
X-Received: by 2002:ac2:4e0c:0:b0:59a:109c:6c19 with SMTP id
 2adb3069b0e04-59bafdb6c5bmr5943814e87.19.1768999787878; Wed, 21 Jan 2026
 04:49:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105060236.400366-1-matthew.schwartz@linux.dev>
 <CAPDyKFozgK_W98=-wqE2fxBsSkKvCU=mYH7WkKVXQPiB3+og3w@mail.gmail.com> <2026012150-overreact-cash-bf4d@gregkh>
In-Reply-To: <2026012150-overreact-cash-bf4d@gregkh>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Jan 2026 13:49:11 +0100
X-Gm-Features: AZwV_QiCjVJmCfIkjTrS9AkR3xlk94vvbN0Bww-v2QhDj6IJ9ubEdJsEAokPt08
Message-ID: <CAPDyKFq4UaB9OZf2nhrja-kv7UwwOXR36Sxa6gF-wDXip=FiVA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: rtsx: card stuck busy fixes for Realtek PCI SD
 card readers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Ricky Wu <ricky_wu@realtek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Jan 2026 at 11:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 21, 2026 at 11:13:03AM +0100, Ulf Hansson wrote:
> > On Mon, 5 Jan 2026 at 07:02, Matthew Schwartz
> > <matthew.schwartz@linux.dev> wrote:
> > >
> > > This series fixes some SD card timeout errors that occur after suspend and
> > > resume ops on systems with Realtek PCI card readers. These issues occur on
> > > my 2 RTS525A card readers and my RTS5261 card reader.
> > >
> > > As a stress test, I ran the amd-s2idle script from amd-debug-tools to
> > > automate s2idle cycles and I launched a visual novel, WITCH ON THE HOLY
> > > NIGHT, from the SD card. Visual novels are basically just slideshows, and
> > > waiting for 10 seconds without advancing the text is an easy way to
> > > trigger rtsx_pci_runtime_suspend/rtsx_pci_runtime_resume. I set amd-s2idle
> > > to test with a 10 second long s2idle length with 13 seconds between runs.
> > >
> > > The main symptom that always shows up is "mmc0: Card stuck being busy!"
> > > followed by timeouts and filesystem errors. This can occur during both
> > > runtime resume and s2idle resume:
> > >
> > > [  260.638214] mmc0: error -110 doing runtime resume
> > > [  261.054214] mmc0: card d555 removed
> > > [  261.054382] Aborting journal on device mmcblk0p1-8.
> > > [  261.054386] JBD2: I/O error when updating journal superblock for mmcblk0p1-8.
> > > [  261.067729] EXT4-fs (mmcblk0p1): shut down requested (2)
> > >
> > > Patch 1 adds a power_off callback so rtsx_pcr can notify the sdmmc driver
> > > during suspend, allowing it to reset prev_power_state. This ensures
> > > sd_power_on properly reinitializes the card on resume. It reduces the
> > > failure rate of "mmc0: Card stuck being busy!" after resume from 20% down
> > > to 4%.
> > >
> > > Patch 2 increases the post-power-on settling delay from 1ms to 5ms. The
> > > shorter delay seems insufficient for reliable reinitialization after the
> > > hardware has been powered off during suspend. Increasing this reduces the
> > > failure rate from 4% down to 0%, tested with over 300 s2idle cycles.
> > >
> > > Matthew Schwartz (2):
> > >   mmc: rtsx: reset power state on suspend
> > >   mmc: rtsx_pci_sdmmc: increase power-on settling delay to 5ms
> > >
> > >  drivers/misc/cardreader/rtsx_pcr.c |  9 +++++++++
> > >  drivers/mmc/host/rtsx_pci_sdmmc.c  | 24 +++++++++++++++++++++++-
> > >  include/linux/rtsx_common.h        |  1 +
> > >  3 files changed, 33 insertions(+), 1 deletion(-)
> > >
> > > --
> > > 2.52.0
> > >
> >
> > Greg, looks like you have queued up these patches via your misc tree,
> > can you please drop them? We need a different approach to the problem.
>
> They need to be reverted (my tree can not be rebased.)  Should I do
> that, or does someone want to send me the reverts?

If you can revert them, that would be great!

Then I will continue to work with Matthew to fix the problem in a more
proper way.

Kind regards
Uffe
