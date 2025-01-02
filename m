Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F215C0
	for <linux-mmc@vger.kernel.org>; Thu,  2 Jan 2025 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735799389; cv=none; b=ONrbJ8WHVYEZQTeVR1X07xNJgkfZFp4yDPuKPhlVq6HdMh+A2dhSDrRb2uRTFzcJtvl8mwj2NfDfeIeGiTHjhLuKNcAPzluaB7Dn/BFSdRMF4O2LgZJyQvKNmvc+AX+qmd3psIAtlBHOjZvmQWc4dbuVLuqx2EcebwAG1A77kaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735799389; c=relaxed/simple;
	bh=MZLGYh4qp6Ypk/SiyArXk6uBCYV8bBy0sl/T92sYBGg=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=RsdxcXX0OGJ2CUul99b7LQJF2k0Zly8Zhar3+K8O6yubQTy7ZppgklwVsO0ksygx9HkQf7/08h0fW7g1bat1zqBIGWcHp9nFTs8q+jtiFTCKRsLDkragQwmJNubrDLwbPmBf89llCQq1wknpJ7C7ZuRTIxTlc4b03BfQaiWjJ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRrJHEaA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRrJHEaA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB49C4CED0;
	Thu,  2 Jan 2025 06:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735799388;
	bh=MZLGYh4qp6Ypk/SiyArXk6uBCYV8bBy0sl/T92sYBGg=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=kRrJHEaAAFzgRCfHqbzBE+gEnA5ty+0IGbHmBQy6WWHTYa9kP4mzbwRn5JkFdcxtY
	 cvc8+GTxtWjfhzqLFNAUtN1Sm7zqEJhOMYDb8yMs51op3KRLkVaBWKXYI214OqnyfE
	 ttZNWs0mNUowT0VB+9nJ4+bb3Z5oUvLkXXyDsda2bFBzJ6YqlzSjA328oB+LAB8O6u
	 8aCyW3Wix0VbuX2qabRViBrE7NabWhda88dpm79pHR4IjsZIndp+HAfHFORBiZINRo
	 uESKFH5TQUzlKrpo4eyOxK/NxGx0l9ZTfJ5vVlm7zv7qu+zcBR1I4vifltZUxoThRn
	 WTcvkgyX/gqIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3AE39380A965;
	Thu,  2 Jan 2025 06:30:10 +0000 (UTC)
From: Adrian Hunter via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 02 Jan 2025 06:30:15 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ulf.hansson@linaro.org, ricky_wu@realtek.com, linux-mmc@vger.kernel.org
Message-ID: <20250102-b218821c11-6cc397c1c8f8@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Adrian Hunter writes via Kernel.org Bugzilla:

I'd suggest trying to bisect as mentioned earlier

https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html

View: https://bugzilla.kernel.org/show_bug.cgi?id=218821#c11
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

