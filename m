Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0871D7E42
	for <linux-mmc@vger.kernel.org>; Sat, 22 Feb 2025 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740259478; cv=none; b=uiQj4iqvSMMktP72g7cIuE9DSQlB4tr8denWDM3YpywBA4ygjFf+EUVWUe/TTi3XgI+Gx1x6AdIrabnNOapfhNo9GPyqdeaYMQ3fRpOtjH7k7Dg1mQLk5yid3WCYq2kz6ysoVj8bbS4Jbr+O/siB/oq8dxefkJrpyIskD3kBzAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740259478; c=relaxed/simple;
	bh=B76EShr4rJtaIe6erD/SrFbyNi953ZnFW/JY3sXTTME=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=k9Co++W+VMyMAt+6x9UrY+YElqMgDxMlzPbOHPffc0eGcbDU2qI7jS8GdQw6F9KSU6dtDWfLVb+3GqVIynUbHxuYGReZmIg+mVJ+EOr3aKgfdmQhbeeCuDgW5gornFAvKqmep7EBzMTGlxG4PnpAjNF821GO2zr/Ai3goXGsCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyFE+zko; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyFE+zko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6055C4CED1;
	Sat, 22 Feb 2025 21:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740259477;
	bh=B76EShr4rJtaIe6erD/SrFbyNi953ZnFW/JY3sXTTME=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=AyFE+zkovSfL1+zyh3tGn5FbV48n1M6Rhl3NW4QwnuZsIOUyznHpWBgjLAE1NRGl1
	 oY2SFdZbYMCedZO/PZsjvQSiNqgHAWbroITyuimNcJ7TMal31WthFopmSZs+T+o9+C
	 a6ZWzG1kFsUaMKUzbVVrt0hseo4MAxuPmXHiCC5aJ82JNKcoSiuVEyd8EdLE/L77E9
	 UkKI/7k7zIN1/k5Ua6sanWmXfGGjnD4Do+v7njdJYCSv6VwoRVXy0ZxOR0pvOHyi5b
	 aGwbdEWiD9NH1HwiP0O6ApXNsFZf+NipWsln6ibNF5oN6yoTk/o7/KJQuMfiB9e5N/
	 IfQ+kDx68Rwvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF813380CEF9;
	Sat, 22 Feb 2025 21:25:09 +0000 (UTC)
From: Christian Heusel via Bugspray Bot <bugbot@kernel.org>
Date: Sat, 22 Feb 2025 21:25:05 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Message-ID: <20250222-b219781c1-0989818c2b6f@bugzilla.kernel.org>
In-Reply-To: <20250214-b219781c0-d1fa30f21bf1@bugzilla.kernel.org>
References: <20250214-b219781c0-d1fa30f21bf1@bugzilla.kernel.org>
Subject: Re: Realtek RTS5129 card reader: sdcard not recognized at boot
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Christian Heusel writes via Kernel.org Bugzilla:

I have now also reported this to the regressions lists aswell as the subsystem maintainers: https://lore.kernel.org/all/1de87dfa-1e81-45b7-8dcb-ad86c21d5352@heusel.eu/

View: https://bugzilla.kernel.org/show_bug.cgi?id=219781#c1
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

