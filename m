From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: Add ioctl to let userspace apps send ACMDs
Date: Wed, 6 Apr 2011 20:11:23 +0200
Message-ID: <BANLkTinOP6G1=ZcC=7Wxr6eO2sowJ_TH0w@mail.gmail.com>
References: <alpine.DEB.2.00.1104051450480.25803@peruna> <BANLkTinsYioaa69ZdFpBAr-BK6RDh8V83g@mail.gmail.com>
 <alpine.DEB.2.00.1104061021350.391@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45782 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535Ab1DFSLn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2011 14:11:43 -0400
Received: by qwk3 with SMTP id 3so1040055qwk.19
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2011 11:11:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104061021350.391@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>

W dniu 6 kwietnia 2011 19:37 u=BFytkownik John Calixto
<john.calixto@modsystems.com> napisa=B3:
> On Wed, 6 Apr 2011, Micha=B3 Miros=B3aw wrote:
>> 2011/4/5 John Calixto <john.calixto@modsystems.com>:
>> > +#ifdef CONFIG_COMPAT
>> > +struct sd_ioc_cmd32 {
>> > + =A0 =A0 =A0 u32 write_flag;
>> > + =A0 =A0 =A0 u32 opcode;
>> > + =A0 =A0 =A0 u32 arg;
>> > + =A0 =A0 =A0 u32 response[4];
>> > + =A0 =A0 =A0 u32 flags;
>> > + =A0 =A0 =A0 u32 blksz;
>> > + =A0 =A0 =A0 u32 blocks;
>> > + =A0 =A0 =A0 u32 postsleep_us;
>> > + =A0 =A0 =A0 u32 force_timeout_ns;
>> > + =A0 =A0 =A0 compat_uptr_t data_ptr;
>> > +};
>> > +#define SD_IOC_ACMD32 _IOWR(MMC_BLOCK_MAJOR, 0, struct sd_ioc_cmd=
32)
>> [...]
>>
>> Since your implementing a new ioctl you can make the structure the
>> same for 64 and 32-bit archs and avoid all this compat crap.
> I was also less than pleased with this, but I chose to implement the
> compat crap because it allow a "natural" userspace API for both the
> kernel32+user32 and kernel64+user64 environments. =A0The ugliness in =
the
> kernel is just when you have defined CONFIG_COMPAT. =A0I think 32-bit=
-only
> is still an important target for this functionality (think set-top me=
dia
> players, mobile devices; basically, anything running on ARM) so alway=
s
> having to cast your data pointer to 64-bit is not appealing. =A0I sus=
pect
> it will be very unlikely to see people using this in the kernel64+use=
r32
> environment.

The problem is only with data_ptr field. If you make it the same size
whether it's for 32-bit or 64-bit arch then you don't need all that
compat code for user32 on kernel64 except for pointer translation when
there's 32-bit process calling.

Best Regards,
Micha=B3 Miros=B3aw
