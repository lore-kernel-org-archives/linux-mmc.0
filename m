From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH v3] mmc: Add ioctl to let userspace apps send ACMDs
Date: Fri, 8 Apr 2011 03:46:50 -0500
Message-ID: <BANLkTikBGpJ0Sjp-8hWVzpVvog9co=HWNw@mail.gmail.com>
References: <alpine.DEB.2.00.1104071816270.10238@peruna>
	<BANLkTin9hfr+VfprkDr-Lc+iY0qShmcnng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og112.obsmtp.com ([64.18.0.24]:57848 "EHLO
	exprod5og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab1DHIqx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Apr 2011 04:46:53 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p388lEOd009154
	for <linux-mmc@vger.kernel.org>; Fri, 8 Apr 2011 04:47:14 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p388lCw1009127
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 8 Apr 2011 04:47:13 -0400 (EDT)
Received: by wwb28 with SMTP id 28so3823815wwb.3
        for <linux-mmc@vger.kernel.org>; Fri, 08 Apr 2011 01:46:50 -0700 (PDT)
In-Reply-To: <BANLkTin9hfr+VfprkDr-Lc+iY0qShmcnng@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Fri, Apr 8, 2011 at 3:22 AM, Andrei Warkentin <andreiw@motorola.com>=
 wrote:
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* According to the SD specs, some commands require =
a delay after
>> + =A0 =A0 =A0 =A0* issuing the command.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (idata->ic.postsleep_us)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(idata->ic.postsleep_us);
>> +
>
> How long can this possibly be? Does usleep make any sense here?
>

Just to expand further on the question... is this a delay after a
command (and it's data transfer, if any) has completely completed and
the card is idle as far as the host driver can tell??? Or is the
timeout while the card is busy (and holding down DAT)?

I popped over to the ASSD simplified spec, and I can see interesting
items like Protected_Memory_WR_TIME and WR_SEC_BUSY_TIME, and from the
vague description I think that's the timeout going into
data.timeout_ns for such transfers.

Thanks,
A
