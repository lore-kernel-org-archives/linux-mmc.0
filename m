From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] sdhci: sdhci-pxa only supports mmp2 at this time.
 Change Kconfig
Date: Mon, 22 Nov 2010 21:16:43 -0800
Message-ID: <B44139C2-C6BD-4130-918E-C56900FB84AF@marvell.com>
References: <3E707E23-91F2-4BA1-A74B-C8EE2E8EAF31@marvell.com>
 <AANLkTimMFsxHt3AEfHDgZsia3c+rYVx2P5Diw=Robrbe@mail.gmail.com>
 <20101123025548.GA29770@void.printf.net>
 <AANLkTi=aPtSsDk5UYgXz5REw0K7m_xzNDSHgs31Rbcx+@mail.gmail.com>
 <F2601D24-BA24-4E4C-8C2D-C6B5C55416EB@marvell.com>
 <AANLkTinZdya+yELS2+Qi3UFjXg0LRveXEf=+nUYJsoHa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35057 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751057Ab0KWFSE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Nov 2010 00:18:04 -0500
In-Reply-To: <AANLkTinZdya+yELS2+Qi3UFjXg0LRveXEf=+nUYJsoHa@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Chris Ball <cjb@laptop.org>, "Mark F. Brown" <mark.brown314@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Eric Miao <eric.y.miao@gmail.com>

On Nov 22, 2010, at 8:59 PM, Haojian Zhuang wrote:

> On Tue, Nov 23, 2010 at 11:22 AM, Philip Rakity <prakity@marvell.com> wrote:
>> 
>> I implemented the first sdhci-pxa.c controller for the pxa168 over a year ago.  Also fixed issues on Tavor.
>> 
>> This approach is not sufficient to make Aspen nor Tavor work.
>> 
>> There are a number of silicon issues that need to be addressed.
>> 
>> 
>> 
>> 
> But we're formating patches for these silicons. I prefer to push
> patches for Aspen/Tavor rather than restricting on CPU_MMP2 now.

You can remove the CPU_MMP2 flag when that is done.


> 
> This driver is used to share among Aspen/Tavor/MMP2.

Since Mark and I did the pxa168 mmc code we would prefer that you leave the patches for us.

Calling into the arch/ code for every platform does not seem the right way to go.   It is probably simpler to factor out
any common code and define platform specific modules for mmp2/aspen/tavor.  Once you start working around the
silicon issues calling into arch/ may not look like an approach that is easy to follow going forward.  

> 
> Thanks
> Haojian

