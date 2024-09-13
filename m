Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50212BA2E;
	Fri, 13 Sep 2024 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257947; cv=none; b=JZL5Yl7f1wExYcfpKgKWgowTBlxZ3fcV1tBoIT3eNol0QPao4Hfsng4RDW/dPKUz5mXRencw9JCf22d/Zl4/cWhkpbXBMqgw0uumW85E/Hz3MfhRHSnqW1/M1YWAh5Cx9DNYo5I6yWwtjcDwAPuiHjwYaOPPpQyTQfRYrhsNZd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257947; c=relaxed/simple;
	bh=wOcXFFZJkYFroI8Y8vyR4sjRArdTV3LbDKjrSMNfqd8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=JLkcK2WwxfUeT2qliUlORy1Mct20J7hUwM56MrOkz1KCfvlp2GDl/TqWjLzmGxXAMabLD4KAb5kRq+UdASluK/n1X1tUVPSDsa0p0T/yRJKhEp3aqYNk4rIGMpwqs21ee0mXQLbGtjjKtvRh9oz7XQZPN9LeLtRybOaqmx8MSHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=oIVXLNNf; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oIVXLNNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726257941; x=1726862741; i=markus.elfring@web.de;
	bh=wOcXFFZJkYFroI8Y8vyR4sjRArdTV3LbDKjrSMNfqd8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oIVXLNNfjNVcyAcY5KU1IY6OkKlQubvXYJHrqK44KVXwEju9g2teSavAfikBz+xU
	 XKlFrfRi19jzXz2t5cyWTyb5nt+aBdUNffm22diGf8CUEO0A+fjb0iEGp1Wv4XziL
	 ifJPHUZkn4wqpH/W41Dek2lVJ4L5emBzbdfs/Q6vD3LQMsyiS+MfDn7wYxkWOM2oK
	 W0SAjrxCdd/4CxZmb5ynP+c2cd/InRAVYUOSE3j7iQEkQG87ZbLJB3A5VszvcMU+V
	 fFgaAwDTqpFe86tZELlAMxQ8S7F9hPZ/mwOWa55JQfmZIBY+Tv40u2MW9i7fMf3sc
	 em12KNY9itHBilDaKg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5QqN-1soNVx2u0r-00106Q; Fri, 13
 Sep 2024 22:00:12 +0200
Message-ID: <014449ba-6b9d-4fb3-8dda-4cbdfa74b9be@web.de>
Date: Fri, 13 Sep 2024 22:00:10 +0200
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
References: <20240913102836.6144-9-victorshihgli@gmail.com>
Subject: Re: [PATCH V22 08/22] mmc: sdhci: add UHS-II related definitions in
 headers
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240913102836.6144-9-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9buK7XdQBP5rea45pUAwBBXZmpVDqremWuF83st63myOidwYhbF
 K2oB8TIsKcmGhPWsg5r4URLDXnX9VW1P5pghvGuSWzvbuYK6boavUyUuV9DR3BEa5voYsuH
 TsA+VsOmEoBMnGxhqLIGgetqpvAaWyHrtlm26LCMIp1MfvrdYzCGP/P2JFhUBD+56vwbNFD
 XXPWlEvyjL4svqEleFAIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6bT37zSAkV0=;pzAV+4hnfTBK5p4KNGFcpU88YR/
 SpN7tB/w07q3NXhDVZ7HeSaSKBGPo9Tm9L3YjywTtHVVhr9qTaT7D0nAo5DmK0luvT0hY0mxT
 vClCbhWykeapGtc9dYXR7Kg28BOHLpIjyo9Pln+BqSgNlRDxY1Dx7g19YsJknTN0u17NPtRJv
 3W7HY8Ys2QBewHkRHrcMhU4X+qGcydtAROP6vYuaFHXr78hGDbgDzUGPpb2IbbM/BLo2TbsAw
 X2yNkY4x2UEX3OrYaqq73vUoU/PgKulFk87kdUX4duALNLS+JAipZ5xjAEqwsYl/Y1gsCLaiL
 bQxfYI0LLNyKD0Thsu2/nERnVuzUiybTuyBiOXK3YHhId07GRLQBdMHwPI6JWe581vTbkcQSi
 gf8lk87OfCNffyL24+catm0GoSY71GkfFZavc1H8p3Z8EkHXtrLKZC+iBDEBj3jPuOzG3ABIi
 6vLnOfkvOxVqfpLiuADUq/0CDs5De6AH1LrgSE4Fz1eOwfLxijZFx627ggVpl03XGHf5K/g+K
 Zxfs0Dg9w9/MEvjI11uqPyNRshUSzFg9p41MSV34py+sLUqngRuLdNCMOrIDVKK2XSW7E0Bb3
 dsbrpuYqdUEfrYYku1HS83t4jaVHzXany9zMg6F7latVf4sDKe+WCknjtGbqfYNSpHcHYkJTO
 pN92MYIIJY31MNcM8AZLsSMvb3/eKg1ta8UtzX7I0D828Mu25JfiVa1gWw7IsP+OfPZgpnM3H
 nNXO1TenoYfQ3IoGoFd8icP/rdHpnsE2czkqEo+yrLnPjZJOkuYJqioinDVu7wNcMgyI0n6NC
 hdjFLc+sJV5hiSpXEroZRkOw==

=E2=80=A6
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -0,0 +1,177 @@
=E2=80=A6
> +#ifndef __SDHCI_UHS2_H
> +#define __SDHCI_UHS2_H
=E2=80=A6

I suggest to omit leading underscores from such identifiers.
https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+d=
efine+a+reserved+identifier

Regards,
Markus
