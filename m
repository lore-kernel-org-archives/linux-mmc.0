From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2] mmc: pxamci: fix the device-tree probe deferral path
Date: Mon, 08 Feb 2016 15:16:15 +0100
Message-ID: <87lh6v2spc.fsf@belgarion.home>
References: <1454793294-7256-1-git-send-email-robert.jarzmik@free.fr>
	<CAPDyKFoKyRYSz+T0xCX5Pdfs3BDEw4nMEg+d0ji-cmn=x5e1WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:28975 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbcBHOQT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Feb 2016 09:16:19 -0500
In-Reply-To: <CAPDyKFoKyRYSz+T0xCX5Pdfs3BDEw4nMEg+d0ji-cmn=x5e1WA@mail.gmail.com>
	(Ulf Hansson's message of "Mon, 8 Feb 2016 10:19:12 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 6 February 2016 at 22:14, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> When the gpio driver is probed after the mmc one, the read/write gpio
>> and card detection one return -EPROBE_DEFER. Unfortunately, the memory
>> region remains requested, and upon the next probe, the probe will fail
>> anyway with -EBUSY.
>>
>> Fix this by releasing the memory resource upon probe failure.
>>
>> More broadly, this patch uses devm_*() primitives whenever possible in
>> the probe function.
>
> There's actually also clocks and regulators that may be converted to
> use the devm* functions.
> Do you want to do that as a part of this patch as well? Otherwise I
> can apply as is.
Yes, I will add the regulator and clock in this patch, you're right, this makes
sense to me, v3 on its way.

Cheers.

--
Robert
