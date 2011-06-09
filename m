From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Fri, 10 Jun 2011 02:27:24 +0300
Message-ID: <BANLkTi=6Fa66QYay_R6vkmREPcb1Bw_FRw@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
 <BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com> <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
 <BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com> <BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
 <BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com> <BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
 <BANLkTimngwDzxW04AMFWBNYLvYFXUhMWQQ@mail.gmail.com> <BANLkTikUaKt3ESg0RKGpxCBK1t6fVvvGqx__uGzp_thPyzcmpA@mail.gmail.com>
 <BANLkTin43tZO1s-MFCnNt0q7pKvf1XRC9w@mail.gmail.com> <BANLkTim2NfCcfRRmcVXepLA0evusZoTJGA@mail.gmail.com>
 <BANLkTimg08VnOMrUwnH6dKzXPJO1fpOh6w@mail.gmail.com> <BANLkTinfeGUADyi1dTSjPRMnbP+TCtN0dQ@mail.gmail.com>
 <BANLkTimbxSA_86a=2QH1pEGg1-O9neEyhw@mail.gmail.com> <BANLkTimQUkf9ZsanZ-czqtYnyRSSSch4nQ@mail.gmail.com>
 <BANLkTi=jsPYEQOnRDyoXD_EzKdqby-QhYw@mail.gmail.com> <BANLkTi=VWUcCQJaBChnitVq1_TT1huE30A@mail.gmail.com>
 <BANLkTinG-CmEh9yXL9Sp+W7PyatvEdOhZQ@mail.gmail.com> <BANLkTi=zuMosw68EMSYjrVi+0dBQkNicJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38717 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715Ab1FIX1p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2011 19:27:45 -0400
Received: by wwa36 with SMTP id 36so2199325wwa.1
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jun 2011 16:27:44 -0700 (PDT)
In-Reply-To: <BANLkTi=zuMosw68EMSYjrVi+0dBQkNicJw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Thu, Jun 9, 2011 at 10:55 PM, Daniel Drake <dsd@laptop.org> wrote:
> On 9 June 2011 19:25, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> let's update that patch. I'd send you an updated one, but I have to go
>> for awhile, so here's the quick change you need to do.
>
> Unfortunately it doesn't help.

That's ok. Let's go back to small steps now.

We have cyclic rmmod/insmod working, and that's good: it means there's
no hw issue.

The next step to have working now is really the ifconfig up/down/up
scenario. That should come before suspend/resume. And this
step-by-step approach is even more relevant to libertas_sdio, because
I suspect there's some if_sdio.c refactoring needed to get it right,
but let's see.

The expected result you want to get is:

- boot, power is off
- insmod, power is still off
- ifconfig up, power is on
- ifconfig down or rmmod, power is back off
