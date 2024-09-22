Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AFF33E7
	for <linux-mmc@vger.kernel.org>; Sun, 22 Sep 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727012113; cv=none; b=BbtjYkv6cLBUzlpqO5HuMWOGUTe4Iv+5Oj4CWj/b5m80aXlFUdh/XubzOpQd/L20/XHsmn/N3eY44gXitCGekYgZEWR2XOI4/uhS52/yjIYbkTsqVCE8dphDbW/GvoBLOy4+Z9jQmo+Vex5+FJUAWMhiWLYUvz8YivBsoJTgF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727012113; c=relaxed/simple;
	bh=TssPY+leBzBJmqkXTPvo7t6aJNjzP7cHx+5fDrP7CLU=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=KS/GCfYOqWPTGSLHXqtYaI42yVGIGpRbhTuUztf3gayYdXbkWrOlkzwNiP8IIxKBnnQYpeP62MbG+gfKb/itqj8thiZOSAarVVtqHO/Z2T1cFCQnPJXNOGCRIjnRzP0a1h1abnLbKDf8lYflbS8ZeBsx1yBWEzjGJkycU3/1sKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFQOclNQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFQOclNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF85C4CEC3;
	Sun, 22 Sep 2024 13:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727012113;
	bh=TssPY+leBzBJmqkXTPvo7t6aJNjzP7cHx+5fDrP7CLU=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=gFQOclNQ6MBujclle+pfwpPHlC0p8Xz12neV/hEs4YiJah2D/u73jsEPo7MwMFwUp
	 MXGmQSPfc4YgUmsMrjJpC4BoML+97FGaTGtS8JMTWJUbH6T/vqBMqVt/Zn1gQTLven
	 8ipKTMfP37qmqWV5fAnx9vBCVSsjZNjDxMnNRLSsc4a8N4Wt6xCS26rrU8N1RH2y41
	 dqyyig1JT+vPds8NuCWuxCrMZ1rRvBJNp1SMpwRblHA/VQxBFxmlLjvMyjic7SiG45
	 Eq26DH9wQtnVfv+2g7TLqfeZwhglL/7hz3miR5bruIj43A6jPWkciDZmIDgxcsQ6gC
	 ibMNNiiW4iO7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0AB3806655;
	Sun, 22 Sep 2024 13:35:16 +0000 (UTC)
From: Thomas Haschka via Bugspray Bot <bugbot@kernel.org>
Date: Sun, 22 Sep 2024 13:35:10 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20240922-b218821c3-354fcfd0cded@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Thomas Haschka writes via Kernel.org Bugzilla:

I am using the gentoo patchset on the kernel, further patched in with camera drivers for the surface go 2.

None of these patches should touch the rstx_pci driver or carddriver directory.

I run the root filesystem on the SD card. To be more specific a
SanDisc 128GB A2 V30. Therefore the system fails once the sd-card does not respond. 

The failure is probably rare for people not running a root filesystem on the SSD as the carddreader seems to work fine, booting the system, but seems to fail after about 10-15 minutes, of activity, as stated with dmesg showing the error message above: 

mmc0: error -95 doing runtime resume

and the filesystem not responding anymore. The SD Card is ext4 formatted, without mounted with journaling turned off. 

I will provide kernel configuration files for both 6.5.5 and 6.8.9 later that day, in the hope that it helps. 

As said reverting to 6.5.5 works fine only yielding a 

mmc0: cannot verify signal voltage switch

but I get this error since years, every other minute, on this system - also with different SD Cards, without any noticeable effect.

View: https://bugzilla.kernel.org/show_bug.cgi?id=218821#c3
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

