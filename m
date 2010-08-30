From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH 1/7] mmc: at91_mci: fix pointer errors
Date: Mon, 30 Aug 2010 19:05:09 +1200
Message-ID: <4C7B5825.6030302@bluewatersys.com>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com> <20100827193303.GB23079@void.printf.net> <4C7AD3A0.40607@bluewatersys.com> <4C7B5601.5060505@auerswald.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.bluewatersys.com ([202.124.120.130]:27114 "EHLO
	hayes.bluewaternz.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751291Ab0H3HFO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Aug 2010 03:05:14 -0400
In-Reply-To: <4C7B5601.5060505@auerswald.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Wolfgang_M=FCes?= <wolfgang.mues@auerswald.de>
Cc: Chris Ball <cjb@laptop.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, avictor.za@gmail.com, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org

Wolfgang M=FCes wrote:
> Hi,
>=20
> Am 29.08.2010 23:39, schrieb Ryan Mallon:
>> I see this is already applied, but why all the type trickery here? W=
hy
>> not just:
>>
>>     memcpy(dmabuf, sgbuffer, amount);
>>     dmabuf +=3D amount / sizeof(dmabuf);
>=20
> Because this is wrong?
>=20
> Maybe you mean sizeof(*dmabuf)?

Sorry, yes.

> The exact style of the bug fix is not important, it's important that
> it's fixed.

I disagree, it's also important that it is fixed in a clear,
understandable way. I found the fix confusing, especially since there
are casts to both signed and unsigned char.

~Ryan

