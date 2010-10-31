From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sun, 31 Oct 2010 17:16:11 +0200
Message-ID: <AANLkTimfp0pPqpO03-R4yBsADQ27RLQ_PxLTfBAMfPGk@mail.gmail.com>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
 <AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com>
 <AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>
 <AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com> <AANLkTi=QT6_zyddRz=3f6GDx-RVoiROOumhegm8pFuHU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55057 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116Ab0JaPQc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Oct 2010 11:16:32 -0400
Received: by iwn10 with SMTP id 10so5963433iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 31 Oct 2010 08:16:31 -0700 (PDT)
In-Reply-To: <AANLkTi=QT6_zyddRz=3f6GDx-RVoiROOumhegm8pFuHU@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Sun, Oct 31, 2010 at 5:10 PM, Daniel Drake <dsd@laptop.org> wrote:
> On 31 October 2010 15:08, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Quick question - how did you manage the power to the sd8686 ? Was it
>> possible to power it down after boot or was it always kept high ?
>
> I didn't do anything except boot then try and load the module. Does
> that answer the question?

No, I'm asking a more general question about the sd8686 and the XO-1.5.
How can one control the power to the sd8686 ? Is it always on and
can't be controlled ? Is there a GPIO that controls it ? or any other
mean to control its power ?

I'm almost sure I understand what's going on, but your answer can
confirm my speculation.

Thanks,
Ohad.
