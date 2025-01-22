Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E324214812
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560689; cv=none; b=D/vB4+sAz/6govJzLhVR2uUmHgRXb9urLM45BZxh8w8r8HdgKrm9JExdfMlk/zkXxcSM4USVje1+ZGCgIg1pGQvgyUFf+/Gjg4Dj6Whv67VZCPGOWBTQoj0UZeQkX1dLhjMdsXOfu1AHs2ElE+r6IbZObZwCYoe1BR4c/jgN/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560689; c=relaxed/simple;
	bh=SawcTwQgIV32y04SNeBVaI+3UunobY1TP+GscCoP2xs=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=Jf2H62xKF9W++8Ip8ztqCcsiLv4kFTH8zEROfIgG38pOhe+uaUB2Y0rjOZ+paP/YOG00ky8W0SovsTEDQTsYo3KuZluH0+ym78RGVZEz4sllvRmPbkuQRobKlaFQ4KmcERBFT6e+My+eoi69gS2h09n0KXZLPObn0nz3DEqbRzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlNcOhbd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlNcOhbd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D39C4CED2;
	Wed, 22 Jan 2025 15:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560688;
	bh=SawcTwQgIV32y04SNeBVaI+3UunobY1TP+GscCoP2xs=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=PlNcOhbdJsyljO9AWGVa8uHmsvoQOqAtMupI2eWhLO5u2Sj3YCeI33PAPOfL5jSC3
	 02sbxcCUCbXjwNFm8d1yMog+c7aGMldj1EHbt3z4VNbxP5Y6WAWbbw10OckrzXq0D5
	 Ijl4xeH2qgq2Y06GIiWIRkRGbNFDZB6qsPyKX/CuhnLWGfMY0CeabjiLvjvY6dCuBW
	 PrGeFr+hGeub3qw/1Std7KqNqCrtBMc02xCXrZlcBdBJmxA946Pp2F4LbuR6KIYII2
	 xlG3BbwKaWpIqJDmGP6aDOFhp/DAql3DF1bTSoM7oB6iAhpAvN9c2VDa+tCKYwrPgt
	 7s8fZSJ0W3zzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710A2380AA62;
	Wed, 22 Jan 2025 15:45:14 +0000 (UTC)
From: josiahspore via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:08 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c2-293ea5ea07ca@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

josiahspore added an attachment on Kernel.org Bugzilla:

Created attachment 283453
cat of /proc/modules when stuck on initramfs

File: modules (text/plain)
Size: 1.39 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=283453
---
cat of /proc/modules when stuck on initramfs

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

