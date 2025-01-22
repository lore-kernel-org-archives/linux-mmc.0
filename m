Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419FD2147F3
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560705; cv=none; b=RwiqlCDcsEFemeAVxJLFrzB3AmLfdDtDl/5kQydXM3vBLDjN0/8VRD5flXZzOHXRH2NpofOPTR9KA5MOxqaSlDYOV3jD7zc6GvLHB7DyQ7Ez0AqLJLR6qwME2I6RbUevEdDOLxaf1HDuvowrKfAK+yZ0xv0Metx5g7WJyIVF73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560705; c=relaxed/simple;
	bh=S1b2hVJTSaYZhwwo25V6ai8MKbPMX3txYzI8ejwF6r0=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=ku/XWuulBXpxd7T50dsXL7wJ2hhDV91pG3irOEUgO5S1pWexoriNbuvl8XV/4scXVsONQFGxoru+utilcq58WHBIWz+/+xf/+rN8YN7jws2CG+WTSIQ6eoPhIxEn0nzF3HLDO4spdl5QEKFzsZ58Ir6/jnBVfcVfEiysAk8rY0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMEQXSps; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMEQXSps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5E7C4CED2;
	Wed, 22 Jan 2025 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560704;
	bh=S1b2hVJTSaYZhwwo25V6ai8MKbPMX3txYzI8ejwF6r0=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=mMEQXSpslJpWQkpx4zjOouz47/tZP0PbmXUnYluRwU9yKOl2QIDt4fcQatt1FKl0k
	 7INN7HXzR8QiMqeH0qxDTU/sZcNgfVBBSuXLYGp0tq08gs5hjNtWae61M64HCyx4MY
	 rahkigl2y9KQFgw8TGQZ2CoIiV2Pu/fLNDKogoHRsvjpuVnyDnvNQ3Utgh5JbxqUiw
	 Gnr/xOolM32Yw3zyJ32294rfR7bG9/ylM63i+LKQmxYgylyJVh+yfO141Y+BowRqyD
	 tZDpHwz/a1d+9tyEIFoYxPefGb4Ydmk3kGGaAtYyd8Rq93jGvoBFCMM1Jg9kOUSZ3g
	 +6pzK08d1uDeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712F7380AA62;
	Wed, 22 Jan 2025 15:45:30 +0000 (UTC)
From: David Lindstrom via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:15 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c9-79fb6d59c9dc@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

David Lindstrom added an attachment on Kernel.org Bugzilla:

Created attachment 283933
MMC trace on SD card insertion, kernel 5.2.2

SD card is not detected on kernel 5.2.2
Obtained using:

echo 1 >  /sys/kernel/debug/tracing/events/mmc/enable 
cat /sys/kernel/debug/tracing/trace_pipe > mmc_trace.txt

Mmc requests return cmd_err -110

File: mmc_trace-kernel-5.2.2 (text/plain)
Size: 32.22 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=283933
---
MMC trace on SD card insertion, kernel 5.2.2

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

