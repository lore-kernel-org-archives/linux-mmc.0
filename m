Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22092D052;
	Fri, 13 Sep 2024 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245754; cv=none; b=m0hUmKwK9X9tnxVxOjjQCVBti8eCDCxba0e99Todwm7s+FTU9mlJfw1V3eq5XSti7g4j5um+IGyMdpvXcht6P+IlgxMiK+IrfmDc4e/HH45RZq3ld/xiLbzE/t9BAW9JLvSW3rlAOw43ceouX0fpalkW6K83klHcoxqX5L9fQOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245754; c=relaxed/simple;
	bh=HXIfKdnG22exxAV+fSAOXl1qXmyMtKHpkEy00UN8v14=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cvBbdhCXN3ATwOlKhJUWhKgGGyNCy+7Nh+rcXQE52T2xC79bO76mkpPV6bryKRb0tVbO75sVwtPg6yj331pbxI/h9iI00pbpZBhOJcDTNkEh2cBt/bJhGrmEM8/Zm8jdBy258oZpKE+09FIomGMJciXSswY1g6JJNILD15voF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=p7dwqn5h; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="p7dwqn5h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726245740; x=1726850540; i=markus.elfring@web.de;
	bh=HXIfKdnG22exxAV+fSAOXl1qXmyMtKHpkEy00UN8v14=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=p7dwqn5hOfV2UKVvdOg+cfcAVvzWZVvi9tMRnTVq0DQJorx7zgx9XXW8XZj054Vt
	 EiTUbLD5liumry+Dpv9w9Opkcswg/4ZqZv0RzBhGPNtIqBg2Zk/zxAMNZ0DNMEJu4
	 43CbwE705LyQ1SINoWOFhYeIy7TwhfPY1RtofcEP8+jYWDnGlsF9nGGfuWpXUqmMT
	 w8V0cIvgIi7/JBidxH0A6CgY1lffQxBXbrvWa8A3bwzWxMhnlViNM4R/ehncKemqX
	 hIWR5k/bSpw4lSAtQzKKfGCsCAXVACCP+XWgRoeZDbV/oQPgrb2wW20tGZdJJJA+x
	 psZ9nUM7BUi1qHGIBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDvDi-1sfDjs29jg-004tLo; Fri, 13
 Sep 2024 18:42:20 +0200
Message-ID: <1016953e-3bab-4acc-a167-27656073feda@web.de>
Date: Fri, 13 Sep 2024 18:42:16 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Akashi Takahiro <takahiro.akashi@linaro.org>,
 Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>, linux-mmc@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ben Chuang <benchuanggli@gmail.com>,
 Daniil Lunev <dlunev@chromium.org>, Greg Tu <greg.tu@genesyslogic.com.tw>,
 HL.Liu@genesyslogic.com.tw, Lucas Lai <Lucas.Lai@genesyslogic.com.tw>
References: <20240913102836.6144-10-victorshihgli@gmail.com>
Subject: Re: [PATCH V22 09/22] mmc: sdhci: add UHS-II module and add a kernel
 configuration
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240913102836.6144-10-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QeA4gMO8b1UNSDpdTs7WI+aozQyDW3a6pLGEyD8WxSbigZW6j13
 L9OjZzChwA5QUbA0jSRakA9iRjlC92EG9/iA9JwLnC+LRNOF9elTCyHQdrH8zV7JGBUZlX7
 yXE4NA0uCBeRKTP0FgRYPB7PPBSSrMjQuPXkU9vbxwZcUQfsznCS8pr3aHXhbxwtN834SCu
 HRwM/Yjnq8F6dD0ok6IRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:taiSzN5xeAU=;3sn3Db6WJaEEEysbldXsOBecBgM
 bha4cX8+Y4Kxt4IB925Hrf5KZfKFbEOlwowtJYCIOI2lQVewRoxwzxL3fYmW0PFCAy/DCQxZA
 W74yeNO2ejPL0wtFQwHdA9a+pZVoGuFpoaoMqaunFYdoSzlYv0ooVb7qYkOU91xV02g0bWFYN
 p6dN1EIeb5+rRB3tAA41LhLsWl6T5Wp08rhTL/jwDKleeBiD5GTRXIHT7LdF0dRgKGm18CCjj
 /CnKTY8AjKd+u7ojk1+J/OCQpL9JlBALIq3OU8awcfeGwtIdriYdUnwjtJZcRZ2BRUWKG7lbr
 7mPUKjXpgCV8j8otmxKU2/BpwSJRmsxqOPg597za+F0dha6Br+ZtH6MRPYbKkW99sOFooAXvr
 rNnOXakN/SZA7VmVOmSft8SIId8CvIheC5pUh5kjU4NrkgbaaHBV57nXxPXPopPgAsyXKW6yJ
 CC3Y58WoY/OWnoMegNK51r0DWAe19XA8w66QplsWtpXyjwgW9AIVhXro+v4Bc6xR3MfZ+bpN9
 aqVfx4yEmt/DrnpX+4n3dfThM2SfkhO85ot/bvrE4VhM00yI5oq6rrfMxFJXVBT9NsB9LZrJg
 J/1YVWVE68qG1Km727mcLUnAooWW2EOxZRg2p4Ga4c92O/ZMqdKosNqyCfWNIJFHh7PNTmioi
 QpJBo+tV5D1RqJQRnNE3GMtGK63ZJUW9mG0QMA3jzb058nd0sicTXayUGqDkIN3Bi0m3+NGo7
 6D9s9OKwjk9++UPWMfeeRNH4A7xljNTWkiRplx7JVMbEkmNGS8vrzHWCSCBbcY3c8NcNRmX7J
 pQklyhZJgXNIgGWIsLS/OWGw==

=E2=80=A6
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -0,0 +1,41 @@
=E2=80=A6
> +MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
=E2=80=A6

Would you like to reconsider the structure for such provided information o=
nce more?
https://elixir.bootlin.com/linux/v6.11-rc7/source/include/linux/module.h#L=
239

Regards,
Markus
