Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C48A211A18
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560727; cv=none; b=OIjwnn9M7bVB5Sab4GxeDi9h9dBMXNdwFWAkdgNtc51q/FwYHznRKZ1ygT0kUnCE6/gsw6lHMRi5hOhVXzFB7vQ0H+rne7iPUBtXgwnYw215LLbCHFRyL2dsCCdx6ndpyLEqHN6pLINgxyyvHaHQ5ZkFX2fyCWnoco1DetxCc4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560727; c=relaxed/simple;
	bh=AhB6tcaoWMKdoYDc9XV/fypJw11wQjOnq7bBFd6pIEE=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=CsQbvHR0OxqMZc8gTvkLsaUk+8jr7Fb9al/+n/OfO9XZD+i/Vs9eUFXqhXVIEUvsh/xJu/toeobZNlyroZrZIx7LaK8uLD6MyTQAoJbRdtC844pgg4qZ0DfqTDfMBYUGRgcneNqKA3VoALo3O8K8oK/hjzk9IivXnsDQKxG+nts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBR5o2Bc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBR5o2Bc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C275DC4CED2;
	Wed, 22 Jan 2025 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560726;
	bh=AhB6tcaoWMKdoYDc9XV/fypJw11wQjOnq7bBFd6pIEE=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=UBR5o2Bc+czOkDSf+ijrRlFZzLDZG00ZqiJvpwPMVl7NO4akxUh6D+heMdRKmxMEh
	 g38gHkAUf9RmbMuuL1assOh24J0KuEwSl7nLbALGdS/CUlANCFfqxZ4OuflTtAq0Dl
	 qk/RmljSpNE31LjaPasyktWgPcHdTNTDKNmgnMZRv02r4iABR4CJdxDCB+tLV4vRVW
	 BF0H6wufApXz6stTB6wQQrzkcAPEUIwj/Sp7diA6dRzUy7Dnsyn1K/tGHFvDe/CLEw
	 ciqa1+vHNlp1na8F+MXhM4PKjxRenXoGqtoJKBBew+BwrwBiXwdYM5brTStm+JZKaG
	 cU5QrY0DFioBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F92380AA62;
	Wed, 22 Jan 2025 15:45:52 +0000 (UTC)
From: Yannis via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:28 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c22-2ed81898193b@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Yannis writes via Kernel.org Bugzilla:

Hi,
Since my comment above, I've moved to Ubuntu 20.10 which uses kernel 5.8. It looks like it's going to be a couple of weeks before Ubuntu reaches 5.8.18 so I can't confirm 100% that the problem is fixed yet.
However, as the kernel code change is the same as Chris' patch I can't see why it wouldn't work.

Scott, Chris' patch just prevents the SD card reader from being powered down and this is working in your case. The error message seems to point to an incompatibility between your card and the reader. I haven't had this problem with the NUC but other, older, machines have trouble reading my high speed/capacity cards.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c22
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

