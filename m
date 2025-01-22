Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C51187553
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560684; cv=none; b=FmozdXp9L1qMNcp+BcZ2FEAunA9uPPgr59HWzMuzpPdVEZUwIPldNBhLKYhl5I4dGc4ffSxg9uhnLKwwulYLjKwJJYrNpx2sZ9ogexTkPxzvAdOok5NInF+KNOQ5G8OiZTM3Cql/0GKwmUvfUHW17LtkOh106X9fH3xWG7n2w94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560684; c=relaxed/simple;
	bh=7bcpFOrkO6AyD8k7AMdo1z7XqbQcdBqvXwgZoGw/xq0=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=tYxMUgn0OBLrXcL3AYb8V0BzuMygKfc1GOYS3WNWUiyt4r6rw82uiowFITqVe711RDNsPQ7jySlJNQi/vzFZtmfG+qqjVtTvTIsKcGGaeQ5JepXhsiQwe+jDFg5OmtBxNaDHsP1YADb0t92QYordxIpiU/5VFrivEy4oa1TOxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSKsMBqf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSKsMBqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E76C4CED3;
	Wed, 22 Jan 2025 15:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560684;
	bh=7bcpFOrkO6AyD8k7AMdo1z7XqbQcdBqvXwgZoGw/xq0=;
	h=From:Date:To:Subject:From;
	b=lSKsMBqfqeIXpQFHS2ZjO5pPYC4IoyIVIbpKyAmRc/HeehPqk5p4eDZ3FaMkPYPJK
	 rocvap+gsPvDXrukzCYQA8JnZ8FF/xUrsqdFMOTpupe4fTL8p1lrgXQG8yvuEkkYm0
	 MTmRPAAbFQwXdOnXtdDwes6dEz2u4X9HgcaXwyBSKNRjcehSe4isxr9RvAN4lq0r11
	 wk2z27nozCaLWhO3UxNTF9HpRHf0ugsY75WJkp0jdGXrnO9TiUbt34K6tioN2OrxfU
	 e3qoPQ6++hAM2CJTwN7Hxh5iZt8YbUQVO+6y2l4K4LXpf31tnqT5YDojhiKSE9Ri9p
	 2GtbmngkynzcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B39AC380AA62;
	Wed, 22 Jan 2025 15:45:09 +0000 (UTC)
From: josiahspore via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:06 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

josiahspore writes via Kernel.org Bugzilla:

Intel NUC NUC6CAYB's card reader acts is not detected after Linux 5.0.x. Everything is currently working just fine on 5.0.21 but I can't use anything higher because my system is installed on a sdcard. Anything higher than 5.0 causes my system to hang on finding root.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

