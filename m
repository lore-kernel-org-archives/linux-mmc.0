Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B43539DBF2;
	Tue, 14 Apr 2026 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154424; cv=none; b=EGMyBTXQq4gnmB6ogDChcy5LgZ5iufIewhb8CVoAMl9jbkSWSY2CUciO4U/IE56GFIcaZaGY3ghwve0F0KMaCWBapBUf/5W+nZeLfIK3s7uKS2+3a1MuE6Kb2pvt/MwjTjq0sVi91HaCNz+K2WRPe+j3XLbhU9HFCQrtz4sKlT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154424; c=relaxed/simple;
	bh=3EfHadgTZizCs2YTDIikcllKAbYD3PM4lNlIMq0xj6E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qaBoa/WLekYC6rPXnWvl7kfpXVmyHlFzKAx1EHi74SnnrwNv7w58vjQ1Ka7muhLjrjfEUPkqaq8QDqkah85ch4Fmh0BwHh+WTiOO/glYc+7mRV91xAmuF1kEXMdD+cKw0DtEQ7a4D62IHwE5LSk7kqStPCjJ7bbnyaFufx9NdvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=linux.spacemit.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
X-QQ-mid: esmtpgz11t1776154412t2aeae6dd
X-QQ-Originating-IP: t5qvFoqOO49dshmNhNcUn+LEJies/jN4pY7I/s4bMd4=
Received: from = ( [183.48.244.18])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Apr 2026 16:13:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8640859911972310649
X-QQ-CSender: troy.mitchell@linux.spacemit.com
Sender: troy.mitchell@linux.spacemit.com
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 16:13:29 +0800
Message-Id: <DHSQ6VG82QYX.1EVAYV9JTBCL7@linux.dev>
Cc: "Ulf Hansson" <ulf.hansson@linaro.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Adrian Hunter" <adrian.hunter@intel.com>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Yixun Lan"
 <dlan@kernel.org>, "Troy Mitchell" <troy.mitchell@linux.dev>, "Michael
 Opdenacker" <michael.opdenacker@rootcommit.com>, "Javier Martinez Canillas"
 <javierm@redhat.com>, <linux-mmc@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Anand Moon"
 <linux.amoon@gmail.com>, "Trevor Gamblin" <tgamblin@baylibre.com>, "Vincent
 Legoll" <legoll@online.fr>
Subject: Re: [PATCH v8 0/9] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
From: "Troy Mitchell" <troy.mitchell@linux.dev>
To: "Iker Pedrosa" <ikerpedrosam@gmail.com>, "Krzysztof Kozlowski"
 <krzk@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
 <f58ec12c-3957-4d44-b823-6a1ae1a1dd94@kernel.org>
 <CABdCQ=NhTkGJUh_fKnZoQMzdpyO-UbV5zrSfiNVUC7bkSBifTA@mail.gmail.com>
