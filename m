Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2A4A3E
	for <linux-mmc@vger.kernel.org>; Sun, 22 Sep 2024 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727012117; cv=none; b=lbCErVfq7eKxYVMg3qZLq0kwejrQ0a+ACfJEggl2SDbfkoNOqHPAQhCUaHWIhLMJxIudPUvCWLt2FC+NCTjCn1lCGTM1KCqvihtjMrOw/MFGwiHft1pPRTDzGZHV+NDHxugB/HT6HmOHSAcek3oB4Zq9lLdht02jEio4XZdOwJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727012117; c=relaxed/simple;
	bh=G3Jne/s1Ww8bwtfK0Q4npEhQ/sdI5eIKyV41pJHo7RQ=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=pAwwqkLWL+D/5F4HZxs3DK3TT8OZy2PirJjUhRG5pQEFySnN4SXi14/il6pfX2T14i70FeM8cDxX632Qg+7fTFA7QjbRsdXRmZuT7njJ5gyqvTozM5ulwgRJSRpKq8sk1W8uHkoKtaoMP1rPebiYYG2LEDEf+cXCsNhUY1tcldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2dz8cMF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2dz8cMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41201C4CEC3;
	Sun, 22 Sep 2024 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727012117;
	bh=G3Jne/s1Ww8bwtfK0Q4npEhQ/sdI5eIKyV41pJHo7RQ=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=H2dz8cMF7V9HPkf/eFZ2tAHtk5Wb+0Yk/2zAOuhFVknKTk0iIb2g9fIAHw4lERpsk
	 9AGzDPM7x8t0RoZzHTpFOk4VDetuKc1qGcpWDl+rjITA77elKWrvmm3SYOL/CR/kil
	 av9do1ILb9DBnDiXRcuUABnVdO8l0ziIujuG1Q7z/1nmcqr4FCa+Wq5gGA7uhhQPXl
	 0W/9QjlqeuIw48jNhw0Llm0Wv+IrGvZqhxgRAyNaAXG1sFEsx6et94lNwQyq04p3Xq
	 bigEi2130Lf6lmfIcxW6ebRyKenV72+H/GF3x1KWTWg2cxFoRVsYix6cmaPGNW8ADH
	 VbwlzWDj0/8jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD543806655;
	Sun, 22 Sep 2024 13:35:20 +0000 (UTC)
From: Thomas Haschka via Bugspray Bot <bugbot@kernel.org>
Date: Sun, 22 Sep 2024 13:35:12 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20240922-b218821c5-3e174e22b99f@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Thomas Haschka added an attachment on Kernel.org Bugzilla:

Created attachment 306908
kernel config with working mmc driver as of kernel 6.5.5

File: 6.5.5-config (text/plain)
Size: 161.60 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=306908
---
kernel config with working mmc driver as of kernel 6.5.5

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

