Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D60360EC5
	for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2026 03:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788406152; cv=none; b=usqc3SwJbJJvNDK24a/gIl6Q/v1plDrPW8fzU/ADy+u4p3zYw9sUPq6tySqHTBHl9DQ7Ko7DNmHvnnrhQN6xcGZse9iX56cLJKEtnb1BS1cvbwh143sRuy3dih2pKNwNRIv9gn2jv+yzMBR8Dp2d2zLaaUQKPZw1lOeNLAkmwZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788406152; c=relaxed/simple;
	bh=WaEq0oRkEcYbCfT8ZdzPK3UROlgtnMIJUAo/u6CFD9M=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=EycIs4vipqi5Uc0TtE040lqdSft1hP87+1Ppy3OsjfrgcRvr0LmQ0M+Q4NI7DG+Y9gOHu2ZWMmadnHfcKN6dX1V3Vu4JEXu7i7ifcMEXOydyYg7LMCOb9mHD6SQ2wz7FfU3FMM5WAf0037Yx5QCfjzKsslwYdqNv8Tz5G5wWa+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=WufOYgvB; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="WufOYgvB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1788406144;
	bh=WaEq0oRkEcYbCfT8ZdzPK3UROlgtnMIJUAo/u6CFD9M=;
	h=Mime-Version:Date:Message-Id:From:To:Subject;
	b=WufOYgvBohAqWUeYoxGp9MA+uWSuGLqLfXalYl9mpjiqLp2nQI+iUK9rlknQGF1cF
	 DjKjFDW6eFJCX4mxxoIirXWUT4NeP3IbOwC+zm90RYbGO8Yjgt7wcNRtHfbF/+0fdY
	 cnUFig/Ag0gCZU3s1amgo5wiIwtRBU7IYMEuwgO8=
X-QQ-mid: zesmtpsz4t1788406143t032f900f
X-QQ-Originating-IP: LJ5LtijfxLyByKUO0WSeF4CNc/Be8prOeq+pDULPaqQ=
Received: from = ( [183.48.246.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Sep 2026 11:29:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17379667977984956232
EX-QQ-RecipientCnt: 13
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 11:29:00 +0800
Message-Id: <DL5D2ETDDPX1.3QTJ53KUA3JED@linux.spacemit.com>
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Yixun Lan" <dlan@kernel.org>, "Ulf Hansson" <ulfh@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Adrian Hunter"
 <adrian.hunter@intel.com>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
Cc: "Long Wan" <long.wan@linux.spacemit.com>, <linux-mmc@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] mmc: sdhci-of-k1: Set clock-frequency of io clock
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260902-07-k3-sdhci-dts-v1-0-4e7909cf4233@kernel.org>
 <20260902-07-k3-sdhci-dts-v1-3-4e7909cf4233@kernel.org>
In-Reply-To: <20260902-07-k3-sdhci-dts-v1-3-4e7909cf4233@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NjvE0m4d9WMkmmrWcLywvNhHuCyU0V79Av3HYD9dIOVmNf5/0qnhBMeF
	hJrtjRFOZLTQmo2CBIx/ZHJt74AtGocuK8qtBdiVsXkWUDpHT2gnYmM4yqgn+wB8XxSBpaq
	dnhIhe1fupbd1tJKpGMqEQqlq9OsJuNiD5UTYUpNhwrLur8DkDm8rVmPLUqR25tBsoqGNVI
	mAn5gkOnzHh2bDP/QTPpVHzHxgcWDyvK1nI6QgrBetnclzX8mw6o3OwGbNQo49DwV97tvBK
	3vgfDV2nkjKWo3qWLyk3w6SXk86FG2eKqquQut7LNAbpZCkl3xvm214TITvlxROiJqURi+X
	0HpzsEheso+llhM7wDjShBcB7sQ+u1QX719b4T0A6enqJY5gYVJOu88fM0jfgM4gpcajoQC
	hfWZCYalcjiQjE1vLuQmtr9r3qbktuPaWP497F4b+5BobWM8yea+v3weZmz+ihtxp5Ksa2t
	OZaD8CT9IKngnBG1CCYUtC+obKF9jOffQIg9NLYdJAyo1nI4Kaca5kBmLbY+sKBN7D56Dns
	92y6JME35HKRkYRChSTERT26mJy2jRdCU78O+nOBCOJKzA6/R8fF3ASQY/MgFsCsDBHUM8g
	YkuqO2A85//wEb57Y8iQpq57gfXUqlLcOev1b9ITNDQpMkYyxtKwTp6h+wi9Rhv0582TKNK
	MJSeAAQZbL1nf8gUEogJ0Yodduus/I/ii9Sm3rTRqiT1V7jcJZv60o9JyU0BGIj8+y6SpaD
	bkElg+QuCEvevxbt9AHBhZVAlLcSou1Sf46K4CeAVrqiVO1JToA6WI6ZO44Ce+7ZM5gtKiA
	Zt5O+ZhiUZrdJJEU5Ti83ZSyVYzx8BcYaDsMgoYGNQqcxuHQA/ervcmRcx25jZFaoo7m4Bl
	RZbOLbXKjQqV42P9MvqAlsGqpVLyeh+s9QO5oJfU1f0abOlcSZgJUbsCFDGHpeihPmdAVHy
	YICbxOgAQBDFzGT66jscUPflBn0JaG+WLO0V4EqHP2mnWIpl+ZoP6alCUlLyQO6vt+Rjs3v
	I73IMgMwFu0crSRJ0f+34PcH2ROTMt1WCYNt+xaXzQWpQWyO2eLwIeryiFlcPLGMI82+QT/
	LfpVS+wNWGZWRHKJoChZEW9EnNYPxU/Q7EhOmqbWyVSku8WNw4kpmw=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

On Wed Sep 2, 2026 at 3:03 PM +08, Yixun Lan wrote:
> From: Long Wan <long.wan@linux.spacemit.com>
>
> Add a clock-frequency property to set the rate of io clock, for SDIO
> case, a clock frequency need to propagate down early.
>
> Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
> Signed-off-by: Yixun Lan <dlan@kernel.org>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
