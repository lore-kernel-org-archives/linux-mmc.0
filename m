From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [comments] MMC: Reliable write support.
Date: Tue, 29 Mar 2011 17:44:03 -0500
Message-ID: <AANLkTinDdEJ0bwH3Kj_QmhD=Z=07eaRvpA=sASn+DmkJ@mail.gmail.com>
References: <1301001751-30785-1-git-send-email-andreiw@motorola.com>
	<201103251614.29893.arnd@arndb.de>
	<AANLkTi=+LOy6V4hLsjaDd60xjEWm7jtYXaW8-4j=7TCQ@mail.gmail.com>
	<201103290901.31680.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:42985 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab1C2WoG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2011 18:44:06 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2TMgRjQ013476
	for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2011 18:42:27 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2TMf08V012847
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2011 18:42:27 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so816235wwb.3
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2011 15:44:03 -0700 (PDT)
In-Reply-To: <201103290901.31680.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

On Tue, Mar 29, 2011 at 2:01 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 29 March 2011, Andrei Warkentin wrote:
>> On Fri, Mar 25, 2011 at 10:14 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> I confirmed with two MMC vendors that there is no "flush". Once the
>> DAT transfer completes, the data is stored on non-volatile storage as
>> soon as the busy status is cleared.
>>
>> Reliable writes are still "more reliable" because if the DAT transfer
>> is interrupted (power or reset through CMD0/CMD15 or hw pin for eMMC),
>> you have predictable flash contents. So it makes sense to map REQ_FUA
>> to it (and REQ_META, I would guess).
>
> Yes, sounds good.
>
> So I guess on MLC flash, a reliable write will go to a flash page
> that does not have data in any of its paired pages.

Should I resubmit the patch?

A
