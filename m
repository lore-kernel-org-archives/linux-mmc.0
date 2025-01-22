Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539E2147FE
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560710; cv=none; b=WzzVcRIZHlT4MSUMUUbdCZLSOjnozcDj0NVJyabgxjC1vUnbYMMg2eibnB6QbvQfUyqEKenmGH1gswPkenLYy87EsDm3gz6js8EfxjUGmJy4tlYskweGZd6GbtuRTsYo5WgrsCQWqaQy4xqDFJplsGQiNLZnPHTUj/P928LnBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560710; c=relaxed/simple;
	bh=Mi9/bofLrDnbSJTp4tfaT+h2CsJI16VotQ2LF02RQto=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=u+FW2LcIEB7amA5ZAb+oJv71xfozBOoBtNP8t9uDvW+jcAUtE0XQeCY9ky+d1xwqJs1+HFdxq+hmPSrJOzZ+lkz0zENPix/b3M6Tenf/ioE+PY7B1hZE4R50vPPjW2lUt+r+MAb5BTsV7zrFWY3d58yjrpX7oiVqvjLQIer6zYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOr5DatL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOr5DatL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4091BC4CED2;
	Wed, 22 Jan 2025 15:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560710;
	bh=Mi9/bofLrDnbSJTp4tfaT+h2CsJI16VotQ2LF02RQto=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=WOr5DatL/9cp2hOYHzbK4qPfBA8X/g3P+Cnre/bck3Z3ZYvAjfckaURPKuf0R226S
	 +ImRKua3E/rAFNwHey+ihkbGPdby+vDKVNrxJ597Wwb+/gyhS4ojv8gFB9zSKZTbUl
	 VvwmL8VO415dcOeyuurv2tXWYsNleCE91mybM/ILp7uoJbmrWz9z5BBt7DsaycCdkb
	 yX1uJX+hoK4YBRjIBDc/NQaDHpeucAVfZStvCPyI+XSAKCGQhVzJSWSpbyN6Fnva55
	 EC1EBe0Xg/TDPMu1fdyvU6lTkQfGomiv8DnIgnAz7Xi0P55koPLjhQ+40cMHSXojpI
	 GDSw4ytsM141Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF15380AA62;
	Wed, 22 Jan 2025 15:45:35 +0000 (UTC)
From: Scott Brown via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:18 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c12-3d119ae62d07@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Scott Brown writes via Kernel.org Bugzilla:

Condition described in this bug is still present on NUC7PJYH with Realtek Semiconductor Co., Ltd. RTS5229 PCI Express Card Reader. Now on kernel version 5.6.12.

The title is a bit misleading as the reader is detected in e.g. lspci, just card insertion doesn't cause anything to happen, nothing in dmesg, nothing in lsblk, as described above.

There was apparently commit bede03a579b3b4a036003c4862cc1baa4ddc351f singled out above. Is no one working on reverting this for the RTS5229? Can we get this assigned?

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c12
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

