Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB51EE028
	for <linux-mmc@vger.kernel.org>; Thu, 13 Mar 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863873; cv=none; b=O5FC2xKu3xf9Dh3qZsuJppEbgab2YexnZN/btJKKYJTr9ou3CAh/Yax+qCaA+1IlkMGdBn8bmdZmhCZAgngoUxUMvYPwCDCpagaZyj95uqibAAF3vswzJjR9V7QpQqjsVsthtxe63EI3ZLZclemONMpRa8j15yiT4FNPWRL4KW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863873; c=relaxed/simple;
	bh=7aTi2009MEBbbw9h3r56rosgSUhiOwt0Tu/yfKq6g/I=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=YHNCNQtkf3Sp0BL3diEcbO09jKVyErCo3WH7B3hls32XqlW9R41U3a77YvZVhQUyD0DLTk8zfWoMZDS//7cDV1/7DwAnbHkT/M/rxrAqQMk7XjaBZYJfzSQCZfdh/y+22Ho5LfBwoekau/NFMjpG059aYi0D/9rnRLmHuSNzS+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp+5/rGc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp+5/rGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189D0C4CEEA;
	Thu, 13 Mar 2025 11:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741863873;
	bh=7aTi2009MEBbbw9h3r56rosgSUhiOwt0Tu/yfKq6g/I=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=dp+5/rGcnyOi45p4W4WHU/PaDlyhS9gw8Cpsdfjchv5x5slyrI1L6s9f+rvPlinV4
	 /EKWdcD1Oe1Wgl4K1pK0AH1f5DcGWsYPOCFkFhq35dPTZ6Tb2Usd9Wp5y5x8hfI0/s
	 akGL1hQQ1iUR+YwTEJgovJVjsf1GNO4ydUx/cumDVS6r8tZNE2quOmsebwbYeDJxEP
	 LGtkg2p+3vkdTTLD9JjZ3hbSuVBZsaxuN20ecSiip/4cFgewRuNU6EdZvflS7NmMi2
	 2165acKxYu+wUpRUhce35D1YGlEd0Vnh7SCK5/wsdnPGbpzoGKzMn/ecg36qgfeAIt
	 tVf+5qFvls7/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4FBD3806651;
	Thu, 13 Mar 2025 11:05:08 +0000 (UTC)
From: Thomas Haschka via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 13 Mar 2025 11:05:20 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: thomas.haschka@tuwien.ac.at, adrian.hunter@intel.com, 
 ulf.hansson@linaro.org, ricky_wu@realtek.com, linux-mmc@vger.kernel.org
Message-ID: <20250313-b218821c16-4d4368864149@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Thomas Haschka writes via Kernel.org Bugzilla:

As Uffe suggested i tried to remove MMC_CAP_AGGRESSIVE_PM from 
drivers/mmc/host/rtsx_pci_sdmmc.c

I add the patch so that you can verify what I did. 

It did however not solve the problem.

All the best, 
- Thomas

View: https://bugzilla.kernel.org/show_bug.cgi?id=218821#c16
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

