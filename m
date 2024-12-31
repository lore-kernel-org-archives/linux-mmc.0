Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A80D1EEE6
	for <linux-mmc@vger.kernel.org>; Tue, 31 Dec 2024 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735635889; cv=none; b=tQemAeT42M6KWABZB1F0LVPsnAJG9bIEYyWSe/tKx8UmdC2VpWTfO+h6RQfu8gBCgiLYgTstpGBPDpZ81tLUSZbmYOWwN0ZhrGn/u16VnWYS0klxSn0AFuVOvY0hKoDfxFBTSTiajw16jh1QwEkNLdcoEWC4BjX8LTN4olGHxtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735635889; c=relaxed/simple;
	bh=+I5Cekh7nl5PjdpsvTTA+YVYPLd+/hqrqMJETUChOe4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=MiPYxFtIYD7a+Gm/5pPrC2GuqOETX9d7dZMoFGGiKt3vZSry+f6h0xz1rjLFS3y5gw2vuq7ZB0S3a65E6b0qk0mW5Ic82JOiuBZdBsiRt92gnR4OtiuUmotza7Ws73hKdKxpO/m85wz77QsCpoJF3/F3zLyqZ/bAK5JcEpX9QVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2TseZ+q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2TseZ+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FE2C4CED6;
	Tue, 31 Dec 2024 09:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735635888;
	bh=+I5Cekh7nl5PjdpsvTTA+YVYPLd+/hqrqMJETUChOe4=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=m2TseZ+qY+xEiamBwQnEGzBR2oR5lVuxWCkATka5XPAVzXzjV8Hn9Icg9D30a/g54
	 0UIHUnSsQYVNSGx1FsSCfU+VyXjxPVi0UjEraUrUPo2RtsJ+sjNKhBmHIzi45jiWLq
	 dtrDtBYBX+GE6RlJhbPhU5jTI7zkcS0/QPXh2ywTxjP80xpfzyINyQFTVyk4VFhnVM
	 QbsMXGR0I4AnZjna7TDykN/xr5pbAlnELMasgI7Q4is4P9Z7UBrWeLsM7iRWp3jhk+
	 RsIkCOF45YaPjE4I2hsJUzK1fOswhSdsbq/zDa0nERfjbcvMi8x2jKPNvHpL8+ZOo3
	 dlyJtZOcnmVlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B3D1D380A964;
	Tue, 31 Dec 2024 09:05:09 +0000 (UTC)
From: Thomas Haschka via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 31 Dec 2024 09:05:13 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, ricky_wu@realtek.com
Message-ID: <20241231-b218821c9-029118b1d990@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Thomas Haschka writes via Kernel.org Bugzilla:

I tried to revert the commit that you pointed out by applying the following patch on 6.12.5. 

The card in question so still fails with error -95. 

For the moment I am stuck at 6.5.5. 

Thanks for helping out so far, but commit 
0e4cac557531 misc: rtsx: Fix some platforms can not boot and move the
l1ss judgment to probe

does not seem to be the root of the problem. 

All the best, 
Thomas

View: https://bugzilla.kernel.org/show_bug.cgi?id=218821#c9
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

