Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63322187553
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560691; cv=none; b=O1ncwQyc3SvB9OXTcNpTNe3bOVRqWdrVdq1+oFokWpLCDa5LA2JQ6GICGmTGRiGBI2HoAmOwc0ZGy+nFardzZrb+GiVYRp0vPF6RaTITX1x9VD+pkPifdcY2Mc0Y+bHjngoe1m16uAI74FsGmrUECvDcayMpR7IWDxsL3SGvOGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560691; c=relaxed/simple;
	bh=CJM5rfvgB2HdxzNdqf8WT8UwsasMIZYJtS7tbH9ugb4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=bI8bw/+NFnBbM76f4kgmZv3K2euCHiNURgqbt+2lpcX87mtIPkbLgF7pnpL8i4gcMfMrOWCWichwU2yZE2RmJQbopJC6F781s6xDvGKDXLtWzyhpCV97HfMXUA/O3/LdHi8+z9FjrNk41mG7sjKg3IG3UBTW8rnfW6kh9uFAkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIdQ9kfb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIdQ9kfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EA2C4CED2;
	Wed, 22 Jan 2025 15:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560691;
	bh=CJM5rfvgB2HdxzNdqf8WT8UwsasMIZYJtS7tbH9ugb4=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=eIdQ9kfbr1XaMSiymEmIcnhXTX9DwTtnOPME1jFLD+REzcvpbJW8yxzyMK9fey2gt
	 hbb9WB4IhmEWNBSD/Gtb/sZ1hhPWGhsDEknOUijPFkB/4r3RRCcFr+Al5LK1OqZdP+
	 EbyccY5ksgfbj4UJxSMRxn3Eyr224d9Ew4aZigRZ8c3UG/e7RqQ3PeozhoahAmNMNy
	 5WUscgrMjiKVprSbPu0HS1W7dOJKhGUkH4gOjYE/C64AG9Zqe4Vj+1yAbyfw37wuCm
	 ZnRg0DlrWjaPPXgZ38wmaX5hRYCBs9DVQboqHJ+IwPTuuqZ+tG7hRMfN/92k9AC2MA
	 9qiX2MZjKA7aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB126380AA62;
	Wed, 22 Jan 2025 15:45:16 +0000 (UTC)
From: josiahspore via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:09 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c3-03c2ca607021@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

josiahspore added an attachment on Kernel.org Bugzilla:

Created attachment 283455
cpu info

File: cpuinfo (text/plain)
Size: 4.56 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=283455
---
cpu info

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

