Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70102741C2;
	Tue, 29 Apr 2025 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966138; cv=none; b=V6+FpV76IK5YUO9zw1iBmkjtAJwZXMqtSmIMqNpDX/m+bwTNEs5yFSWDJO3a2eWCgnVTD6wzFHdyQ5bfrIUcKKvsSkGulzEJA6CYt4V8+3qpv4TH4pEshooS2Vi4XWnFXo61S4OOz20YcI0+ufz21+ULiGmem1BPVSWuCqSVQlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966138; c=relaxed/simple;
	bh=7INoI59PUXsAlHHobRmZkNritWE8r2tNEpUsf1Ziw7s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E1bODtVHfFvj2HJQfr02OLKChteGTJ96yP7B3ZvJbGb97NBWlw/+xrxtVUAyU2zg2D59ddG5uSwShKpOQ9A+dnpJsC5yKPOuT3B5SYNKyjTerG7egys4TwU005QxJCnrqeupQRhsXWM9ADNabR7SAS/ScP4aLpxIY4N7k76i8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzIkrCn1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzIkrCn1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDACDC4CEE3;
	Tue, 29 Apr 2025 22:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745966137;
	bh=7INoI59PUXsAlHHobRmZkNritWE8r2tNEpUsf1Ziw7s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IzIkrCn1LRCfBjaez821Fh5UmfgDofoPJPtS9sF6/01lvSPsDCzHV5tCeIceNDcSi
	 do4JFhdTXSunnAlENaIY17IuBdBGokDFqJBfMk+eL+9ZtxrWBaw8jQ6Pl2h+mHkUGb
	 Yclfq+3KYYTDcN3FSnrDy5dtAoozg2r2UjQxcI+7rWs6SyPifjIXN1CdYXplZUA1rM
	 pbbveVILYTKM3Mi+01vz1bexXwRnoBb0+UqddKAysEQ1SJVpbhoghmrSfabY5naOzp
	 kqz4oGWu00aEcvkpF9pGJC2Fiz1FFeSKM+ZGjxVCkE03t3k/JIwovFu5Al4G+DMaLv
	 cCf2a5rY+w8dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0E3822D4E;
	Tue, 29 Apr 2025 22:36:17 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.15-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250429204600.176542-1-ulf.hansson@linaro.org>
References: <20250429204600.176542-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250429204600.176542-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.15-rc1
X-PR-Tracked-Commit-Id: 77183db6b8dbd8c352816030b328dd55993dc330
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8bac8898fe398ffa3e09075ecea2be511725fb0b
Message-Id: <174596617647.1816670.16769745932031926746.pr-tracker-bot@kernel.org>
Date: Tue, 29 Apr 2025 22:36:16 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Apr 2025 22:46:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8bac8898fe398ffa3e09075ecea2be511725fb0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
