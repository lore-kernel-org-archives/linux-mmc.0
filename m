From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Wed, 20 Apr 2011 20:06:37 +0200
Message-ID: <BANLkTinhuGYQfqSzMvqSpxeXV2CBe5dRmg@mail.gmail.com>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <alpine.DEB.2.00.1104131737280.15392@peruna>
 <BANLkTim4VUmQmWEVJahhw4yfXiSmXi+K0g@mail.gmail.com> <alpine.DEB.2.00.1104201034170.28189@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38862 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465Ab1DTSG6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 14:06:58 -0400
Received: by qyk7 with SMTP id 7so2400332qyk.19
        for <linux-mmc@vger.kernel.org>; Wed, 20 Apr 2011 11:06:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104201034170.28189@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

W dniu 20 kwietnia 2011 19:38 u=BFytkownik John Calixto
<john.calixto@modsystems.com> napisa=B3:
> Hi Michal,
>
> On Wed, 20 Apr 2011, Micha=B3 Miros=B3aw wrote:
>>
>> So... again... What's the problem with anonymous union of pointer an=
d u64?
>>
>
> As Arnd pointed out, this would not work for big endian machines.

There's no endianness dependency in the example I wrote. All fields in
a union start at the same address, so compat_ioctl will always take
u32 from the beginning of the space reserved, and 32-bit pointer set
by userspace will also be at the beginning.

Best Regards,
Micha=B3 Miros=B3aw
