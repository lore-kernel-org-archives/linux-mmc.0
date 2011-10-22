From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: boot partition ro lock support
Date: Sat, 22 Oct 2011 18:33:57 +0200
Message-ID: <CACRpkdY5T+QoyLvsPmwQRcNPoV=U=46LRGzKvK_8fSL8kurSwA@mail.gmail.com>
References: <1817564019.180377.1319247876337.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
	<m24nz171vj.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46504 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab1JVQd6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Oct 2011 12:33:58 -0400
Received: by mail-iy0-f174.google.com with SMTP id k3so6023598iae.19
        for <linux-mmc@vger.kernel.org>; Sat, 22 Oct 2011 09:33:57 -0700 (PDT)
In-Reply-To: <m24nz171vj.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Andrei Warkentin <awarkentin@vmware.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, John Beckett <john.beckett@stericsson.com>, linux-mmc@vger.kernel.org

On Sat, Oct 22, 2011 at 12:32 PM, Chris Ball <cjb@laptop.org> wrote:
> On Fri, Oct 21 2011, Andrei Warkentin wrote:
>>
>> The permalocking brick-potential (more like paper-weight-potential) =
is
>> IMO unacceptably high that something like this is just accessible vi=
a
>> a sysfs attribute. This is exactly why the boot partitions were put
>> under force_ro, so that some poor sap wouldn't end up nuking the boo=
t
>> partitions (with obvious consequences), and permalocking seems even
>> nastier.

I presume the sysfs files are there exactly to avoid bricking,
by locking partitions down from userspace. So what you're saying
is that this should be done by the kernel itself or bootloader?

[Chris]
> I agree. =A0Does anyone have an argument for including either of thes=
e?

I see the problem with having it as sysfs files, so what is our
rationale about using that documented MMC feature? I can
think of two:

1) Use a kernel cmdline param to permalock partitions

2) Only bootloaders should do such stuff

As noticed all over ARM linux' mailing lists boot loader updates are
nasty stuff, usually it's pretty hard to alter stuff there to get what
you want. Not all boot loaders are as sophisticated cmdline parsers
as U-Boot mind you...

So what about a cmdline approach? That makes it possible
for people who are willingly recompiling and hacking their kernels
to tinker with this if they absolutely want to go in on that
partition, make it rw and change stuff.

=2E..org have I just got all this backwards...?

Yours,
Linus Walleij
