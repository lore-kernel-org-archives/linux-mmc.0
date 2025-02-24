Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42B1DA31F
	for <linux-mmc@vger.kernel.org>; Mon, 24 Feb 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386376; cv=none; b=kVtLRtJuK555erAsfDYZuJxQtWEgogCOiEQG7S3eJPU6QXCvdXOaecgPBZSlDZde/qH1JoB7EnRZ23Uz0pxrgVrBvJWMx7+HuCgT8wc12FD47f74UnUCXdoyMXdW/3180KSdzLGlbS40tLX+xF3QrQxjR0bHyHxZ+b7gCXiFGO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386376; c=relaxed/simple;
	bh=hEFT5u+nMjjSk8TkcXckF5J0s2sX3wZ2iwc5n2MXCW4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=gxN+1hFdi0DBo9K2OVlapcZRV16heAKg0D9NClXWDwK8V69OxMeJLZEeIetTlEGU30UwSc0X4WrHiseOCGpv4XQYcgJhLFnvjmpQ2/tJdZYub5cLoKuETTAkRDzHEsZYq5kzZrdToh03WRzF8yCw3h65Q+SnxJoyVZL0NrDM0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2c/bUhZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2c/bUhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BC6C4CED6;
	Mon, 24 Feb 2025 08:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740386376;
	bh=hEFT5u+nMjjSk8TkcXckF5J0s2sX3wZ2iwc5n2MXCW4=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=A2c/bUhZ8/r438do8YJgtf/kl61rSkKRvHGz5YsvUiCpsMzp9b0lqN5jKsKUjK6i2
	 NHO/cIA1nHTNPWnqTv8lbQ4TDfKKeLZ/xVZlFUw1vKdWaq7ogkY4mWlRpzNOAeYoPw
	 CjatKyDoUDPjDHd+2IQACGr7692BocBlnPU77v462Y8AY1JMmcRMhl81PbqJ5tE9ni
	 RIFvnHyp3NB/e+pYsLAXJgsRGsecXJo3mfFJQXIu5pYHN48apGH1Doe5MrCPsajiGi
	 09adgZhoaXf3cpm5UJBX2xgQ6Axf1lTQBTX8nq3yeVSapzkWj0GsBV4vK6KlRYbKnl
	 4ieB6bcSr6pvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B3EEF380CEE5;
	Mon, 24 Feb 2025 08:40:08 +0000 (UTC)
From: Christian Heusel via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 24 Feb 2025 08:40:06 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Message-ID: <20250224-b219781c2-eb3f5315cace@bugzilla.kernel.org>
In-Reply-To: <20250214-b219781c0-d1fa30f21bf1@bugzilla.kernel.org>
References: <20250214-b219781c0-d1fa30f21bf1@bugzilla.kernel.org>
Subject: Re: Realtek RTS5129 card reader: sdcard not recognized at boot
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Christian Heusel writes via Kernel.org Bugzilla:

Revert sent out: https://lore.kernel.org/all/20250224-revert-sdcard-patch-v1-1-d1a457fbb796@heusel.eu

View: https://bugzilla.kernel.org/show_bug.cgi?id=219781#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

