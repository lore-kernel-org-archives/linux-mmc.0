Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2482E8DF8
	for <linux-mmc@vger.kernel.org>; Wed, 23 Jul 2025 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276194; cv=none; b=UPzo3cOmOQzKpfA8wc1ABcrx8jlLMTqbKMUX56F8QcSM2e/QfrzyTbY1TM5hc3saveIJN8lW2YqspG8ASk+sJZPLIr1TbfLjuWTOQqtZq16ZLvW7xJGMGCJibQdsCVXKjzxYHS5c4bdNiRQXjOmq+XyDlq4dQX/LBoTVLXlnoUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276194; c=relaxed/simple;
	bh=AGGIwQYB9ZjhwYrsITqkH7cG9L06STaCa2ySXS1YD6s=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=JIQrL0KzWejXrGWvuOY2CCZKjj5vtbaMJghWyNer8e6cCcySO7AUNjup9parv8+Z9b54FHBODfo50IgHr7D0p45P/YXkzUPDDC5MldVcU6wKFA/BWDb9nn9Fjx4LM0SVExBb3/UzG3/WfKc7qMdTj/zM9/nJdwFAjbfc2Bj6lHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQoyria3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQoyria3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35266C4CEE7;
	Wed, 23 Jul 2025 13:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753276194;
	bh=AGGIwQYB9ZjhwYrsITqkH7cG9L06STaCa2ySXS1YD6s=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=pQoyria3eHedqnBXwvCMeMZOETH0BCwHQ9avzEir+gBZxtUyCBli53pT7aGNONV0J
	 mCrXtXP0gXzMfSpSMxhh4vDyeyYN8V88qzsmmhAQrlm7Ofl1OKg8nBHbaZUiaUwMrU
	 fOz9XVHiWaM/+TuhuQajTgPQqcMXMZEhaeQx2QyZYY0MfxjOfjy4kCblDeJiu6NW/c
	 LryzmShleyQmhL8M5neYNKNt+b8OVSzgVD9f6ukdXrJR9AJ6WZ5ur5Q1524GRKyIPQ
	 /go+EfF/pcAGeNmz7ZxETxUWyffYI+v6ZrPUiJzdWUQTMZ2FD8JOw6ypo5Kaaa5k+o
	 TxXcfYsGM+TUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0B7383BF4E;
	Wed, 23 Jul 2025 13:10:13 +0000 (UTC)
From: Laurent Bigonville via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 23 Jul 2025 13:10:07 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250723-b220362c2-8a6308351f43@bugzilla.kernel.org>
In-Reply-To: <20250723-b220362c0-fd0fdb0c86b1@bugzilla.kernel.org>
References: <20250723-b220362c0-fd0fdb0c86b1@bugzilla.kernel.org>
Subject: Re: rtsx_pci driver is blocking s2idle
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Laurent Bigonville writes via Kernel.org Bugzilla:

I meant that rtsx_pci(_sdmmc) is loaded

View: https://bugzilla.kernel.org/show_bug.cgi?id=220362#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

