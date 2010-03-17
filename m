From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: Highmem issues with MMC filesystem
Date: Wed, 17 Mar 2010 20:10:15 +0530
Message-ID: <043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946> <alpine.LFD.2.00.1003170946250.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50926 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754290Ab0CQOkf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Mar 2010 10:40:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu


----- Original Message ----- 
From: "Nicolas Pitre" <nico@fluxnic.net>
To: "Hemanth V" <hemanthv@ti.com>
Cc: <linux-mmc@vger.kernel.org>; <pierre@ossman.eu>
Sent: Wednesday, March 17, 2010 7:19 PM
Subject: Re: Highmem issues with MMC filesystem


> On Wed, 17 Mar 2010, Hemanth V wrote:
>
>> Hi All,
>>
>> We are trying to enable highmem support for OMAP based boards, while 
>> doing so
>> we are
>> unable to boot poky UI if the filesystem is in a MMC card.
>>
>> The poky UI comes up fine if the filesystem is in NAND or NFS,
>> while with MMC it gives errors like segmentation faults/syntax error 
>> while
>> there are none.
>> Seems like read from MMC is getting corrupted.
>
> Yes, this is a known issue with highmem on ARM architectures v6 and
> later, related to some cache mishandling.  This is not a MMC issue as
> the problem occurs when booting from SATA too. The problem is still
> investigated.
>

Nicolas, Russel are there any more details available which might help
in investigating this further.

Thanks
Hemanth

>
> Nicolas
> 

