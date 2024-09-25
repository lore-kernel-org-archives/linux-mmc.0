Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8F18E04B
	for <linux-mmc@vger.kernel.org>; Wed, 25 Sep 2024 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271606; cv=none; b=m/9qqsbu302L3+tJFh+S4oUtlnAQyv2+KBNNLjjxlnbt+I3YHApk91oGSWtHHAmD3H5nBg3ZHRPVosaHNw/bJVYdT4rIJ2HuW659BpEj+GbqVPS9Pc4aXkRSO4Q0X03z4mriL16kOrrVZ9dMIvFn+7V44LhgsBzoaRDN4xuQd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271606; c=relaxed/simple;
	bh=HhMHYgbNEVPa6FT+lNCpFYGRjaq2nbNVFCzZ4ngas9s=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=gRueVoR7d9AkYRqXVBHZLqEO722MMCvniNRCORFifoqRiQFGpn5MnhQdUdryAYmCvVij0LNaw2XWlHFY2K44QlYzMjMypUeOv0JxBShm2Znbecs6ihit+qbbyQYBGsHzzqpvnpPC90g+gegqEQPp4j0npm+L0IsdBE2cOd9ERGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMrDdC7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMrDdC7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376D6C4CEC3;
	Wed, 25 Sep 2024 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727271606;
	bh=HhMHYgbNEVPa6FT+lNCpFYGRjaq2nbNVFCzZ4ngas9s=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=jMrDdC7qPssHlS14PwkFiklMj2KipzKW4aQczPmLayy14qJRF2KfPNd2fOvMU6mYZ
	 lP4NHGekb74iZzywZwu6zCE9vSMTvAw+C568SyvZsKtSD/g/cv4ON30jbEikahRUr2
	 w3JcojvEsy7tb6440Vf742LYLS/hnRgMC/+ElijWlGjPCC6p7vMVkdDPm9MJJR5j+x
	 MFnVU2cMFeuZpobKpV4paVffAGXQtcLDnDx58aie/kAXoPKW5L4SLrVChRD4/LDV4c
	 QlRIzLm+MwAK0OKSmkslD8UTX5/WFfsIJXJ8wO5oGYtefSbPahcDLuZqifHhBhj4Sl
	 dsEb/n6/vU1Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B47C33809A8F;
	Wed, 25 Sep 2024 13:40:09 +0000 (UTC)
From: "The Linux kernel's regression tracker (Thorsten Leemhuis) via Bugspray Bot" <bugbot@kernel.org>
Date: Wed, 25 Sep 2024 13:40:06 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Message-ID: <20240925-b219284c2-aa94a203fbda@bugzilla.kernel.org>
In-Reply-To: <20240918-b219284c0-db72da0a4ac7@bugzilla.kernel.org>
References: <20240918-b219284c0-db72da0a4ac7@bugzilla.kernel.org>
Subject: Re: sdhci_pci module is blocking low power s0ix sleep with GL9767
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

The Linux kernel's regression tracker (Thorsten Leemhuis) writes via Kernel.org Bugzilla:

In case this is a regression (sounds like it's not!) please let me know.

Side note: reminder, there is a decent chance that your report here won't be seen by the developers; for details search for "bugzilla" in documents like https://docs.kernel.org/admin-guide/reporting-issues.html or https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/

View: https://bugzilla.kernel.org/show_bug.cgi?id=219284#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

