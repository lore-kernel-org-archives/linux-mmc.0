Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C94A15
	for <linux-mmc@vger.kernel.org>; Sun, 22 Sep 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727012115; cv=none; b=R2p8k6raOXNQh+bIylTmO42CFFkhaWug/y5IDuba3sK7FxEuj6eQo6wSt7o950poHLC7E3KxvrGbRKDo4y4RBdDUCRXhjmz51ki1bE7XU2vmTH+MsDeSMQLRCF1BA7o8fNhoBZOBpAF62eV9J0C7WlUDjQIvEBZqIwLT1J3lAkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727012115; c=relaxed/simple;
	bh=xjBU4L0aHIkqZSkwBqdq8zAnqtUz7GIZA6VxF2jF3iY=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=Vq5Xe2m+VvO1ZBdqdMs2IcVA0lxftUJAM4GkpWyuKK40KVk0AH7lRE1V3qY8vPjok5rUVO4vzN0ZoEfnkboPRmo85qT1bBcYxJ5uGBHcfeLAc09MV92qC6kyO+t121890Fuh8tTOzcE1EVHKbodVA5eZvLnfKJ3ngxN7kK2n36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siEqCQu8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siEqCQu8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01BAC4CEC3;
	Sun, 22 Sep 2024 13:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727012115;
	bh=xjBU4L0aHIkqZSkwBqdq8zAnqtUz7GIZA6VxF2jF3iY=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=siEqCQu8xlwXJHmDBQT5+n/UwKCB/2LxVoUT5gTRD2iG34iz2C6sXT4mJgwPikJwq
	 ZFIAzEIOakTLeYgY+6IqclMRI+YWKpk5YWUUKMloUzxDKr01S4zINtIJFRyMOMXJC4
	 assLmdWaStMCLuip4Sjz9bITPCZUeN/Lj5sBOAAW0UAbHkbmlA2vy672EhLDP7c5A+
	 Xr6syGHkrVnOoJ28qUsGsr3U1vCMiosx/OSmuDIy42xn/tNrJQ55dJ2gnoqgicf5Q5
	 TI8Tb6F3v2wHTpYUujTECIrmKzs25kpvcNAelpfrFI2oSV8mWfZyjuQWQt/bNjPP2Q
	 gPcOvOgpoIDEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7130C3806655;
	Sun, 22 Sep 2024 13:35:18 +0000 (UTC)
From: Thomas Haschka via Bugspray Bot <bugbot@kernel.org>
Date: Sun, 22 Sep 2024 13:35:11 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20240922-b218821c4-637a3f6d7112@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Thomas Haschka writes via Kernel.org Bugzilla:

The problem starts already at kernel 6.6, at least at 6.6.52

I also tried to modify: 

drivers/mmc/core/core.c

essentially reverting it back to it's 6.5.5 state:

diff linux-6.5.5-gentoo/drivers/mmc/core/core.c linux-6.6.52-gentoo/drivers/mmc/core/core.c 
554c554,556
<       mmc_wait_for_cmd(host, &cmd, 0);
---
>       mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> 
>       mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT, true,
>       MMC_BUSY_IO);
562c564
<       err = mmc_wait_for_cmd(host, &cmd, 0);
---
>       err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
564a567,569
> 
>       if (err)
>               err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);

doing this I was semi successful, as

mmc0: error -95 doing runtime resume

still showed up, but after around 1 minute of waiting the driver seemed to have recovered and continued working, until failing again a few minutes later. Which causes large long stalls on when trying to use the card.

View: https://bugzilla.kernel.org/show_bug.cgi?id=218821#c4
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

