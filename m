Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8021D214801
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560714; cv=none; b=t28v4vOb5h3px8kML8ki8O+3cagdbYI6Z5og0XRoO2pYgEPHSx19SH3uY6tlZWScU057GdY10mq+hMMSnCLu82wmt8/w4SAYGbX5WuNp3Yq3617Eor1mYABb3l6J0rdVG1qK4v8EVYfrm4j/ogdJeGNdTvtzc61gU8ZOIjx0J5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560714; c=relaxed/simple;
	bh=eRR2Yg0fLuIiGWveQvjRuW/zq1j/w4zNQMDUe18+vTQ=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=OUUSEBf93mHur3mFcQG7BSlS3EMkmgAwqSSLhjK9CoZw9nRos5hkH5Rbiged6L3IOVue9EInD1BTk/wwenJavCETrIMAYCZkljzaHeuCG2eYd6pgrHKIp2/y9/c9xRP2B5aHffej/hYK0n6poY0xoSYV1Y3PWBUDIMjgkuf0rcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GISp1fRG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GISp1fRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041CEC4CED2;
	Wed, 22 Jan 2025 15:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560714;
	bh=eRR2Yg0fLuIiGWveQvjRuW/zq1j/w4zNQMDUe18+vTQ=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=GISp1fRGvBkk5pQAD41yJmRZfGVF8PkU+189oe30PCkxi6LQ6LLW1mzh/GAVZ2/GZ
	 HPbHE8OxnHQRy+M1XPfzEr6qYsXQB0prGmhwoxTAb8okFDTUcDr2UN8pGF1BExPxXi
	 3mdheXGYqV5UW/XF9owtwcktydjpyZ9mlDNwfUdP0OhbYbnGfupYJi0IRfW5F5qYqq
	 CK2lEhFU060anJwqyMhNz00cwN+1Xn7FBIF9GGifRoF++O8e4tNC77Hh6R3HutjSEY
	 Py2dIEf7Iq3lsZxm+9MrggFma9O/r97YWF3ztQyeBXi4DZW9dtQZPNdgdLRNS+ZTit
	 pLL4NSq9oc//g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF8A380AA62;
	Wed, 22 Jan 2025 15:45:39 +0000 (UTC)
From: Chris Clayton via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:20 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c14-66e8de5dc6a8@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Chris Clayton writes via Kernel.org Bugzilla:

I've reverted* bede03a579b3b4a036003c4862cc1baa4ddc351f and built the 5.4.0-40 kernel**.
The RTS5229 card reader in my NUC6CAYH now works with both SD and MMC cards.

* The commit does not revert cleanly because of some later changes. The manual fix up is not too difficult, however.

** Actually, the build fails but after the modules have been built so the rtsx_pci.ko driver module is available in the build directory. I installed it by hand and then ran depmod manually. The build system is a maze of voodoo that I am still trying to untangle to get a full set of deb files produced. Nevertheless, my testing strongly suggests that commit bede03a579b3b4a036003c4862cc1baa4ddc351f is the culprit.

I've also reverted the commit and built the resultant kernel on my (non-debian/ubuntu powered) laptop, which also has a card reader (RTL8411B PCI Express Card Reader) that needs this driver. That continues to work after he reversion.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c14
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

