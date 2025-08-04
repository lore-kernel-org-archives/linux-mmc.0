Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3120D15C0
	for <linux-mmc@vger.kernel.org>; Mon,  4 Aug 2025 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309093; cv=none; b=UJJZ+INuKwVMCZbSuoN6Az3Df0PAhhZCAXisP7XcwcVkW3Z6CUs/9zzn5pAaGLpU+60HJfMbu54D9apSRzfdaQCW9Pqm6TjaQJ5sVfmhmijFEwMLMx5SArFSAnIjbGX/8WOhqzneQrEJywnIiMr1J8VL85KnZbl67z9+cJ8EOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309093; c=relaxed/simple;
	bh=EH82wbDnXBopYLgiEcTS6k379QkXKVAWzqXjULcmC6E=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=QB+xWDkGCyK8Vps7V01/eWfIbnldC+3fDTRD40tcuGggkMOaFugTRQ6vHQ2j/ZMa5j0Z4/SY1LbmXuD9M8L8Mpsa+jKP//924EvG1f7JNdvK1OewkKDCvFwp9dbjrQC8N6z6LuJrM9pXqUw+HS1Jokr7TV7eyMtYy72GQsfHoJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRl+/Dmp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRl+/Dmp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A884BC4CEE7;
	Mon,  4 Aug 2025 12:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754309092;
	bh=EH82wbDnXBopYLgiEcTS6k379QkXKVAWzqXjULcmC6E=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=BRl+/DmpuT0iEr9Gk0H5KokM5iMCV8/hg8Fqo+1brngJEMy2tC6vuxqoj/w4njjRJ
	 +0sO1wMmMkM+7txnKJxmgUqPGuY7tmec2x0lW8G9bOdJs+fPYw9v07sh/f3SdmNvEu
	 nG//na+7j3ChiqKHd0SWNSN2Q9s/EJNeIyWVcF3kl1p68Tzc1L6/EDMNNvpeRFNZBp
	 avnZurn18MBuskjZe6QGa9MjhioHSapPMP2PEYkxKk4l5Iu8tkJfolNQ2e82U6v9fl
	 rgIHbhRsXbJhmONJSZhQm8bsCT5AUbVSEx/Dh6HfieoOLP749hqUbgdXZR4YDVavpM
	 U37si0mxcn9Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37C8F383BF56;
	Mon,  4 Aug 2025 12:05:08 +0000 (UTC)
From: Laurent Bigonville via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 04 Aug 2025 12:05:10 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ulf.hansson@linaro.org, ricky_wu@realtek.com, linux-mmc@vger.kernel.org
Message-ID: <20250804-b220362c6-18137771fd5a@bugzilla.kernel.org>
In-Reply-To: <20250723-b220362c0-fd0fdb0c86b1@bugzilla.kernel.org>
References: <20250723-b220362c0-fd0fdb0c86b1@bugzilla.kernel.org>
Subject: Re: rtsx_pci driver is blocking s2idle
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Laurent Bigonville writes via Kernel.org Bugzilla:

Please note that I got confused and that the rtsx_pci(_sdmmc) modules were blacklisted.

If the modules are properly loaded, the reader doesn't seem to cause the s0ix-selftest-tool -s script to report an issue with the reader.

With "s0ix-selftest-tool -r on" it complains about the link state of the SSD drive

So maybe this bug is invalid? Or there is another issue at PCI level?

View: https://bugzilla.kernel.org/show_bug.cgi?id=220362#c6
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

