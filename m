From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: mmc ioctl for hw reset ,partitiing, enhanced area setting, boot
 partition update.
Date: Wed, 30 Mar 2011 15:24:16 -0500
Message-ID: <AANLkTin7A3ugk03=501yvCnJUxgbvQrJvX_uYNSLqVMV@mail.gmail.com>
References: <AANLkTinF8nWeV5sBb1FOswvPTVgOSbbCNGkOEsiX2+rV@mail.gmail.com>
	<AANLkTik_rGsh7jOkGBRALtW=DB-x5pQrpu_UjAyq15dR@mail.gmail.com>
	<AANLkTin__DPxqh0QigvNs2TSM5fruyMNMyVAnmFC8HGb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:36068 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932981Ab1C3UYS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 16:24:18 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2UKMfwL000873
	for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2011 16:22:41 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2UK7hIZ022726
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2011 16:22:40 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so1897369wwb.3
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2011 13:24:16 -0700 (PDT)
In-Reply-To: <AANLkTin__DPxqh0QigvNs2TSM5fruyMNMyVAnmFC8HGb@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NamJae Jeon <linkinjeon@gmail.com>, linux-mmc@vger.kernel.org

Hi,

On Wed, Mar 30, 2011 at 10:11 AM, NamJae Jeon <linkinjeon@gmail.com> wrote:
> usally, bootloader is stored in boot partition. I suggested ioctl to
> update bootloader in boot partition not modifing boot partition size.
>

Maybe I didn't explain myself clearly enough, sorry. The patch I have
exposes the boot partitions
as block devices and you can read and write to them without affecting
the rest of the MMC card.

> and moviNAND(samsung) is needed by boot parittion size setting. and
> when boot parition size is changed, all user data will be reset, it
> will be initial status.
>
> but iNAND(sandisk) is not needed it. boot partition size is fixed(1MB).
>

I am unsure what you're talking about. The eMMC 4.41 spec (see 7.2)
does not allow changing boot partition size.
It is fixed to a certain size, and that size is specified by the
BOOT_SIZE_MULTI field in EXT_CSD. For the Toshiba devices
I have around me (MMC08G, MMC16G and MMC32G), each boot partition (two
total) is 2MB in size.

I don't think ioctl for accessing device partitions is a good idea,
because the device partitions are just block devices, so they should
be exposed as such.

For device partitioning, to support create General Purpose partitions
(up to 4), an ioctl is probably needed. You could look at "[PATCH
resend] mmc: Added ioctl to let userspace apps send ACMDs" by John
Calixto which was last send March 17th. That's generic enough to
support partitioning (which is a one time programming procedure
anyway...so there may be no value of adding a specific ioctl for it,
considering how dangerous of an operation it is).

A
