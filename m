From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: CMD23 plumbing and support patchset.
Date: Thu, 21 Apr 2011 01:29:40 -0500
Message-ID: <BANLkTik99XdFSsb7cjX0YoYHRA2d+Vn_yg@mail.gmail.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
	<1302950458-1969-1-git-send-email-andreiw@motorola.com>
	<m3pqogbcoa.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og103.obsmtp.com ([64.18.0.145]:55551 "EHLO
	exprod5og103.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab1DUG3n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 02:29:43 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3L6RkqO018787
	for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 02:27:46 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3L6NP6N017238
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 02:27:45 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so1742494wyb.15
        for <linux-mmc@vger.kernel.org>; Wed, 20 Apr 2011 23:29:41 -0700 (PDT)
In-Reply-To: <m3pqogbcoa.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com

Hi Chris,

On Wed, Apr 20, 2011 at 8:44 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Sat, Apr 16 2011, Andrei Warkentin wrote:
>> This is the third version of the CMD23 plumbing and host driver supp=
ort
>> patch set.
>>
>> Changes:
>> 1) CMD23 support (used for features such as reliable writes) is deco=
upled
>> =A0 =A0from general multiblock trans through use of a quirk for affe=
cted cards.
>> 2) Newer Sandisk MMC products are whitelisted along with some known =
good ones. All other
>> =A0 =A0MMC products do not use CMD23 for general transfers (seems li=
ke safest choice for now).
>> =A0 =A0SD products unaffected.
>
> Just gave this a try on SEM04G, which is in the whitelist, but didn't
> see a performance increase (or decrease). =A0What are you using for a
> testcase? =A0I'm a little wary of running mmc_test on it. =A0:)
>

Can you give me the manufacturing date? This is pretty interesting.

You can see an improvement even if you do something like time block
writes (O_DIRECT | O_SYNC, of course). But after all synthetic tests I
measured the time it took to do 40000 SQLite insertions and saw
something like 30% improvement.

A
