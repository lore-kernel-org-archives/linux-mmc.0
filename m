From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH 1/1] mmc:Support of PCI mode for the dw_mmc driver
Date: Wed, 30 Nov 2011 21:31:18 +0530
Message-ID: <CANYdXnrfr26BbsgypmxUDka7w9K7BUB-4b_tPSPKxh-2B3Ah8A@mail.gmail.com>
References: <1322656585-8363-1-git-send-email-shashidharh@vayavyalabs.com>
	<4ED63861.7030607@imgtec.com>
	<CANYdXnr1+gNmE0nTf0BOHMFZnwsJgYKk8ZcAJqdutDTx25gnWQ@mail.gmail.com>
	<4ED64EAB.4050405@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58241 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab1K3QBT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2011 11:01:19 -0500
Received: by ywa9 with SMTP id 9so753415ywa.19
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2011 08:01:18 -0800 (PST)
In-Reply-To: <4ED64EAB.4050405@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Philip Rakity <prakity@marvell.com>, "Mark F. Brown" <mark.brown314@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

On Wed, Nov 30, 2011 at 9:11 PM, James Hogan <james.hogan@imgtec.com> w=
rote:
> Hi,
>
> On 11/30/2011 03:27 PM, Shashidhar Hiremath wrote:
>> Hi James,
>> =C2=A0 Sorry for the minor alignment issues.Will fix them .
>
> Thanks
>
>> I actually did
>> compile the code but as separate driver not along with the kernel. I=
n
>> fact, I have also tested the PCI patch ,but not as separate files bu=
t
>> with the earlier #ifdef method =C2=A0I had sent in initial patch .
>
> But the new patch was completely different, you can't just rework the
> entire patch and expect it to compile and work without at least tryin=
g
> it to make sure, as evidenced by the fact that with mmc_next + your
> patch, I get:
> dw_mmc.c: 7 errors, 22 warnings
> dw_mmc-pci.c: 2 errors
> dw_mmc-pltfm.c: 6 errors, 1 warning
>
ohh,
will compile and fix it
> Cheers
> James
>
>> On Wed, Nov 30, 2011 at 7:36 PM, James Hogan <james.hogan@imgtec.com=
> wrote:
>>> *sigh* You haven't actually tried compiling this have you? How do y=
ou
>>> know whether it works or not? You really really should at least mak=
e
>>> sure it compiles (for simple changes) and works without breaking
>>> anything (for anything non-trivial like adding support for a new bu=
s
>>> like PCI)!
>
>



--=20
regards,
Shashidhar Hiremath
