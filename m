From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sun, 31 Oct 2010 18:16:14 +0200
Message-ID: <AANLkTiktD13-UC8=gwWhp9oR9_vGcM98VpRQ9i0CQg_-@mail.gmail.com>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
 <AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com>
 <AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>
 <AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com>
 <AANLkTi=QT6_zyddRz=3f6GDx-RVoiROOumhegm8pFuHU@mail.gmail.com>
 <AANLkTimfp0pPqpO03-R4yBsADQ27RLQ_PxLTfBAMfPGk@mail.gmail.com>
 <AANLkTi=gFmq47Xq+CxnU18aHyhcaF78WrWYDhga4Xf2X@mail.gmail.com>
 <AANLkTimqFBBsDCCDNOq22fuqjw7pezizZ9At+1ucGZ-j@mail.gmail.com> <AANLkTi=RP0i5cWO4AogGJx-sQ+17YKuiptQWi0ypYVnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60343 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767Ab0JaQQf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Oct 2010 12:16:35 -0400
Received: by iwn10 with SMTP id 10so6009636iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 31 Oct 2010 09:16:34 -0700 (PDT)
In-Reply-To: <AANLkTi=RP0i5cWO4AogGJx-sQ+17YKuiptQWi0ypYVnA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Sun, Oct 31, 2010 at 5:57 PM, Daniel Drake <dsd@laptop.org> wrote:
>> cat /sys/kernel/debug/mmc1/ios
>
> clock: =A0 =A0 =A0 =A0 =A00 Hz
> vdd: =A0 =A0 =A0 =A0 =A0 =A00 (invalid)
> bus mode: =A0 =A0 =A0 1 (open drain)
> chip select: =A0 =A00 (don't care)
> power mode: =A0 =A0 0 (off)
> bus width: =A0 =A0 =A00 (1 bits)
> timing spec: =A0 =A00 (legacy)

Good. Power is taken down after the mmc+sdio devices are added to the
device tree.

Just to make sure - on an older kernel (that doesn't have SDIO runtime
pm), the card is powered on at this stage (this info will help me rule
out some corner cases) ?
