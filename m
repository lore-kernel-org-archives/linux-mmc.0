Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94818643
	for <linux-mmc@vger.kernel.org>; Mon, 30 Sep 2024 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700906; cv=none; b=bK2cpesXUPaf2XohB5YlmgR1SFrKzZq44pfYQd6OuGX2tpflBhC5TLjXz4/dayUsG2JPFiGXoo23dLhVdEhqjsBgvWOYGSqmbfGzxw7yqxyRwSOKvM4QvAlnRdrpMsyckIUfwk3vaqM0WtQH3XyMP5lAF1alNXDrfgA5gUb/V+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700906; c=relaxed/simple;
	bh=HkQ3jzjJF4CcRBDQCasLcnnUKURVkEsf+iTsxe+Lxl4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=kgkmaOGLBw/LyEv3OiRY2zfLQdnG7rgZT4KS2pC2K2bcy7sntxZ7q6zYtmBX8KrralybOkXwLxGnjo4ocWUhy2+0jSdh3DpDbhSRcwnuHZgHdsnUJePZAvgdgDxHp8iAWSGz859i8B8/zvohxf09yftXivQrZ/kH5ojdpoYG4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbPLkkY3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbPLkkY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E540FC4CEC7;
	Mon, 30 Sep 2024 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727700905;
	bh=HkQ3jzjJF4CcRBDQCasLcnnUKURVkEsf+iTsxe+Lxl4=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=pbPLkkY3Bo5iRCxx119KGUO/skZ9xprklP71NnArzRLQk9FzwPvsKLAwOgcXJJG3G
	 kePteYG8P6N0CaEXEB4F8TeX8bNayoEQLAe3IblTqIs7el9vMg5k+swS80Sa5S/8dI
	 tPSJ/laNu4pdhrotrGDt9DGjRT+zmj8Z3wnSeFxPhsKz8yL1GycM4B1zgaGMaaXTFk
	 VqW6akyrQbokkXk7EEQM3UhWRWczXhnY6+aCHAz4PbtLgCzk3UWnXagQiPG1bR7442
	 7zrkvH4MVci+Iqd69Oc6HIfEtu9Ym+OxZ0VKHxzVYXCJMq3rEJAHuS8QzGWfiGF5X4
	 lyIJmvebpSt8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EED983804CB9;
	Mon, 30 Sep 2024 12:55:09 +0000 (UTC)
From: Georg Gottleuber via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 30 Sep 2024 12:55:07 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Message-ID: <20240930-b219284c3-4b860e70294f@bugzilla.kernel.org>
In-Reply-To: <20240918-b219284c0-db72da0a4ac7@bugzilla.kernel.org>
References: <20240918-b219284c0-db72da0a4ac7@bugzilla.kernel.org>
Subject: Re: sdhci_pci module is blocking low power s0ix sleep with GL9767
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Georg Gottleuber writes via Kernel.org Bugzilla:

In an AMD device (InfinityBook Pro 14 Gen9 AMD), however, the same card 
reader sleeps without any problems.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219284#c3
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

