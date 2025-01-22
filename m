Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9F9211288
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560733; cv=none; b=cBWu7XhJJ9EooadIro7A1UBsLgvsch9cE2BbCqePGwyZjIxi1qU1zpjJgYZ5D7ApVdYDxM4dokB7brOGrcM2fdnBClP3pR3u/D8HELT3ugEirzpO0a39Hz3k489X0+UfaF5yOf7Xznv8A24a9GaVI6/b/bBm/GSLWMcPDX1Yazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560733; c=relaxed/simple;
	bh=X8avffDXjUHVnmgwjE1MZzR64vFNyPIha55ZQL4ouLA=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=KIZPbejDu9v3qYOL+wfZ3ehxQGSd/IjgYUd/OkQXvlAn3DC2Qu8DbGaX5eVFGRY6rVi/5Ah9MuuTcm2M4WeBvOCvlsR/K4BC1rCEhuStuluajg2j1X1gbt5PkoOBbPrEbQ2njVoU5Dxeax+0cyus6FjVDMEuSLw7r+HVsF6fywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlmBlY5o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlmBlY5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF07C4CED2;
	Wed, 22 Jan 2025 15:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560732;
	bh=X8avffDXjUHVnmgwjE1MZzR64vFNyPIha55ZQL4ouLA=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=LlmBlY5oFQETS8l+TKWOZfAIYe/bJaHGJ1W0gCWAglQikgVwPMnnVCGvBwQwFX1Tn
	 TB+MHjFtTevuVg9Gh1jwY6NOco8CJegtdsZLFBQN2tAYsbnGph7z6cZOGZ1xIdTzt3
	 DBK9JRL24k2Y19HNAj4ADrH95H9KDZs3bFS/Hsu+wxl/7BRfCAFVRM+3938OSiTWP2
	 L+yiuvr08abuGGE/v7mdgx04/PN/yKXLnDIMAW9LhqpL5PUpUTVFq4cuRh3VGPC2XM
	 Mo/MJD08YCzOmGzkXPLBJZvZNC9MlqxZc40K9ANqPNcyl7cX/7YwQNjyq0cYMM1F/g
	 qjTuT8aojkC/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71D39380AA62;
	Wed, 22 Jan 2025 15:45:58 +0000 (UTC)
From: Chris Clayton via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:31 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c25-9208572636fa@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Chris Clayton added an attachment on Kernel.org Bugzilla:

Created attachment 304518
attachment-15581-0.html

I no longer have the hardware, so cant help any further.

Chris

On Sat, 1 Jul 2023, 14:22 , <bugzilla-daemon@kernel.org> wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=204003
>
> Doug Miles (dougmiles42@gmail.com) changed:
>
>            What    |Removed                     |Added
>
> ----------------------------------------------------------------------------
>                  CC|                            |dougmiles42@gmail.com
>
> --- Comment #24 from Doug Miles (dougmiles42@gmail.com) ---
> Bumping this, because it seems to have died on the vine and is still an
> issue
> in kernel 6.2, as far as I can tell.
>
> --
> You may reply to this email to add a comment.
>
> You are receiving this mail because:
> You are on the CC list for the bug.

File: attachment-15581-0.html (text/html)
Size: 1.47 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=304518
---
attachment-15581-0.html

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

