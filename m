Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11514C9F
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560737; cv=none; b=WyKc6GBV0Y3lmbOZVpSYpcQ5Ata0A1n9/YvQiWC/fccEHQpih8KKaUBMU7Vn9Gpx+vodQT1jsh2yHivkAmEmlX37NVN9I6kCvq039I7pAzqA0u5Cr3WCAHPcI/OPt8FXICGDli9wOQvSSFUTyBsAEYINvOlHQEF7Ye1js84SGgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560737; c=relaxed/simple;
	bh=/Ur+mBzRLoU8bZeKKrG7myxnMVsGyyFwm09cX4Y9ALA=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=lYx3ADRGIDth/ucjAIDFS3+2M2JF8to1R+RyJkp/Dw/k2tky9hV0dNwFuFWxzRb+qwe+2WFZ2GEOG0qckKKNnfoGB9voQxhiGqmhrbsYdB4c2JQD2teATuAH8JH0YrxyHCi29GPXcSnydVVq6QQ6+w+NjUFrapffAPbrhqLbyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx39tg3Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx39tg3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836A9C4CED2;
	Wed, 22 Jan 2025 15:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560737;
	bh=/Ur+mBzRLoU8bZeKKrG7myxnMVsGyyFwm09cX4Y9ALA=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=Cx39tg3Q9zWemgXlTxxFR1y2sM2akbnKHbyP9cMLTWeVWbCta+FdXNadL9sNLU+9s
	 iiE/aNURFpKekvWZE/L9dImsq2kPoZXWOSb/VM1J4NpYaYXoUn+GrsSPsKU7FWc8tQ
	 JvZWlJ1PbgvkQJe89/aX11KMs4mqV9AKRn+SmsIEZw+F9loYjW39F9LVnT7LlmNaLE
	 Rl+uFix+CJsseHPirT76dN++Wo+qVhmPZUpqUYx6XjgelnLF3WvgZBW/mHS4jQ4RJm
	 8WsWahtpihdxKosxv+m1dw1mmyiAnnwh3UblbRp4Jgoq6Wj4HB8u9bxwt8fflhgjoZ
	 hIwYUtMwe22wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34579380AA62;
	Wed, 22 Jan 2025 15:46:03 +0000 (UTC)
From: Roger Heflin via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:33 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c27-156b9a738732@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c26-388b1c9760a9@bugzilla.kernel.org>
References: <20250122-b204003c26-388b1c9760a9@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Roger Heflin writes via Kernel.org Bugzilla:

(In reply to i.chryssochoos from comment #26)
> Hi,
> I don't have access to 6.2. I'm currently on Ubuntu 22.04 with kernel
> 5.15.0-76-generic (on the same box as back in 2020) and behavior is
> mixed:
> 
> I tried a Samsung Evo 256GB (U3, V30 etc.)  and had an error:
> [5189171.233955] mmc1: cannot verify signal voltage switch
> [5189171.568328] mmc1: error -110 whilst initialising SD card
> 
> Switching to a 10+ year old 8GB SDHC got things working:
> [5189234.395708] mmc1: new high speed SDHC card at address 0007
> [5189234.412143] mmcblk1: mmc1:0007 SD08G 7.50 GiB 
> 
> Reinserting the 256GB card worked:
> [5189290.073393] mmc1: cannot verify signal voltage switch
> [5189290.191013] mmc1: new ultra high speed SDR104 SDXC card at address
> 59b4
> [5189290.191462] mmcblk1: mmc1:59b4 EE4S5 239 GiB 
> 
> After a warm reboot (card left in slot during this), it's still
> recognized without the voltage switch issue message being printed:
> [2.053896] mmc1: new ultra high speed SDR104 SDXC card at address 59b4
> [2.057427] mmcblk1: mmc1:59b4 EE4S5 239 GiB 
> 
> All in all, the problem of the reader not working at all is (still)
> fixed but it looks like some hardware registers or similar are not
> properly initialized at boot?  Maybe using an older/simpler/etc. card
> brings them to a working state?
> 
> Happy to supply more details etc.
> 
> Yannis

I can confirm that this is still a bug on 6.4.7 (close to current).

Mine fails with Lexar UHS-II cards.  The 2 cards work fine on slow usb sd card readers.   Older SD cards do work on both of these readers.  The issue seems to be the newer cards that have this issue.

Errors are this:
160866.008169] mmc0: cannot verify signal voltage switch
[160866.441037] mmc0: error -110 whilst initialising SD card


I have at least 2 different machines that have these cards in them, and this behavior is on both.

I can collect for this issue.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c27
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

