Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1B2139C8
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560721; cv=none; b=DiM4SBPlehgDzCrzZYimdtcxGMZGrOJTRjK8/lUiSy2+2O+G3uSF4RPGXdOu1nRz6/Zsq1FOW+Awg9YnFPSK/v6N9nOZehceidcPyL0hIEyT5t4bXmXGXGEQf0zQUixNC4YGSYN+PmDKhW4DAhWNYAh0XleZ+szfeWM0eZPWluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560721; c=relaxed/simple;
	bh=foKOySBh+9tUo9izL1dafO0mLhwqcOh8t3nnxGvgKv4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=ecG1H4KwHMgpwc8Or/vGOFfve5bNE/UT8VboQ6YUa3O38ZNRTkrEgE5TyF7xSnm2XC1YkD2Ym1tavBNkEt+uy61SGt90VzraH+P67lWLeqBMz4MVP1+s2r2ajTtJtX+h4GRFs9UYLQD2UpB2sM8f+nhetzVOo9jbbdur1dyaD84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uS/GIGOm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS/GIGOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9035C4CED2;
	Wed, 22 Jan 2025 15:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560720;
	bh=foKOySBh+9tUo9izL1dafO0mLhwqcOh8t3nnxGvgKv4=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=uS/GIGOmxukH5+PkWkFrnmPQzD5Ce216iHk31Kjsbfry6sNUGHch97lABctN+oIqh
	 GFaJqy3aBu46fKaRMIzUoAelqrFHSXxzPh8StU5V8ZYZU59kgp9EKaR2K3V1TdIKiU
	 j0m9zUTk7NUj0D9imABQN2aOPbRxfPPfrh17bo75FgPDVqFbOQ1L9LN7uLQmvj9tHU
	 4qDV/hXk4b/gS14Zg+3oQ1BwRl34mwhrxkRxlGtAX8x+rz8pbLZATZn6PJeaHI6A9D
	 je/EpfJXyD7gDR3rjhP169If6nbPVol/7r2RW9MuZDY4Oq0bSXDboohR3uEX2vUwva
	 0Qc1D5fSvEaZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717D6380AA62;
	Wed, 22 Jan 2025 15:45:46 +0000 (UTC)
From: Chris Clayton via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:24 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c18-bdada20369aa@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Chris Clayton writes via Kernel.org Bugzilla:

Kernels 5.9.3, 5.8.18 and 5.4.74 have been released today and they contain the patch that enables the card reader on the Intel NUC boxes. Hopefully the patch will make its way through to distro kernels in the not too distant future.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c18
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

