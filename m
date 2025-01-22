Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5B7211288
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560717; cv=none; b=hGfpjvdd6DQ7gnbh5dssWR587of9qWvm0ZKM6raQRCHa331AFF0Ttav8nkvE4Y+7kXlt8y5ZKX7bRjlItMuFfiRc3G2oxg0RX7rqRqFPisnOP4dfr0cvoHEbNo87ZeKOQwDSo+G7t/CdPs4wsf+Caq1OaR7Rk+Hw1n+/2Djsvu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560717; c=relaxed/simple;
	bh=HJ4kkNPRinOK4HLje3gMG70Zu8vHO824v77F6BreM8Q=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=XSBzo6jgLxyxjpxMuu7EKIulLeJ4VIAYX81BXXPx+W6avIVp+4H5AVzyJ9Rir1DDxYGX1A2bzdU6/RxkAPpcPjkr0cNSqf+Q+mDbTnBJPClBEm0ejukkDhq44iNzSK2RSbxfpSzmKuEjnj5b9Xk00oKM56lN99sXr6Tgpd6iRnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bwgbm45Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bwgbm45Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012FDC4CED2;
	Wed, 22 Jan 2025 15:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560717;
	bh=HJ4kkNPRinOK4HLje3gMG70Zu8vHO824v77F6BreM8Q=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=Bwgbm45QebBanqqlA9eqk/K6Uljvs/MEnerKOUGyUvsaCC/AWyq7S8VeegiVwPUZw
	 BU9oSvN02FR6/AtmEMer6GWGbt8Vid2fvLrii5CkqmRZsyQsab+U34HYecWuyWXV/B
	 ITRuL4+24LlcgZpZRRDtoCAL/oUjZEVayo4Nhusuwc3WtkB+QU+32LPW8FJ+JDnnqm
	 Cbna1ozDe/KyEYUyFkRsfLlSzMIWL4kvpSaBp8baoMJyqnB1qw9J1HISyd1Gjxa4AU
	 4cqJVSr5S0L6JmI4z/AErvmsH/Z8aFTwSbw3bYreV7YCRXPh1YrwfawWgygGJUz0o9
	 3ZUFS7xjnwK1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEC0D380AA62;
	Wed, 22 Jan 2025 15:45:42 +0000 (UTC)
From: Chris Clayton via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:22 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c16-9c24bb3803a9@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Chris Clayton writes via Kernel.org Bugzilla:

Following on from comment 15, I've patched and tested 5.4.44 (which Ubuntu's latest kernel seems to be based on) and the card reader works fine.

Despite saying that I could take this no further, I did push on a little further and I've isolated the code that causes the rts5229 to no longer work since bede03a579b3 was applied. I've also reported the bug to LKML - see https://marc.info/?l=linux-kernel&m=159639774221968

Since reverting bede03a579b3 on recent kernels needs manual intervention, I've devised a simple patch (against linux-5.7.12). It applies correctly to 5.8.0 too but with offsets. If it doesn't apply properly on other kernels  between 5.1-rc1 and 5.7.12, it is simple enough to apply manually.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c16
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

