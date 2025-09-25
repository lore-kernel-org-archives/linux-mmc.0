Received: from mail-m19731118.qiye.163.com (mail-m19731118.qiye.163.com [220.197.31.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8012FC897;
	Thu, 25 Sep 2025 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803247; cv=none; b=rS693tfqH464JJIKgRWVFDjPsoeyVok/rcR/QkItWLOGE6lXrFZHPkAMpvtH+X9cb5U/Rq8SufHAUjqtYCNB7+FVtLtctKlH4JI5ZaYl/jTNFYUEEVMni9MtyM6llK6hlpkU+ihgRwYgnnLXCMB1vRhWL0Sfl7s5bxUYyBZrsGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803247; c=relaxed/simple;
	bh=gYBSjV3A3ooxiOPwbQrY6yaQ+S7lDvaqMNSGiSIoVDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9wxnkDodKESzMMcS8Iq9oMHbyyJ5cxh0Y/DMzMm2mz2Ty2oUtmCZeIdONH0DhdJr9Ky9OSQZ63leIy1mD+BZU2OOTDa8ycjpQv2W1QPXU5WbvicGBRe0yPX2/6kCG6jVwCV35h065jdMFwVy2L2p4hDJ4xqouSFfLGzSs78kxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=lMq0Zdbl; arc=none smtp.client-ip=220.197.31.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="lMq0Zdbl"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 240dfac53;
	Thu, 25 Sep 2025 20:11:56 +0800 (GMT+08:00)
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
	ulf.hansson@linaro.org,
	will@kernel.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH 0/9] arm64: introduce Black Sesame Technologies C1200 SoC and CDCU1.0 board
Date: Thu, 25 Sep 2025 20:11:54 +0800
Message-ID: <20250925121155.2401934-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925090412.2068216-1-yangzh0906@thundersoft.com>
References: <20250925090412.2068216-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9980c98bf209cckunm0dbea3318270a9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaT04ZVkNOS0NKSh0ZT0pCT1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=lMq0ZdblTM4Zv2oMG3N+IorP8ydfWF/POg1If0IxGoUdZpVXrgamH/KY+J5nm03NYw1du4yJQMv12lrKqKLjh5RdA40kpajnglkSyGdO8hNpW9vHCtTkuls4L3JFqxzTZqPUg1DjwcWPvdkKPPFQsrwAwYGCOtKsvuT5kiIIRuI=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=eo5MQOkGyElXlEHPuquWDvolz5tCt5MH2A2PG0iQrcA=;
	h=date:mime-version:subject:message-id:from;

On Thu, Sep 25, 2025 at 05:03:57PM +0800, Albert Yang wrote:Subject: Re: [PATCH] splitting SoC and MMC parts

Hi Arnd,

I may have missed an important detail in my previous note. If I split
out the MMC-related patches and submit only the SoC parts first, I
cannot validate the SoC on real hardware: both the kernel and the root
filesystem live on the MMC device. Without the MMC stack (DT bindings
and the controller driver), the board does not boot to userspace, so I
cannot properly verify the SoC/DT changes in isolation.

Would you prefer that I:
- keep the MMC pieces in the same series for initial bring-up; or
- validate everything locally, then send only the SoC/DT parts first and
  follow up with the MMC binding/driver as a separate series?

I’m not entirely sure which approach best matches the normal workflow,
so your guidance would be appreciated. I can proceed whichever way you
think is most appropriate.

Thanks for the review and suggestions.

Best regards,
Albert 
