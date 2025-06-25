Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC34E265CC5
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861730; cv=none; b=stDCv+rsuasxdM+V7hoGDC31MBL34Gvb1+L3liObyf06Uq6FenjBTIdemiX4Ag3foJf0PtTRDRJb4C3XoeQ85jbWSM4NN+U2KXrqf/0EK9RwZshP8w1IwMTCi0Pi3yMhCqK0UXq2mopf4QldAoSvflB6G1u6RI2NyxzNRtN3AxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861730; c=relaxed/simple;
	bh=HgVXEK3nSlu/Ydn6XI5+ytFIQfMyJedXOtvsYti73EU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=n8I8LsER4nuFrD00cWiLGUF82EbKc7hjabX+2pkqSWF3x55Kddx+GvWMY+Fq2sdBsPFpltvpXLRa+DTwSWZrlqiR278tyGjs4LY0CoZVuKr2z3fj5UX/KzdkhxkbVacrweht1NPZXl0ipDA6M2VAUR/xPcrW7Ab1inD+PGNGQJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OBCMxahp; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OBCMxahp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750861723; x=1751466523; i=markus.elfring@web.de;
	bh=HgVXEK3nSlu/Ydn6XI5+ytFIQfMyJedXOtvsYti73EU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OBCMxahpcIHM5kAnP/WBnIBImjAuJfEJuFeIGSb8Gc0uu6wTL7IvfxPCKBqUZ+wk
	 wiWoEsn02RpKmqNDL7hYMU60cEYhVsgBc7A5sIgwIiDRL7DnHSRaxv4xm9IQQOV5j
	 hFYkNwY7fLbcEcVD7LAGdViHV6pNopirhIeM3XLP/R6KcGdmxC5HzNjJpX+LB0BdC
	 P70uQxotSjrTu4glri6gU7fkd+CtiTfg/jRtHY9IrpEWoP7F+Eiahd9vKZFtHeslN
	 SrIXlim3eZHLP8irTpk6m3BwP7/NuNyWfuuqipnYvbxTuPmYRvXCm3VCIj04IYuX7
	 C/GG6Nq1uefsDi/FMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N30ZN-1us3Nf3nob-00z6R4; Wed, 25
 Jun 2025 16:28:42 +0200
Message-ID: <f1bcf11f-817d-4a57-8084-fd1e1e5c5140@web.de>
Date: Wed, 25 Jun 2025 16:28:42 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: mmc-utils: Completion of error handling
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xlJS4YN23oLE8cpKlo5zp2PZab0R7erG/YxOhAvcH+cwZMAh8m5
 S/HiEJoL+Cgc+nncFS5qh4I/ejFHCPk/mSXy66HWiIzauHiIc2VPl2cjwMMhAkflUGjQraY
 7+nhawz1K0F3TL/3wn2rVL6LQGAqrF84oSR07RNPvK/9XYH/PkuFPrv5CzkHVrkhtiLDvOb
 4dXhLB0QckDgHreYU43fA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yN5peamuv2g=;mFtndzqTBvYfKoFTG6mS9a4P2rR
 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

Hello,

I have taken also another look at implementation details.
Thus I have noticed that the error detection is incomplete so far.

How do you think about to add more error handling for return values from functions
like printf() (for example)?
https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git/tree/mmc.c?h=v1.0#n515

Regards,
Markus
