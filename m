Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC72F2D
	for <linux-mmc@vger.kernel.org>; Sun, 22 Sep 2024 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727012112; cv=none; b=a+bunOPtrT5uGdnkBWGAgfW7SSBiPZd3+h9vVuotypD3D3yzrCU9YfMdVal7b1Kf87kQ2+mU6NihQkbcz3VrS6MjMY9pcfEepkJ4aPwTz4P8wgGQlWpbGQNozcaeWM6XXrtMrEsz+sGrc+OtwwFE2YeWYO3GMPJK7akaWIseqWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727012112; c=relaxed/simple;
	bh=SNKnD86ZK5yTWLMnxxk4uwA8S5gKdw+aJvZN/UAK84w=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=RE88008ZOrGE9UYMYTae7g1OOr60LEigjN6agtJOEIWfhQALbOP2NbWl/erIFKu4XngqN46j2CzdkhL91Gq89PVqpm+UW4gyYmVdx1y+MB3lZTp4LpPkJrq1H9opF6n/V8UB4T/hO3+lQ03/MK9IAAV/aKVMdKf2c5xrP1SHkMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6JhuCov; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6JhuCov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1708C4CEC3;
	Sun, 22 Sep 2024 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727012112;
	bh=SNKnD86ZK5yTWLMnxxk4uwA8S5gKdw+aJvZN/UAK84w=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=k6JhuCovc/2rSI2rY0wfYl/jlznZPJZqD77AgFleqvzOGfGNogtmbFkAQ3CugHsXU
	 I3KV5I2evD4zEwJGlH9Pdn2t+4Eo3iWH8g92uX4DDsmngcQrGQnh7EwfQgvrrf2ftF
	 UmhOSX77R81jRdytm+eslCaPWb8e2EY1RXfqnq5CxKRCm3Ih8KSsxzxkTnaSRgltcn
	 0fR2ogNjDAE93TYJlbY56eorjzeI76jmkMkPezDEYTrN+BLGTdZe3bEb02dL1y6z9E
	 XczT4JQVgOL5BovNESvG1XZnNr0TI3RIsesYuilBqIkN7uK6MMvullDVaNVGV0U7Lz
	 k3i9xEqqoIBAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E1D3806655;
	Sun, 22 Sep 2024 13:35:15 +0000 (UTC)
From: "The Linux kernel's regression tracker (Thorsten Leemhuis) via Bugspray Bot" <bugbot@kernel.org>
Date: Sun, 22 Sep 2024 13:35:09 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20240922-b218821c2-68415fc8fafb@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c1-3bdb282803d1@bugzilla.kernel.org>
References: <20240922-b218821c1-3bdb282803d1@bugzilla.kernel.org>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

The Linux kernel's regression tracker (Thorsten Leemhuis) writes via Kernel.org Bugzilla:

(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from comment #1)
> What does "makes my system frequently fail" exactly mean? Fail to boot?

Ignore that, I had missed the "causing the filesystem on the card to stop, after several read writes."

View: https://bugzilla.kernel.org/show_bug.cgi?id=218821#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

