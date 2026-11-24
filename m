Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795505542;
	b=DN/WHrfSlL2WBVPpCExCwSRJl0vZU4KVRkAF0cM7rYwt9t7KDaGA22i7Llf2n8VT7ISX
	 +kLBr4yMMGqCPqh7EzFQNqt7oVn+KLwzMMxSLrHVPfW/JPtWHFixDWlNT9ysueDh5yxs2
	 syUzQNBhN/MHeUo1wlP65hJmRBH2MiJKW6kG/Vfg3d99Vgz30jAECyYC1EBGT3f2GmbMw
	 DLmxscvdQXmXvkbL7Gj2Y/GE3kIZfZZD4XUPs9USZIMUc2cpeqRt+LToG1SH5Cp6t0KHo
	 G2P3qEousL3QF1bln3fAk8yXc8xVzWcYzWy0fps0HuqclpOhdfM9Z29mM8cIAFyHXhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505542;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Na/xHpz56IDcbN0eSdzo7NSqLd3nv4ld6JrP2WnktoM=;
	b=c177aJLcCZWQ/JVbmeF9oFlgLBIyPk7H45/MhxNKB+ZUEMGkMwBAywuP1+tYSFChbU88
	 7NLcVUPFCAsqqkM8GIuUVU8uf0wToIiv7BrIHz1UEpvcCeW0ZxVINfqeu+kAvTGfWaBv0
	 b9JaQzbgK0jzcKLjo0dfFseelFqw/eD1uozN1CdkG3Xd5mgqsWsFoXwDb/xLoB3Uigh5r
	 gsLz7aitwgjpk7PuMMgeteLOANtLDdfVdANTVzSR3V/tDnnA940CnMVH311WwYYECJH2G
	 sYhElcned/VUnPEitlRthpAqkoSvMsmozD0lc2CvdyVaUm+bPgQkmvBoZ9qkCvThMtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=xy2v7FaD;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89106606A321;
	Tue, 24 Nov 2026 07:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89106606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=xy2v7FaD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=xy2v7FaDBe6dSOGJoIElLDjgtXQ7HeD4bMqBYgUp+i1d6JjFFQJ0iGh3bO4JhHOlhKUiF/P7OpTpM
	 xAoF5mUqD88iPyQtjsOAyJAtIy93KcWlrWsntx0r2iz0Uv1dYIWjrPFLnz1I2/YEXDz9tgqRcrnx5o
	 J0u0x89ZyfUpMePY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96b053d7d3bf-4b05d;
	Tue, 24 Nov 2026 15:32:16 +0800 (CST)
X-RM-TRANSID:2ee96b053d7d3bf-4b05d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6b053d7e1f4-18454;
	Tue, 24 Nov 2026 15:32:15 +0800 (CST)
X-RM-TRANSID:2eea6b053d7e1f4-18454
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-acpi: Fix free_irq() of a never requested IRQ
Date: Tue, 24 Nov 2026 15:32:13 +0800
Message-ID: <20261124074000.1387-2-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <1f6cefa9-497c-4803-a027-81e84f6a6e9f@intel.com>
References: <1f6cefa9-497c-4803-a027-81e84f6a6e9f@intel.com>
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

On 24/11/2026 08:16, Adrian Hunter wrote:
> WARNING: From:/Signed-off-by: email name mismatch: 'From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>' != 'Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>'
>
> Otherwise:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks for the ack.

Understood on the From:/Signed-off-by name mismatch: the SoB line was
left over from an older commit and did not get regenerated when I
updated my git user.name. I will make sure the SoB name matches the
sender on all future submissions.

For reference, the patch:

  mmc: sdhci-acpi: Fix free_irq() of a never requested IRQ
  https://lore.kernel.org/all/20261110070032.1387-1-laixiangwu@cmss.chinamobile.com/

Best regards,
Xiangwu Lai


