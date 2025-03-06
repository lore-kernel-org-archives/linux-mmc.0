Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F81DF759;
	Thu,  6 Mar 2025 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251747; cv=none; b=JO7Hl1bkT+VGaIz1hCbnRfHvj0cxzD7moAmwyjU4oMaPHZ7QUvwDahwxcLqgD0Rop3igE9engTPPzD8el3ilDeC12H4OhsmlvEXaZCBA8g7o7F7Nk7tHmq6QLCLyoeI4pnawwsHr3x+0mu9P7xIBYFqjVeKyj9HC2rHZ8/gSIDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251747; c=relaxed/simple;
	bh=D9/WEW6tyPw9DbuSZopa9attlAEU5bOtQtJOBNnThlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fN02le5vkwQoB4H5sOq7BKybK4Z/aBRGb91v9bL4qIuWESP6HjyW2zU/HH65bdV2NX8ToZLVzH0kmCsAAGX39WubR+jfhSMLxcATxcZl8MjaJqaO60O/eeFH4jnhi80QkEwLiQgnvIBXcrblbsIxiPiBHrT9/SyHy8JVIvkTtiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id d2603c59;
	Thu, 6 Mar 2025 17:02:11 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 0/3] rockchip: Add support for onboard eMMC on Radxa E20C
Date: Thu,  6 Mar 2025 17:00:01 +0800
Message-Id: <20250306090001.113127-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305214108.1327208-1-jonas@kwiboo.se>
References: <20250305214108.1327208-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHR5PVkJOQktIQ0gdTE1MGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktISk5MTlVKS0tVSk
	JLS1kG
X-HM-Tid: 0a956ab0e16203a2kunmd2603c59
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDo6Dww5SjJKIjwxDjgIPkIR
	AS8wFENVSlVKTE9KSU5KTEhJQkxOVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQUhISTcG

Hi,

> Driver changes to use different delay and tap num is needed to be able
> to support HS400 modes, something for a future series. With this HS200
> mode should work:

I have tried HS200 mode on other rk3528 boards and it works fine,
so can we enable HS200 mode for Radxa E20C first?

Thanks,
Chukun

-- 
2.25.1

