Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996D93CCFD8;
	Fri, 14 Aug 2026 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748340; cv=none; b=iTstAydkLSP2cwGPkogaTgel6Jj2dHM51QUY7g9cuoy1z70KGhyvl/TXAEPVQecnZSAhJi2+wZG1I+gtgitdSB40XkjQa4VZmUtPE6kIv18jLEhxuBYKo4hmhtT9NqAmFGDca72vM+jFSYxjdJlkhFk9CaNav0QU2IdiHeNhRCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748340; c=relaxed/simple;
	bh=3lvvhpcmPfLo3RfI2hgUUiQ8IAB+s93KzG6h8ovV6Ug=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IOhcxa0CjobItf8LTVKDY7VaUTK8FI7AuxfY2DEqgXWsmFVuSBPB/0ReXwyZ3bhuA577SwBh+9JeUP/yCGYgdCuRQs/A1Nda0ZPIgilNvojV3q3xfqL5Hu0+nBdlRsZ3JM2lR9UjEL8zlzdUR9L8YkeGdzWBpOZvkrOpd9wpn4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvJ6rjV8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvJ6rjV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFD41F000E9;
	Fri, 14 Aug 2026 22:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786748338;
	bh=JtZzFG+XQGrA0nXQ2vpaPVu39Gp1x3qDHcOfiveCxfU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=BvJ6rjV8l+n6jc8kZk05hp+NaeNcFkNf+1rWurIFBwCc66llEyp0a0pBolZWDfkMQ
	 v8AaS/eGFcFIFq/HclJWzR+yUkgsl+Pb8zNorb/IS4eLVjDXvQ3ti00Q4pWQ2cY0RS
	 DBz/9zfFAGNbIldMQeTBT6Vq2YJyG70ak1+84ms7Ja/BRrTO9u7cSdpycNvaXuJ80i
	 xMdQVfFYBSH/pycJ0v9m0dzbvQZSNY4P3N5A9GTuTMTMsZjlj0OZ0ZL2GpXk6b+k78
	 B28XwHnJY5IO7bjgYdPHiSkj7eNEjkRtqPciukcFHdhdC7iEt2sYS7W+Ap9ior2nNg
	 be7VYvGmnvnjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ABC783924460;
	Fri, 14 Aug 2026 22:58:13 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v7.2-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814142010.127902-1-ulf.hansson@oss.qualcomm.com>
References: <20260814142010.127902-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814142010.127902-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.2-rc2-2
X-PR-Tracked-Commit-Id: 00179ed9fbe07799676e2cb63c4e7f0e7cd80a5c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2ed9eaaf2631a4f1c1f3b2fc267aecb2150a7b2
Message-Id: <178674829246.3991221.13495280137669555872.pr-tracker-bot@kernel.org>
Date: Fri, 14 Aug 2026 22:58:12 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 16:20:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.2-rc2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2ed9eaaf2631a4f1c1f3b2fc267aecb2150a7b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
