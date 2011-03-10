From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [RFC 2/5] MMC: Allow function-specific quirks.
Date: Thu, 10 Mar 2011 14:41:45 -0600
Message-ID: <AANLkTi=HBwXQL125Zat-wAcZYFE5ZKy9bUzqBfp+sB_u@mail.gmail.com>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
	<1299718449-15172-3-git-send-email-andreiw@motorola.com>
	<201103101609.28223.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:36783 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab1CJUmd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 15:42:33 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2AKgmUf000721
	for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2011 15:42:48 -0500 (EST)
Received: from mail-vx0-f170.google.com (mail-vx0-f170.google.com [209.85.220.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2AKbUsQ028526
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2011 15:42:48 -0500 (EST)
Received: by mail-vx0-f170.google.com with SMTP id 39so2433486vxb.15
        for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2011 12:42:31 -0800 (PST)
In-Reply-To: <201103101609.28223.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

On Thu, Mar 10, 2011 at 9:09 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 10 March 2011, Andrei Warkentin wrote:
>>
>> This allows us to create quirks for block devices, without
>> creating messy Kconfig dependencies, or polluting core/ with
>> function-specific code.
>
> The change looks good to me, but it's hard to read because
> you are moving around code and changing it in one patch.
>
> A better split of the first three patches would be to first
> move the code to a header file without changing it, and then
> make the changes.
>
> Or you could directly add the code to the header file when you
> introduce it in the first patch.

So basically squash the three patches dealing with quirks infrastructure?

A
