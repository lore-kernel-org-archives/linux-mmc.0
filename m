From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [[v4] 2/5] MMC: Use CMD23 for multiblock transfers when we can.
Date: Mon, 23 May 2011 14:33:00 -0500
Message-ID: <BANLkTimP22uz29mrE_GV7Sya-t9ucQ5wbQ@mail.gmail.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-2-git-send-email-andreiw@motorola.com>
	<1303870235-29041-3-git-send-email-andreiw@motorola.com>
	<4DD48273.4060402@samsung.com>
	<BANLkTi=yJuEtN-SSokhp5CE_mCz9D9D5SA@mail.gmail.com>
	<4DD5F045.90001@samsung.com>
	<BANLkTik72KgftDWz6aNn=zGDqj1uMpwnYw@mail.gmail.com>
	<BANLkTi=mpibUJLJTCcf+i7=PgPBUFecgRw@mail.gmail.com>
	<4DDA55B6.3040708@samsung.com>
	<BANLkTinES0gAtz12LDA3jpEWF4J+1t8eVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:42520 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933483Ab1EWTdD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2011 15:33:03 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4NJXX8w024026
	for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 15:33:34 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4NJSeak022257
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 15:33:33 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so6383773wwb.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 12:33:01 -0700 (PDT)
In-Reply-To: <BANLkTinES0gAtz12LDA3jpEWF4J+1t8eVg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org, arnd@arndb.de, Kyungmin Park <kyungmin.park@samsung.com>, "Gao, Yunpeng" <yunpeng.gao@intel.com>

On Mon, May 23, 2011 at 2:25 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> On Mon, May 23, 2011 at 7:40 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi A..
>>
>> I tested your patch..(using CMD23)
>> my environment is the below.
>> eMMC card : Sandisk SEM8G (eMMC 4.3+)
>> buswidth : 4bit (SDR)
>> AP : C110
>> benchmark : IOzone
>>
>> I want to know how do you think about this result?
>> (i can't see your results)
>>
>
> I think that you should use my tool to measure I/O performance.
> Because I want to see the mins, maxes, average and
> std dev. Iozone adds way too much noise to the data. You can run it 5
> times in a row and get completely different numbers. Please use
> https://github.com/andreiw/superalign.
>
> For a more realistic test you can try performing 20000 sqlite inserts
> or something of the sort and timing that.
>
> A
>

Additionally, be careful how you do your testing. I don't want to
sound obvious, but, to ensure you can actually compare the collected
data against each other -
1) Disable all power/frequency scaling/management/gating, suspend/resume, etc.
2) Make sure nothing else uses the eMMC. No root mounted fs, nothing.
3) Make sure you are avoiding block cache and file system. You want
direct block I/O.
4) For extra extra extra reliable results - Make sure you are not
rebooting across testing. You will need to add a flag so you can
disable CMD23 on the fly via debugfs.

For sqlite testing some other helpful hints -
1) Unmount partition containing files on which the SQLite test operates.
2) Perform BLKDISCARD over the partition.
3) Format with desired file system.
4) Mount.
6) Sync && echo 3 > /proc/sys/vm/drop_caches
7) Perform test.
8) Umount.
9) Repeat from (1)

A
