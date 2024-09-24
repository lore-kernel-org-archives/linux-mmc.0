Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F311A7248
	for <linux-mmc@vger.kernel.org>; Tue, 24 Sep 2024 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727181006; cv=none; b=UM5myo0xtibp5yc2518BY/vRX6bjsQUhj1ztk0jebMlJibNmqp5Jqhj6k8Xgi8ob0bgL5dgjev2agENj7igR+GJJyy8jXQ84IWp11yZyUzZ0MRd1a4a20yR4S8xraCeeiYe9GaV6kHryT17/AtdZ74JKNKxnhNvl562jrc/nNrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727181006; c=relaxed/simple;
	bh=OugdprAsfj24vKXjVGOiL6KeGDqBFT/pg6Pbxd9l4UQ=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=CUDJ2/R4t5UJqqZE6RKSX7EeAwSofdqJdxUUNULa8W7NA/m6ZH3pYCSbim6XOsOczovLvKPTOnfOssjsI7wB8GNCjJSsok3wrr8SK8RISCmzNbEMRPGLke2q5aHRoHR+Kg8xruHAecR+u1P8LMJ6XWRqSwAMBlFMJMDAC0gAw2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lvgq3Y/k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lvgq3Y/k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459AAC4CEC4;
	Tue, 24 Sep 2024 12:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727181006;
	bh=OugdprAsfj24vKXjVGOiL6KeGDqBFT/pg6Pbxd9l4UQ=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=Lvgq3Y/kvjnvb4jziDCeDbb9ZcPEAcHx69qp9XfN0Ex1dHR18QALFMczPDQW543d1
	 ZW7H3XA2W4ygR9F3oPBBZb6MruPkaex570iUnZAIC3QrKhIv0CgCk52rrfnV3Q7Qg2
	 E1CsdO6BmszjroKsqKLCCx57gsFTMkS4nDjban31Je1Dcr6qucjG2RcanHMW9UAwaL
	 XKNhZO4ZUQ5uO9cUE4xHqytUctbZpHhWWC5OkrLeq7ly6jgY+ByAWSaK5GzKeCIIIJ
	 KHuMIpVBM1zfKpnXpUrsX4Muc7263w/6cDIogOGBe7R+nNR9aZ/ow5Kl4CJRxmaSX/
	 RH9A7gAssSlhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B3A1C3806655;
	Tue, 24 Sep 2024 12:30:09 +0000 (UTC)
From: Thomas Haschka via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 24 Sep 2024 12:30:11 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Message-ID: <20240924-b218821c7-c5ca413428c1@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Thomas Haschka writes via Kernel.org Bugzilla:

I also tried an other card: 

With SanDisc 128GB A2 V30: i get mmc0: error -95 doing runtime resume
With   ADATA 256GB A1 V10: i get mmc0: error -84 doing runtime resume

using 6.6.52, 

again with 6.5.5 everything works.

View: https://bugzilla.kernel.org/show_bug.cgi?id=218821#c7
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

