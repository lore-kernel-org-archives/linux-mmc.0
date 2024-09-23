Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB151990A3
	for <linux-mmc@vger.kernel.org>; Mon, 23 Sep 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093706; cv=none; b=jAG+/yH7N41/u9iosPbiKk/FP6P5If6kvCDayqaMk7AakXuRqK3ejyO8S8HT8Pa9GgrvSe9YXY8O0fDTEZMMGQYwFhXiicpy3taKY8LwLCyrgmJGpU6V+h1SfTpcmA0wtLho6tnKbcsVsmE923UrrV7VldApvANPDqpRueBY91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093706; c=relaxed/simple;
	bh=OAaXKYJItk8b0dZ+KSlI+K2BubmeK35Z2/SH3v2PXFQ=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=bkFHazAOA1JWSA0bZZvDitZ85yNoqKJ7KnOnQ4DHIVscoEmT5vVdUEDn3LoW2S8u51lZ0of4ZzsicuBkJAe6Epo2ukm0i2MdE3ZC2UpAMPzcB5y3I/dsEoXzd8AeWLI108i2+9pRV7ZpofqfhU6ImEpjiP/2p5dyu6vPvUbygU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVrRZWOu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVrRZWOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E4AC4CEC4;
	Mon, 23 Sep 2024 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727093705;
	bh=OAaXKYJItk8b0dZ+KSlI+K2BubmeK35Z2/SH3v2PXFQ=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=fVrRZWOuRADSgkLfE9/iUHZXsmHgrxTBRnfsN8TC8le+zdOKNA3MtVtFpbm0Qm56m
	 aulX9OpEDxe5Xx5yLiOs2NXc4C0KwsHiFj3e/JEJPyFaL1/notA0xfd0xapdyJ7DuM
	 2EX69pvij4M/esI/DQyjKErvV5vNPkGnrAsIUeggJUUgy6ttS/NGVj93lfQqFtq1Iq
	 Ha0xJtnVBf3zwJD97/1pLCWFHziX2sUM6cZI6Y/yMUuz5S96IL4q1crJVDpWXqAtD5
	 WDiWo9SbRrSarA8Kw6Q5BnqLDo2AnNGEUD4rNWU2NRlq0WS6YTR8iF2C1nW+AZln9L
	 RVkLIIJ5KJXMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EFB303809A80;
	Mon, 23 Sep 2024 12:15:08 +0000 (UTC)
From: Georg Gottleuber via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 23 Sep 2024 12:15:04 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Message-ID: <20240923-b219284c1-ed78d9cf224e@bugzilla.kernel.org>
In-Reply-To: <20240918-b219284c0-db72da0a4ac7@bugzilla.kernel.org>
References: <20240918-b219284c0-db72da0a4ac7@bugzilla.kernel.org>
Subject: Re: sdhci_pci module is blocking low power s0ix sleep with GL9767
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Georg Gottleuber writes via Kernel.org Bugzilla:

I was able to reproduce the behaviour with kernel v6.11.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219284#c1
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

