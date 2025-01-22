Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01954C9F
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560730; cv=none; b=T9u7N0f+U2w6Wr4/3WRvanJ65VvzrMWPY1GFvaCtTPYqmE+BsdWKEkR9mjZZe+rvSRLUvWWCGb6Ner5IoUMoyNU+5oGsR3s8Og/PfXkvSfx9ERq+VdOHU2+Bi91XWZSBHU61TrBj0B6dJxhzOZxHuDaA2Pic9ug+2XnidD9QpYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560730; c=relaxed/simple;
	bh=lUGLFo1YU+1WlZY0nFGmq9zpvdHQjCd7nb4WbmkKNBY=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=ISbRfbt0UQxVVRDML2eUOcSuRdFqv9Kwq8xSGxf+mNGYK6hGsNCzWHpE4hkfV5N5xdn6Zk922yIOmiZkjQ66DHXXghwr7T9U3Y687vKiXnItwd1JlA8V7TC1GuKNEejB7LB59FE53a1ZU7FreywqTpQkW+ZIqXWXzQaVBHt3wYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEZdp99H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEZdp99H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896CFC4CED2;
	Wed, 22 Jan 2025 15:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560730;
	bh=lUGLFo1YU+1WlZY0nFGmq9zpvdHQjCd7nb4WbmkKNBY=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=XEZdp99HDkH2p5Dhb7k6tj0XLcrukQl2xaUDi+s0ZhP+A6a4a373umOljxIuGLpEX
	 816JFvmA5FVtAiprzCJ+iQxPMnhewuO0wAdxCtMzhNIF3dPdcsyVRNuvRwmw8owrsk
	 ScUiafkmpaJXYx3XYHDVqBow5kdsKNNXaN8vlevj6GLbjAR0CEZvDvUQKCJpdphK5B
	 vyQ7JDJEjKaN9ZRJx/wgerp+6js2f66R2qfvvTB0vryoHhIX3G0/ukEyF5Sedxg+GH
	 r5KiwmzEOKOLdxZFKySFr6D0kebubsD7bXCsoapj63wgwIqe3Kl7WEGc2JfcI2ITpo
	 fHDbScE7/hcbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 346FC380AA62;
	Wed, 22 Jan 2025 15:45:56 +0000 (UTC)
From: Doug Miles via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:30 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c24-c639f5ed04ee@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Doug Miles writes via Kernel.org Bugzilla:

Bumping this, because it seems to have died on the vine and is still an issue in kernel 6.2, as far as I can tell.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c24
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

