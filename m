From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [comments] MMC: Reliable write support.
Date: Mon, 28 Mar 2011 19:50:51 -0500
Message-ID: <AANLkTi=+LOy6V4hLsjaDd60xjEWm7jtYXaW8-4j=7TCQ@mail.gmail.com>
References: <1301001751-30785-1-git-send-email-andreiw@motorola.com>
	<1301001751-30785-2-git-send-email-andreiw@motorola.com>
	<201103251614.29893.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:37238 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab1C2Auy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Mar 2011 20:50:54 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2T0pD0W024232
	for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2011 20:51:13 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2T0gcS4021677
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2011 20:51:12 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so4265182wwb.3
        for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2011 17:50:51 -0700 (PDT)
In-Reply-To: <201103251614.29893.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

On Fri, Mar 25, 2011 at 10:14 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> +static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request=
 *req)
>> +{
>> + =A0 =A0 struct mmc_blk_data *md =3D mq->data;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0 =A0No-op, only service this because we need REQ_FUA
>> + =A0 =A0 =A0 =A0for reliable writes.
>> + =A0 =A0 */
>> + =A0 =A0 spin_lock_irq(&md->lock);
>> + =A0 =A0 __blk_end_request_all(req, 0);
>> + =A0 =A0 spin_unlock_irq(&md->lock);
>> +
>> + =A0 =A0 return 1;
>> +}
>
> How does this work when you have a flush that does not directly follo=
w
> a REQ_FUA or REQ_META request? I would assume that we still need to
> flush in some way, which you don't seem to do here.
>

Arnd,

I confirmed with two MMC vendors that there is no "flush". Once the
DAT transfer completes, the data is stored on non-volatile storage as
soon as the busy status is cleared.

Reliable writes are still "more reliable" because if the DAT transfer
is interrupted (power or reset through CMD0/CMD15 or hw pin for eMMC),
you have predictable flash contents. So it makes sense to map REQ_FUA
to it (and REQ_META, I would guess).

What do you think?
A
