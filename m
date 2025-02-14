Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA4263F25
	for <linux-mmc@vger.kernel.org>; Fri, 14 Feb 2025 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537080; cv=none; b=IXqFr1uXWDnOGv0tkgd0mbpn97VxkIQX84SP4iz07E4Yd4q5nZe6IHCbAplY8QEnqoM+1IhV8ZXy2as7xAxyuErw6Y8/auxfDI2TqW6q8j2WjwhHr0loE9GQXrnIlArTN+F5Lt7FX8q9Te0FancT91pnHnXrjRAqtIJbl2tKq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537080; c=relaxed/simple;
	bh=yU5gi6jSoxATpHp2UGS1HbtzvvCtVIpyrx41H4qrlAE=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=d0Yp+L/KnvNw9Wg5GNx6gWtpQ4BAPqrAddiIs9gje5h5ysZ9NxioR5lkyyYxRwllcPWL0AfWfDAiOzzXALp7bmebrtNU3FfnlyF8ilSuJE2VwOjpP06rUs5hImv6RpgVs6ugyqi52o1Mfz1LyJijhDsrSuKZ5r3nk+zWPFTICjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5GMh5xQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5GMh5xQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B6CC4CED1;
	Fri, 14 Feb 2025 12:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739537079;
	bh=yU5gi6jSoxATpHp2UGS1HbtzvvCtVIpyrx41H4qrlAE=;
	h=From:Date:To:Subject:From;
	b=e5GMh5xQxdJqEx2DAztT4Av8R2v+TkON5wdq0V4KDTEOpk/Q9zUSidJXfrfHBlpXP
	 PBXu5pwfAj2+AEJup8WVeX+sFIOeln20Z4BtwK+71aaazMkWQE7ZG7QzKQAW/PAUB4
	 OCewkpiXZ1HlcLV3IPablVnv7/80QGQ4SlpbCCm0a/2o3hGIqihOfFJN/i0dWcIV76
	 ucFa7TiCXTQhYMxuvsu/E2085qamBalwWKRti0rXiBlY954Hwzosc6XV+bv/7UVlNk
	 RIGwiOsBsYutKlncatN0S5mFp7x+80oKghxw5qL5X4DmMPd60I/Bt4M7jSxUWeJ7S0
	 R7EQH2K8pXOHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF3C5380CEE8;
	Fri, 14 Feb 2025 12:45:09 +0000 (UTC)
From: quintafeira via Bugspray Bot <bugbot@kernel.org>
Date: Fri, 14 Feb 2025 12:45:06 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250214-b219781c0-d1fa30f21bf1@bugzilla.kernel.org>
Subject: Realtek RTS5129 card reader: sdcard not recognized at boot
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

quintafeira writes via Kernel.org Bugzilla:

Using a Realtek RTS5129 Card Reader Controller (0bda:0129), the sdcard is not recognized at boot. In order to have the sdcard recognized, I have to unplug and plug it again after booting the system.

This issue affects kernel versions 6.12.13, 6.13.2 and mainline.

Reverting commit 235b630eda072d7e7b102ab346d6b8a2c028a772 (drivers/card_reader/rtsx_usb: Restore interrupt based detection) fixes this issue.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219781#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

