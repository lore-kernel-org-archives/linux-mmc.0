From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [v5 2/5] MMC: Use CMD23 for multiblock transfers when we can.
Date: Fri, 20 May 2011 13:12:07 -0500
Message-ID: <BANLkTimyCO1vwjG5jnYVg+Yb=eLr6+C6hQ@mail.gmail.com>
References: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
	<1305841590-26963-3-git-send-email-andreiw@motorola.com>
	<4DD642A0.1040608@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:32931 "EHLO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933693Ab1ETSMJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2011 14:12:09 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4KI9lsE028003
	for <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 14:09:47 -0400 (EDT)
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4KI8xVm027587
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 14:09:47 -0400 (EDT)
Received: by mail-ww0-f42.google.com with SMTP id 4so780746wwk.3
        for <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 11:12:07 -0700 (PDT)
In-Reply-To: <4DD642A0.1040608@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, arnd@arndb.de, malchev@google.com, Kyungmin Park <kyungmin.park@samsung.com>

On Fri, May 20, 2011 at 5:29 AM, Jaehoon Chung <jh80.chung@samsung.com>=
 wrote:
> Hi Andrei.
>
> I have some question..
> In mmc_blk_issue_rw_rq() of block.c, there is the below code.
>
> static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *=
req)
> {
> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
> =A0 =A0 =A0 =A0struct mmc_card *card =3D md->queue.card;
> =A0 =A0 =A0 =A0struct mmc_blk_request brq;
> =A0 =A0 =A0 =A0int ret =3D 1, disable_multi =3D 0;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Reliable writes are used to implement Forced Unit A=
ccess and
> =A0 =A0 =A0 =A0 * REQ_META accesses, and are supported only on MMCs.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0bool do_rel_wr =3D ((req->cmd_flags & REQ_FUA) ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(req->cmd_flags & =
REQ_META)) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(rq_data_dir(req) =3D=3D WRITE) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0REL_WRITES_SUPPORTED(card);
>
> =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmc_command cmd =3D {0};
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 readcmd, writecmd, status =3D 0;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(&brq, 0, sizeof(struct mmc_blk_=
request));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq.mrq.cmd =3D &brq.cmd;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq.mrq.data =3D &brq.data;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq.cmd.arg =3D blk_rq_pos(req);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!mmc_card_blockaddr(card))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq.cmd.arg <<=3D 9;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq.cmd.flags =3D MMC_RSP_SPI_R1 | MMC=
_RSP_R1 | MMC_CMD_ADTC;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq.data.blksz =3D 512;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq.stop.opcode =3D MMC_STOP_TRANSMISS=
ION;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq.stop.arg =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq.stop.flags =3D MMC_RSP_SPI_R1B | M=
MC_RSP_R1B | MMC_CMD_AC;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq.data.blocks =3D blk_rq_sectors(req=
);
>
> There is "brq.stop.opcode =3D MMC_STOP_TRANSMISSION".
> If we use CMD23, this line didn't need? Actually i don't know, so i a=
sk to you.
>

Nope. Needed. CMD23 support might not be implemented by host driver
(like it isn't right now for anything non-SDHCI). And even it if were,
you still need to send stop command on any error conditions. I suggest
you read the relevant sections in the publically available eMMC spec.

A
