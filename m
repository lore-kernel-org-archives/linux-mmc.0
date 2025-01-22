Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC5C214803
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560697; cv=none; b=M6p323t/0OvMOENZFsij2NkT2SYs87VyFobNTHxoD5qQLH0pNjzymVVJzV57gsxRA0MA+crFEkO16aErTXO6JKJS9bKiNeDvLqzEyri9kjlaMFsphDrOQyk2hfuHZsjHDJVaCFN+5zo901D4eUdAN4LnGy2WZuQnHVlCIV7mTds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560697; c=relaxed/simple;
	bh=XWW+EkAvQlt/wXEO2gTV0ycDej31nzC568YwhHrsqZE=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=QwKL+oytzu/wXrWpJFPAAXcmyaxcTXJYH61kuHW/JDPJM70I+T+7DpgnyrtY33jvBQXpHvdLNc0k7PONZ+sSzF8zencJFI9JLe63xPxR8QG/UWml0BpH2wMJA/wFfEkuonSCRzwVkz2PMnf+52S7daV9hXEp/+cECSoxhYfWmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkuXjTHV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkuXjTHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630A3C4CED2;
	Wed, 22 Jan 2025 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560697;
	bh=XWW+EkAvQlt/wXEO2gTV0ycDej31nzC568YwhHrsqZE=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=jkuXjTHVsX4B/F1UAC3rfw7PncFlsFs/XIwPGMXbYwJ/x65MkymfYBH06T0bOGSsH
	 WxCx8QkgzThtJQGNbDUXpf9HsYwt239gCz0mrAL5T5AKYQO1m1ujCl014mOz+qoRZc
	 ajHlVK7YC5zabqDQKgW1uBWRaZMxXEg37k4qlwzT3ttOLs3BwhAUQJiRu7UodzJdqg
	 heVFLSCWFPug8obcqHiWynaloNMbTylH8nix6ZOlQCUSZXHU65kGf+Cn6BLi4l5SO4
	 zzvxSNq8KNoqQvkwxdrRelQzbjzVa+AVXwI+6pa7Q5x/t1Qb5/rgIvdbkzxY6dNGYT
	 Xe259sPYoLicw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0C8380AA62;
	Wed, 22 Jan 2025 15:45:22 +0000 (UTC)
From: josiahspore via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:12 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c6-1495a1e009e3@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

josiahspore writes via Kernel.org Bugzilla:

Another thing to add is that 5.1-rc1 is where the bug started.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c6
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

