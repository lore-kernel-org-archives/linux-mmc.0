From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH v2 2/2] mmc: Check CAP_SYS_ADMIN for destructive ioctl ACMDs
Date: Tue, 5 Apr 2011 19:25:27 -0500
Message-ID: <BANLkTi=wXpqFGhaBPnoRa+sQJ_eysvrTVA@mail.gmail.com>
References: <alpine.DEB.2.00.1104051458350.25803@peruna>
	<BANLkTi=xcPEJxophfymqF5+Nd=aF40H=FQ@mail.gmail.com>
	<alpine.DEB.2.00.1104051613150.25803@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og115.obsmtp.com ([64.18.0.246]:60932 "EHLO
	exprod5og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994Ab1DFAZa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 20:25:30 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p360Nknv014129
	for <linux-mmc@vger.kernel.org>; Tue, 5 Apr 2011 20:23:46 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p360NjLS014121
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 5 Apr 2011 20:23:46 -0400 (EDT)
Received: by wyb34 with SMTP id 34so1210287wyb.15
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2011 17:25:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104051613150.25803@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

On Tue, Apr 5, 2011 at 6:40 PM, John Calixto
<john.calixto@modsystems.com> wrote:
>>
>> In MMC-land:
>> CMD18 is PROGRAM_CID (which is a once-in-a-lifetime operation).
>> CMD38 is erase
>> CMD25 is write_multiple_block - this can give a non-root user full
>> control over a disk, bypassing security.
>
> Hi Andrei,
>
> I have CMD18 as READ_MULTIPLE_BLOCK... =A0Regardless, this ioctl is
> specifically for ACMD opcodes (application-specific; preceeded by
> CMD55), not CMD opcodes.

I'm sorry, I meant CMD26 instead of 18.

Could you check the SD behavior for undefined ACMDs? If I do ACMD25,
and ACMD25 is not defined, will it be executed as CMD25? This is the
MMC behavior as I have mentioned.
If so, that means you will be able to bypass access control and be
able to (at the very least) read/write block as non-root.

Is there a way for SD to verify which ACMDs the card actually
supports? As far as MMC is concerned - no. I really wish ACMD had
their own classes as well.

A
