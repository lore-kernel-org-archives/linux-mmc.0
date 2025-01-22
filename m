Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72A2144DC
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560699; cv=none; b=tOCYxmH16cLgK7GVVV3OEApWuyK/I0+OTz3mw/lulufT8UbBs+uBKSLvMRP/H1N44jaDMfcZzkPnUFdmWF49Y4iSFXbTw5Ao9w2fFjiSwOc4Sff3toiuju/H27QfGwFTuvEhbp3XGWVjY/08+B1B/adaf9aP0nVcVQsAlTSYXtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560699; c=relaxed/simple;
	bh=s0/hNIgljnyhiTyZyDIFhvrGt1exoKZ/fS5rwTMY/Ks=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=sO2NzPu2ugASsD0DdkCh6sAj2w+T3zZ+4l0opoM/fBqjj7aBM0KixC3keUPE9cotQR7UqArVybYz3VzKNlt4fv5C2enxCw87uwTEXjl8syHgROJGe7A54PQuyk1bBMLqSye88S4c9518ZoxbY86oAfhwwOEKFlNE/pcF9xG4xOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZtg77hH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZtg77hH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1A5C4CED2;
	Wed, 22 Jan 2025 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560699;
	bh=s0/hNIgljnyhiTyZyDIFhvrGt1exoKZ/fS5rwTMY/Ks=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=TZtg77hHlZ99aJkvaxlAFWrJHeySx5QU/6XSRvpuOEjY9OGDC95HUSQNeTDi5kGFP
	 EWnns3JwWiYyS4giLUiL+elPcJOTtV0DvZRkLtm/VkJ7WDViqOcdynM5op1PoZxKI8
	 rOqOBUfoRuAIiT6CoSVZSDtfhvgMCWplxvB323XzuwaK/gfUXL3tAjTBaIUZQVoUq+
	 qVBcwJySUG5jO7+I+FdrJ4Ed0yNHIYwdT5jp0qcIeMRqGSq83gdt9m2EDPqdCwD2xE
	 lFVe0lSBkatewCuDMbm2wZJkMIIRjfJ4q3To4ZTYwHtNKq1HopvYgbvmSURsvXuxBJ
	 c4tbrsW4Ei3XA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71004380AA62;
	Wed, 22 Jan 2025 15:45:25 +0000 (UTC)
From: David Lindstrom via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:13 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c7-cc6bf6ab33dd@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

David Lindstrom writes via Kernel.org Bugzilla:

This bug is also present on the Intel NUC7CJYH board, which uses the RTS5229 PCI Express Card reader.
Kernel >= 5.1 fails to detect any SD card. Nothing shows up when running lsblk.

Also tried 
# udevadm monitor

while inserting a card. Still no output.
Downgrading the kernel to < 5.1 solves the problem.

I did a tracing of kernel mmc events on kernel 5.0.13 and 5.2.2, whilst inserting a card, see the attachments. 
According to the trace, all mmc requests return cmd_err=-110 on kernel 5.2.2.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c7
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

