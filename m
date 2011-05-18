From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [RFC] MMC: Request for comments attempt at dealing with
 removeable suspend/resume.
Date: Wed, 18 May 2011 03:06:53 -0500
Message-ID: <BANLkTi=nFwD4nCK2H_KytbAbrKRs20uGmg@mail.gmail.com>
References: <BANLkTikMmf-d1BVG6ZMUV-L-nB05ytQVYw@mail.gmail.com>
	<1301949069-13283-1-git-send-email-andreiw@motorola.com>
	<5D8008F58939784290FAB48F54975198419F754279@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:53507 "EHLO
	exprod5og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab1ERIG6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 May 2011 04:06:58 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4I84dV4009202
	for <linux-mmc@vger.kernel.org>; Wed, 18 May 2011 04:04:39 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4I80xkA007736
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 18 May 2011 04:04:36 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so1178154wyb.15
        for <linux-mmc@vger.kernel.org>; Wed, 18 May 2011 01:06:54 -0700 (PDT)
In-Reply-To: <5D8008F58939784290FAB48F54975198419F754279@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, May 17, 2011 at 5:15 AM, Dong, Chuanxiao
<chuanxiao.dong@intel.com> wrote:
>
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org
>> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Andrei Warkentin
>> Sent: Tuesday, April 05, 2011 4:31 AM
>> To: linux-mmc@vger.kernel.org
>> Cc: Andrei Warkentin
>> Subject: [RFC] MMC: Request for comments attempt at dealing with removeable
>> suspend/resume.
>>
>> Is there any value to doing something like this in order to be able to
>> suspend/resume
>> with a (manually, or rootfs) mounted filesystem on mmcblk?
>>
>> Thoughts?
> Hi Andrei,
> I also encountered the same issue with you when system is suspending. And the modification in core.c actually can fix my issue.
> For the mounted root file system, I think it makes sense for such medias to use MMC_UNSAFE_RESUME. Is there some use case need to remove root file system media?
>

Except that if the filesystem (non-root) fails to unmount or it's a
root filesystem on a device on a host which isn't MMC_UNSAFE_RESUME,
then you will re-enumerate incorrectly on resume. On resume, fs will
be on a now "dead" device (say mmc0), while kernel will re-enumerate
card as mmc1 now since mmc0 never tore down.

Basically even if you're smart enough to avoid switching cards on
suspend/resume, this can still get to you and you will wind up with
either just a hang (if root fs on card), or weird re-enumeration and
countless I/O errors to dead device.

What above patch does is that it uses a two step process to clean up
MDs. MDs are put on an orphan list when the backing device goes away.
If they can be safely cleaned up - great, and they go away completely
when the refcount drops. Otherwise, they'll be "reconnected" to if the
*same* backing device reappears again.

A
