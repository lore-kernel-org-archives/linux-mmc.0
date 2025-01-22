Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBB5214201
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560725; cv=none; b=enW/wTmlH6KUXa8M5VUrQB1ptKBD/JI5kfc2ZsDXaUvMFb3QYAKdWV7l6nI24AhgswJmMK0uIrx8BPSLXaKQ0L/2elU5gvtXYRFA4pPdKnzc35trvdiEEFlppbB/ICxLDS9UbWg8LOiqC+N9GKFaXhYd45lV63ii89uIl4MerNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560725; c=relaxed/simple;
	bh=sVkMQSYGQ48n7GHRBdXIPF4iVoNFgNiemJ1Q81mkbM8=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=QEDbL+Ik/EUpCHtz1zgul+vllT4zzVBsZ34zBmzNJQyCjW25eoJHeMaqJivIeN7meJ39SQ6SoY9zRs2ShyPblQusRoCGbuoT/phVBsgDWsUCCEzVT5KdlpCBKHqXg2AxxMlCwJ0hXFSvmCYna5xIV8IYNroylvYeG1VPVDqSrUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btqRLcka; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btqRLcka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407A4C4CED3;
	Wed, 22 Jan 2025 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560725;
	bh=sVkMQSYGQ48n7GHRBdXIPF4iVoNFgNiemJ1Q81mkbM8=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=btqRLckajezVizZB89JXG8N7YPlVoew+UZLyXfAGA6JKPBSPIQbL5vGh378hk9PEL
	 WhAdyFxwwoPxo72+xV6i10mLVikvfjtpAM9eeDP9Jv/EhB5BNhWWJNoIt9AdaBNhtS
	 F56ya4CwAXB6GmAbsMgxNnRUHAQ6jjC/7Dm15BQzFo896DHKFBOo0J5SoUkdoQJVJe
	 PzuMK6HD0bGeLWKTCSFvJrhBddKeLIemNfNRNJUVgzPt/NaROn4dRXITIgvcnM2rce
	 E91fWxd9jrpGBnHfdMC40KXu/RM0sd3fjBIj54G/y91F2fJcIXp1CJutzFIk/4ooZh
	 xliZ7aHH+Qt3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE81380AA62;
	Wed, 22 Jan 2025 15:45:50 +0000 (UTC)
From: Chris Clayton via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:27 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c21-7f7f67bd9e68@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Chris Clayton writes via Kernel.org Bugzilla:

Sorry, I can't help to debug that because the card reader works fine on my NUC6CAYH. All I can say is that error 110 is a timeout.

It's interesting that at comment 17 above, Yannis reported that the patch worked on the same hardware platform. However, that was on an Ubuntu 5.4.x kernel. I'd be tempted to raise this issue on with the Fedora support people.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c21
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

