Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD1C1FBA
	for <linux-mmc@vger.kernel.org>; Sun, 22 Sep 2024 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727012110; cv=none; b=a6d7TEZlmSZEZFKUWHH+DY2GzVvIVOnDvGcpGb20prmtcgsQ3JnPod6y32Si4xRXorwlQtJq5FAJZkQ3zFGWQ73uC0yTHFDa+WV0LJZ4Zn4/KCMam1eoglCmL1omkCjoJM+iKcOLn/Te2LJD/xBVTGkiU9Gj0z8xUwLNPb8paiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727012110; c=relaxed/simple;
	bh=sH5uvNI3sHy3h9UXBU70y5cbbak6FILYBhmDlLVQRJ8=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=lq4u/inMfCMN+tRS6j+U6cPmD6YanPUraCbYkf/JoGQqJ1kwUaFFI9hLc90DWkzjgtppcSKnOhIy5QRMI3iOcPpcbDXU7uCL25Y2Y9cbXRA1FkTEG6Mv7rmvGm/LCnQ4CxPqsV81ilO2yN0wqRhpuxdZRtMJrDek4+p5cMYIBOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5I936q9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5I936q9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82515C4CEC3;
	Sun, 22 Sep 2024 13:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727012110;
	bh=sH5uvNI3sHy3h9UXBU70y5cbbak6FILYBhmDlLVQRJ8=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=L5I936q9Nio5dOzuZHKtW/kcywsptZH5ATETvhc0RzamaS7YSpa8Tud2ePg+Sl/PU
	 sqwnuCkRVPxDRAls4jys5OwQK0vqHsVuooT8PkEbmrcRUqXDH3sMLyS6V7rMpSNSuq
	 7T/I5Vu0qBH8zfs61V7tO89sgLrHXmAAilxY1VmcLCNSObq4bJztpwY8xVu3v5SLsF
	 4F3m1LxwIOc9LRlfaWSMAq4cxO9+qlz4Vu39P8BTRf9i52WVWuNxcC35x3uzQLRWsj
	 b5gW9rmxfyi15m5tgaDq9VOZ4rBFdl8dUi9gNTk5IN+eWSmyRRzA/5uL8Ii/5J7N1j
	 pyzOgh+tEQAZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0253806655;
	Sun, 22 Sep 2024 13:35:13 +0000 (UTC)
From: "The Linux kernel's regression tracker (Thorsten Leemhuis) via Bugspray Bot" <bugbot@kernel.org>
Date: Sun, 22 Sep 2024 13:35:08 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20240922-b218821c1-3bdb282803d1@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

The Linux kernel's regression tracker (Thorsten Leemhuis) writes via Kernel.org Bugzilla:

Are you using vanilla kernel or something that is close to vanilla? 

What does "makes my system frequently fail" exactly mean? Fail to boot?

And could you maybe bisect the issue: https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html

View: https://bugzilla.kernel.org/show_bug.cgi?id=218821#c1
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

