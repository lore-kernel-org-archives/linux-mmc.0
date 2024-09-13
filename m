Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB2BE6F;
	Fri, 13 Sep 2024 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240681; cv=none; b=oCs4j2+x2KcdY9qQO6SKcV6bh9ObgHq4QrkgVqVLBV8d+O1PutDjOr0hCtp3B1xYdw/vDx+SieeZfvR/fQws5h0Sm7MenMrxJ0yUVRZ44lyYLlIQp4GfwxsQbneU2Z+WSslxKk/8DVKqw2ruavcR1BYFE+Q1qP6wM5OWdh3xPEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240681; c=relaxed/simple;
	bh=HdARxft5lo/WwL7MdcchDvg7lHX7sYr4osFJymFGL3w=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=IET8SAmMu5OAlNLB7I5vmom5CepRzmM0+73z6r8qWLXLcF1tUITIX023Qdgdatb/k81eKv1tkqPZT2GEWNuI9232JDyNRdfxcyg2IkdYQIOsuwyxdzFnv64d6ZGY0GGFdtZhKT4NReF2T2dtyn38W2uDfqljZ8ZmHH9hvmRGdY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=D4tqCtsc; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="D4tqCtsc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726240662; x=1726845462; i=markus.elfring@web.de;
	bh=RnKqKkU5ax07eav2EVa2dS7EwG10YlWPtNLoGqh3bH4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=D4tqCtscxIhQoVsyq3ZjCr/heR8Sxwrl9CdSHVdZrbLm3TCiR5cAnwipTn8gccz6
	 4h7M2bo9j8B1W+EhchvIibvww7vq/ZWki/LCED5NaR8Y4N7rw1IYZ4outWAQtm2Hc
	 KVp86KzQOynVSGPu+JjTkMvaQdy7MT2hg9rhTpUZBNFvQ7owwU/xD7aE5ibL7WXKW
	 1FKGiyn2DYbUXf7n1DEn1NiM7U3Py73AmtLpIbN1f849SbgOgFxIa8wGKjTkFzvXj
	 vng9NvyFI6K55KT4NHKk+6f1QlCklh1qEp9PqieDa2AW6Vh6O62o8C7FcIEVePUfe
	 77bT4g0VsqxasVObhA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N9LEU-1rsujS1TQy-014dYn; Fri, 13
 Sep 2024 17:17:42 +0200
Message-ID: <973892ec-d905-4524-a024-d506099290ea@web.de>
Date: Fri, 13 Sep 2024 17:17:17 +0200
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
References: <20240913102836.6144-18-victorshihgli@gmail.com>
Subject: Re: [PATCH V22 17/22] mmc: sdhci-uhs2: add irq() and others
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240913102836.6144-18-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6gIqQ0bFKBlIcJgZ73wRNhc1GcKsyI4tYhuXKDQ/FUmsLFAxV7G
 mkTccOSDa9lqUwTokxxOfYIkMlspGHR2FN8nUoVBGrNgMW1iw+eAqRkd+2SDkG0dCJsePqh
 wnGVK87SMDEv+gLB93BKkWclpzVgZ7aR276yk3AdGLwl3SG19hSRLY9gs9KREpQ0vffIajH
 P9OL/+a5Sg0MaWxhObehA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2YAwxqnx5mw=;SMPcOF5Br0swl+g+TLEel6MDUMu
 83v9QwbYH4jjEOu+cWk8v3Vu/4QAbGxno8v54qwjMRUyN+xHOpzQyEJ+Dr37Z15GxEd2qqd7b
 lUdepGSvx0PSfRtts2XdWvvVxJ9Vy6+7D477YiX7h65BhE1kuS7f3RyPdjLZl5pWyFa65s2dG
 33BywuGPntxfEWEKOcoSq3glmOuUrb2QTvHnz24t4s/ab4u4L9RVSST64xhkdnsadKPacT8JW
 kI0hVp+jWY8WD7hit2kZBZWUHa9Copn1JHxRxBco5xhkI3JMB9+V+gYuRf0CWq3KvMk9CbAfC
 dRRzfFI7qLvpi5I0G3SH2DpAOPc1o9vfaoQ+7COtSOVsNNewVigZ2xGXpUf4k/+C5ZIhf9ci3
 eHI090EPuEso1s3NSbQ4l2E73FBaBficirzQdmMYFVnlirn1vQb6UIPhwA+A+PLmkRJWPX+Io
 RY7xL94YpxHfU/tXSzW4kz/b35uP2/PgjC4U2D70Yy0crwrv9C6c4/6NNOCJVY06d09CXM6lu
 YtiFB7RzfIUxwfo+RU/TjSfxlk6y3lRNTGopIipF8QERi1IhbVDNngrfv9Gv/21Y6gRj8R+9y
 Pykv/wJBs8994sx6ptXparZzT5P/ZZxo7WF2HDeA4JSxHymbpO4Cg+06oE2cBxy+IqPPXwSxG
 vRApcpxxgEUzoEcEaW2daox1gieb19vs5VX2B8n82hI41HuhndEJrGY1tplUqa3cLV4lD0nwL
 1nJJGu38kvKMCCv0zSeQHMJ3OVfCLqxN7Y/ZfQzcZvw49EEj6lVlvghMgYfFyV1RYMUIaIdXv
 bXpbuTfS3jwYaPRgogN22N2g==

=E2=80=A6
> +++ b/drivers/mmc/host/sdhci-uhs2.c
=E2=80=A6
> +static bool sdhci_uhs2_request_done(struct sdhci_host *host)
> +{
=E2=80=A6
> +	int i;
> +
> +	spin_lock_irqsave(&host->lock, flags);
=E2=80=A6
> +	host->mrqs_done[i] =3D NULL;
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(spinlock_irqsave)(&host->lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.11-rc7/source/include/linux/spinlock.h=
#L572

Regards,
Markus
