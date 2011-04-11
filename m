From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [patchv3 4/4] MMC: MMC boot partitions support.
Date: Mon, 11 Apr 2011 17:18:49 -0500
Message-ID: <BANLkTinHodYLMMA0=JJ1z_kX8jQm1P=akA@mail.gmail.com>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
	<1302556424-21951-4-git-send-email-andreiw@motorola.com>
	<m3oc4c8n3b.fsf@pullcord.laptop.org>
	<BANLkTimAFUnodvc2yBs-Bj=DnSpmZN7BwA@mail.gmail.com>
	<m3ei588m3t.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:40683 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab1DKWSv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 18:18:51 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3BMJC49003044
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 18:19:12 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3BMELYS001387
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 18:19:11 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so6856610wwb.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 15:18:49 -0700 (PDT)
In-Reply-To: <m3ei588m3t.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, arnd@arndb.de

On Mon, Apr 11, 2011 at 5:22 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Andrei,
>
> On Mon, Apr 11 2011, Andrei Warkentin wrote:
>> So it was one of the two -
>> a) stick mmc_bkl_part_switch into mmc_blk_issue_secdiscard_rq,
>> mmc_blk_issue_discard_rq, =A0and mmc_blk_issue_rw_rq.
>> b) Move claim/release into mmc_blk_issue_rq and put partition switch
>> code into one place.
>>
>> (b) is cleaner. =A0What do you think?
>
> Thanks, I see.
>
> (b) is definitely fine -- I'm suggesting one patch to push claim/rele=
ase
> up into mmc_blk_issue_rq() (which should have no other side-effects),
> and then a second patch to add partitioning support and also insert t=
he
> single mmc_blk_part_switch() into the right place. =A0Does that make =
sense?
>

Ok, great! Will do.

A
