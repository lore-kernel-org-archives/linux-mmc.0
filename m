From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sunxi: Declare ERASE capability
Date: Wed, 20 Aug 2014 16:20:22 +0200
Message-ID: <CAPDyKFq1yzdu19ReECRZzVynHZByN4803WdZ=vjgCnC9F0+MiA@mail.gmail.com>
References: <1408541960-14788-1-git-send-email-wens@csie.org>
	<3728016.4j3Ljjy6eM@dizzy-6.o2s.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:60675 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbaHTOU0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Aug 2014 10:20:26 -0400
Received: by mail-qa0-f51.google.com with SMTP id k15so6920771qaq.24
        for <linux-mmc@vger.kernel.org>; Wed, 20 Aug 2014 07:20:25 -0700 (PDT)
In-Reply-To: <3728016.4j3Ljjy6eM@dizzy-6.o2s.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>
Cc: Chen-Yu Tsai <wens@csie.org>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hans de Goede <hdegoede@redhat.com>

On 20 August 2014 16:10, David Lanzend=C3=B6rfer <david.lanzendoerfer@o=
2s.ch> wrote:
> Hi
>> Declare ERASE capability so we can use filesystems with the discard
>> option and the fstrim tool.
> I totally agree with you that information about such capabilities sho=
uld be
> exposed but maybe it would be wiser to use DT instead of hardcoding i=
t?

Nope, this is pure software support. No HW config.

What we should do future wise, is to remove the MMC_CAP_ERASE
entirely. Due to current existing bugs, mainly in mmc core layer
regarding erase, we can't do it yet.

> I mean a WiFi device won't support erase functionality...

That's already covered by the mmc core layer. No worries.

Kind regards
Uffe
