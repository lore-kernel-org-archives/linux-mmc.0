From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: rtsx_pci mmc erase support
Date: Mon, 25 Jul 2016 23:54:34 +0200
Message-ID: <CAPDyKFoCF-H86irhovpqM9Z-RW3CGvOvY0jdWLME_wvvYxj7+g@mail.gmail.com>
References: <5a550d59-720c-a6db-27fb-40b08e263fad@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35580 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbcGYVym (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2016 17:54:42 -0400
Received: by mail-wm0-f43.google.com with SMTP id f65so151316259wmi.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 Jul 2016 14:54:36 -0700 (PDT)
In-Reply-To: <5a550d59-720c-a6db-27fb-40b08e263fad@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mauro Santos <registo.mailling@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 25 July 2016 at 18:46, Mauro Santos <registo.mailling@gmail.com> wrote:
> Hello, I apologize if this is not the right place to ask but submitting
> a bug report to ask a question didn't seem right.
>
> I have a laptop with a realtek pcie card reader which uses the rtsx_pci
> driver and I was wondering if mmc erase command support is not (yet?)
> implemented in the driver or if support is missing because the hardware
> does not support it.

These commands don't require a specific HW feature. but only software
support in the driver - which indeed is missing.

Although, one should know, the discard/erase feature in the mmc core
has since long been poorly implemented.
There are a few patches that greatly improves the behaviour and which
are queued for 4.8.

Would you be interested to test the above changes + plus some
additional which I can provide you to enable erase/discard for
rtsx_pci?

>
> Both fstrim and blkdiscard fail with cards (and fs) I know that support
> this.
>
> The card reader on my laptop:
> 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS522A
> PCI Express Card Reader [10ec:522a] (rev 01)
>
>
> Regards,
> Mauro Santos

Kind regards
Uffe
