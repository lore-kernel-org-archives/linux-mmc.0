Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F62B2139C8
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560722; cv=none; b=MKTBBk5ZzYPlTR0o3j/BgGB8sUBlEDp1vBMuNzjACHcXq9gpc9ZUcElIxq4F4M2+YqhwB7nUZ00FVxJfGWxQDvTiUXH32tf+QeOFvuDGOJfoV0EesU33Z9nWvTidZLn2AKXUrSgoNsAQUR9JWQRf/GMSdv9bfg84wTZ7LBwxO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560722; c=relaxed/simple;
	bh=sHznG5GAZp8F0669JEGIGhAlMEXW4tG5Lu0S9nJogSI=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=jfDCmFTb2aQl7Dreg3gaQ18LCX6JL6j6T+tl4GxGkMnVIgq5lshgrwqdW5Ja1u15lPGzSFyO9jZxwzGbEDrNYtSJf3OZ9xvLZOyXL/vslcv9tiR7iVFBwULJvvO70MaJlGf8T6JgSmhO7YmQnK84gd4U/i0trdXjEuqZovvNxNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAy0pEUc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAy0pEUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4356AC4CED2;
	Wed, 22 Jan 2025 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560722;
	bh=sHznG5GAZp8F0669JEGIGhAlMEXW4tG5Lu0S9nJogSI=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=oAy0pEUcBGiqTOEwcSWzIJFQFdxglFBmIxWEfgxX8eDWwilc5cSHSWact1gl6v0Gl
	 fHYpfdEBvrr1/3KGLktB5BWm2RinVoj8QTAAEFWtG/i/AWbMAefDKwxAOIMihmW6pK
	 x3Zpdr4/XhtgNjiKhgGEp402x3iRP8TcgDOHwHQzFAVmSJ9Hn1bn29edYhGCkb3vxT
	 TxI7JLx5jT/KC8iqm0uQolg1CA0igf7umId1YTfzx7KFrV4Kbo+mzFMKdctW1HzFUV
	 XVqlZ8InLX0GclQBJRoRgEPD/4UMmwnWfpBcRkCXIHBXb+FP105BEPkdrJ9Ts5PHU1
	 8JVSnFpBwIDHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE5380AA62;
	Wed, 22 Jan 2025 15:45:47 +0000 (UTC)
From: Scott Brown via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:25 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c19-9ca421485703@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Scott Brown writes via Kernel.org Bugzilla:

My results in dmesg when inserting an SD card on kernel 5.8.18-200.fc32.x86_64 on a NUC7PJYH:

mmc1: cannot verify signal voltage switch
mmc1: error -110 whilst initialising SD card
mmc1: cannot verify signal voltage switch
mmc1: error -110 whilst initialising SD card
mmc1: cannot verify signal voltage switch
mmc1: error -110 whilst initialising SD card

That's more than what happened before (when dmesg would show nothing) but I guess maybe the complete fix wasn't pulled in to the Fedora build, or some other issue still exists. Not sure.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c19
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

