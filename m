From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send ACMDs
Date: Wed, 23 Mar 2011 01:18:01 +0100
Message-ID: <AANLkTikHzG3j8oT_aqZ5VAGFxyBBShyPzQTZxvxwkuff@mail.gmail.com>
References: <203F41F6E33F954E8E8B02559FDC906F7431FC48EA@modex01>
 <alpine.DEB.2.00.1103180927390.5267@peruna> <AANLkTimjssCz_U4xbSf+ecoM7RsjC3eGQBo2vabfyy=T@mail.gmail.com>
 <201103182026.48939.arnd@arndb.de> <AANLkTinKon=D445PEHP2CzeL7OUpf_4y8j0-GA2nmZPt@mail.gmail.com>
 <alpine.DEB.2.00.1103211129130.23727@peruna> <AANLkTimwnS74Ybo6XTLOVUs7pRZBv4+hDgS7i2bfj+HV@mail.gmail.com>
 <alpine.DEB.2.00.1103221508420.30367@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62153 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164Ab1CWASW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Mar 2011 20:18:22 -0400
Received: by qwk3 with SMTP id 3so5555804qwk.19
        for <linux-mmc@vger.kernel.org>; Tue, 22 Mar 2011 17:18:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1103221508420.30367@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, cjb@laptop.org

W dniu 22 marca 2011 23:31 u=BFytkownik John Calixto
<john.calixto@modsystems.com> napisa=B3:
> On Tue, 22 Mar 2011, Micha=B3 Miros=B3aw wrote:
>> >> It is not that unusual on "normal systems" to give write access t=
o
>> >> some partition or device to unprivileged users. Database volumes =
are
>> >> one example.
>> > Are you talking about the device nodes themselves, or about access=
 to
>> > the mounted filesystems that live on those devices/partitions? =A0=
It seems
>> > like if you give unprivileged users write access to the raw block
>> > device, you should expect a lot more trouble from
>> > runaway/malicious/accidental writes than you would from
>> > application-specific commands being sent via ioctl.
>> I don't exactly see what's your point here. If you say that writes a=
re
>> less dangerous than ioctls, then I agree. Even now, for some block
>> ioctls you need CAP_SYS_ADMIN because of that.
> In general, I agree with your caution. =A0My point is that I'm not su=
re
> this type of protection belongs in the kernel. =A0We use permissions =
and
> "medium-privileged" role users all the time to marshal access to
> sensitive files and devices. =A0This is a problem that has been solve=
d in
> userspace. =A0You don't let normal user "john" have the same access t=
o
> device nodes or even files and directories that you would for role us=
er
> "database", or role user "webserver". =A0(Actually, you probably shou=
ldn't
> let normal user "john" have access to anything - I hear he's trouble!=
)

When you grant write access to a device to some user, you should
expect that it is all you are granting. There shouldn't be any hidden
doors that, for example, if underlying device is SD card then you can
destroy it by this ioctl(). Not counting wearing or WORM-like media,
writes (also erasing, changing encryption keys, etc.) are undoable.
Other forms of access should be granted separately (by capabilities or
other means).

Best Regards,
Micha=B3 Miros=B3aw
