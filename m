Received: from mail-m19731117.qiye.163.com (mail-m19731117.qiye.163.com [220.197.31.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8E25A631;
	Thu, 25 Sep 2025 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791368; cv=none; b=Hf2iE/T+LwP4aB+Nh7K9mKMoabIh3xUOJZk9wJQR8kbZQikvwf8V8tOXBfc0aSu0tijcxq0Y6hiyv5VJYJ9INEB6T+FVywFVe3D/GxDpxzT2I4YWp3t/bRmv8m3z7eTtFbv9h6FfzkVTE3qYr3einNKAb/4ltWaaGWAI9d1h3DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791368; c=relaxed/simple;
	bh=+25K4/DDFNbUBIX+mJ83av9RMSXYXNjfs6v2m9tj5Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFb2p1B11IOFsmeL7E+4SFW2Kfm5L427AmQIpfbVlGHWwLm3cz3EgASvJFIdnZhPaWdZFm6NknEjV4JSVQpFCQpybmCrHqmE+m4+dRJNLH7/t/JPP1ih5qNu8ESLY1UG6vX1gzIbxRwBtSzXhH11mB/mj3EmENF85NPMMnjhQeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=EaUyY8h5; arc=none smtp.client-ip=220.197.31.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="EaUyY8h5"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 240893680;
	Thu, 25 Sep 2025 17:04:13 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: arnd@arndb.de
Cc: adrian.hunter@intel.com,
	bst-upstream@bstai.top,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gordon.ge@bst.ai,
	krzk+dt@kernel.org,
	krzysztof.kozlowski@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	robh@kernel.org,
	soc@lists.linux.dev,
	ulf.hansson@linaro.org,
	will@kernel.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH 0/9] arm64: introduce Black Sesame Technologies C1200 SoC and CDCU1.0 board
Date: Thu, 25 Sep 2025 17:03:57 +0800
Message-ID: <20250925090412.2068216-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <09b1318e-21dc-4354-8733-866b70696295@app.fastmail.com>
References: <09b1318e-21dc-4354-8733-866b70696295@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99801dae4c09cckunm84ce030b7ee644
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGR1KVkJPHUNMTkseSEsZTlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=EaUyY8h5CHAcit44dzTgBh8rziyTnDfx62RPx1X0zkPa+VBwXUyvBJ5a9I0175tPIT3VBBs09v8NfXhfxg4PPc99k5QeJGpYLE7JmmKKCQslGg05RxuwcZX2mpog+9rojAY1CvqEEHw5UY7EV6npvt2oBHs0szhCugygrqvSNk0=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=0DhrsaNuhSxVlQYKeIzRpHEryPeJrUlat2vNZyj7co8=;
	h=date:mime-version:subject:message-id:from;

Hi Arnd,

Thanks a lot for the clear guidance and for looking at the series.

You are absolutely right about the soc@lists.linux.dev submission. The 
inclusion was an unintended side effect of using:
    b4 prep --auto-to-cc
I mistakenly trusted the automatically generated list without pruning it.
I'll manually adjust the To/Cc going forward and only add soc@lists.linux.dev 
once the SoC base is ready for your tree.

> I'd be happy to merge the actual SoC portions in arch/arm64 as they
> do seem to be ready, and for a new SoC support I sometimes merge
> in required driver changes with a subsystem (uart, irqchip, clk, ...)
> maintainer's Ack as well. However the MMC driver portions in patches
> 4-6 don't really fall into that category, as there has not been
> any Ack for this version yet, and MMC is not one of the subsystems
> we normally make this exception for.

Understood. Not all patches in the series have Acked-by/Reviewed-by yet 
(especially the MMC related ones), so I'll restructure for v5 per your 
recommendation instead of waiting for every Ack before resubmitting.

> Given the current timing, I would suggest that you respin the
> series for 6.19 once 6.18-rc1 is out and leave out those three
> patches in the submission to soc@lists.linux.dev.

Will do. Planned split for v5:

  Series A (SoC foundation) -> target: arm-soc (NOT including MMC driver patches)
    1. Vendor prefix dt-binding
    2. SoC / board dt-bindings  
    3. ARCH_BST Kconfig/Makefile enablement
    4. Initial dtsi/dts (without the sdhci/mmc nodes, see note below)
    5. MAINTAINERS entry
    6. (Optional/minimal) defconfig updates – avoiding enabling symbols 
       that rely on not-yet-merged drivers

  Separate MMC series -> target: linux-mmc (cc: devicetree, you, lists)
    a. MMC controller dt-binding (current patch 4)
    b. MMC driver patches (current patches 5–6)

> If the MMC driver gets merged for 6.19, it's ok to keep the
> sdhci device nodes in the dtsi file here, but to make things
> easier, you can also leave out those nodes in the initial
> submission and send this as a follow-up patch to
> soc@lists.linux.dev once the driver is actually merged.

My preference is to OMIT the sdhci/mmc nodes entirely in v5 to keep the 
base SoC description minimal and avoid orphan nodes. If you would rather 
I keep them present but with status = "disabled", please let me know and 
I will adjust accordingly before sending.

After the MMC driver lands, I'll send a follow-up patch adding the 
sdhci/mmc nodes to the SoC dtsi.

I will also:
  - Ensure vendor prefix binding precedes its usage
  - Trim any defconfig entries referencing the unmerged driver
  - Remove soc@lists.linux.dev from To/Cc until the SoC subset is 
    really intended for your tree

Does this split and sequencing match your expectations? Any further 
adjustments you'd like before I prepare v5?

Thanks again for the review and direction.

-- 
Best regards,
Albert Yang
