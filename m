Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB18632
	for <linux-mmc@vger.kernel.org>; Sun, 22 Sep 2024 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727012108; cv=none; b=RlLgR+r/hTin6NENotDFrjX9M/zBP8ovuuRnKRfDekbjlTvy6deRrgKEkTPOXWiIc2ZoBjEgCHn+BcG7H7ZyRvDOW0PFpKb8sYw7O8RHtWDeD+t/mSGF4TT6AT8wRn3JWA+VkwOgf2Xz0G9zkVTHhQHqB6wNXuK2Bb2lbPZuvew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727012108; c=relaxed/simple;
	bh=3oD6kOM93Nv1ENUbixHi0hzLX6iVTsJUHXIOvsHV00g=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=Imu6ZSzmQLmSx1LRyvNWmMx2JEaFblBwIWVhWvFp4P4zlVTpc957/ps8+rUx9cQ5psAx55FdPjOtgTZUcVinf3PHq8lYCqEfFynNIWZvwDDZNnfS7SwGplV5NrbaaPv4YzONYigTWAdlAR3g6/P8Jt85mAy1epBYCvTjE5Pt5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9wOa+M6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9wOa+M6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A58AC4CEC3;
	Sun, 22 Sep 2024 13:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727012108;
	bh=3oD6kOM93Nv1ENUbixHi0hzLX6iVTsJUHXIOvsHV00g=;
	h=From:Date:To:Subject:From;
	b=i9wOa+M6z+JpEnZkRzJLXHyjrftnPI8F0x5XIu+ZNNbyrC2NxuNL0W/SzoFicIPMH
	 jUPw5fqNmhhKqHHC6QbXowlG5IKC3HD/Xgswxuqx7g1UAGArp1xFkWYMa8u5MQiPmG
	 h/annn45tNVcggpTE0R0439KZCepxJZSbw4PNo4wA6eRY7bSjoORxT6evBTMi99g/I
	 MeP88ZrLywAkyz3g9dmWbDOhCrte462HAEEdMQ17SG3Bslsc0Z43EFEKeISMCT8ZVB
	 nyqyY/oOID/DMj3+xgcXAEu0hAQtVq5n0Aw3gvrV+JVKAgecDJe3oyk4g5HnwnidzL
	 xJCK4y87gZC+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78BFC3806655;
	Sun, 22 Sep 2024 13:35:11 +0000 (UTC)
From: Thomas Haschka via Bugspray Bot <bugbot@kernel.org>
Date: Sun, 22 Sep 2024 13:35:07 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
Subject: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Thomas Haschka writes via Kernel.org Bugzilla:

Updating from 6.5.5 to 6.8.9

makes my system frequently fail with the following error showing up in dmesg:

On 6.8.9:
mmc0: error -95 doing runtime resume

causing the filesystem on the card to stop, after several read writes.

reverting to 6.5.5 solves the issue

This seems to be due to modifications in
drivers/misc/cardreader the RTSX_PCI driver. 

The Microsoft Surface Go 2 card reader is detected as RTS522A

even on 6.5.5: 
mmc0: cannot verify signal voltage switch is common

View: https://bugzilla.kernel.org/show_bug.cgi?id=218821#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

