Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B5214810
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560708; cv=none; b=BeMwFU6aM+RPnpe8lF1sKcv0j5aB8wjuoVJV3UxpuzXlIf3HIlIYbtye20V8wolTtFwUmx5gq8RL31meC/OssHBXD2Y9HSfCScxnGzalBIrGGWRE5/mX7NgsKJzg1hcNyh8CUwB33xc0pjCcFCGGjpQQmahaU+bCCkzg9dY0qno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560708; c=relaxed/simple;
	bh=2zLARWSbzHUNk08SSXBvlZ6pJKLZqgPqEI/No2bnnS8=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=mi7aP2iY8abYlPPoympBEPK6FNthY/EkyTwkk/QcvFBm1MQiG/IJggfXRk9NR7+WFofGsPp8DzWL35SSTPQS+ICqzp7jS80Tl6D732Z/vvwCEHEjLEr5dLGK3j6XtoLA02MG2gH+svrNJiy00xrrdtVeS51VM3sjqSyw0rHWJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7wtOgvC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7wtOgvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42EEC4CED6;
	Wed, 22 Jan 2025 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560707;
	bh=2zLARWSbzHUNk08SSXBvlZ6pJKLZqgPqEI/No2bnnS8=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=n7wtOgvCk6ZpeSM4TwfGLeJ9FFA3GFdBIG6MO5XzrXco2cVVoEXX2vK/4qpx6DK99
	 QrUap8cTugAgJN9ClaudsGaP+Oz/HFUILva0iNQcO07uGFGNeFhtNWWcZ4jWhDTw2/
	 QG5po7gFurb4qhxLqDrWKEsCNSNarlbuJ53xEfBwN+G2S5MSKNc+0ujmEgXBliWKbP
	 jMdjaQKc+yBTsNPQlBItfeeNRzi7DKIIchYE7dtp8uFVyzDXZtAcO6G1Prd0G5hTM1
	 sQSorSab28gLpFsZQmpl02wI9NVhwgIT0Y0Vlo+Yuz9IWLuRgchTcJy6srChHLSSCx
	 973Crp8Ms2A2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C73380AA62;
	Wed, 22 Jan 2025 15:45:33 +0000 (UTC)
From: josiahspore via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:17 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c11-9a1de22a7fca@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

josiahspore writes via Kernel.org Bugzilla:

I wounder if this has anything to do with that not working.
[    2.614469] mmc0: cannot verify signal voltage switch

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c11
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

