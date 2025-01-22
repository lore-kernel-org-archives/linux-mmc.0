Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87421480C
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560702; cv=none; b=HFB4Wv7zSPrIQZFal+uR1qI3876KFFO6Bm8hbsTNOjobbVovH7UN9sRzIzrWDyMgshF6366jybE8fEMNO4gRdZCOiibQgRSZMKDAH6TMg0xZxQ0tc+5d0b/6/71MoFpXF6X/O8nISJfDKGndmoczZLhjLazM6+kGgaFoSFUhNFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560702; c=relaxed/simple;
	bh=q/z7kOzONeEthRSRCFavfA/oyOet2Qv2xtVKv64O6f4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=Nv5aaxZP8DfKfk7nMeqpxFs7RG7T4jtoRGVln8O2HcHxMbB4g5NI5avXraHqWH8BpXmSn29TwdoAlc7+incp6568c75MwbbJ25SoFj6fkla05JtURwTo4p0TADTTnQzYQMO6wtjb5NCyVeZpfd16/OPkYcrFjSq/+Llpohc3KzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3A7f8Mt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3A7f8Mt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45502C4CED2;
	Wed, 22 Jan 2025 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560702;
	bh=q/z7kOzONeEthRSRCFavfA/oyOet2Qv2xtVKv64O6f4=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=T3A7f8MtAnCKxxUWRqBGbheatO4Oq6o3suQOpX9FkbAC9Ftu+kTtFQ+2YQOVHlQWc
	 NEzOnkwUaMg8BNP4OsY9eJ2hyX3fne5e+COgqGknc0d1x5/R+EM+Va69Ue8wFHXrAd
	 P9rYcwef2Nzdhfk7gliDDRKoC6dXXoGJYm3BVb9L34RHYxGqxEbc+1mE8clh5hv/di
	 YKFxaurFZUjI9vG2D27gS6BUnj1XzlUpHrksSzbc1KDlJ56O28QmdCyaLpgwj2DqoC
	 JgXCYLuCSRsE++PR/Up209nPSCJ7ZxX/Cqkt/Fw/iUfxZSBDMUqqA0SNmf6pBk5rZv
	 I6IY2nZPHFXYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2C7380AA62;
	Wed, 22 Jan 2025 15:45:27 +0000 (UTC)
From: David Lindstrom via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:14 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c8-2b3e3f4a742c@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

David Lindstrom added an attachment on Kernel.org Bugzilla:

Created attachment 283931
MMC trace on SD card insertion, kernel 5.0.13

SD card is detected correctly on kernel 5.0.13
Obtained using:

echo 1 >  /sys/kernel/debug/tracing/events/mmc/enable 
cat /sys/kernel/debug/tracing/trace_pipe > mmc_trace.txt

File: mmc_trace-kernel-5.0.13.txt (text/plain)
Size: 129.50 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=283931
---
MMC trace on SD card insertion, kernel 5.0.13

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

