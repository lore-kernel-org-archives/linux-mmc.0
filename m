Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF1A267721
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866131; cv=none; b=IzUfA2De8hSVxLDgvYZ5DJM2ylVMq3SmpPvbxAx4xBDdirP9sdAjMAi1ICDNcD2S4+7Mpl80oFIx1ejEjAsRpD4mGPT5yDQDhVLmuQy7/ss29TAN0F/SzKLOqyRWPbX2B3k1b96CzZocD22VbQXneroiczurVwMmtD6UzaGdvlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866131; c=relaxed/simple;
	bh=Yoysdxzc8V4/Vswg/klW1SBl/4rm1ikEpuyLDraaSV8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=FNLVkYjXYdkpnrVj/SIOsi9sNCRrXAbK3SvBUnfZDRMdiXXj2dTDIG5rWKBfkcWeUm4/0dLEsnhusuhgMJ1Yj9fPNTZ42VNaGYfYAQsaXZcswEhm+NQxToxznDOBEoy6Ucn2kjHLUdVFYoOKcM8vv4Irhf7kxVfe9aFZjikbWPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EtaoBcU0; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EtaoBcU0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750866127; x=1751470927; i=markus.elfring@web.de;
	bh=Yoysdxzc8V4/Vswg/klW1SBl/4rm1ikEpuyLDraaSV8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EtaoBcU0DrOnsph2SWBSR6WL0lWvT+6P/uurx3+yDr+s6pAQUcAy56iXehumNFLn
	 5wIBFlunW7ISSX25Dh/u1Cz8LGYcpbsFHQMctRogLTZX7mmFkmSyNP05Ce8yna1Ip
	 q9axe0EVvWE3ApkxlS7WqHgHbW0TnOl+o4oEsc9rH4Emznw0bdjXWZzN2GQKjpHbh
	 19vO2guMkisvjo1P+qn8xLt+b+DUOuyBdPUzR29W6wFxvtMtv0hS4Mpub5SpGfTgI
	 SOfUFy7MkMeCWbUCK1GtZkNB/H1aYm8ns/4R7HomXD3gPp6hc88ROtsKbTEt43J8v
	 T5zFIoSMWOECzTzjnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvsln-1ulzXl36Fb-01580U; Wed, 25
 Jun 2025 17:42:06 +0200
Message-ID: <c412a4af-aaab-43c9-bbe0-322b39e4457e@web.de>
Date: Wed, 25 Jun 2025 17:42:06 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-mmc@vger.kernel.org
Content-Language: en-GB, de-DE
Cc: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?Q?mmc-utils=3A_=23define_=E2=87=92_enum=3F?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UzjPGESvMhk/v7V8KnAq28DRbt1KXPs+hp3gBQAcuYTe/lBM57k
 CdX1lPptdWrMrVWaiZ37ry1dBgOQUrI3fQ6AiBDgzl+wd1/wG5NNHWYu+KpZ2KyDKNjCJVX
 v3HIJ+6Um0kPSwLmmR15ES73idr+33H30lpmiNOguTnEVN5zCDRxjygafCvTsmG6VLbyMeS
 CJMLsQQYe3Nu6tiZi5kfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hQGA7i625HU=;IpG5vlRP6GXm4Efl4nbnnaRKG+m
 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

Hello,

Would you like to replace more defines for constant values by enumerations
to stress their relationships?
https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git/tree/mmc.h?h=v1.0#n75

Regards,
Markus
