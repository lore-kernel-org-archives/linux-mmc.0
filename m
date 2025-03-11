Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8E225A32
	for <linux-mmc@vger.kernel.org>; Tue, 11 Mar 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697675; cv=none; b=nmifh1IBekK6+64QAeNLTbwmhjiIYUZzBaaWG7JFlMQWGbFse0FC/LKCpkF+X6V8mM/kwoLHpOKDXV8N9MLfGxK7Z8+oVPa4aMya2n9zxURDLKFsdtRpZUS86/eTxR//sboM6LLCvXqdil/xSIG+/D88SRC4366d3aKe4xJE7AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697675; c=relaxed/simple;
	bh=9sjBBWS9bpI3NZmO5G/TMQPP/DrdJFrc0FcE29rYoS4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=C8nwbKtdrL8pSuwrOWG3P5hrWoUKDigi6yd/U1bh/i9LNcOKsZQL0k+9j6lMrfvodRr4RYZpQk+HQmTMlAg+U/llVbi0lJ1ViJIQwl9i5o2FxHTfHwxSj3KliTMKT2Z6Rvak1OlFhcJI3JWCVLrkpwtk7whBTY4SmizCU4iaT14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kfk4hlLl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfk4hlLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E57DC4CEE9;
	Tue, 11 Mar 2025 12:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741697674;
	bh=9sjBBWS9bpI3NZmO5G/TMQPP/DrdJFrc0FcE29rYoS4=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=Kfk4hlLl/DU2omwOZI51ydtKR6OX1M1i+jAmjWx44K3DFm0JITGELXYNpHrXmh/Ne
	 GLrC/BsvNW8m1+mt6SORSS2HNe1gjLG4eolBQbYTtrgDjhSrboDwTRtr/O5q0scst2
	 5U0+H+KTMk+6maXYh4ienHr8j3shPYY/4RfItejSR25Gvupko5JzAC3dA1EkpMQkSg
	 23eqrJ3PkoClV/DuI+6nZJUUX9A+lnkpzRMnXrvEc54OiQZAesVQGEuDuul0NRI/29
	 EGnw1ie+AZwST/e+yd+NL+cFqFXdFUUQNM3WDDzRn5kn92t0U+EcSBB/qHczkqyY0o
	 VT6caqyoUg0SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B32EB380AC1C;
	Tue, 11 Mar 2025 12:55:09 +0000 (UTC)
From: Adrian Hunter via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 11 Mar 2025 12:55:18 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ricky_wu@realtek.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250311-b218821c14-1185eb2dfa30@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Adrian Hunter writes via Kernel.org Bugzilla:

On 21/02/25 16:55, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=218821
> 
> --- Comment #13 from Thomas Haschka (haschka@gmail.com) ---
> Created attachment 307693
>   --> https://bugzilla.kernel.org/attachment.cgi?id=307693&action=edit
> Patch for 6.12.16 which solves the problem on the surface go 2
> 
> By reversing the bisected commit it was possible to me to build this patch
> for
> the current 6.12.16 kernel which yields stable sd card operation on the 
> surface go 2.

I do not really see how that commit could affect the card, but it could
be that it results in runtime suspend then runtime resume happening very
close together.  If there were insufficient delays to allow voltage levels
to reach the correct values, it could result in the card misbehaving as
seen.

View: https://bugzilla.kernel.org/show_bug.cgi?id=218821#c14
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

