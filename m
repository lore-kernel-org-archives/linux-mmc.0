Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE768209F38
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863935; cv=none; b=X3zj8PS325sQvO3ijmJkbXuS7o4z8bLyS1QaIGyybhInjuOqxfzEQYMOVnSPBygr2ES3SA5H0TfVLDW4nYQMyeR4jUOyMoYb7LsKQqQTxHzZBNHq+UCfdYFc+C139LqFwcaQdkk/BW9t21Rxm0L8ADh54m9txfdg2jvejwTJpIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863935; c=relaxed/simple;
	bh=5L2wrzmhR+cHrQspJ1+tnQIdukFWsewNTJwoVeOnhs4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BByHilyBNXTIiR/vGYCY935J5FLgVMahRI+iPtupJA8O94w4XJnjHlG9kuFxpxlmAM7zWvDmMCKJPhG07ZTT2qMfEf58JywkhQ9SaWueyU0sjTlICxq45s3O6MPc5lIe/bZhv54HivpiOAHWqCv0LQppBtX4Iw12M1PpacKHVqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SC6dCGu9; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SC6dCGu9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750863921; x=1751468721; i=markus.elfring@web.de;
	bh=5L2wrzmhR+cHrQspJ1+tnQIdukFWsewNTJwoVeOnhs4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SC6dCGu9+CgyWEPtQpnQO64VLeq2UfOQ1gLl9vuXEsnzbs9qDLlUdLTfUMQdDPdy
	 GVWl2X1UhWR3sICTBF+EJeRwAeTIj0RBWe+WSEVZwLq3MdNET2x/j3tUi/yupCECA
	 DGleCiS1zLk9Qw/V6RMProW/NGLiGXcSAZsV0yYKl9QDfxwdjX206GwGPw6VDoBVt
	 wk+ZLlH2w9yopCYC50iqnOSPBntDBrMIeMKawY0g6EMlVicEW78DCsYluihEeUWwe
	 1fNBnjMyYozaDXbSS+woxB4Wea2T3r/DQXIBYMg7RbckdPTNwH9pX882IjkC+sf1n
	 71U1SEFBHn6sVGXACA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgAJ8-1uwd6F29ZG-00iK8c; Wed, 25
 Jun 2025 17:05:21 +0200
Message-ID: <e8686658-9b45-4a65-a540-190f4fdc455e@web.de>
Date: Wed, 25 Jun 2025 17:05:20 +0200
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
Subject: mmc-utils: reserved identifier violation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kw25s6l4bWSTHLkHLvftOpsY39Ui86J2310U57x2CZp41HURRrc
 xuVPkwsWMsI897QcetE+OOmSMeV87/LWVsNlRIFJWxW00UYVNWQnGLDueA+RH/Ov2Uhr+rn
 A5DZb/9lCLJQCVVeRW1uEuudWbMlmErgu1xWilEfdnElt89zg4UhejdUNf12APGFwVCSQB4
 ewr5BA2dMeSggNg7Y+eBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OTJts9S4xAw=;2RtQv9Mpye2XFfStN/KvT76KPdX
 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

Hello,

I would like to point out that an identifier like =E2=80=9C__do_ffu=E2=80=
=9D does not fit to
the expected naming convention of the C language standard.
https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git/tree/mmc_cmds.c?h=
=3Dv1.0#n3315

Would you like to adjust your selection for unique names?
https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+d=
efine+a+reserved+identifier

Regards,
Markus
