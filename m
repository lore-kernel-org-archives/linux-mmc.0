Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64751211288
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560719; cv=none; b=YBMiahlFYs+yrZ1GD74PNWbZ6dh3VhmDAxGqgUNLmtV5YmnXer2z3hGLltFDasixOFzrr/jm8dj0SxtB9KapXn103ihxXp47ya0Onlnho9gpl6bgtqh1l1frcgAN0GXy6RKW4SIRF2xV2ewnRaLlaUerYXNY7L8hh/PhDIAPRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560719; c=relaxed/simple;
	bh=1HwJUNP8rpXyMvVOEK+8z7EmP2XfdMK9wyX48gkosMc=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=PtrAQKocU42Bl9spDXgGa9yqYl5OXbUdUM9TqfJfugbLbikgZLEbyOgBU7b5vrKnwWJIZDMAsKaQhIHFCVpP318e3ldmOpLgSOs+cQJ7XQon9IcwjD19v9h9exTip5sZOafsE3VmNJ+rK6SHZlXQl59XkhzaIQkCxkAY5QqGuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYcDO4Tn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYcDO4Tn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475BCC4CED2;
	Wed, 22 Jan 2025 15:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560719;
	bh=1HwJUNP8rpXyMvVOEK+8z7EmP2XfdMK9wyX48gkosMc=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=fYcDO4TnQuVpROik/A6F0AThpL3M4SbX67XOnp99xMdKgcGVquymo0mhbHS8QN/R/
	 M0R7McyRuc75Zh0xzd0TUxc4Cch+HvP2Rd/7lH7voFmDHXkOdG/GukfOyRFsnD/19l
	 gCO509fxDSFr852XKMZUIaKBkvwUpUg2voQbW3eJnH83pkXUN5/qfz7qNtARuR1mQg
	 XvJjcs6Ud8nPw9/FwS+hJMZ1cJ2hGaYMiqpaVAThF+k0Thc9pfyFs6yNs1n2jQ8Go7
	 /rFm4ui92gsp38uMrPHwE2Kg8SSJJMr0b1s1tbu5Kx2PL4yGb7S202q9aQmDA93pa/
	 wcKJ9AcddGl/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF38380AA62;
	Wed, 22 Jan 2025 15:45:44 +0000 (UTC)
From: Yannis via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:23 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c17-96905a135ddf@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Yannis writes via Kernel.org Bugzilla:

I have tested the patch proposed in https://marc.info/?l=linux-kernel&m=159665699504104&w=2 on the Intel NUC7CJYH (RTS5529 is the onboard card reader) and I can now read/write on SD cards again.

This is under Ubuntu 20.04 with a standard Ubuntu 5.4.0-42-generic kernel.

Thank you for the fix Chris.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c17
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

