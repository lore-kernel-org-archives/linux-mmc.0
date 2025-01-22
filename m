Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B402147FE
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560696; cv=none; b=uZ2gGQDUHB5IOxgDbZAZY7qqDHNGkW2MCtnEBDeEB8HagkziK/aYf0ljM8cB+dWYv/iZi/6ZYli8D5lENrSRNnBkdcqTU1LNfYXeIFUf0//0qa5s6KpiLdVo2KVlb5ipWgicOsrIOK4kPa7ogV5xKJ5xYXd3tkcxvrTDSm6u0hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560696; c=relaxed/simple;
	bh=eU6+R0zDUthnMqZaTd0uxwkymNKBzLAZ4ZTmh8nlBeA=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=XPhCoB2X2It0p8Y0iq4KVhCfrY7yI2jlPp8t12F9903BU8cXQeU3AJZ1rlfWNaiW84qTqM2R/TKuOQ4AzIKL820FLuIPrKgK7fmTM3EpLGMdoTTmVlcKFJkujxQ2pZZhFcnvHGL+nLHsjEohAtub0oqXxXGBV5/6W5iFkbc6o6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjlF7e25; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjlF7e25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C014DC4CED2;
	Wed, 22 Jan 2025 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560695;
	bh=eU6+R0zDUthnMqZaTd0uxwkymNKBzLAZ4ZTmh8nlBeA=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=tjlF7e25ws2Lrwjspx2VuS8nQdghhdYQ5E/ADRMmISKokzOfqz7vs1NI45L/Tj9AQ
	 ZHIrXbUwedwQDFkQKl5Vx6sxrzdwh9M9LJVUKyRcYMyL7CjfmkbW06NmfWHnEOvibQ
	 xKIDXBWfGdngX5JNxg7DQ6JRQIjBapQjnCv2dpwfhZTDvrw7Q6u121FOTxofPoouYd
	 MHzNq/vQWKcgS9HLxKjLlxBsWuHrYDVFB41Cu8SUWsHVPhzxLwtSbSYeAQKE0ZcfCL
	 BmtJE84cRunxAVYo0JhgCwjiM8toWkiMiFVrW937I//Tbi44HiByoFma1xJZT/vWF9
	 4aqRm/HHFW8OA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715B8380AA62;
	Wed, 22 Jan 2025 15:45:21 +0000 (UTC)
From: josiahspore via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:11 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c5-9d51836f059c@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

josiahspore added an attachment on Kernel.org Bugzilla:

Created attachment 283459
lspci -vvv on Manjaro

File: lspci (text/plain)
Size: 25.38 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=283459
---
lspci -vvv on Manjaro

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

