Received: from mail-m49218.qiye.163.com (mail-m49218.qiye.163.com [45.254.49.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB126A08D;
	Fri,  8 Aug 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644495; cv=none; b=sB1oWGMgcMyYKWhwDEJQjMb+R/dJ6QCa+WJtlJ+m7GHFdddby1jku/DgqBQ/Bxvz4pIc98uwxwDFACcqmexsqTwxCwNdqOkRDH2GGixXaUtochZ15ZP/PDX7TgbP8dl8fxRudQ60vZBuO9BEyo7Agd7DwjxvHhKvvSTtlKfT53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644495; c=relaxed/simple;
	bh=UMMram2ZjUHrHg01oacDv8x4L+ZPA3GCACl9UUWvTdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4zbQm8La7wlm1yt5Or6KIAS37CsZVEoohZhzlBMtyjg8yf5Yjn+zqZaNjQ+VBbMC+rH2NL6VFugbwVA7G7L7wCPSloeKrbpxrMG1WBZRYQftBw+Oyyh6piI8SNkEJaiNSxMVu1QF3IGPnkz4M85In1YFBtpVe4WCxSkpw9nxXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=ZkceHxx6; arc=none smtp.client-ip=45.254.49.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="ZkceHxx6"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1ebed567c;
	Fri, 8 Aug 2025 16:39:16 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: arnd@arndb.de
Cc: adrian.hunter@intel.com,
	gordon.ge@bst.ai,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH v2 5/8] mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
Date: Fri,  8 Aug 2025 16:39:16 +0800
Message-ID: <20250808083916.959079-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <05e13ba9-c1fe-450a-a159-9693edce0a23@app.fastmail.com>
References: <05e13ba9-c1fe-450a-a159-9693edce0a23@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9888d59a2709cckunm8a5206c1190d65
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSEgZVkxLHUpCThlMQxpMQ1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZkceHxx67vdS/R2UpoicE+AT3gjvl1GiqBIUpKS9hB8eJ2D7IjDy3OoPF2ZrXikD3M2VAlXkZi5IuM85c2HVbBT+5gg+36a6oc4EurQXxYQ04t3+aTdHLPMmsdjFkBa5f+FCNofuIV1wvvtTgP1pdB9IJEkvYberFJrowrfcjN8=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=ltflQ7gDmvfXjVE4GTV7MCASErUz4ot/JosTdkdTVUI=;
	h=date:mime-version:subject:message-id:from;

Hi Arnd,

Thank you for your detailed review and technical guidance on the dma-ranges
configuration and hardware address mapping solutions.

On Fri, Jul 11, 2025, at 08:55, Arnd Bergmann wrote:

>A more sensible setup would be to have the DMA access
>routed to the memory controller. Since memory on your
>system appears to start at 0x8.00000000, that would look
>like
>
>        dma-ranges = <0x0 0x0  0x08 0x00000000  0x1 0x00000000>;
>
>which means that a DMA to the first 4GB of the bus
>address space gets routed outside of the bus into the
>first 4GB of physical memory. Obviously you cannot just
>change the dts to pretend this is the correct mapping, you
>have to also program the bus controller to use it.
>
>The datasheet for the chip should tell you specifically
>what type of bus this is (AXI, AHB, OPB or something else),
>and what registers are used to program this mapping. It
>is possible that this cannot be reprogrammed, but more likely
>there is a hidden register that is made available to the boot
>loader but is not intended to be reconfigured by the OS.

After investigating the approaches you suggested, I need to clarify the
hardware constraints we face:

The BST C1200 SoC has fundamental hardware limitations:
- System RAM starts at 0x8.00000000 (above 32-bit addressable range)
- The eMMC controller's DMA engine is limited to 32-bit addressing
- The SMMU does not function for address translation in this path due to
  hardware design flaws
- These limitations were finalized during silicon design and cannot be
  modified in software

Regarding your suggestion about programming the bus controller mapping,
we have thoroughly reviewed the BST C1200 datasheet and confirmed:
- No accessible registers exist to reprogram the address mapping
- The 32-bit DMA limitation is a hard constraint of the controller IP

Given these silicon-level constraints, the current bounce buffer approach
represents the only viable solution to provide eMMC functionality on this
platform.

We understand this is not an ideal architectural solution and appreciate
your patience in reviewing this hardware-constrained implementation. I want
to assure you that these design limitations have been addressed in our
subsequent chip generations.

We would appreciate your consideration of this approach given the documented
hardware constraints. Thank you again for your time and expertise in
reviewing this patch.

Best regards,
Albert Yang
