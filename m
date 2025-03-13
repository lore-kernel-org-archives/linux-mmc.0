Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005B5265CD2
	for <linux-mmc@vger.kernel.org>; Thu, 13 Mar 2025 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863876; cv=none; b=AgjQA7UxmufjX33kDQ0vwyZ99wL6x/l2wdsJoZ3kd99TzHxPfa4KFtdDq0qpswJswqem31Awi1nHLj2vK4Rs5pmWTpe/iAktgIL/mjH/JqhVz3UeMc6cvUkctEBMMtM4HiI1C3XrzXyPYHYnsRT8Ir6FftPIQ1OU36QHDpHFVqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863876; c=relaxed/simple;
	bh=sF/5DOUCTZPLMTZuBfHrpj59GjjaTW8J2BYWWIDl/0s=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=rp0apLygWGJXw6w38EoDGlcFynGFeZUSGWpqQOs/PlA7rMo4DiAqL4rsxgBaeH3Lvmx9dBm8MW/PKMjgfN/Noj5jzzgqmBJWV3dFIgb8tXdgkPczK+7Ry+InI7xN2H/K7cvi7dQ967RCK6UCgxJGnfjsqxHXiC2xXn57ohhWFvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrSySxMX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrSySxMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF19C4CEDD;
	Thu, 13 Mar 2025 11:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741863875;
	bh=sF/5DOUCTZPLMTZuBfHrpj59GjjaTW8J2BYWWIDl/0s=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=XrSySxMXp/+vbcXVWbBIP7WRMikqgMBZEysiW1QszfXmQzvUXQDHKWZo5hekJ+/XN
	 LP8SuEmhaKvyTyfgumKQX8i7kx4yi0KqLKwQr0c7+khj1ZU5R4jrja6C+qp4tKaS1L
	 bVnWtbfNzn8PnFDZifXO5ljr1rxIv0arAS4TZEYzAHHSSkZN4M8mpQKSKgLn2gxYL9
	 LxqDvXAMhrDJcH5uISqmWYH3LRmDOygK7Q0Q61djz6PcSKO+AT5MpP1wzZ+N0ox8SX
	 ZGOKJYintKtZCXwBy5nwvzXbY8v/4IZJwEbtOMz5GN40rm9P8cJgspWCngXQeWpD1y
	 NFv4zLZY3cg/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E323806651;
	Thu, 13 Mar 2025 11:05:11 +0000 (UTC)
From: Thomas Haschka via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 13 Mar 2025 11:05:21 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: thomas.haschka@tuwien.ac.at, adrian.hunter@intel.com, 
 ulf.hansson@linaro.org, ricky_wu@realtek.com, linux-mmc@vger.kernel.org
Message-ID: <20250313-b218821c17-c3328a4529f6@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Thomas Haschka added an attachment on Kernel.org Bugzilla:

Created attachment 307814
Patch to remove MMC_CAP_AGGRESSIVE_PM ( does not fix the problem )

File: remove_mmc_cap_aggressive_pm.patch (text/plain)
Size: 583.00 B
Link: https://bugzilla.kernel.org/attachment.cgi?id=307814
---
Patch to remove MMC_CAP_AGGRESSIVE_PM ( does not fix the problem )

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

