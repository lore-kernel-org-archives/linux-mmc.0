Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27C7DA7F
	for <linux-mmc@vger.kernel.org>; Mon, 23 Jun 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691079; cv=none; b=agelvZg+sYi8nhKXwbMpJzK8JwN8NHq/jxRtza0KAjMhvZF+IojINLrsG4319HKasW+/YMxZ+TVPRxhGOwh213rBykRqG74+alrEcD90hcoiGQnv+8RTShND0XuLrPcKqS1hBzNrriA58jZcUX4RE/Wx9NhPlokhP/5mzE16JIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691079; c=relaxed/simple;
	bh=JbsM8EgSBLNtZEMn/i1/qv9xPJe3PL94qtvxDPCbLDM=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=o4WeQfTqlmqnTPcCwk2nwwbPu3FS+8G9X+rRjze9WJa5a3ilsJATrk1KlHk3KfzYQaGQa5dPW0yFvQ3FMdNvNX4h7tEkWtfeDzqx3Pl00lhm3XMi1RDw/zkFytDBsyTrmC5LM0MNAb7AdIzcZ27Yq74Ndd8+1ZNcJ2JeBlpC61A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zmy22y5A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zmy22y5A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304A5C4CEEA;
	Mon, 23 Jun 2025 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750691079;
	bh=JbsM8EgSBLNtZEMn/i1/qv9xPJe3PL94qtvxDPCbLDM=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=Zmy22y5ArxHEtICE0gm0cmlWuATOdZRaD+KNMS8GKmkFyhiLmSXHfmQI6wBccQwl0
	 aPS+KRC9s3biC3J0blvlBpxmCeBZ4dj7EL4WsoGGD22Aj2gV87Z8L3ugHr8sDqfzye
	 /0ke39Lrzjm09zlNAtfoXuBapt8U6ntQd4tf7YvIJEej4hDWllg0iDh+QTQYmHFcav
	 MIrWavbgLVi6i0fVaA4RU2Q4xyEwwmeIW2Xp6FyRhzD6ySLBvH7Hvd8DxEyTnCUIxc
	 w2q7lb1YVLTskbK/KMt6pyZoeoZuB8IAbV0ZveNLTNCuiAJxF2h8zszvekUHcQnFK8
	 8GXdVwtRNduOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7B9C938111DD;
	Mon, 23 Jun 2025 15:05:07 +0000 (UTC)
From: raoul via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 23 Jun 2025 15:05:07 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: victor.shih@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw, 
 ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Message-ID: <20250623-b220103c4-2f0c325849d1@bugzilla.kernel.org>
In-Reply-To: <20250510-b220103c0-216fec070bba@bugzilla.kernel.org>
References: <20250510-b220103c0-216fec070bba@bugzilla.kernel.org>
Subject: Re: UHS2 init fail
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

raoul writes via Kernel.org Bugzilla:

Ok thanks!

View: https://bugzilla.kernel.org/show_bug.cgi?id=220103#c4
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

