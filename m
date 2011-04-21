From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH] mmc: mxs-mmc: add support for pre_req and post_req
Date: Thu, 21 Apr 2011 10:52:20 +0200
Message-ID: <BANLkTimZvqs__Z7XY=RNsX9yP-hfQ5r95w@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
	<20110417164830.GE17935@S2100-06.ap.freescale.net>
	<BANLkTimwvX633UaUoc4P4DD1xnpLbMTrZA@mail.gmail.com>
	<20110420140120.GF1965@S2100-06.ap.freescale.net>
	<BANLkTi=UR4NDEGjFkTnp_2UG4T1qUEPATw@mail.gmail.com>
	<20110421062535.GA4024@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:35205 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab1DUIwW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 04:52:22 -0400
Received: by qyg14 with SMTP id 14so869558qyg.19
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 01:52:21 -0700 (PDT)
In-Reply-To: <20110421062535.GA4024@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linaro-kernel@lists.linaro.org, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On 21 April 2011 08:25, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Wed, Apr 20, 2011 at 05:22:34PM +0200, Per Forlin wrote:
> [...]
>> > Do you have omap_hsmmc and mmci mmc_test result data to share?
>> >
>> I keep the here:
>> https://wiki.linaro.org/WorkingGroups/Kernel/Specs/StoragePerfMMC-as=
ync-req
>>
> Actually, I have seen this page before. =A0I was wondering if you hav=
e
> mmc_test raw data (test log of cases #37 ~ #40) to share.
My test numbers are 39 - 42, same tests though.

PANDA - omap_hsmmc:
mmc0: Test case 39. Multiple write performance with sync req 4k to 4MB.=
=2E.
 mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 18.987487792
seconds (7068 kB/s, 6903 KiB/s)
 mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took
11.947631837 seconds (11233 kB/s, 10970 KiB/s)
 mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 9.472808839
seconds (14168 kB/s, 13836 KiB/s)
 mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 8.260650636
seconds (16247 kB/s, 15867 KiB/s)
 mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 7.622741699
seconds (17607 kB/s, 17194 KiB/s)
 mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took
7.323181152 seconds (18327 kB/s, 17898 KiB/s)
 mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 6.744140626
seconds (19901 kB/s, 19434 KiB/s)
 mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.679138184
seconds (20095 kB/s, 19624 KiB/s)
 mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took
6.625518800 seconds (20257 kB/s, 19782 KiB/s)
 mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 6.620574950
seconds (20272 kB/s, 19797 KiB/s)
 mmc0: Result: OK
 mmc0: Tests completed.
 mmc0: Starting tests of card mmc0:80ca...
 mmc0: Test case 40. Multiple write performance with async req 4k to 4M=
B...
 mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 18.647644043
seconds (7197 kB/s, 7028 KiB/s)
 mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took
11.624816894 seconds (11545 kB/s, 11275 KiB/s)
 mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 9.170440675
seconds (14635 kB/s, 14292 KiB/s)
 mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.965667725
seconds (16849 kB/s, 16454 KiB/s)
 mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 7.318023681
seconds (18340 kB/s, 17910 KiB/s)
 mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took
7.040740969 seconds (19063 kB/s, 18616 KiB/s)
 mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 6.444641113
seconds (20826 kB/s, 20338 KiB/s)
 mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.380249023
seconds (21036 kB/s, 20543 KiB/s)
 mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took
6.333343506 seconds (21192 kB/s, 20695 KiB/s)
 mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 6.328002930
seconds (21210 kB/s, 20713 KiB/s)
 mmc0: Result: OK
 mmc0: Tests completed.
 mmc0: Starting tests of card mmc0:80ca...
 mmc0: Test case 41. Multiple read performance with sync req 4k to 4MB.=
=2E.
 mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 20.567749024
seconds (6525 kB/s, 6372 KiB/s)
 mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took
12.770507813 seconds (10509 kB/s, 10263 KiB/s)
 mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 10.003143311
seconds (13417 kB/s, 13103 KiB/s)
 mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.775665284
seconds (17261 kB/s, 16856 KiB/s)
 mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.960906982
seconds (19281 kB/s, 18829 KiB/s)
 mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took
6.661651612 seconds (20147 kB/s, 19675 KiB/s)
 mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 6.510711672
seconds (20614 kB/s, 20131 KiB/s)
 mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.434722900
seconds (20858 kB/s, 20369 KiB/s)
 mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took
6.396850587 seconds (20981 kB/s, 20490 KiB/s)
 mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 6.368560791
seconds (21075 kB/s, 20581 KiB/s)
 mmc0: Result: OK
 mmc0: Tests completed.
 mmc0: Starting tests of card mmc0:80ca...
 mmc0: Test case 42. Multiple read performance with async req 4k to 4MB=
=2E..
 mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 20.650848389
seconds (6499 kB/s, 6347 KiB/s)
 mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took
12.796203613 seconds (10488 kB/s, 10243 KiB/s)
 mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 10.019592286
seconds (13395 kB/s, 13081 KiB/s)
 mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.603942870
seconds (17651 kB/s, 17237 KiB/s)
 mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.751251223
seconds (19880 kB/s, 19414 KiB/s)
 mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took
6.252929687 seconds (21464 kB/s, 20961 KiB/s)
 mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 5.956726076
seconds (22532 kB/s, 22004 KiB/s)
 mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.863586425
seconds (22890 kB/s, 22353 KiB/s)
 mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took
5.818939210 seconds (23065 kB/s, 22525 KiB/s)
 mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 5.797515869
seconds (23150 kB/s, 22608 KiB/s)
 mmc0: Result: OK
 mmc0: Tests completed.


U5500 - mmci
mmc0: Test case 38. Multiple write performance with sync req 4k to 4MB.=
=2E.
mmc0: Transfer of 65536 x 8 sectors (65536 x 4 KiB) took 94.638215679
seconds (2836 kB/s, 2769 KiB/s)
mmc0: Transfer of 32768 x 16 sectors (32768 x 8 KiB) took 42.323242363
seconds (6342 kB/s, 6193 KiB/s)
mmc0: Transfer of 16384 x 32 sectors (16384 x 16 KiB) took
26.845500458 seconds (9999 kB/s, 9764 KiB/s)
mmc0: Transfer of 8192 x 64 sectors (8192 x 32 KiB) took 19.154612107
seconds (14014 kB/s, 13685 KiB/s)
mmc0: Transfer of 4096 x 128 sectors (4096 x 64 KiB) took 15.318183875
seconds (17523 kB/s, 17113 KiB/s)
mmc0: Transfer of 2048 x 256 sectors (2048 x 128 KiB) took
13.373840666 seconds (20071 kB/s, 19601 KiB/s)
mmc0: Transfer of 1024 x 512 sectors (1024 x 256 KiB) took
12.335949719 seconds (21760 kB/s, 21250 KiB/s)
mmc0: Transfer of 512 x 1024 sectors (512 x 512 KiB) took 11.886310118
seconds (22583 kB/s, 22054 KiB/s)
mmc0: Transfer of 256 x 2048 sectors (256 x 1024 KiB) took
11.703806675 seconds (22935 kB/s, 22398 KiB/s)
mmc0: Transfer of 64 x 8192 sectors (64 x 4096 KiB) took 11.632018242
seconds (23077 kB/s, 22536 KiB/s)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:0001...
mmc0: Test case 39. Multiple write performance with async req 4k to 4MB=
=2E..
mmc0: Transfer of 65536 x 8 sectors (65536 x 4 KiB) took 94.567817239
seconds (2838 kB/s, 2772 KiB/s)
mmc0: Transfer of 32768 x 16 sectors (32768 x 8 KiB) took 42.043969582
seconds (6384 kB/s, 6234 KiB/s)
mmc0: Transfer of 16384 x 32 sectors (16384 x 16 KiB) took
26.483716374 seconds (10135 kB/s, 9898 KiB/s)
mmc0: Transfer of 8192 x 64 sectors (8192 x 32 KiB) took 18.694318999
seconds (14359 kB/s, 14022 KiB/s)
mmc0: Transfer of 4096 x 128 sectors (4096 x 64 KiB) took 14.832822022
seconds (18097 kB/s, 17673 KiB/s)
mmc0: Transfer of 2048 x 256 sectors (2048 x 128 KiB) took
12.792243128 seconds (20984 kB/s, 20492 KiB/s)
mmc0: Transfer of 1024 x 512 sectors (1024 x 256 KiB) took
11.793732364 seconds (22760 kB/s, 22227 KiB/s)
mmc0: Transfer of 512 x 1024 sectors (512 x 512 KiB) took 11.299139279
seconds (23757 kB/s, 23200 KiB/s)
mmc0: Transfer of 256 x 2048 sectors (256 x 1024 KiB) took
11.160603255 seconds (24052 kB/s, 23488 KiB/s)
mmc0: Transfer of 64 x 8192 sectors (64 x 4096 KiB) took 11.036530115
seconds (24322 kB/s, 23752 KiB/s)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:0001...
mmc0: Test case 40. Multiple read performance with sync req 4k to 4MB..=
=2E
mmc0: Transfer of 65536 x 8 sectors (65536 x 4 KiB) took 24.830932935
seconds (10810 kB/s, 10557 KiB/s)
mmc0: Transfer of 32768 x 16 sectors (32768 x 8 KiB) took 15.896942145
seconds (16885 kB/s, 16490 KiB/s)
mmc0: Transfer of 16384 x 32 sectors (16384 x 16 KiB) took
11.452273667 seconds (23439 kB/s, 22890 KiB/s)
mmc0: Transfer of 8192 x 64 sectors (8192 x 32 KiB) took 9.247484468
seconds (29027 kB/s, 28347 KiB/s)
mmc0: Transfer of 4096 x 128 sectors (4096 x 64 KiB) took 8.117996552
seconds (33066 kB/s, 32291 KiB/s)
mmc0: Transfer of 2048 x 256 sectors (2048 x 128 KiB) took 7.672241687
seconds (34987 kB/s, 34167 KiB/s)
mmc0: Transfer of 1024 x 512 sectors (1024 x 256 KiB) took 7.588627916
seconds (35373 kB/s, 34544 KiB/s)
mmc0: Transfer of 512 x 1024 sectors (512 x 512 KiB) took 7.545239751
seconds (35576 kB/s, 34742 KiB/s)
mmc0: Transfer of 256 x 2048 sectors (256 x 1024 KiB) took 7.558409240
seconds (35514 kB/s, 34682 KiB/s)
mmc0: Transfer of 64 x 8192 sectors (64 x 4096 KiB) took 7.567300503
seconds (35473 kB/s, 34641 KiB/s)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:0001...
mmc0: Test case 41. Multiple read performance with async req 4k to 4MB.=
=2E.
mmc0: Transfer of 65536 x 8 sectors (65536 x 4 KiB) took 24.077512698
seconds (11148 kB/s, 10887 KiB/s)
mmc0: Transfer of 32768 x 16 sectors (32768 x 8 KiB) took 15.280992666
seconds (17566 kB/s, 17154 KiB/s)
mmc0: Transfer of 16384 x 32 sectors (16384 x 16 KiB) took
10.892908603 seconds (24643 kB/s, 24065 KiB/s)
mmc0: Transfer of 8192 x 64 sectors (8192 x 32 KiB) took 8.698435941
seconds (30860 kB/s, 30136 KiB/s)
mmc0: Transfer of 4096 x 128 sectors (4096 x 64 KiB) took 7.617525358
seconds (35239 kB/s, 34413 KiB/s)
mmc0: Transfer of 2048 x 256 sectors (2048 x 128 KiB) took 7.058797630
seconds (38028 kB/s, 37137 KiB/s)
mmc0: Transfer of 1024 x 512 sectors (1024 x 256 KiB) took 6.779599610
seconds (39594 kB/s, 38666 KiB/s)
mmc0: Transfer of 512 x 1024 sectors (512 x 512 KiB) took 6.639430826
seconds (40430 kB/s, 39482 KiB/s)
mmc0: Transfer of 256 x 2048 sectors (256 x 1024 KiB) took 6.588963683
seconds (40740 kB/s, 39785 KiB/s)
mmc0: Transfer of 64 x 8192 sectors (64 x 4096 KiB) took 6.561933369
seconds (40907 kB/s, 39949 KiB/s)



>
> --
> Regards,
> Shawn
>
>
Regards,
Per
