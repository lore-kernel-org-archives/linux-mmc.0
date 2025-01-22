Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4362147F3
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560686; cv=none; b=kRFuGa3BlBwhcwxsDZ3X6IwBug+PNOZBbFwDel6D1TliPzdFupaxEVDYDbmWOxnrb7bMM+ZAZVwn4wjdq45w7wEiVGDmM+imc9lfuRsUps7QhD8azn1ItCczPTY1qmZ6TG2CI0gTvPent6t2P72x0lsYos0fsgt3moEisZVA/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560686; c=relaxed/simple;
	bh=ma7RVYtnmiDGEs0ZqJnOcKCkoEQ4Y0XJCNv4djCljAw=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=jkV4f2KKPolN1Gz9aeQ3106E6h8O+h9WGPECz5xLyJggyWxwl0uU/f+3bCZ5wd7qyjdloFhrxrrSbl0bKd3cBVkHQGkBWy1Sz2VEz6YMwCvUf44vKAr1xmY9hUp+SLMirJvlyXqkVXf90vUx1Qh6Ih7TiRnlaIw+LLZtRcDdP3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGiD7QpB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGiD7QpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8891DC4CED3;
	Wed, 22 Jan 2025 15:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560686;
	bh=ma7RVYtnmiDGEs0ZqJnOcKCkoEQ4Y0XJCNv4djCljAw=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=RGiD7QpBWt1Ni4uoWC/mLdVUDC3S50zSS4tPmRp3Ix1YPQ3BvLEPwsIgsGNUusgJW
	 MMw0J9NVFrv3tYMh+5PztZozz2M8aAT9DgQ+S4vR5XT0/ObSVbqCNa6RofVKOLeye1
	 VeadBj42L15fiIQnTNtY9sMgMdo4G4SmNVkH2P3S6xVNvKGK9KRsIqrdHWJ5foO0xO
	 WrRkLLgfzDHBwfj/GKXK1s5DR94JNOxVWOzqyH3FlN/jcEvODwSxY6aNSwgXOsseEA
	 kILkJvEb0EnGPYhI4kReMOzmmwyPryuIPtkLXaynLzy+w9iIXCJ4ElFQ4h7wok3HRK
	 ZDSLIBx0VGw/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB9380AA62;
	Wed, 22 Jan 2025 15:45:12 +0000 (UTC)
From: josiahspore via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:07 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c1-51fd85c61fa5@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

josiahspore added an attachment on Kernel.org Bugzilla:

Created attachment 283451
kernel dmesg

File: dmesg (text/plain)
Size: 45.85 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=283451
---
kernel dmesg

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

