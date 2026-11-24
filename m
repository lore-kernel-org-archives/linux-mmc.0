Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795495354;
	b=ZQA4ZZmiem9kJv4weRGDux8tfKsC0t7Mr2uag0MpGu0fx6H4e0yaM+hJa9HMjYTZzJAr
	 rvVXjy54/iAvpheqgLKymBU0AC/8ROMV8kZe0YrL7y5884J1vf8iDNM5NiSrlwg2wYBLf
	 i2xz7vV5NcepaLehSKmyMLFEq3fzQ1IDmWl06iTKMOMv3HbmvBuYkNhivOljIu9eM59Jx
	 laQLvJNqwDq8MIXpEypWGDVE1wc8vbdL9BOau2Tt1KiXaVTlEgzD3C2Vj2KTSrjhNEoxf
	 oFIlRsuPXqisdPwWWS68LY33kHCdnl9n8qrpvtANz5M5q3/yn+tcQAh//vF2kqE5eVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795495354;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HPRlXrhuY01xa0JM4zwsAD8gBhn/CJP6r4SC92+UztA=;
	b=A950GNuMoVh1hgnG7vLbOiQTOCW8MBNTFWuRt1iQ/lRf+gobeL/kk2VZi7GH6EvGbYXC
	 YN3WF+6sSeZvyjMmLdfyfbYbtIIgd0bCvn8bhmVEE6dkMHFWzjwDjQ8yQ+/1hbVCuw5Oi
	 HGQZAL8NhfDTkx++M40sUKjOpZWOx3eIgDlhqmYc3fD1Rx4Iw4+IgvKbozStPOOXCy47Z
	 KAugfxnP4o44/oFnEly4yA/cpQo5F1iy0xegVSjX1iRXxRNiJ3y9fuVCawy2//UUtJwxT
	 ay1hB2BF8HBj+rMIfXRtQbhImyaiCR3xB4OrOEenJB04XRVg+pRTB6CrabySTdG/cCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=uZXp6S+2;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9111B606A33D;
	Tue, 24 Nov 2026 04:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9111B606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=uZXp6S+2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=uZXp6S+2BXm8sCtDv6VwhOzZKa5wV7vSwGmAJdyw59d0X7YCmOdrWA9jP7qGZ8zY5uRmgeGxpA3Fb
	 /f9ukKiItES5mVU7M8HGUIWm9+3sSIb3BAoG8/KFlSdLKOP2dUbB6m5jp/URPO3kn8csmjSBdE8LOp
	 e8BzJlEtZl7lmupw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16b0515b6d9c-1fb70;
	Tue, 24 Nov 2026 12:42:32 +0800 (CST)
X-RM-TRANSID:2ee16b0515b6d9c-1fb70
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66b0515b6769-138e6;
	Tue, 24 Nov 2026 12:42:32 +0800 (CST)
X-RM-TRANSID:2ee66b0515b6769-138e6
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-acpi: Fix free_irq() of a never requested IRQ
Date: Tue, 24 Nov 2026 12:42:30 +0800
Message-ID: <20261124023400.1387-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261110070032.1387-1-laixiangwu@cmss.chinamobile.com>
References: <20261110070032.1387-1-laixiangwu@cmss.chinamobile.com>
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

Hello Adrian, Ulf,

A gentle ping on this patch, sent two weeks ago on Nov 10:

  mmc: sdhci-acpi: Fix free_irq() of a never requested IRQ
  https://lore.kernel.org/all/20261110070032.1387-1-laixiangwu@cmss.chinamobile.com/

The patch fixes the Intel BYT/HSD/AMD error path: when
sdhci_add_host() fails, sdhci_acpi_remove() still runs
free_irq(slot->host->irq, host) on an IRQ that was never requested by
that probe attempt, triggering the "Trying to free already-free IRQ"
WARNING in the IRQ core. The fix keeps *irq at 0 until the request has
actually succeeded, mirroring what the sdhci-pltfm probe order already
does.

Please let me know if anything else is needed.

Thanks,
Xiangwu Lai


