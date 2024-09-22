Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01611524C
	for <linux-mmc@vger.kernel.org>; Sun, 22 Sep 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727012120; cv=none; b=YPHah8G3Hyhsdxkw9lFCQ6EiOuod8Z7TorVEYwjx2eSyJKQnY19kTgXseI5tDuli4e7OorrwVxvYX/iJMFn1m09e0x4n2XKKPX3MrHPWS2pJ6AdqpcF9T6wP4r/8CsM0ThMxOYgxaK9uF9NMHWeVbyQcHfU+zCuEtb2dXhrLo/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727012120; c=relaxed/simple;
	bh=sg8GHlnU1NIs8DAaK0P/fOT3VcvmQi25XgZ2GnIrGkQ=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=Y9SD93dM/HAgRV25KpsHsCxBfoLZJHA1fWH4CCnVQzF+Gv6LLaXsJMnd3Iq2okKEHiyUi6TtX6P0UpgbMqnijrHvPvwdpcbE+1yTuyeqQ4iuB+GKz9gjlT6aDWhRviZvC8yIEXEM/44DOSJNNwV/f7X9d2RnJqT6lcxA2LYHT8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgOG+4H9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgOG+4H9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7949BC4CEC3;
	Sun, 22 Sep 2024 13:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727012119;
	bh=sg8GHlnU1NIs8DAaK0P/fOT3VcvmQi25XgZ2GnIrGkQ=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=fgOG+4H9JZFokWuEO6Xsv+OLSOmXzoGabJd2ksC3UmdL24J7/eWhhX8tfYaKwa/rB
	 2m17IyrU5pXJLkpBtwyZ8tHNoCHOcMfpzwFyhuHPwE7OcbUnVtcQsVzGAVrgP/3Hyq
	 5LdYl0feIBiy+kjmRHEeMdcttIWjnxWtqXdCm5AN+WBU5yAfwMs0CmrDSzxwk7afmq
	 lCCYA8ztSuMVh5HAHYvseZx/tSQ6O/4DUOvukwlD28KrqZkgUxlsGP2zBcjOski5bR
	 iJIS1Asgzsskju87AxlFW0yq761Mu4eGpwwTZaWsKsFATfFkkxhO49yAWQykVwdYA4
	 uPCX8HlUXLzpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1C43806655;
	Sun, 22 Sep 2024 13:35:22 +0000 (UTC)
From: Thomas Haschka via Bugspray Bot <bugbot@kernel.org>
Date: Sun, 22 Sep 2024 13:35:13 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20240922-b218821c6-a6dc79e2a03f@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Thomas Haschka added an attachment on Kernel.org Bugzilla:

Created attachment 306909
Kernel config with non-working mmc driver as of 6.6.52

File: 6.6.52-config (text/plain)
Size: 163.12 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=306909
---
Kernel config with non-working mmc driver as of 6.6.52

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

