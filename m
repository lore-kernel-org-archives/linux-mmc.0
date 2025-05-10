Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798081EA7C2
	for <linux-mmc@vger.kernel.org>; Sat, 10 May 2025 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746868171; cv=none; b=AuRXsVU0EDqea69Yr8ba+bzfNGkvaoG+/r5vLNdPyj6eSG0YfrXbGGNEQuHACZXK4Q1nVL5WAHB1wm9n15TuG3aFia9vnRd8kxgtVFVvcMaxchUBTrcXIY6Rwc4J/iiGBsn/beFpGK0eY0+Gc0lEP3C5W8CIXJnewmhKmVK9t4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746868171; c=relaxed/simple;
	bh=iX5WY7QhurZerew0l6rrLEebye5VDk5sLPa1xbPtq4g=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=rNd0LEQBkQq070e6xbNekplo4TQQ7eo+a8AzdRep5UugfSSxayS9pcHB1/a3jWnOE3T65ONTWMRHCJkdQRKawNJKlOe3mAB/oe1NSAqgpMAD89dRBydVBKD2pzqQz5Kczj0+6DQOqS3Izj9fDqwcVbHv9YZBZB9Aw9gFKmrY794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkkq/zlV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkkq/zlV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4714C4CEE2;
	Sat, 10 May 2025 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746868170;
	bh=iX5WY7QhurZerew0l6rrLEebye5VDk5sLPa1xbPtq4g=;
	h=From:Date:To:Subject:From;
	b=bkkq/zlVhzKfDb/XGW+h3ZaBR3apZzVRYkCsdB3vEe3whMLm/80NqPqZIrQemJq68
	 lbU5FLDA3X+V4WaTUdZp1Js9IUv+d9jAVUCldZv4wAye1gudkexUD9tgZ1iGHHYCvN
	 RlJOn0SBVSXj/XiEQMLEqj0PjA8kb0o06WbZ8p84ZnoHYDymVXwvZNKbGX36lonot4
	 IOD7hUgAHb5PyF2Lvgs4u+RwlXKfqkDp7ZGD8s4e4MbXC7E0CKdw+397Wp7tEFEviS
	 mUOeY6N1Xr34Gc3dnac5etLkuJ7Xg8x04lTNV+ZQaGlKED3NT6OBKoi2MC5O74t8td
	 36RrxUALJ+t3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3808D3822D42;
	Sat, 10 May 2025 09:10:10 +0000 (UTC)
From: raoul via Bugspray Bot <bugbot@kernel.org>
Date: Sat, 10 May 2025 09:10:06 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250510-b220103c0-216fec070bba@bugzilla.kernel.org>
Subject: UHS2 init fail
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

raoul writes via Kernel.org Bugzilla:

Hello,

I have a PCSpecialist notebook with SD/MMC card reader. When I insert my SD card I can browse it in Gnome, but I see the following errors in dmesg:

mmc0: SDHCI_UHS2_CAPS_PTR(65535) is wrong.
mmc0: UHS2 init fail.
mmc0: failed to initial phy for UHS-II!
mmc0: SDHCI_UHS2_CAPS_PTR(65535) is wrong.
mmc0: UHS2 init fail.
mmc0: failed to initial phy for UHS-II!
mmc0: new UHS-I speed SDR104 SDXC card at address 59b4
mmcblk0: mmc0:59b4 ED2S5 119 GiB
mmcblk0: p1

The device:

Class: 0805 SD Host Controller
Vendor: 17a0 Genesys Logic
Device: 9767 GL9767 SD Host Controller
Svendor: 1d05 AIstone GLobal
SDEvice: 5006 unknown
Revision: 03

Thanks

View: https://bugzilla.kernel.org/show_bug.cgi?id=220103#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

