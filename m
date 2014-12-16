From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/4] mmc: sunxi: General fixup (v2)
Date: Tue, 16 Dec 2014 15:12:14 +0100
Message-ID: <54903DBE.1090100@redhat.com>
References: <20141216140921.3036.14668.stgit@dizzy-6.o2s.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46723 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbaLPONm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Dec 2014 09:13:42 -0500
In-Reply-To: <20141216140921.3036.14668.stgit@dizzy-6.o2s.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?RGF2aWQgTGFuemVuZMO2cmZlcg==?= <david.lanzendoerfer@o2s.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, Chen-Yu Tsai <wens@csie.org>, =?UTF-8?B?5p2O5oOz?= <lixiang@allwinnertech.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi,

On 16-12-14 15:10, David Lanzend=C3=B6rfer wrote:
> Hello
> This patchset was inspired questions from =E6=9D=8E=E6=83=B3 of Allwi=
nner and incorporates as
> well suggestions from Hans related to spin locks.
> For example have not all attributes of the shared host object been pr=
otected
> by the spin lock, this has been changed.
> Also some register names and reset behavior have been fixed now.
> And a minor cleanup happened at the clock frequecy setting, since the=
re has
> been a piece of left over code which has been there because it was in=
 the Android
> driver and we just adapted it because we didn't have proper documenta=
tion about
> the timing of the module.
>
> Looking forward to your feedback
> Cheers David

Thanks.

Series looks good and is:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
