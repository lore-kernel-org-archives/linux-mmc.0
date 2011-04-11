From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [patchv3 4/4] MMC: MMC boot partitions support.
Date: Mon, 11 Apr 2011 17:10:37 -0500
Message-ID: <BANLkTimAFUnodvc2yBs-Bj=DnSpmZN7BwA@mail.gmail.com>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
	<1302556424-21951-4-git-send-email-andreiw@motorola.com>
	<m3oc4c8n3b.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og103.obsmtp.com ([64.18.0.145]:47403 "EHLO
	exprod5og103.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756089Ab1DKWKj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 18:10:39 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3BM8o0p003610
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 18:08:51 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3BM72Kh002911
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 18:08:50 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so8544287wyb.15
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 15:10:37 -0700 (PDT)
In-Reply-To: <m3oc4c8n3b.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, arnd@arndb.de

On Mon, Apr 11, 2011 at 5:00 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Andrei,
>
> On Mon, Apr 11 2011, Andrei Warkentin wrote:
>> Allows device MMC boot partitions to be accessed. MMC partitions
>> are treated effectively as separate block devices on the same
>> MMC card.
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
>
> Looks fine, but would you mind breaking out the {claim,release}_host
> changes around mmc_blk_issue_rq() into a separate patch? =A0It doesn'=
t
> look like they're obviously related to the partitioning support, but
> maybe I'm missing something.
>

So it was one of the two -
a) stick mmc_bkl_part_switch into mmc_blk_issue_secdiscard_rq,
mmc_blk_issue_discard_rq,  and mmc_blk_issue_rw_rq.
b) Move claim/release into mmc_blk_issue_rq and put partition switch
code into one place.

(b) is cleaner.  What do you think?

A
