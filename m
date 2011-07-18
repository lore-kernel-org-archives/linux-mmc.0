From: Manoj Iyer <manoj.iyer@canonical.com>
Subject: Re: [PATCH] mmc: Added quirks for Ricoh 1180:e823 lower base clock
 frequency
Date: Mon, 18 Jul 2011 15:36:38 -0500 (CDT)
Message-ID: <alpine.DEB.2.02.1107181535250.1677@lazy>
References: <1310419715-13254-1-git-send-email-manoj.iyer@canonical.com> <m2sjqa2q93.fsf@bob.laptop.org> <alpine.DEB.2.02.1107131031360.3174@lazy> <201107131835.25217.arnd@arndb.de> <alpine.DEB.2.02.1107131144250.3174@lazy> <m21uxu2k96.fsf@bob.laptop.org>
 <alpine.DEB.2.02.1107131157440.3174@lazy> <m2wrfm1537.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1333013405-1311021405=:1677"
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <m2wrfm1537.fsf@bob.laptop.org>
Sender: linux-pci-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Manoj Iyer <manoj.iyer@canonical.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, matsumur@nts.ricoh.co.jp, linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1333013405-1311021405=:1677
Content-Type: TEXT/PLAIN; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE


Chris,

Here are the results with SanDisk SDSDXP1-016G-A75 16GB Extreme Pro SDHC=20
Memory Card.

u@u:~/flashbench$ sudo ./flashbench -a /dev/mmcblk0p1
[sudo] password for u:
align 4294967296        pre 1.16ms      on 1.15ms       post 1.15ms=20
diff -2024ns
align 2147483648        pre 1.2ms       on 1.2ms        post 1.2ms=20
diff 522ns
align 1073741824        pre 1.21ms      on 1.2ms        post 1.2ms=20
diff 570ns
align 536870912 pre 1.2ms       on 1.2ms        post 1.2ms      diff 662ns
align 268435456 pre 1.2ms       on 1.2ms        post 1.2ms      diff 404ns
align 134217728 pre 1.2ms       on 1.2ms        post 1.2ms      diff=20
-1692ns
align 67108864  pre 1.15ms      on 1.16ms       post 1.16ms     diff=20
1.37=B5s
align 33554432  pre 1.18ms      on 1.19ms       post 1.15ms     diff=20
31.3=B5s
align 16777216  pre 1.17ms      on 1.19ms       post 1.15ms     diff=20
31.5=B5s
align 8388608   pre 1.17ms      on 1.21ms       post 1.18ms     diff=20
32.9=B5s
align 4194304   pre 1.37ms      on 1.55ms       post 1.17ms     diff 274=B5=
s
align 2097152   pre 1.37ms      on 1.37ms       post 1.39ms     diff=20
-7992ns
align 1048576   pre 1.33ms      on 1.33ms       post 1.34ms     diff=20
-7793ns
align 524288    pre 1.33ms      on 1.33ms       post 1.34ms     diff=20
-6641ns
align 262144    pre 1.34ms      on 1.38ms       post 1.35ms     diff=20
33.8=B5s
align 131072    pre 1.35ms      on 1.37ms       post 1.34ms     diff=20
27.2=B5s
align 65536     pre 1.34ms      on 1.37ms       post 1.34ms     diff=20
31.7=B5s
align 32768     pre 1.33ms      on 1.37ms       post 1.34ms     diff=20
32.5=B5s

u@u:~/flashbench$ sudo ./flashbench -O --erasesize=3D$[4 * 1024 * 1024]=20
--blocksize=3D$[256 * 1024] /dev/mmcblk0p1 --open-au-nr=3D2
4MiB    23.2M/s
2MiB    23.6M/s
1MiB    23.5M/s
512KiB  23.2M/s
256KiB  23.2M/s
u@u:~/flashbench$


On Wed, 13 Jul 2011, Chris Ball wrote:

> Hi,
>
> On Wed, Jul 13 2011, Manoj Iyer wrote:
>>> It could be better.  Do you think you could get hold of a UHS-1 card fo=
r
>>> testing with?  (I don't think it's worth doing if there's no appreciabl=
e
>>> performance difference either way.)
>>
>> Yes, I can go out and buy one today, do the performance tests like I
>> have done before and report back to you.
>
> Perfect.  Thanks very much!
>
> - Chris.
> --=20
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
>
>

--
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Manoj Iyer
Ubuntu/Canonical
Hardware Enablement
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--8323329-1333013405-1311021405=:1677--
