Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878E33A6E1;
	Tue, 24 Feb 2026 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771965002; cv=none; b=H4gCc0i5uQDJicqrjzWOhX16wu9M8b9R2bmeKYFC6UHqkbZuY6GjsWZR9IVZMkK0c1tpDhAfxOB3AUxX/oc5KZG6qlhpSOZGMY4n19d7p1mkZIDm0nxNDfeAZ8CaXKtR4f24d3acGjlY0WSfKfrOom7CrMZXgJZlyDc95gsYtAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771965002; c=relaxed/simple;
	bh=FWVYnHrFiSYu00+TBU/59piex8zCA4H56AvpNx3WHdg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BLTX4Voy88m28EHzKEZyBK7hfiqkpJL7toRLHmxshc3H5tDFdOc+2xjEK9g/IDiDnqKDSH9bj8fPlcgiJv+8WirL6iXUG61xjnxKvIZNwyuvFfLGeNplbONnE2HPy1DkfBuaLS5xrnpCpOC613SWV8EinGZCO2kH4u0nIGc35GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEUt6gcv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEUt6gcv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367DCC19422;
	Tue, 24 Feb 2026 20:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771965002;
	bh=FWVYnHrFiSYu00+TBU/59piex8zCA4H56AvpNx3WHdg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CEUt6gcvAPFUlr+xHssLhKRVQe38OL2rOMJGDwF+c74dWcPnwx9hCYikAT3RoVf1E
	 T6UD3EHBj4zLQczqd4Slp5X/zDA7pb536IQ4b9Veq1SvQj+4NCjYENJwZnw/6ArEzg
	 XDP0TMO8rArYELaqhOxT1KyARjMmOgs5k45oYZRWaA2hTe0ptwr6Fu9bDzFP5whgws
	 3Cjk6vGtjjOkIxbRYrHXSqaPxOJv9FPYwB+CCYqOQH1Id0dEc4dAY7BjjqEbY/aw+b
	 cROVkBoejhAzIcjfOMF3/RghVY2DIX4EsUSsEbIio3uRQAgJfVxckVuU3LFljIMLCQ
	 K0oKsFdJ/eBAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CDE3808200;
	Tue, 24 Feb 2026 20:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/8] mmc: sdio: add MediaTek MT7902 SDIO device ID
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177196500778.4139022.732715685642852259.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 20:30:07 +0000
References: <20260224061325.20189-1-sean.wang@kernel.org>
In-Reply-To: <20260224061325.20189-1-sean.wang@kernel.org>
To: Sean Wang <sean.wang@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, ulf.hansson@linaro.org,
 linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-mmc@vger.kernel.org, sean.wang@mediatek.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Feb 2026 00:13:18 -0600 you wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add SDIO device ID (0x790a) for MediaTek MT7902 to sdio_ids.h.
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/8] mmc: sdio: add MediaTek MT7902 SDIO device ID
    https://git.kernel.org/bluetooth/bluetooth-next/c/30c211ed0440
  - [v2,2/8] Bluetooth: btmtk: add MT7902 MCU support
    https://git.kernel.org/bluetooth/bluetooth-next/c/ad7c85c44e42
  - [v2,3/8] Bluetooth: btusb: Add new VID/PID 13d3/3579 for MT7902
    https://git.kernel.org/bluetooth/bluetooth-next/c/39b32232e047
  - [v2,4/8] Bluetooth: btusb: Add new VID/PID 13d3/3580 for MT7902
    https://git.kernel.org/bluetooth/bluetooth-next/c/cde58a6f8d84
  - [v2,5/8] Bluetooth: btusb: Add new VID/PID 13d3/3594 for MT7902
    https://git.kernel.org/bluetooth/bluetooth-next/c/71fa9af03199
  - [v2,6/8] Bluetooth: btusb: Add new VID/PID 13d3/3596 for MT7902
    https://git.kernel.org/bluetooth/bluetooth-next/c/2dbd6783e368
  - [v2,7/8] Bluetooth: btusb: Add new VID/PID 0e8d/1ede for MT7902
    https://git.kernel.org/bluetooth/bluetooth-next/c/df6be153d1bb
  - [v2,8/8] Bluetooth: btmtk: add MT7902 SDIO support
    https://git.kernel.org/bluetooth/bluetooth-next/c/287f90321f25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


