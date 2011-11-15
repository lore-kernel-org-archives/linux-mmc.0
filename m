From: merez@codeaurora.org
Subject: RE: [PATCH 2/2] mmc: core: Support packed command for eMMC4.5
     device
Date: Tue, 15 Nov 2011 04:48:02 -0800 (PST)
Message-ID: <faba552e7bd19ee5399c73c2b478a34d.squirrel@www.codeaurora.org>
References: <620ec9ffa6bdbba9ae5f76998e36f8dc.squirrel@www.codeaurora.org>
    <001001cca043$395dbfc0$ac193f40$%jun@samsung.com>
    <CANfBPZ-Zn+R4GosEL-RJxh8gduAr8e+qN876uPwDkHfiEpdERw@mail.gmail.com>
    <ea21d88d904af165cb911354e3f51ea6.squirrel@www.codeaurora.org>
    <001e01cca2b2$3b449310$b1cdb930$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:15423 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab1KOMsD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2011 07:48:03 -0500
In-Reply-To: <001e01cca2b2$3b449310$b1cdb930$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: merez@codeaurora.org, "'S, Venkatraman'" <svenkatr@ti.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com

>> >>> >> >> > + =A0 =A0 =A0 if (rqc)
>> >>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs =3D mmc_blk_chk_packa=
ble(mq, rqc);
>> >>>
>> >>> It would be best to keep all the calls to blk_fetch_request in t=
he
>> same
>> >>> location. Therefore, I suggest to move the call to
>> mmc_blk_chk_packable
>> >>> to
>> >>> mmc/card/queue.c after the first request is fetched.
>> >>
>> >> At the first time, I considered that way.
>> >> I'll do more, if possible.
> I considered more.
> I think that mmc_blk_chk_packable would rather be called only for r/w=
 type
> than all request type(e.g. discard, flush).
>
mmc_blk_chk_packable can check the cmd_flags of the request to verify i=
t's
not a flush/disacrad etc. In such cases will not pack.

