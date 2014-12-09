From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: Re: [PATCH] mmc: sdhci: Fix FSL ESDHC reset handling quirk
Date: Tue, 9 Dec 2014 09:41:16 +0100
Message-ID: <CAPk1OjFGDL9=nK69R2FufA-kcd-tR01kD7PCH5wP+nEpvTaYqg@mail.gmail.com>
References: <1417773533-10052-1-git-send-email-alessio.bogani@elettra.eu>
	<CAA+hA=QRDnkG50=ah6ze6=nzL3fpbSUqdB9WZzVYevmrpJTWfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from spamalot.elettra.trieste.it ([140.105.206.208]:51741 "EHLO
	spamalot.elettra.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbaLIIlT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Dec 2014 03:41:19 -0500
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
	by localhost (Email Security Appliance) with SMTP id 615B2440E67_486B5ADB
	for <linux-mmc@vger.kernel.org>; Tue,  9 Dec 2014 08:41:17 +0000 (GMT)
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
	(using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com", Issuer "Google Internet Authority G2" (verified OK))
	by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id 16AE043E07A_486B5ADF
	for <linux-mmc@vger.kernel.org>; Tue,  9 Dec 2014 08:41:17 +0000 (GMT)
Received: by mail-wg0-f50.google.com with SMTP id a1so157408wgh.23
        for <linux-mmc@vger.kernel.org>; Tue, 09 Dec 2014 00:41:16 -0800 (PST)
In-Reply-To: <CAA+hA=QRDnkG50=ah6ze6=nzL3fpbSUqdB9WZzVYevmrpJTWfA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On 5 December 2014 at 13:07, Dong Aisheng <dongas86@gmail.com> wrote:
> On Fri, Dec 5, 2014 at 5:58 PM, Alessio Igor Bogani
> <alessio.bogani@elettra.eu> wrote:
[...]
>> This patch partially reverts the above mentioned commit and make
>> SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET dependency explicit in both drivers.
>
> Personally i prefer to manually restore irq in sdhci-of-esdhc driver
> too as imx esdhc driver
> instead of reverting the patch to avoid adding new QUIRK in common
> driver if it's only
> for esdhc controller.

Thanks for review. Updated patch follows.

Ciao,
Alessio
