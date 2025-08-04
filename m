Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBA21C3027
	for <linux-mmc@vger.kernel.org>; Mon,  4 Aug 2025 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754308493; cv=none; b=kOOBnaB0qV2N9NDyEI4z95xoDK7JV6J8Pn9HNfrRv+BGHpE+7mj90E6IvCTjqJI4QM5dnQN5ozU6uLWEFAVW4v3jBwH8U2FUep8a2rl6K4RkvcBpRuhE7BdVVz8Aw24wIhowgZIF5GvR5LyO3YUNXzgh+UDliaO7V3i72TAbScs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754308493; c=relaxed/simple;
	bh=3wYtTguSZ4FNTQqhN/D2/xyWoZYEHEJJOn69MbZ6ghE=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=sLs+xVsPPQJ0zaVBfqTbd040NfN6EFWL04cu5qgiDKBn7WGAqKkq/HcwgkZcXywhl41b3Aip4LBYXkpqZvPKAfAqV/WmOwKjrJjOWeIMiaRM9zXDpOh40x0Mzd50hTbib6jRPDzBXSkofWASKetPzOj0jrNPJrivaOd7RBfTNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLVX0nqC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLVX0nqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42F8C4CEE7;
	Mon,  4 Aug 2025 11:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754308492;
	bh=3wYtTguSZ4FNTQqhN/D2/xyWoZYEHEJJOn69MbZ6ghE=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=vLVX0nqCQJTl+2DDUzUCv3J82B3bDCfp6jst/uAttBCYOqAbrdQj/MpwGYYVdF8Gb
	 +TIptydRSTezZdZ6+GmfSTXSeLZ4V7QV/wtfII+SMYS/E2k7qdLTjO/SjDzD/12me1
	 KbOIYpbRN0XV9zvFm79EUzcnaB+BgYV+vKDhPNGztajiONNwKTbGEC158B2oXissjs
	 jSywzEYp4FjEEhZ/TFKJWYdCY5LtggGxzKviqMgAi4MTpq+wSCKt+wsTHWz71W43SZ
	 0ag2qnuDX5EXq2bFPLdIImT2tfLRsdUzIlqdhvQglEnLW6BiY59OY1uUwnNk7xabBG
	 X0R2VGghigpQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37D29383BF56;
	Mon,  4 Aug 2025 11:55:08 +0000 (UTC)
From: Laurent Bigonville via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 04 Aug 2025 11:55:08 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ricky_wu@realtek.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250804-b220362c5-ed8045a89233@bugzilla.kernel.org>
In-Reply-To: <20250723-b220362c0-fd0fdb0c86b1@bugzilla.kernel.org>
References: <20250723-b220362c0-fd0fdb0c86b1@bugzilla.kernel.org>
Subject: Re: rtsx_pci driver is blocking s2idle
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Laurent Bigonville added an attachment on Kernel.org Bugzilla:

Created attachment 308440
lspci -s 72:00.0 -xxxx

File: lspci.txt (text/plain)
Size: 13.37 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=308440
---
lspci -s 72:00.0 -xxxx

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

