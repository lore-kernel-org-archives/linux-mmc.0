Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F10187553
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560694; cv=none; b=VN6JYQzPe/0nHQf1rHcjGN2ceSjghwW6TRlKB9ss7yCv3JVHZrIllP+N9lvrPTUhOjcBiblEYpVJ0GHqRMkPJOUAytNsjtxHQjZjo4zddqMZqNbpg0gv2jHjccvbD0hsrHYNqnlzIJNxTmd8RsXO+UOwgfKRfaljvXN519T8k3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560694; c=relaxed/simple;
	bh=9EeYLmJWWAukgAyWUv6ATCtZnldxjQNyTRP6PYdj2Co=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=avcl284zbpQJWmxj5fgCNaWFCnw/rnVyF5HpmD3VcacSVDfzD4Z1vEbublHU5yINOhhj6HbrC0WdliZbjyrwZtWSKQQ0XJ6N7xaweTrT4sigmDJ6FoHdh64mbsMXvcxIicT2wSdw0h7vRO/KZCSQpN67SJGV2FjzvDZhUZdJlXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4j0aINR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4j0aINR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C756C4CED2;
	Wed, 22 Jan 2025 15:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560693;
	bh=9EeYLmJWWAukgAyWUv6ATCtZnldxjQNyTRP6PYdj2Co=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=X4j0aINReKTx53dAVco1FMkt4hiiOmMCX1HNWnkc7iB3BHU3d39sDVwj9FBDkFCuU
	 TL/TlwLeOHTE1It9TYEaQxZRDTtthw5Wowcx5JS03OSEWdNbaZ6BdAopPiPgf8S9+s
	 2FXrvwzGK34PY4Zm51bl/G2LPEveJwx+wOeR+BAV9A37uQO+WBekbhs5a8cPPFtTwV
	 zx7bSHAKsxvTyS3SknUujqwZtD410i461/CfPo0fgd7CcLd8sKOXnoLMZpJN/Yiz7h
	 vzQTzXcxvaQ8PwjOCOtwelz0NSMlx1rm6ndX1L7GF8u24njkhipsY5IpQaywdwoJUS
	 +hvumbFMV+oaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DE1380AA62;
	Wed, 22 Jan 2025 15:45:19 +0000 (UTC)
From: josiahspore via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:10 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c4-6a37a10fe4ef@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

josiahspore added an attachment on Kernel.org Bugzilla:

Created attachment 283457
lsmod on Manjaro

File: lsmod (text/plain)
Size: 3.95 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=283457
---
lsmod on Manjaro

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

