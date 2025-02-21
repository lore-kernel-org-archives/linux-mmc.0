Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C8D125B9
	for <linux-mmc@vger.kernel.org>; Fri, 21 Feb 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149978; cv=none; b=izWrnNNy5GgGa/2MlDE/gp4Meduw/Bvp8TNV6FXYZDzpbgwiGUB82qwlygn/mFky6kzRqSL8MHb9icNshaYOISTkE9f6u7GEHh73PZc4SiwgDFUZ6r9ELGk0wzhbCRjZugvBfLwWFyvUX4yu1LYamZ++ZsrGong5XgPY2e5zEiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149978; c=relaxed/simple;
	bh=Gq9Hs2xHxpBFKJwxgECqUDFaTTpG0OjXw449N9iIKEU=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=ean9EPPJR77pmUfDJYfHREEkN1WlYVtXdKZkgiU+G/wgcT47qTlDNHOOBUHLujdBrSJMGvvZbT/GUKgxLKZrYpcX1DLhv/phSMhLDNbAeJQJ6CQ+9gXLdRRSpqlkAz36RWuzx2+P6Vqz2N2+QXUi6ZaM3oMd7IjcIy8eJohili4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNukWH1i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNukWH1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC274C4CEE2;
	Fri, 21 Feb 2025 14:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740149977;
	bh=Gq9Hs2xHxpBFKJwxgECqUDFaTTpG0OjXw449N9iIKEU=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=cNukWH1ide7U6eF1bS3+4lvZ86sYKP+k7YujIPKZpUhldGsi9wMYKHgQ1SIoXwW4I
	 /1oKKK7lew4VG57rmFjXJJb3eMzWBddT9JMOp3Zq/GOmbm2z4y4DZKwJmNM7DCHzyQ
	 IInQJq167BdCcC2wsv/sSfbUmBc3HBKTlHQNntv96M0LbuDV9Xo/jJ6xpju4icc41P
	 U6tePsGK045Aud5SxAxnzAFHsio70YwQRUIitI7x5L0Ub01SkHQ0Sw2vWWncMpeZ6r
	 rwJtdBU4FJiuLiTprcxWDo1/orDGRPZblGol24S4jRcEfpC1LzM9L4Om+mbcDb7tg2
	 LZUqa1nhmG4FA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2CFF380CEEE;
	Fri, 21 Feb 2025 15:00:09 +0000 (UTC)
From: Thomas Haschka via Bugspray Bot <bugbot@kernel.org>
Date: Fri, 21 Feb 2025 15:00:17 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ricky_wu@realtek.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Message-ID: <20250221-b218821c13-3c567aeaaf1f@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Thomas Haschka added an attachment on Kernel.org Bugzilla:

Created attachment 307693
Patch for 6.12.16 which solves the problem on the surface go 2

By reversing the bisected commit it was possible to me to build this patch for the current 6.12.16 kernel which yields stable sd card operation on the 
surface go 2.

File: surface_go_cardreader_patch.patch (text/plain)
Size: 2.74 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307693
---
Patch for 6.12.16 which solves the problem on the surface go 2

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

