Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE493043BE
	for <linux-mmc@vger.kernel.org>; Tue, 23 Dec 2025 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766519003; cv=none; b=NRsmVHsTK2OMRoitDXpVdbeBIFx5x4R7wyvnMorFp+ja3oJnP1nBbFiEzfU/SPAL4rUXABNjDhViE73e9f4MkUEMwrINalAr6Ly0KQhM8q7y76NtrZelSGbX5qZW00/fVHUsP6YWeNLLEFNUI8rH22QYt8SbD8hjedSqNQtYzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766519003; c=relaxed/simple;
	bh=BREtBW6a5/bVTiCfPRgToAaJyODJvIaxuZyxBIaU1cs=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=Qf8T7Rthn5H+7IhjOLJ4+NX0/oGbxObENvfD1uHPnmv0kQ2mKrBpydkfxldgOgqVrpV5bmNcKwh5HlYrphZgLzZ6tgg+pz6liFnyMUKVVx8EtItQJ4RsWFusA1xqRlUaPYNijOLmOz17lhiItCbKL9wy+kHMZtrrtdKT4XyA4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFpHWcat; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFpHWcat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DC9C113D0;
	Tue, 23 Dec 2025 19:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766519002;
	bh=BREtBW6a5/bVTiCfPRgToAaJyODJvIaxuZyxBIaU1cs=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=ZFpHWcatotp7Xqomd6aOnLUxS9jfOHI2SjgAcUgTuij7c0yWsVv9z6GjlVzWoQyLj
	 WFmxO3YIxbiglGUZit2iIN0mnI6gmTp7aCscp572VLZ40w6u7IPUJPc1ntlMw1UB29
	 NqhlqDAb6+dyqCczxo4ZGAw1zEAIlRj0l8nqz8McS4nZ1DsIDKX764yyYr//a8JagG
	 h+ngnfzAOEeAMDT9CBEXCnqTMuAexs/3XxUnncpiEvP+hY2VdAVJu/UESOG7OMHXUD
	 fFzUbpFfZ0R40xAr6W8plqSIrr1Xyh5+SDfIjQXApz7O1onql/5dIlAMcvIKuZb8sQ
	 FR/8b20rHBoJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7C8F13811A41;
	Tue, 23 Dec 2025 19:40:09 +0000 (UTC)
From: Randy Dunlap via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 23 Dec 2025 19:40:06 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Message-ID: <20251223-b219781c3-09717e87d1a5@bugzilla.kernel.org>
In-Reply-To: <20250214-b219781c0-d1fa30f21bf1@bugzilla.kernel.org>
References: <20250214-b219781c0-d1fa30f21bf1@bugzilla.kernel.org>
Subject: Re: Realtek RTS5129 card reader: sdcard not recognized at boot
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Randy Dunlap writes via Kernel.org Bugzilla:

Patch was applied:
commit 2397d61ee45c
Author: Christian Heusel <christian@heusel.eu>
Date:   Mon Feb 24 09:32:59 2025 +0100
    Revert "drivers/card_reader/rtsx_usb: Restore interrupt based detection"

View: https://bugzilla.kernel.org/show_bug.cgi?id=219781#c3
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

