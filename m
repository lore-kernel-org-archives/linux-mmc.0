Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795571163;
	b=LE89wWctrVqg0qZwhhU1zTZu03j+uEjwSXUIi6fa0HGwePFfHFmE6F2jcfzdNItB5NFT
	 CselWA7ZMa0AWaTNbgUj3LpTREXx3CkLEyrI5wSLd2WAjvSt5TPeSX4Uy/JF/dRcb6VhT
	 E+n4KJwL2sPjpvuuC4FbmCfEjZJR+wZYm99+GSOSNQXCpebRTeUuNH4hNc0TYU8FrmXUM
	 yjHL8nGEaiaNU2EiiMf4LwzFZxh7bonR30UEorETyIJaYy5Rz1FPfc1YRkvTKVHrwZQDY
	 tJnrQXkWdT9SaN+TSwnhAPpUNZSd1IHLkI+w5JiMaxAM6dbK3U6nz47kjVAL8y+zmTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571163;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TeTnovkauwzR0I7HmMwDZdwEJRwZzHMfctTgYRdrwFc=;
	b=0XYHgt92txjq1DuJ1MV+z8fTnegfD1ENl4BFKTUAQ0vWjJHjOK+zojWvdjcCo3PQN7ce
	 O6yFKsoAX5RaYM5CBIMzQZ50foHg+lSYJdcMPZGR+05TlIKob35KUq8CzMtShLNZwO/HJ
	 nJ2BZygxyyHKGuT4E1KjLB8V6ixLFSsczxPRynWW784RoiaO7Wf/xQu15dxEXKgol2btJ
	 4IcbURzhtG597vYqQXiwAEgJIMds90FB8wteYka+eRgEtfY76Kfcw2Ksk2dZeRUztvSQE
	 Pd5OjmZZrgemljznpyUJLjaDrEtqniuq3oiO0rROYM47EJNF4oTc1hO8riO3zAJ5G6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=BxcXtQJs;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03843606A321;
	Wed, 25 Nov 2026 01:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03843606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=BxcXtQJs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=BxcXtQJsZZmCOCIjtV6GeLiztmJ9hmD2+R6zQ7rYoD029if891/u03F/pTi4vn3lopKRFXPF6HC90
	 zouc4En/7B/TRFXZx+Lei/LM5ne4v2mg7T7uPc+Qaygdwa6rnIc9JXbSv5kJAe1SsV1TKdcov0O5pM
	 UXfljaSxhnnota5U=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26b063dd6b9d-88402;
	Wed, 25 Nov 2026 09:45:59 +0800 (CST)
X-RM-TRANSID:2ee26b063dd6b9d-88402
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26b063dd5b07-33fad;
	Wed, 25 Nov 2026 09:45:59 +0800 (CST)
X-RM-TRANSID:2ee26b063dd5b07-33fad
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-acpi: Fix free_irq() of a never requested IRQ
Date: Wed, 25 Nov 2026 09:45:57 +0800
Message-ID: <20261125021500.258-2-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <a3fd82c9-4c71-4b7e-af62-8381110b0a71@intel.com>
References: <a3fd82c9-4c71-4b7e-af62-8381110b0a71@intel.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Adrian,

On 24/11/2026 11:50, Adrian Hunter wrote:
> You can send V2 with a correct SOB and my Ack

Thank you. V2 is out:

  [PATCH v2] mmc: sdhci-acpi: Fix free_irq() of a never requested IRQ
  https://lore.kernel.org/all/20261125014043.258-1-laixiangwu@cmss.chinamobile.com/

It is content-identical to V1 apart from the Signed-off-by line, which
now reads "Xiangwu Lai" to match the sender, and your Acked-by carried
over verbatim.

Best regards,
Xiangwu Lai


