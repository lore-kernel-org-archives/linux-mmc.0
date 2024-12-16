Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844261CEADD
	for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2024 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734384291; cv=none; b=rAZP5JknaRlx84wO+R5+GqT3zbQw7KNQPW6GFM6766pvehppBEeKGEDt5G+bSOOKAnEGStJHUevL/kSgdX6prArQKy3UMzyctvoK4VIX4MSlCc2ATczLDzam7x2p/6TvtVqCVgtiGib9Tbd0PoDw6Bidq6zt9oi96BNn1gZH94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734384291; c=relaxed/simple;
	bh=i2Q7qNfHTIOTiDIgbOcaocVDF5MoxTMApqynNi5K2c0=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=rJfNBcbLCO26ZtIwOZO+vATuXJm2AQ/IaZaWXAbubYtwynUOUt/o3WFZbPWG0lmFzXsnZYtQ9H51iORVYbijlQ6QNdg5IdrogFQD4qAc9byflp0CzTtxhu1vi/1O4nC2j552UwOtK23wNXo1b0j/7/4WPBd7l2vbPRK2lfqOj9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtdI1A3O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtdI1A3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CBFC4CED0;
	Mon, 16 Dec 2024 21:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734384291;
	bh=i2Q7qNfHTIOTiDIgbOcaocVDF5MoxTMApqynNi5K2c0=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=rtdI1A3OOlil9PDW9F0XUGedyX4tRfIC/b5LazIb+ZNv/K2S3vJbHssGGDci487a1
	 uNeGe8kS5IrowsxbASdd8dGuNSpYVbTcPP5KBngxUOGMTf4VMCMGQ+zSWTKh4lEW+b
	 selV0P9hRw7YolXQr3H5k3UTWc95CqkbW/ScwOaN2QwG2iRBJNOEQ8R8JyuXfftTQB
	 pdSRs3ttzsViFu6T7/7KrWZRkv137Dv4chdmx3fNVb4B4oESzNJoG+8wKdrLD2qj5b
	 rJd4lQpon3eRXimZhCuxRRdi4ZPQ4WnyoBc2EwwVjWpsPtexmydU4zWDkhvBJO8kZd
	 xaRsdHYuzuIvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFCB3806656;
	Mon, 16 Dec 2024 21:25:09 +0000 (UTC)
From: GRbit via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 16 Dec 2024 21:25:10 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20241216-b219284c6-6198c4e381f1@bugzilla.kernel.org>
In-Reply-To: <20240918-b219284c0-db72da0a4ac7@bugzilla.kernel.org>
References: <20240918-b219284c0-db72da0a4ac7@bugzilla.kernel.org>
Subject: Re: sdhci_pci module is blocking low power s0ix sleep with GL9767
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

GRbit writes via Kernel.org Bugzilla:

Well, I must admit I'm not used to think before I write. Modern platforms that allow to edit your messages made me lazy.

Some more info on the topic:

I've tested suspend on tuxedo kernel:
$ uname -a
Linux tuxedo-inf9 6.11.0-107011-tuxedo #11tuxnoble1 SMP PREEMPT_DYNAMIC Sat Nov  9 11:02:15 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux

After that I found a public thread with a patch to the problem of the topic starter: https://www.spinics.net/lists/linux-mmc/msg82920.html

I'm not sure how to check the code of the 6.11.0-107011-tuxedo kernel, yet I found that this patch is applied on the latest kernel version 6.12.5
I copied configs of the tuxedo kernel and build a 6.12.5 kernel with "make -j bindeb-pkg"

Unfortunately, s2ram still gives me the same problem: system can not go to sleep properly and just turns off. Blacklisting sdhci module didn't help, I still see the same messages in dmesg.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219284#c6
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

