Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB272ECEA3
	for <linux-mmc@vger.kernel.org>; Wed, 23 Jul 2025 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276194; cv=none; b=r30dLwJSLYget6KWdhvQ7ZpljnDgD9Lt3zZtLIqnAEQ2qZRU5VxU/kLW8nvaGUVNcUvmbYsozLD5SFb5e2+KmdtJhILOgwM8LmI9v1cfTHBfATqSAwYAQ70+mMK5Rhp1Dm7J0+JSTzmKcp8uKclz/lg0iQlNXRXtb6kpR0OeXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276194; c=relaxed/simple;
	bh=30pQxWrivU6iwu2TxmH1TpxkiY1FklzC5f3O46L4IAM=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=Y6wY3aCSBDCE6M0U1VhLdSYgF5pjdhJvEX5LuhXPW2fXTo0Ey/uj93OJF/qtciH8qgFriZ6HsTktT2H9nEddH0NhuDV3si5aYfogYd6tRLENM9qsdEsm74ORGHj8SmUw5KJgSyzlJW1E56OwAYmfIc2w2pav5rKqHkCs3XTvOuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3KSYwZB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3KSYwZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E35DC4CEE7;
	Wed, 23 Jul 2025 13:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753276193;
	bh=30pQxWrivU6iwu2TxmH1TpxkiY1FklzC5f3O46L4IAM=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=K3KSYwZBMfCAWameSldW6zW6Xs5rXJXUwZE0LByNnxO0ZypkcbNEhprwIz9A7pMg+
	 ooCx32s2BuVMkeBJoImTeTsiTtCC1llf6dR44sDhieVWE4WdWMX+MiB9CGheXYbMNv
	 bmNWnw6aB+btzkq8HA7EbkYkpAb/QTSIpRLWMfHaf1L9R3cs/7E1ZTZOz9r88zwmRy
	 pTDKaJ0CLmAcKiuPHfsrm5puiZYCkDZ69wUwyYLcexmLNYrqmZcNFGlxV80zGYg+8t
	 DtQp24L0m1ngDiu5LBcPv4+3jPxlvLVVzeyGfWJ3XWq7A9Q89paHl4kguudDGtVhMP
	 Dg2wvi+ePutBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 75849383BF4E;
	Wed, 23 Jul 2025 13:10:12 +0000 (UTC)
From: Laurent Bigonville via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 23 Jul 2025 13:10:06 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250723-b220362c1-b84f7fd893f8@bugzilla.kernel.org>
In-Reply-To: <20250723-b220362c0-fd0fdb0c86b1@bugzilla.kernel.org>
References: <20250723-b220362c0-fd0fdb0c86b1@bugzilla.kernel.org>
Subject: Re: rtsx_pci driver is blocking s2idle
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Laurent Bigonville added an attachment on Kernel.org Bugzilla:

Created attachment 308405
s0ix-selftest-tool -r output

File: 20250722-16-30-s0ix-output.log (text/plain)
Size: 7.66 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=308405
---
s0ix-selftest-tool -r output

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

