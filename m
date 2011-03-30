From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: mmc ioctl for hw reset ,partitiing, enhanced area setting, boot
 partition update.
Date: Wed, 30 Mar 2011 01:44:51 -0500
Message-ID: <AANLkTik_rGsh7jOkGBRALtW=DB-x5pQrpu_UjAyq15dR@mail.gmail.com>
References: <AANLkTinF8nWeV5sBb1FOswvPTVgOSbbCNGkOEsiX2+rV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:37751 "EHLO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533Ab1C3Goy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 02:44:54 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2U6hHIe012208
	for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2011 02:43:17 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2U6aNmk010078
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2011 02:43:16 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so1002304wyb.15
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2011 23:44:51 -0700 (PDT)
In-Reply-To: <AANLkTinF8nWeV5sBb1FOswvPTVgOSbbCNGkOEsiX2+rV@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NamJae Jeon <linkinjeon@gmail.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

On Wed, Mar 30, 2011 at 12:23 AM, NamJae Jeon <linkinjeon@gmail.com> wrote:
> Dear. Chris.
>
> you know, there is no method to use emmc 4.41 function in current mmc driver.
>
> hw reset ,partitiing, enhanced area setting, boot partition update etc..
>
> If mmc have ioctl for emmc 4.4.1 functions, mmc user feel convenient.
>
> Is there a plan supported emmc 4.41 fuctions ?
>
> Thanks.
> --

I have sent a patch to support accessing partitions other than the
user area ([RFC] MMC: MMC boot partitions support),  The first part
just adds the required changes and enables the boot partitions. I
didn't want to add everything before I got the core changes reviewed,
commented and hopefully approved.

Actually the ioctl to support creating new device partitions will be
interesting because that will affect the size of the user area, so it
would need to be rescanned. Obviously performing something like that
on an MMC with a filesystem could be deleterious...

What about hardware reset? It's more-or-less equivalent to powering
off the bus from the SD controller... Why would you want to expose
that through an ioctl?

A
