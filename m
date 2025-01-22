Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698454C9F
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560735; cv=none; b=jPEjSTlebCVpwXC8EqOceub/UNVI+UJSTerya2sgdjfaM9qimKk7D/ZFbtX4ci+XkI1toXec7YSK7a3QC5rgE94oUaWg/9uW5rVktvUzRQno9mGVKiWBAhk3Ze7GqyBB3hJY0R1orIUXJtHruhN5scI6NHwCzujMm3P0WavZO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560735; c=relaxed/simple;
	bh=B0UeBZPoPKJ7VmoT9qxbH3AcXUuYs8DCXuRr/a8JU5M=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=DXM9+U8+oDBpbkJ+exVK30YZU5T3IJyaEDLha+8SWa8cDvFWvnxEDZGY5ouAEHx8HsGxqmyOvgBIFAU73ILblndcYwO1jbuZU1WBtr+58kjxEbaSZNf9L1bMAxGLZY9FmGWGN5x+THytlq21IIYLleauFepSE9RhDfWETmIO5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLuVXBCf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLuVXBCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFF0C4CED2;
	Wed, 22 Jan 2025 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560735;
	bh=B0UeBZPoPKJ7VmoT9qxbH3AcXUuYs8DCXuRr/a8JU5M=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=ZLuVXBCfmxQRJT5iJe7ds6bLkarel3YSXi5Vvl1mGEGtgxdDd7TIAMXjTqViMCbDH
	 9JjmSU16I3f/CbYHaXlTkDRHmgdUlxysOFeFIkiRtg8HyBKMrNbEDF2VXyLfFqB82Q
	 /D+oDALMoYB3C/4jhg8eGfSPbUcutF0K9UDiy0iO/BgL5q9apa5fnfcoBRgH9k449h
	 ydryuse5jXJWASQZCmx62NJ+3AeNsWH3WzRRs7Eeh5Bojvoa6so75slstS/8gh3ZWI
	 2UWupxtswSvaEf3Kc9YmFyFoMaDP9xvTQrxiWasbuuV+zXAnYnuYXOA40k3NDx39YX
	 NSWVJt0YpHlrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2FD380AA62;
	Wed, 22 Jan 2025 15:46:00 +0000 (UTC)
From: "i.chryssochoos via Bugspray Bot" <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:32 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c26-388b1c9760a9@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

i.chryssochoos writes via Kernel.org Bugzilla:

Hi,
I don't have access to 6.2. I'm currently on Ubuntu 22.04 with kernel
5.15.0-76-generic (on the same box as back in 2020) and behavior is
mixed:

I tried a Samsung Evo 256GB (U3, V30 etc.)  and had an error:
[5189171.233955] mmc1: cannot verify signal voltage switch
[5189171.568328] mmc1: error -110 whilst initialising SD card

Switching to a 10+ year old 8GB SDHC got things working:
[5189234.395708] mmc1: new high speed SDHC card at address 0007
[5189234.412143] mmcblk1: mmc1:0007 SD08G 7.50 GiB 

Reinserting the 256GB card worked:
[5189290.073393] mmc1: cannot verify signal voltage switch
[5189290.191013] mmc1: new ultra high speed SDR104 SDXC card at address
59b4
[5189290.191462] mmcblk1: mmc1:59b4 EE4S5 239 GiB 

After a warm reboot (card left in slot during this), it's still
recognized without the voltage switch issue message being printed:
[2.053896] mmc1: new ultra high speed SDR104 SDXC card at address 59b4
[2.057427] mmcblk1: mmc1:59b4 EE4S5 239 GiB 

All in all, the problem of the reader not working at all is (still)
fixed but it looks like some hardware registers or similar are not
properly initialized at boot?  Maybe using an older/simpler/etc. card
brings them to a working state?

Happy to supply more details etc.

Yannis

On Sat, 2023-07-01 at 15:29 +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=204003
> 
> --- Comment #25 from Chris Clayton (chris2553@googlemail.com) ---
> I no longer have the hardware, so cant help any further.
> 
> Chris
> 
> On Sat, 1 Jul 2023, 14:22 , <bugzilla-daemon@kernel.org> wrote:
> 
> > https://bugzilla.kernel.org/show_bug.cgi?id=204003
> > 
> > Doug Miles (dougmiles42@gmail.com) changed:
> > 
> >            What    |Removed                     |Added
> > 
> > -------------------------------------------------------------------
> > ---------
> >                  CC|                           
> > |dougmiles42@gmail.com
> > 
> > --- Comment #24 from Doug Miles (dougmiles42@gmail.com) ---
> > Bumping this, because it seems to have died on the vine and is
> > still an
> > issue
> > in kernel 6.2, as far as I can tell.
> > 
> > --
> > You may reply to this email to add a comment.
> > 
> > You are receiving this mail because:
> > You are on the CC list for the bug.
>

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c26
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