In-Reply-To: <CABdCQ=NhTkGJUh_fKnZoQMzdpyO-UbV5zrSfiNVUC7bkSBifTA@mail.gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NwzkBiTYPEyUCrsQl1xjU+epwdSOa/J/dxUu58fgXZ6q133ACAq7W9DS
	Is2Io7Lu9XDyFy5vUGmjUPJpl1xRHQ7ntoJA2nvt+MmW9X8cwDyBIMgS9wJ44tDd07jlFXx
	pUAUMrI8cICnjvB0ReNEbcDDCR2ahcc1vyUMDkV1FxmrSC7bLnx2lYyzdYyCC6QKK3JGFQM
	vH30KJab+HG+jM0aMcn95I1QiLk5+fA0ngQ6BWW4iYgW0z7gUuinfmqvqpKqX0+Uw1t9ZG2
	ejJf8cr80qxGB35qPGFKRKaDYWxVQYEZgZ21VyxPq4oqzU13Xl+LeGh42JbzydPJyzsCf3o
	+PtqLtOcQEYph8JYtb8uCvzv8RRmcjWODBG5SadQpjlFhI5OC7P/TFyQuVNoPaAYgIH2mYM
	4T7RtWKPmqkYj+y3cWILRKavmVbRHj9QNFmmzwZ2hJhqxwsfBRyqozudZ9uzWqYInlGjSV/
	CfyF7hSr4QzT9EBN5UEmePsf01gc3sliFCZJyXWmx2s4mxGmpzB4d2LTjNs7CsNeRIluh+P
	AEpRpp6TA691SAtcBdpOmrDBRPZJaOWNnPyO2feprC7xW7lCo2wIYAfz1S/ccD0Ry3jNZin
	j+mrsQSKzCitIK5spUnIhTYf9FpMCUOEpyEdJGYy8WCXI3K/WBXWfJ/HBW8e0MQlbbsEDaj
	SP2GsnadAmtG1BVWqVTa7dWaOlYMGeT3ei55Yx2ZmygJToT/YjvjChU5g+/YxypFMPr76lm
	ttosZIpIaNiFr1qXbt5H3nC1r2oNSJFkqJTqmRgt7eEOIq1a7Q6yw0IZly1hDJdalvNJuMd
	LO26WmJwWUxoodwHJh8tLpSjm63zGmixxHr+NAhRjtb9BIRhoDi15Lw+r4w1Wohu+SnlFvM
	W8XlN3DeyBHAMTDxhhnrrCogSdXBRhIIi0YI2ueE2VepwjMUOUr+WXiG/8OElPPj3LN3Di+
	aDZHKkTgQWJ/kgtQSEWqZqDZ0f32swXU/uW4RMujF15ukzi9cwgDxY9zLZV3O35uxVwZyhi
	DGhqJKIjrLXug7KDOlpOlZbYjVHqWJ4xLR7Pjnfs4LrvI8kRQDukpIVMCeJWvIaq5OzBbZD
	L7nXlKqnU8q
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On Tue Apr 14, 2026 at 3:12 PM CST, Iker Pedrosa wrote:
> El lun, 13 abr 2026 a las 10:07, Krzysztof Kozlowski
> (<krzk@kernel.org>) escribi=C3=B3:
>>
>> On 13/04/2026 10:02, Iker Pedrosa wrote:
>> > This series enables complete SD card support for the Spacemit K1-based
>> > OrangePi RV2 board, including UHS (Ultra High Speed) modes for
>> > high-performance SD card operation.
>> >
>> > Background
>> >
>> > The Spacemit K1 SoC includes an SDHCI controller capable of supporting
>> > SD cards up to UHS-I speeds (SDR104 at 208MHz). However, mainline
>> > currently lacks basic SD controller configuration, SDHCI driver
>> > enhancements for voltage switching and tuning, and power management
>> > infrastructure.
>> >
>> > Implementation
>> >
>> > The series enables SD card support through coordinated layers:
>> >
>> > - Hardware infrastructure (patches 1-2): Device tree bindings for volt=
age
>> > switching hardware and essential clock infrastructure.
>> > - SDHCI driver enhancements (patches 3-7): Regulator framework
>> > integration, pinctrl state switching for voltage domains, AIB register
>> > programming, and comprehensive SDR tuning support for reliable UHS
>> > operation.
>> > - SoC and board integration (patches 8-10): Complete K1 SoC controller
>> > definitions, PMIC power infrastructure, and OrangePi RV2 board enablem=
ent
>> > with full UHS support.
>> >
>> > This transforms the OrangePi RV2 from having no SD card support to ful=
l
>> > UHS-I capability, enabling high-performance storage up to 208MHz.
>> >
>> > Tested-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
>> > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
>> > ---
>> > Changes in v8:
>> > - Resending the series as v8. The v7 submission failed due to an SMTP
>> >   error during transit, which resulted in a broken thread on the maili=
ng
>> >   list.
>>
>> Hm? Everything is here:
>> https://lore.kernel.org/all/20260413-orangepi-sd-card-uhs-v7-1-16650f49c=
022@gmail.com/
>>
>> You can send individual patches to fix up threading, use --in-reply-to.
>
> My apologies for the noise and the rapid resend.
>
> The reason for v8 was that the v7 cover letter (0/9) failed to reach
> the mailing list due to an SMTP error on my end. This left the v7
> thread "headless" in the archives without the changelog or the full
> context of the series. I was attempting to fix the threading
> immediately so that reviewers would have a complete set of patches to
> look at, but I realize now that resending the entire series on the
> same day was premature.
So that's why Krzysztof said you should send individual patch with --in-rep=
ly-to.

                                      - Troy
