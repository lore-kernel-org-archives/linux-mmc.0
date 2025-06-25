Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547091C700D
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862940; cv=none; b=LToxXHRcH6K0u+dN/6+iHIl9SlYHvvZBJwzfUjJBWrbOqXfzjHgygdyoP63zrca8CzoNBYuetNNtqbwGKMA+p9EHMCzqkCT4EEVHoIr3nebqywGEBahIn+AMCkaReD+Wza4Y8KK0ImYbvv3HXvMBx6dv6F2xf6FcTqGYNAWsYs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862940; c=relaxed/simple;
	bh=RgM9JmWZOh1R4thwPHrnWnF+54eVVRtmrA7eEoTlO0A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fGabuYXQU3r9FsawJlGRVXSIayMWib6DB7mvRfxz8oPNKVHY7eEyeIxj2thsi0PvPEBTcNPyh5s0prOU93Qe/En8G2WUMZ3K7oL5WV9qPMRgWFoMGn8vy9yqxm8j0d58sCX0/LZLNugN6f2Ru43hIVEplqaBUAIftFfBX6Fbog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=r41R7T73; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="r41R7T73"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750862933; x=1751467733; i=markus.elfring@web.de;
	bh=jlZ1WyKq8WY7vLKxx+AU5v/spPm7rYjs+Be6A6PbsO4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=r41R7T73Lt3lRLYF2VfxfWsWCSVeLzm8ZYq3iM+GEDwv8Peeo8aYg9Z3KXKgVs4r
	 cQTST/o70jYb29sWKGgroLkXD0Cq36VsPl0Y3VenBu/ouonb4jOFvVvo6SZi9T8Za
	 FpdChGeLcPx8zihrl2xu/vFeBuVLefYOubzp6cL2doNGK4EKylbRqeCdVI/PR0Wj/
	 gvVFBTjGp9FiIOEiPJcaQfE9rHSK+xBKB8gKWPbFv8xzY35+T4fyAxvpI1Yk6PUWi
	 GlQsyMtiOHMuO49Q5TdR3QxUVvIWRVfyVwa852P0RdEkThJIb96anY8MMCeqOwXj4
	 ddu/sWQIqAbK+RjApw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDv9M-1ucAfh0CnM-007ZYn; Wed, 25
 Jun 2025 16:48:53 +0200
Message-ID: <c89ce826-7ff4-4d02-9c15-7f61c157003c@web.de>
Date: Wed, 25 Jun 2025 16:48:52 +0200
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
Subject: mmc-utils: Remove unnecessary null pointer checks
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sZfJgXksUWfplQN2GSMG/ix0sFgZ+FK6t1n+UkfYk+KxH++J87a
 Sa5R2lltVDFw7Ore8NJp/ipmz99Afts4wzrjeLDlISseUjgcCjBhTioYQyBGJquCculQqVj
 aoWAmioaLn3EDIHSRhIVAd/iU7g9/xoViNCF3AFu6YCKzR1jKCacCOkSl6OvAYuxwBPgBs9
 eiNqy+5MN2WOXtgYK+2eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zObQPgkVuRw=;VVSf6/+M4CDHhDwCC+OhnuBUlWH
 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

Hello,

An extra null pointer check is not needed in functions like the following.
https://stackoverflow.com/questions/18775608/free-a-null-pointer-anyway-or-check-first

* __do_ffu()
  https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git/tree/mmc_cmds.c?h=v1.0#n3424

* do_alt_boot_op()
  https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git/tree/mmc_cmds.c?h=v1.0#n3654


Regards,
Markus
