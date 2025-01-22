Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E534211288
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560716; cv=none; b=H+vpCvGmvecDctzZhfg1mq1QwQNOXoyZhwHe35n9HlXT3TorNmFAInJNhX1+Un6qvfCsDCusRExUAiIQJPmGKQLHzFtU+Z6fvXXRThIlSlh3bO912PpiNgXFuUB3674mbOKIffgkh8uC1rd2eT7Yns5HRWFMi3Xn/NPjIYwQFEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560716; c=relaxed/simple;
	bh=Cn+MM52ZLVdzlOnGtcKhpkIPYMn6VNz6IS9bCQVxftA=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=NQTgYm8mL031B0arxllYY2KAvkUE8qbCSaLB5ApK4o6WkO4o9tBQLdt3ChR2epIO4XQECd/vxMzMHQkzZwgu0aIUTGRY9lexQBy8u1nIB7+UzVlDEfucufY22HNcopowque25SYAURWznLEtjPWpnyf/HaZ88+P3UQhPKU7vEZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0nRgZ8j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0nRgZ8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D16AC4CED2;
	Wed, 22 Jan 2025 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560715;
	bh=Cn+MM52ZLVdzlOnGtcKhpkIPYMn6VNz6IS9bCQVxftA=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=H0nRgZ8jIfeP14DS3rUgg4deI6vmIMnkoNi91oxuHU1RGnu6fFggY5P8tXMlCkPPV
	 Xg+r3VWTjFCczp1aj5sdoHs6LcsD/spTJ73djShlbxCNVBsa2aJSM7Lv/xpa6j8H4r
	 Iw0gLzCOc0tg7rMzExDEeh6tYcmZQbzMf2Xm+yf3guLXOk6v3d8iCSk26hqLQQewUJ
	 e0mcDkKxClkQW6YHYPC0jBkQ1z23sIpZv5lAzmJRspSYjPRtGfJDFn60nBMuFWi67a
	 JBAhNbMxLS1BDtnRskBcjUG1K/M9ZxPq+yWShGMvU4aeJl87xrebACR4JPO5UVQTe6
	 PuQaxBkPM6sRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DA0380AA62;
	Wed, 22 Jan 2025 15:45:41 +0000 (UTC)
From: Chris Clayton via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:21 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c15-4a4081654d77@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Chris Clayton writes via Kernel.org Bugzilla:

I've done more investigating of this regression and I've narrowed it down to rtsx_pci_init_ocp() in drivers/misc/cardreader/rtsx_pcr.c. It is called by rtsx_pci_init_hw() (from the same source file. If a comment out that call, build and install the resultant kernel, the rts5229 reader and the card inserted in are detected and work fine. The machine is an Intel NUC Tall Arches Canyon NUC6CAYH Celeron J3455. I can't take this diagnosis any further because, as far as I can see, the only change the patch identified as the culprit (see comment 10 above) makes to rtsx_pci_init_ocp(), shouldn't be executed for the rts5229. So far, I've built and installed 5.7.12 and 5.4.54 the latter of which I am currently running on the machine. I think I tried an unpatched 5.7 series kernel earlier in my investagations and the card reader did not work. To be sure, I'll build an older 5.4 kernel that more closely matches the one currently included in Ubuntu 20.04, and check whether that works when rtsx_pc
 i_init_ocp() is not called.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c15
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

