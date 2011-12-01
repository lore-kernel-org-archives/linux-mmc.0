From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc0: Too large timeout requested for CMD38!
Date: Thu, 01 Dec 2011 13:01:39 -0500
Message-ID: <878vmwmarg.fsf@laptop.org>
References: <CAC=G6szdK=6wR4xiZk9mhBofEf7DHeuAcpeeTiVCdiK1aUyeOw@mail.gmail.com>
	<CAC=G6swWj3=eUYUczCqcNJq7Nj177nis4817+bg-qS0dUic=Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54212 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755813Ab1LASBf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2011 13:01:35 -0500
In-Reply-To: <CAC=G6swWj3=eUYUczCqcNJq7Nj177nis4817+bg-qS0dUic=Xg@mail.gmail.com>
	(Paul Schilling's message of "Fri, 18 Nov 2011 16:59:53 -0600")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Schilling <paul.s.schilling@gmail.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>

Hi Jaehoon, Kyungmin, Kukjin,

On Fri, Nov 18 2011, Paul Schilling wrote:
> I am getting the following error when trying to use a swap file on a
> large 32GB SD card formated with EXT4.
>
> Thanks,
> Paul Schilling
>
> Swap file /external_flash_a/swap_file being enabled.
> mmc0: Too large timeout requested for CMD38!
> mmc0: Too large timeout requested for CMD38!
> mmc0: Too large timeout requested for CMD38!
> mmc0: Too large timeout requested for CMD38!
> mmc0: Too large timeout requested for CMD38!
> mmc0: Too large timeout requested for CMD38!
> mmc0: Too large timeout requested for CMD38!
> mmc0: Too large timeout requested for CMD38!
> mmc0: Too large timeout requested for CMD38!
> mmc0: Too large timeout requested for CMD38!
> mmc0: Too large timeout requested for CMD38!
> mmc0: Too large timeout requested for CMD38!
> mmc0: Too large timeout requested for CMD38!
> Adding 131068k swap on /external_flash_a/swap_file.=C2=A0 Priority:-1
> extents:3 across:135104k SS
>
> Linux version 3.2.0-rc2+ (#######) (gcc version 4.3.3 (GCC) ) #77
> PREEMPT Fri Nov 18 13:37:37 CST 2011
> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053177
> CPU: VIVT data cache, VIVT instruction cache
> Machine: CONDOR2416
> [..]

Any thoughts on this s3c error?

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
