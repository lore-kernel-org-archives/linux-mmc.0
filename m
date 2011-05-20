From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [[v4] 2/5] MMC: Use CMD23 for multiblock transfers when we can.
Date: Fri, 20 May 2011 01:54:26 -0500
Message-ID: <BANLkTi=mpibUJLJTCcf+i7=PgPBUFecgRw@mail.gmail.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-2-git-send-email-andreiw@motorola.com>
	<1303870235-29041-3-git-send-email-andreiw@motorola.com>
	<4DD48273.4060402@samsung.com>
	<BANLkTi=yJuEtN-SSokhp5CE_mCz9D9D5SA@mail.gmail.com>
	<4DD5F045.90001@samsung.com>
	<BANLkTik72KgftDWz6aNn=zGDqj1uMpwnYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og111.obsmtp.com ([64.18.0.22]:43079 "EHLO
	exprod5og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933731Ab1ETGy2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2011 02:54:28 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4K6swPK011708
	for <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 02:54:58 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4K6sXDC011598
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 02:54:58 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so3591719wwb.3
        for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 23:54:26 -0700 (PDT)
In-Reply-To: <BANLkTik72KgftDWz6aNn=zGDqj1uMpwnYw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org, arnd@arndb.de, Kyungmin Park <kyungmin.park@samsung.com>, "Gao, Yunpeng" <yunpeng.gao@intel.com>

On Fri, May 20, 2011 at 1:49 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
> On Thu, May 19, 2011 at 11:38 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi Andrei,
>>
>> Andrei Warkentin wrote:
>>> On Wed, May 18, 2011 at 9:37 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>> Hi Andrei
>>>>
>>>> Andrei Warkentin wrote:
>>>>> CMD23-prefixed instead of open-ended multiblock transfers
>>>>> have a performance advantage on some MMC cards.
>>>>>
>>>> you mentioned about "some MMC cards".
>>>> Conversely, that means the some card didn't have a performance advantage?
>>>>
>>>> Did you find the performance advantage?
>>>> if you found the advantage and you can tell me,
>>>> i want to know what do you have the some MMC cards..
>>>>
>>>
>>> I've tested this on a Sandisk eMMC where I saw as good as
>>> a 50% improvement on writes (30% real-life use cases). This was a
>>> SEM32G 4.3+ part.
>>
>> Can you tell me your environment? buswidth, AP information, benchmark etc..
>> And if you have the performance result's data, can you share them?
>>
>
> This was on an SDHCI controller (hence the patch...) on a Tegra
> 2-based system. I was measuring
> throughput on reads and writes (obviously without block cache,
> filesystem, etc) to an eMMC card, 8 bits.
>
> Tested both with my tool (https://github.com/andreiw/superalign) and
> an sqllite-based test.
>
> I'm attaching the data I have.
>
> A
>

Additionally, CMD23 use is a requirement for SDXC cards (Arindam can
comment on that), as well as for MMC reliable writes and eMMC 4.5-spec
features (Yunpeng Gao can comment on that).

These patches allow CMD23 use. They do involve a some changes to host
controller because of interaction with CMD12, as well as Auto-CMD12
and Auto-CMD23 features. I can definitely consult you if you need help
implementing CMD23 support for whatever controller you develop for.

A
