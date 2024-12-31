Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E731EEE6
	for <linux-mmc@vger.kernel.org>; Tue, 31 Dec 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735635891; cv=none; b=KzlFQF2ZynXXK/CTZCXAQf0kMgeIoJr2lcf93+IMjQvuLejNeuCpupdKQscECz/VRN6+3BlIDtULb+oA6vOYXxS+Pagcg1igp4P0NkOthvpm9yExHWDQavH2jgB7sLiqOIJ9ru/Y7lP6BxZH7vqXTyBhSrt8B2V1rneNKrs6W/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735635891; c=relaxed/simple;
	bh=UauPmC5Gi0g8se0ZcKiAoAHdb7ok5wGVYW4jyivYJBE=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=USnnxPsG4yeSpL0Crr7xv+Ry5mOnMaz2fqJao/PWaoRhfm2nbeElBv+N+d8ffT7sdYwrQg1HugqpauPj5bXzim0Uw5RE0WrQSRgnE8+gYEAFxURxf2iP2p2DwWGeGYAAsPyBGw7ckYZRgagDVDbK4E9ECm0vWTUg+9yDgBDyL7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiYB3TKF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiYB3TKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42CBC4CED6;
	Tue, 31 Dec 2024 09:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735635890;
	bh=UauPmC5Gi0g8se0ZcKiAoAHdb7ok5wGVYW4jyivYJBE=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=WiYB3TKF+ua4c0XnStyNJDQTRRahFRu1YElSQkbLQhxcTxIqHRfEQk+fCKapNc+HV
	 UrPE/K1obnHzT7ckRZbF+x+wNdvCfNb/svIoEIMW1XPTRdbRsqOb1A+d/hcQtGy0K+
	 yOJP0XTyjJh7YBIKk5wqskgPn/rn/tywHACX/7ob9lsCTKEAl0lmjY3A06Gv4/gWH4
	 Rn/8n9w5oG6PudnPjE/5pOlsOaPIrHNzw2HNEdkPvzdDMvkCF08Yal2KAVlAHMUsyg
	 FOEUb14CxQp4afic5/MPfBo6aK/PnECu3GbzNqHry0ay5vijsuWwtHLel4WB8LsBu4
	 fwGpMUX1HHS4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADD1380A964;
	Tue, 31 Dec 2024 09:05:11 +0000 (UTC)
From: Thomas Haschka via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 31 Dec 2024 09:05:14 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, ricky_wu@realtek.com
Message-ID: <20241231-b218821c10-42c93d6572ba@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Thomas Haschka added an attachment on Kernel.org Bugzilla:

Created attachment 307427
Patch to revert changes from commit 0e4cac557531 [ Does not solve the problem ]

File: my.patch (text/plain)
Size: 13.78 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307427
---
Patch to revert changes from commit 0e4cac557531 [ Does not solve the problem ]

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

