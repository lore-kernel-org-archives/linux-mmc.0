Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C15221CF89;
	Tue, 12 Nov 2024 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451984; cv=none; b=sVVN7ccOvHzjOiWYIAw5iIzML2Etd0k9OlGNlUPpNiwBlKvR64tiwIyEvPu/1fc05L0Hfi8pQ0Au4/z6VBKEqDCeLL22xSUXW0QDuzrBsPAmFMn4eewj0wxqmNrGKI2k+M/hUf2SFDK5rbR980I1X3KhGcLwQuFutEeE8svHYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451984; c=relaxed/simple;
	bh=yQwt2DsCgJNyhwxurxcyAkIppPnQMY1VaVKG7hi5I50=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kcNNvOcGg9tgFaxcq7ZU/WB9vjQEFflJtSTfAUn3H1c979nlmkEt5qpOY4bCCZeLqk8Jibdoat2BjTa+5Yp/2+qq+HdOiJsr+xwjcPVjnivTSruTeJ5A1Xk4WLt8Nee0lMZEJFPPfx4ct0yA7xyZ0FpfabSQ9fzITRnxgjC0fws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6y6LtGk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6y6LtGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F323AC4CECD;
	Tue, 12 Nov 2024 22:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731451984;
	bh=yQwt2DsCgJNyhwxurxcyAkIppPnQMY1VaVKG7hi5I50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6y6LtGktbgmjw7H7iEjQnUw2HgxVOxdQdc3XvkpzYIwS3B5Bg7247bL18aVlvf6c
	 HruMzh6Ko1Z6shqY/8X6eMEliFKSNrAGHS4/4Gcijrjs1UEkqkNoEqSTHUaZFrDJEb
	 gdMrbkSjLDbKB6sAihOeai9Ad4VstoFrf0AAF1cS13kfFvglzDCWVE3PgFXTzsHimE
	 IVH8dkBDV5m2c3gm2t0Ees/AGJmcOdAt5qLgyZsn1B3WYif5ivyXEdgPMXyqyOvJtb
	 QbqFFo/TMAivSPSeohmtQmadCT9s+3jD4Qd0eMqU7D/cVZPZxP6YEeSfcQb2sXnRKj
	 VdxC4cxziwnBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C503809A80;
	Tue, 12 Nov 2024 22:53:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mmc: core: Only set maximum DMA segment size if DMA is
 supported
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173145199424.701548.5612261824540957185.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 22:53:14 +0000
References: <20240924210123.2288529-1-linux@roeck-us.net>
In-Reply-To: <20240924210123.2288529-1-linux@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-riscv@lists.infradead.org, ulf.hansson@linaro.org,
 paul.walmsley@sifive.com, samuel.holland@sifive.com,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
 robin.murphy@arm.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Ulf Hansson <ulf.hansson@linaro.org>:

On Tue, 24 Sep 2024 14:01:23 -0700 you wrote:
> Since upstream commit 334304ac2bac ("dma-mapping: don't return errors
> from dma_set_max_seg_size") calling dma_set_max_seg_size() on a device
> not supporting DMA results in a warning traceback. This is seen when
> booting the sifive_u machine from SD. The underlying SPI controller
> (sifive,spi0 compatible) explicitly sets dma_mask to NULL.
> 
> Avoid the backtrace by only calling dma_set_max_seg_size() if DMA is
> supported.
> 
> [...]

Here is the summary with links:
  - mmc: core: Only set maximum DMA segment size if DMA is supported
    https://git.kernel.org/riscv/c/c26339faed11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


