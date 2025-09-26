Received: from mail-m15566.qiye.163.com (mail-m15566.qiye.163.com [101.71.155.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB1DC8FE;
	Fri, 26 Sep 2025 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758851302; cv=none; b=OVvvUSFqIFv8JHtim73XSHfuLLVoVcM6yDeKuR08wWPvRIX/N4PLiEskxMBx7z/2iEcOsWHSw0oeyVZv+1VIfEJAEmX1xnROJG/FrTiVCPkNJQ5vVQt2aSu9Bf6geKj8AAbCixNyOrMW8AI5s9JdIkr51GquOlY31PCDLini3FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758851302; c=relaxed/simple;
	bh=P8696kRKlLXhdw5Ol12Ycd8Gx0qPHMwpsnEK69OxTsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/SzcdWX+BZS+to2Z0OQXfr/Vrnd2W2i5vaBIzXPTa6SHZu2RBOiCbhh2W21CawmXELuFb12/PcgkmLb1ZvXGUq5EDuv+IveO9zoaWG7MbttjEXJ2YlMSJM86nc9sKzEt5MCaj+frqY1if2StWZZI86dg9iEe+2rq2Ws3SMG+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=dw80sa2c; arc=none smtp.client-ip=101.71.155.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="dw80sa2c"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 241b800cb;
	Fri, 26 Sep 2025 09:48:08 +0800 (GMT+08:00)
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
Date: Fri, 26 Sep 2025 09:48:07 +0800
Message-ID: <20250926014807.2919409-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f64b0e00-1c30-47a1-b6b0-1bc28cc7f8ac@app.fastmail.com>
References: <f64b0e00-1c30-47a1-b6b0-1bc28cc7f8ac@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9983b4cc3a09cckunm02b014f18bacab
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHRpCVk4ZSx5PTBkfGk5LTlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dw80sa2cDL14SK4ldMNnUd3MPXuHA84uZtjN7fE0A7GNysxx1MCj/4tXyZeh8fFHSkI2wIYFXO8PFveocuCppX18lLF50mod2zj8AZn4RZDP4tRcH7BUrrkyRUszhdYd3iyKGdlpsEOGdI1Gw28c789g7ED83x2vuJyULwUzEqo=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=uL75prvgW+wJB6okTWkfXgiVRAHI/46T0CBY4F1eUuY=;
	h=date:mime-version:subject:message-id:from;

On Thu, Sep 25, 2025 at 03:38:44PM +0200, Arnd Bergmann wrote:
> On Thu, Sep 25, 2025, at 15:34, Ulf Hansson wrote:
> > On Thu, 25 Sept 2025 at 14:12, Albert Yang <yangzh0906@thundersoft.com> wrote:
> >> On Thu, Sep 25, 2025 at 05:03:57PM +0800, Albert Yang wrote:
> >>
> >> Hi Arnd,
> >>
> >> I may have missed an important detail in my previous note. If I split
> >> out the MMC-related patches and submit only the SoC parts first, I
> >> cannot validate the SoC on real hardware: both the kernel and the root
> >> filesystem live on the MMC device. Without the MMC stack (DT bindings
> >> and the controller driver), the board does not boot to userspace, so I
> >> cannot properly verify the SoC/DT changes in isolation.
> >
> > At least to me, I would not consider that a problem. As long as you
> > can test the pieces together "manually" that's fine, I think.
> >
> > I mean, the platform was not supported in the first place, so it's not
> > like we would be introducing a regression - or break something, right?
>
> Agreed, it's rare for newly added platforms to immediately have
> everything working, and we can still fix things if they don't.
>
> It's also possible to test userspace by using a standalone
> initramfs with a login shell or an automated test suite, but
> I don't require that.

Hi Arnd, Ulf,

Thank you both for the clarifications.

Understood regarding validation expectations. I'll proceed with the split:
  * v5 SoC series (no MMC binding/driver, no mmc nodes in dtsi)
  * Separate MMC series (binding + driver) to linux-mmc
  * Follow-up enable patch once the driver lands


If any critical fix is found while iterating on the MMC series, I'll send
a follow-up patch depending on timing.

I'll move ahead with preparing v5 accordingly.

Thanks again for the guidance.

Best regards,
Albert Yang
