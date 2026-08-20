Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A32EAD15;
	Thu, 20 Aug 2026 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787215948; cv=none; b=ikCSyDymT1RnCa7kHj5M8JlIuSzqBNhdXYJ3UxYCZFbsYIY1rbcPHo5npGZ3Z5aFNeKgHU/nASH0FPKG309k6QMWJa1HxwBWNq0xuUtXhMf651ZDrDp6gjZolzitWBYbnKB5kjfM2xU94CZU6zQ6++XFlyFTJBD4Bs6CGF5fgZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787215948; c=relaxed/simple;
	bh=nl3RHoIGXqRDgeBLqKSa2p0/TBKu2PcU9pGZX5JPE5Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=pooPFimzIVO4N5trOvxmDB+1uILxe/PTWSbKOSY64ED12oWLHxMpwHETaBkEK72wSDAuhEX5fpbs8SnzSg4EHNGE+kHCn5ZBmg0B3qbRruA4rywhIwlRuBELDKDJjts54HaMlVLqEnEhjSiw4Dp8mVUHQYq1tiOfJNVUAVqNkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pusRnDQQ; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pusRnDQQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787215937; x=1787820737; i=markus.elfring@web.de;
	bh=nl3RHoIGXqRDgeBLqKSa2p0/TBKu2PcU9pGZX5JPE5Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pusRnDQQeNoAQpVG9E5OisQ6Jm3lRilDJRTV3q998j5HnMMSmb93khFpdGmwt0AJ
	 vTQrvYoVuT6qEt1evHL0mS9QYIp4onV2pxQoGx5IGH3DZXX9t7jUeOHTQWRZ40VuG
	 84I1K2dFHqPOf3rJVFqjzQwTgc6gLIjs4qSiN2vmd0IPNCl3dh/rPD+gYaH5vgwq5
	 z5cyxDzFo059IyIw2SwZ2Q+6UDlLj8N/jwEHI1AmRIP+sm0ShFgzUZipIPE3Eo94R
	 cO24sLS/dTNqWHrmhmNM/vOxLbevXCfxZT4INyvfWYv31MHk73qaK1Jy25Wm0ywx/
	 vwehYh2USWWsgkLGKQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pUQ-1x1xOR2sxC-00C1E7; Thu, 20
 Aug 2026 10:52:17 +0200
Message-ID: <fa3ab6b3-bc8d-42ff-8faa-833c3585cbe3@web.de>
Date: Thu, 20 Aug 2026 10:52:07 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: 1298662399@qq.com, linux-mmc@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>, Ben Dooks <ben-linux@fluff.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <tencent_76880DF24877C8490B50E7D7BC52A55EA105@qq.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: check clk_prepare_enable return in probe
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_76880DF24877C8490B50E7D7BC52A55EA105@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uXUSPrxKhHUoMTH+9yApLWieroI0wu2Xg1AQACiVST9Dnzpmy1i
 FnYBmJWN8z0cJb8TE1HDI0B4Pu5PHj72c2xOCkqTLg9EKmDYpYyKfe98xSGlgRbMzXApYjY
 lN/11m1BRhYX6Dkn2wEspg/FOlWsB+0BK54atv+hhAfoD7zfJ5GOQAzt6H/l/Zcqd+EfBf0
 NdXh7/6PkbnuJBCZsMMbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k2w7ade15TQ=;G9By/DPeNAq5SKiHb3vuCoBPAbf
 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
 iW7kUCkUmVHzysjwYs6R0sJgFYNMqHL7

=E2=80=A6
> Fix this by checking the return value and propagating the error,
> cleaning up only resources acquired before the failed enable.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv7.2#n34
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2#n145
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2#n792

Regards,
Markus
