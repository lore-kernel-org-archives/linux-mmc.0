Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B7E1D9A54
	for <linux-mmc@vger.kernel.org>; Fri,  5 Dec 2025 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764968591; cv=none; b=BKZOScGXUvYu1d5lygzKcWCfQkH0YjDkAzSC/LGuGplAoiKKpH8nN67yK//yhx/ewo9ECB7e0Bm+cVR+o0V/xoc2PwnImeVVAnCqzX8TtqwY3eXMoTotrfk6O1+oCCWBIIJ+k5oGcbSTsQC0f0+et5w3B7t9lyiNrkL/AtwoV4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764968591; c=relaxed/simple;
	bh=YD+GnviS62UfZKK5oDiSauMP0CshiM1PDgE1BaTwgvo=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=QEBxlBAtF+1eRuU8OoSdtLuw4SH8jxLi/Iar3K55ugMUZh2/pGMj/Ab3xImiNWvgSOEswYXuCUjVvFh4kr4A7qX9me1TSrSgEpvmGgctiw945clcgbl4ziHahYvpdlCpTUU8GCHOoFKLkfL5D/XK1RExkcCjdl1vgnJg2Yt8xSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6IXkiqc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6IXkiqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D519BC4CEF1;
	Fri,  5 Dec 2025 21:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764968590;
	bh=YD+GnviS62UfZKK5oDiSauMP0CshiM1PDgE1BaTwgvo=;
	h=From:Date:To:Subject:From;
	b=L6IXkiqci4FHSU1x2rd1d7Oe3VDNcBHZSitFtBa9wRtNrCLNMX2G7SVcx7iUQnjkH
	 mWNB6iq7O11qpJw/GX9+TrqHPPsZQZHCK/CzgoGrK+SbiHqTdGNkQ17D28xua1j/bb
	 Hr62YDlI2hMBKEKsll6x/4MEVN3Wsr/d9Sj40IfP/q9Q3qhunvRNlsO+Fg2V3w0o7W
	 ARV+GK/Ta59ZCst8xUquomLQaiDoOJEt3ov8ruqOku28br2X219dYc/8mCUWkzqh30
	 QiyRQjXRDZ5thwdlq+O5FvW3zRJ+ojAslWIaKUC3qgK24EurQQt0Dj+9dh/tW4pAHh
	 2PdGoy+hgRi4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7DB3E3AAA0D7;
	Fri,  5 Dec 2025 21:00:09 +0000 (UTC)
From: Mohamed via Bugspray Bot <bugbot@kernel.org>
Date: Fri, 05 Dec 2025 21:00:05 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20251205-b220841c0-b1d85d237308@bugzilla.kernel.org>
Subject: Unaligned access in drivers/mmc/host/sdhci-of-k1.c (arch:ariscv
 soc:spacemit k1)
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Mohamed writes via Kernel.org Bugzilla:

There is an unaligned access in spacemit_sdhci_set_uhs_signaling that calls spacemit_sdhci_setbits(host, SDHCI_CTRL_VDD_180, SDHCI_HOST_CONTROL2);

As SDHCI_HOST_CONTROL2	0x3E the helper function spacemit_sdhci_setbits uses readl and writel functions, 
ie.
/* All helper functions will update clr/set while preserve rest bits */
static inline void spacemit_sdhci_setbits(struct sdhci_host *host, u32 val, int reg)
{
	sdhci_writel(host, sdhci_readl(host, reg) | val, reg);
}

So you get an unaligned access exception/panic/oops with cause 5 on the read.

To reproduce this you need to enable the emmc in the dtb as none of the boards have this enabled. It seems a bit strange that the commit message says that the emmc is working, as it is disabled in the emmc, yet there is working version based on 6.6 which does work. Obviously, it must be my mistake as the commit message cannot possibly lie and say that a driver is complete and working.

View: https://bugzilla.kernel.org/show_bug.cgi?id=220841#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

