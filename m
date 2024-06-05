Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC0197527;
	Wed,  5 Jun 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589594; cv=none; b=dQiLlvtKGhfLvyZb5eoLsSGae/VV+X68fzTRLMoPmEkNYW/PNnr8+TXq1FoXbj/iiiqK8WSO7a8Av9cThqY1nulfPx84SW9yh1hwUTMh69uE3so51cw5JowjCRTIQtq0D9biCuIL1C5f3mJw9Jn94wZyvGa+owE1Sf8i+8r+E9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589594; c=relaxed/simple;
	bh=KquR/qVX3Bfj67P/WWEDL2CtUe6KxjKA4k3e1DojbFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XlxWDxyluOB5Lz58BtXzhq/plOdLTbu7pU2f/TBdf44MblE3zfAuTO66bT5SdF5Mm6Lw/Z/qbi2wMpI4sQ0bB6rtRf3dEWIXxwDYowN2oOXJNU8z4wIzu6gD/V33XcJsIz4Xhseth/wRftcSeACzJsr/ufvYVnFuu6m9B9dDJ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H27FA7rG; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H27FA7rG"
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A9D8FC0000F5;
	Wed,  5 Jun 2024 05:07:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A9D8FC0000F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1717589233;
	bh=KquR/qVX3Bfj67P/WWEDL2CtUe6KxjKA4k3e1DojbFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H27FA7rG4T0cLUUFumTG7nIsUW2aH5Gz0fqTkaW5+lWjherjlJc+2tSsCvN169o80
	 r8N8hDvh3KkEMs/N5XkSNeRwHlq5B3rxwO9IEGAuMSDa7OMhSdS96X27QWKAvZYfIM
	 5R3ln8YOavuc6GHch3wybngblyEQgzUaJmWcHadA=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 796E718041CAC4;
	Wed,  5 Jun 2024 05:07:11 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v5 4/4] arm64: dts: broadcom: Add minimal support for Raspberry Pi 5
Date: Wed,  5 Jun 2024 05:07:12 -0700
Message-Id: <20240605120712.3523290-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <874589f6c621036620cca944986e5be7238b4784.1717061147.git.andrea.porta@suse.com>
References: <cover.1717061147.git.andrea.porta@suse.com> <874589f6c621036620cca944986e5be7238b4784.1717061147.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Thu, 30 May 2024 12:12:01 +0200, Andrea della Porta <andrea.porta@suse.com> wrote:
> The BCM2712 SoC family can be found on Raspberry Pi 5.
> Add minimal SoC and board (Rpi5 specific) dts file to be able to
> boot from SD card and use console on debug UART.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
