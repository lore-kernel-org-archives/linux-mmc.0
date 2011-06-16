From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
Date: Thu, 16 Jun 2011 15:35:52 -0500
Message-ID: <BANLkTin3knd8CUP4wSrXYio-asrM+Omrhg@mail.gmail.com>
References: <201106022149.47936.heiko@sntech.de>
	<201106141610.42700.heiko@sntech.de>
	<BANLkTimzxUQnVn5VC8EOaJeHq=wifUhZ4A@mail.gmail.com>
	<201106162214.11084.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og107.obsmtp.com ([64.18.0.184]:33162 "EHLO
	exprod5og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757062Ab1FPUfz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jun 2011 16:35:55 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p5GKX8nW002462
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jun 2011 16:33:08 -0400 (EDT)
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com [209.85.160.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p5GKQkSw029045
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jun 2011 16:33:07 -0400 (EDT)
Received: by mail-pw0-f42.google.com with SMTP id 4so110180pwi.15
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jun 2011 13:35:52 -0700 (PDT)
In-Reply-To: <201106162214.11084.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Thu, Jun 16, 2011 at 3:14 PM, Heiko St=FCbner <heiko@sntech.de> wrot=
e:
> Am Dienstag 14 Juni 2011, 22:32:41 schrieb Andrei Warkentin:
>> Hi Heiko,
>>
>> On Tue, Jun 14, 2011 at 9:10 AM, Heiko St=FCbner <heiko@sntech.de> w=
rote:
>> > nope, no updates yet. The flood also only starts when udev wants t=
o
>> > create its device nodes, meaning the initial detection seems not t=
o
>> > produce this problem
>> >
>> > But when I disable the whole boot partition stuff, it works as bef=
ore
>> > without irq storms.
>> >
>> > As there don't seem to exist reports from other emmc users about t=
his
>> > I guess the problem lays somewhere between the boot-partitions-pat=
ch
>> > and the sdhci-s3c driver (for s3c2416 at least).
>>
>> Alright. Curious. Can you let me know what eMMC device you are
>> connecting to the controller? What is the eMMC revision?
> hmm ... how do I find these?

The simplest is probably knowing what part is in your platform. The
slightly more involved is adding a relevant printk for
card->ext_csd.rev inside drivers/mmc/core/mmc.c.

> The real device providing the storage is a 2GB NAND Flash from Hynix.
>
> And sadly both of your patches didn't change anything.
>

Can you provide me dmesg for both patches?

Thanks again,
A
