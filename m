Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836B5211A18
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560728; cv=none; b=j1S03f3T5J7p4vuY97lCd5kDDBxautCCAKhggTXLfNNQmHiBOp2FwC7PZ2aLyXUmGHIhnB2MGnG7ADi6sV/0O2N127qmx1Ql9z8LMjqhNyYTS7eBQuBhmg8amUSHUaNwx3kk8JyEzlWwQfDJLlj/76Ibk1SC0ToWF4D98LCMIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560728; c=relaxed/simple;
	bh=2x6dAogg/rPQqM0z3D5cqABmKJYMkr6g92REHYxcKA0=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=Swqxlw46UQSXtNGy4gH2wbYWnKNHv3QDnBKE6V22V819yMMouODZwB5f4UibBA26UJuhkiXyGHmt0gfn8mW0bN+ur2sGcLcsjI4Rb6CkrlHheLIlt6zxgrVrmJ14UyGopZXCo+Wk0LmV0VY0KXRthmRaRvOgX47KLnR6cZc1iY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzq95ABL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzq95ABL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044AFC4CED2;
	Wed, 22 Jan 2025 15:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560728;
	bh=2x6dAogg/rPQqM0z3D5cqABmKJYMkr6g92REHYxcKA0=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=hzq95ABL/m4Bsf5bqXtMFE05A5vkSZfaYTdWvvTulWMj1uxXlXImpYEvOe8IAYFsA
	 oPV829Bipo9hniLE+itj4oXVUvQY6PwpSvEa9mCt063Gr81+NxZsU9+vjxUUvdCgmH
	 dKU4q41NjRxDpxa932T6BYpgNJ45snH1u5uJN8SiSCQAQ1zavbmm5MeeavoP2SiRAe
	 tmNLmGRQssQ94eTWGpVDyBH85ayUhUj697bLulTOdtSBVgvs14gYYNPCAwJNz5yV5O
	 NK/xzHbDmHRBXX/YTy9IVIQnLT4UrbdvLSoa4Nm0Sp6P1kTOShVWXZJjZ+d3nryEiq
	 Bo1ZP1iyBqgZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE27E380AA62;
	Wed, 22 Jan 2025 15:45:53 +0000 (UTC)
From: Scott Brown via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:29 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c23-10ab6dd52467@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Scott Brown writes via Kernel.org Bugzilla:

I see. The two cards I have tested with are a 64GB ADATA MicroSDXC rated USH-1 Class 10 bought in 2014 and a 32GB ADATA MicroSDXC rated UHS-1 Class 10 V10 A1 bought in 2018, each in a micro-to-full SD adapter. I will see if I can scare up some other cards to test with.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c23
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

