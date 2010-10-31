From: Daniel Drake <dsd@laptop.org>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sun, 31 Oct 2010 15:57:28 +0000
Message-ID: <AANLkTi=RP0i5cWO4AogGJx-sQ+17YKuiptQWi0ypYVnA@mail.gmail.com>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
	<AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com>
	<AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>
	<AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com>
	<AANLkTi=QT6_zyddRz=3f6GDx-RVoiROOumhegm8pFuHU@mail.gmail.com>
	<AANLkTimfp0pPqpO03-R4yBsADQ27RLQ_PxLTfBAMfPGk@mail.gmail.com>
	<AANLkTi=gFmq47Xq+CxnU18aHyhcaF78WrWYDhga4Xf2X@mail.gmail.com>
	<AANLkTimqFBBsDCCDNOq22fuqjw7pezizZ9At+1ucGZ-j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33404 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066Ab0JaP53 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Oct 2010 11:57:29 -0400
Received: by wwe15 with SMTP id 15so5216042wwe.1
        for <linux-mmc@vger.kernel.org>; Sun, 31 Oct 2010 08:57:28 -0700 (PDT)
In-Reply-To: <AANLkTimqFBBsDCCDNOq22fuqjw7pezizZ9At+1ucGZ-j@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 31 October 2010 15:27, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Can you please tell me the output of the following line
> (after boot, but before you load the driver):
>
> cat /sys/kernel/debug/mmc1/ios

clock:          0 Hz
vdd:            0 (invalid)
bus mode:       1 (open drain)
chip select:    0 (don't care)
power mode:     0 (off)
bus width:      0 (1 bits)
timing spec:    0 (legacy)
