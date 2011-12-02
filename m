From: Paul Schilling <paul.s.schilling@gmail.com>
Subject: Re: mmc0: Too large timeout requested for CMD38!
Date: Fri, 2 Dec 2011 11:07:20 -0600
Message-ID: <CAC=G6szgD_dUW3ndccNmxf7LP_Zzm-ehmb=4djBoW_rGMwA1qg@mail.gmail.com>
References: <CAC=G6szdK=6wR4xiZk9mhBofEf7DHeuAcpeeTiVCdiK1aUyeOw@mail.gmail.com>
	<CAC=G6swWj3=eUYUczCqcNJq7Nj177nis4817+bg-qS0dUic=Xg@mail.gmail.com>
	<878vmwmarg.fsf@laptop.org>
	<4ED82AAC.4030402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38037 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875Ab1LBRHV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2011 12:07:21 -0500
Received: by vbbfc26 with SMTP id fc26so2448045vbb.19
        for <linux-mmc@vger.kernel.org>; Fri, 02 Dec 2011 09:07:20 -0800 (PST)
In-Reply-To: <4ED82AAC.4030402@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>

Hi,

This occurred on two different but large SD cards.

 The 32 GB card that produced the output has the following specs:

=B7         Brand Name: EBS

=B7         Model: 32G_TF_C10_1A_R4ORG.2

=B7         Class 10



The 16 GB card that produced the output has the following specs:

=B7         Brand Name: Samsung

=B7         Model: MICROSDHC 16GB

=B7         Class 2

Thanks,
Paul Schilling

On Thu, Dec 1, 2011 at 7:32 PM, Jaehoon Chung <jh80.chung@samsung.com> =
wrote:
>
> Hi Chris.
>
> i didn't know this error is related with s3c.
>
> When swapon is performing, i know the card is run the discard.
> (mm/swapfile.c about line 2050? run discard_swap())
>
> At that time, This SD card's erase_time_out should be too big,so this=
 message may be produced.
>
> If i can get the more information, very helpful to me for debugging w=
hether this problem is s3c or not.
> (What is SD-card's vendor?)
>
> Thanks
>
> Best Regards,
> Jaehoon Chung
>
> On 12/02/2011 03:01 AM, Chris Ball wrote:
>
> > Hi Jaehoon, Kyungmin, Kukjin,
> >
> > On Fri, Nov 18 2011, Paul Schilling wrote:
> >> I am getting the following error when trying to use a swap file on=
 a
> >> large 32GB SD card formated with EXT4.
> >>
> >> Thanks,
> >> Paul Schilling
> >>
> >> Swap file /external_flash_a/swap_file being enabled.
> >> mmc0: Too large timeout requested for CMD38!
> >> mmc0: Too large timeout requested for CMD38!
> >> mmc0: Too large timeout requested for CMD38!
> >> mmc0: Too large timeout requested for CMD38!
> >> mmc0: Too large timeout requested for CMD38!
> >> mmc0: Too large timeout requested for CMD38!
> >> mmc0: Too large timeout requested for CMD38!
> >> mmc0: Too large timeout requested for CMD38!
> >> mmc0: Too large timeout requested for CMD38!
> >> mmc0: Too large timeout requested for CMD38!
> >> mmc0: Too large timeout requested for CMD38!
> >> mmc0: Too large timeout requested for CMD38!
> >> mmc0: Too large timeout requested for CMD38!
> >> Adding 131068k swap on /external_flash_a/swap_file. =A0Priority:-1
> >> extents:3 across:135104k SS
> >>
> >> Linux version 3.2.0-rc2+ (#######) (gcc version 4.3.3 (GCC) ) #77
> >> PREEMPT Fri Nov 18 13:37:37 CST 2011
> >> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053177
> >> CPU: VIVT data cache, VIVT instruction cache
> >> Machine: CONDOR2416
> >> [..]
> >
> > Any thoughts on this s3c error?
> >
> > Thanks,
> >
> > - Chris.
>
>
