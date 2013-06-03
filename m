From: Peter Turczak <peter@turczak.de>
Subject: Re: [RFC/PATCH V2b]: mmc: card/core: support password locked cards
Date: Mon, 3 Jun 2013 15:43:52 +0200
Message-ID: <9FC288D4-A00A-4735-B6C6-EE333EF4CE2E@turczak.de>
References: <3B0B2667-A242-4337-96EC-3925AB4EC18F@turczak.de> <201305271728.37770.arnd@arndb.de>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: multipart/mixed; boundary="Apple-Mail=_B38C3337-6168-466C-8C58-7822B9722734"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from netconsequence.de ([85.214.40.104]:48201 "EHLO
	mx.netconsequence.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758355Ab3FCNnz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jun 2013 09:43:55 -0400
In-Reply-To: <201305271728.37770.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Peter Turczak <peter@turczak.de>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>


--Apple-Mail=_B38C3337-6168-466C-8C58-7822B9722734
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Sorry, forgot to attach the patch file.

Thanks Arnd for the input.

I've prepared a RFC-Version of the patch.

I'm not quite happy calling mmc_sd_resume() from the rescan ioctl. =
Unfortunately the rescan needed it twofold:
1. Force the SD layer to reread scr, ssr, etc. by somehow reaching =
mmc_sd_setup_card()
2. Remove GENHD_FL_NO_PART_SCAN from the disks flags and trigger a ioctl =
BLKRRPART on the block device. Which I would prefer to happen within the =
kernel.

Either one should introduce a flag in the mmc_card struct that forces a =
rescan of the sd card or even remove it completely and probe it again. =
Or there should be a command like mmc_card_reinit() which restarts =
mmc_sd_setup_card() along the way.
What is your opinion?

Regards,
 Peter

--Apple-Mail=_B38C3337-6168-466C-8C58-7822B9722734
Content-Disposition: attachment;
	filename=0001-Add-basic-support-for-password-protected-locked-SD-c.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-Add-basic-support-for-password-protected-locked-SD-c.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20afb19025006d3197929a29350be2b0f239715230=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Peter=20Turczak=20<pt@netconsequence.de>=0A=
Date:=20Mon,=203=20Jun=202013=2015:17:24=20+0200=0ASubject:=20[PATCH]=20=
Add=20basic=20support=20for=20password=20protected=20(locked)=20SD=20=
cards.=0A=0A=0ASigned-off-by:=20Peter=20Turczak=20<pt@netconsequence.de>=0A=
---=0A=20drivers/mmc/card/block.c=20|=20=20=2063=20=
+++++++++++++++++++++++++++++++++++++++++++---=0A=20=
drivers/mmc/core/sd.c=20=20=20=20|=20=20=2024=20++++++++++++++++-=0A=20=
include/linux/mmc/card.h=20|=20=20=20=204=20+++=0A=203=20files=20=
changed,=2086=20insertions(+),=205=20deletions(-)=0A=0Adiff=20--git=20=
a/drivers/mmc/card/block.c=20b/drivers/mmc/card/block.c=0Aindex=20=
dd27b07..0e49e62=20100644=0A---=20a/drivers/mmc/card/block.c=0A+++=20=
b/drivers/mmc/card/block.c=0A@@=20-568,12=20+568,57=20@@=20cmd_err:=0A=20=
=09return=20err;=0A=20}=0A=20=0A+static=20int=20=
mmc_blk_ioctl_rescan(struct=20block_device=20*bdev)=0A+{=0A+=09struct=20=
mmc_blk_data=20*md;=0A+=09struct=20mmc_card=20*card;=0A+=09int=20err;=0A=
+=0A+=09/*=0A+=09=20*=20The=20caller=20must=20have=20CAP_SYS_RAWIO,=20=
and=20must=20be=20calling=20this=20on=20the=0A+=09=20*=20whole=20block=20=
device,=20not=20on=20a=20partition.=20=20This=20prevents=20overspray=0A+=09=
=20*=20between=20sibling=20partitions.=0A+=09=20*/=0A+=09if=20=
((!capable(CAP_SYS_RAWIO))=20||=20(bdev=20!=3D=20bdev->bd_contains))=0A+=09=
=09return=20-EPERM;=0A+=0A+=09md=20=3D=20mmc_blk_get(bdev->bd_disk);=0A+=09=
if=20(!md)=20{=0A+=09=09err=20=3D=20-EINVAL;=0A+=09=09goto=20cmd_err;=0A=
+=09}=0A+=0A+=09card=20=3D=20md->queue.card;=0A+=09if=20(IS_ERR(card))=20=
{=0A+=09=09err=20=3D=20PTR_ERR(card);=0A+=09=09goto=20cmd_done;=0A+=09}=0A=
+=0A+=09mmc_power_restore_host(card->host);=0A+=0A+=09/*=20Enable=20=
scanning=20of=20partition=20tables=20after=20unlocking=20*/=0A+=09if=20=
(!mmc_card_locked(card))=0A+=09=09md->disk->flags=20&=3D=20=
~GENHD_FL_NO_PART_SCAN;=0A+=09else=0A+=09=09md->disk->flags=20|=3D=20=
GENHD_FL_NO_PART_SCAN;=0A+=0A+=09ioctl_by_bdev(bdev,=20BLKRRPART,=200);=0A=
+cmd_done:=0A+=09mmc_blk_put(md);=0A+cmd_err:=0A+=09kfree(idata->buf);=0A=
+=09kfree(idata);=0A+=09return=20err;=0A+}=0A+=0A=20static=20int=20=
mmc_blk_ioctl(struct=20block_device=20*bdev,=20fmode_t=20mode,=0A=20=09=
unsigned=20int=20cmd,=20unsigned=20long=20arg)=0A=20{=0A=20=09int=20ret=20=
=3D=20-EINVAL;=0A=20=09if=20(cmd=20=3D=3D=20MMC_IOC_CMD)=0A=20=09=09ret=20=
=3D=20mmc_blk_ioctl_cmd(bdev,=20(struct=20mmc_ioc_cmd=20__user=20*)arg);=0A=
+=09else=20if=20(cmd=20=3D=3D=20MMC_IOC_RESCAN)=0A+=09=09ret=20=3D=20=
mmc_blk_ioctl_rescan(bdev);=0A=20=09return=20ret;=0A=20}=0A=20=0A@@=20=
-775,7=20+820,7=20@@=20static=20int=20mmc_blk_cmd_recovery(struct=20=
mmc_card=20*card,=20struct=20request=20*req,=0A=20=09u32=20status,=20=
stop_status=20=3D=200;=0A=20=09int=20err,=20retry;=0A=20=0A-=09if=20=
(mmc_card_removed(card))=0A+=09if=20(mmc_card_removed(card)=20||=20=
mmc_card_locked(card))=0A=20=09=09return=20ERR_NOMEDIUM;=0A=20=0A=20=09=
/*=0A@@=20-1738,6=20+1783,7=20@@=20static=20int=20=
mmc_blk_issue_rw_rq(struct=20mmc_queue=20*mq,=20struct=20request=20*rqc)=0A=
=20=09=09=09areq=20=3D=20&mq->mqrq_cur->mmc_active;=0A=20=09=09}=20else=0A=
=20=09=09=09areq=20=3D=20NULL;=0A+=0A=20=09=09areq=20=3D=20=
mmc_start_req(card->host,=20areq,=20(int=20*)=20&status);=0A=20=09=09if=20=
(!areq)=20{=0A=20=09=09=09if=20(status=20=3D=3D=20MMC_BLK_NEW_REQUEST)=0A=
@@=20-1857,7=20+1903,7=20@@=20static=20int=20mmc_blk_issue_rw_rq(struct=20=
mmc_queue=20*mq,=20struct=20request=20*rqc)=0A=20=09if=20=
(mmc_packed_cmd(mq_rq->cmd_type))=20{=0A=20=09=09=
mmc_blk_abort_packed_req(mq_rq);=0A=20=09}=20else=20{=0A-=09=09if=20=
(mmc_card_removed(card))=0A+=09=09if=20(mmc_card_removed(card)=20||=20=
mmc_card_locked(card))=0A=20=09=09=09req->cmd_flags=20|=3D=20REQ_QUIET;=0A=
=20=09=09while=20(ret)=0A=20=09=09=09ret=20=3D=20blk_end_request(req,=20=
-EIO,=0A@@=20-2018,6=20+2064,13=20@@=20static=20struct=20mmc_blk_data=20=
*mmc_blk_alloc_req(struct=20mmc_card=20*card,=0A=20=09if=20(area_type=20=
&=20MMC_BLK_DATA_AREA_RPMB)=0A=20=09=09md->disk->flags=20|=3D=20=
GENHD_FL_NO_PART_SCAN;=0A=20=0A+=09/*=20If=20SD/MMC=20is=20locked,=20any=20=
read=20operation=20will=20fail=0A+=09=20*=20so=20there=20is=20no=20point=20=
in=20doing=20a=20partition=20scan=0A+=09=20*=20until=20the=20device=20is=20=
unlocked.=0A+=09=20*/=0A+=09if=20(mmc_card_locked(card))=0A+=09=09=
md->disk->flags=20|=3D=20GENHD_FL_NO_PART_SCAN;=0A+=0A=20=09/*=0A=20=09=20=
*=20As=20discussed=20on=20lkml,=20GENHD_FL_REMOVABLE=20should:=0A=20=09=20=
*=0A@@=20-2093,6=20+2146,7=20@@=20static=20struct=20mmc_blk_data=20=
*mmc_blk_alloc(struct=20mmc_card=20*card)=0A=20=09=09size=20=3D=20=
card->csd.capacity=20<<=20(card->csd.read_blkbits=20-=209);=0A=20=09}=0A=20=
=0A+=0A=20=09md=20=3D=20mmc_blk_alloc_req(card,=20&card->dev,=20size,=20=
false,=20NULL,=0A=20=09=09=09=09=09MMC_BLK_DATA_AREA_MAIN);=0A=20=09=
return=20md;=0A@@=20-2319,9=20+2373,10=20@@=20static=20int=20=
mmc_blk_probe(struct=20mmc_card=20*card)=0A=20=0A=20=09=
string_get_size((u64)get_capacity(md->disk)=20<<=209,=20STRING_UNITS_2,=0A=
=20=09=09=09cap_str,=20sizeof(cap_str));=0A-=09pr_info("%s:=20%s=20%s=20=
%s=20%s\n",=0A+=09pr_info("%s:=20%s=20%s=20%s=20%s=20%s\n",=0A=20=09=09=
md->disk->disk_name,=20mmc_card_id(card),=20mmc_card_name(card),=0A-=09=09=
cap_str,=20md->read_only=20?=20"(ro)"=20:=20"");=0A+=09=09cap_str,=20=
md->read_only=20?=20"(ro)"=20:=20"",=0A+=09=09mmc_card_locked(card)=20?=20=
"(locked)"=20:=20"");=0A=20=0A=20=09if=20(mmc_blk_alloc_parts(card,=20=
md))=0A=20=09=09goto=20out;=0Adiff=20--git=20a/drivers/mmc/core/sd.c=20=
b/drivers/mmc/core/sd.c=0Aindex=209e645e1..f774e9c=20100644=0A---=20=
a/drivers/mmc/core/sd.c=0A+++=20b/drivers/mmc/core/sd.c=0A@@=20-805,8=20=
+805,30=20@@=20int=20mmc_sd_setup_card(struct=20mmc_host=20*host,=20=
struct=20mmc_card=20*card,=0A=20=09bool=20reinit)=0A=20{=0A=20=09int=20=
err;=0A+=09int=20status;=0A=20=0A-=09if=20(!reinit)=20{=0A+=09/*=0A+=09=20=
*=20Test=20if=20card=20is=20locked=0A+=09=20*/=0A+=09err=20=3D=20=
mmc_send_status(card,=20&status);=0A+=09if=20(err)=0A+=09=09return=20=
err;=0A+=0A+=09if=20(status=20&=20R1_CARD_IS_LOCKED)=0A+=09=09=
mmc_card_set_locked(card);=0A+=09else=20{=0A+=09=09/*=20If=20card=20used=20=
to=20be=20locked,=20this=20is=20_not_=20an=20reinit!=20*/=0A+=09=09if=20=
(mmc_card_locked(card))=0A+=09=09=09reinit=20=3D=20false;=0A+=0A+=09=09=
mmc_card_clr_locked(card);=0A+=09}=0A+=0A+=09/*=0A+=09=20*=20If=20card=20=
is=20locked=20or=20already=20initialized,=20do=20not=20try=20to=0A+=09=20=
*=20set=20it=20up=20further=20.=0A+=09=20*/=0A+=09if=20(!reinit=20&&=20=
!mmc_card_locked(card))=20{=0A=20=09=09/*=0A=20=09=09=20*=20Fetch=20SCR=20=
from=20card.=0A=20=09=09=20*/=0Adiff=20--git=20=
a/include/linux/mmc/card.h=20b/include/linux/mmc/card.h=0Aindex=20=
f31725b..08f325d=20100644=0A---=20a/include/linux/mmc/card.h=0A+++=20=
b/include/linux/mmc/card.h=0A@@=20-249,6=20+249,7=20@@=20struct=20=
mmc_card=20{=0A=20#define=20MMC_CARD_REMOVED=09(1<<7)=09=09/*=20card=20=
has=20been=20removed=20*/=0A=20#define=20MMC_STATE_HIGHSPEED_200=09=
(1<<8)=09=09/*=20card=20is=20in=20HS200=20mode=20*/=0A=20#define=20=
MMC_STATE_DOING_BKOPS=09(1<<10)=09=09/*=20card=20is=20doing=20BKOPS=20*/=0A=
+#define=20MMC_STATE_LOCKED=09(1<<11)=09=09/*=20card=20is=20password=20=
protected=20*/=0A=20=09unsigned=20int=09=09quirks;=20=09/*=20card=20=
quirks=20*/=0A=20#define=20MMC_QUIRK_LENIENT_FN0=09(1<<0)=09=09/*=20=
allow=20SDIO=20FN0=20writes=20outside=20of=20the=20VS=20CCCR=20range=20=
*/=0A=20#define=20MMC_QUIRK_BLKSZ_FOR_BYTE_MODE=20(1<<1)=09/*=20use=20=
func->cur_blksize=20*/=0A@@=20-416,6=20+417,7=20@@=20static=20inline=20=
void=20__maybe_unused=20remove_quirk(struct=20mmc_card=20*card,=20int=20=
data)=0A=20#define=20mmc_card_ext_capacity(c)=20((c)->state=20&=20=
MMC_CARD_SDXC)=0A=20#define=20mmc_card_removed(c)=09((c)=20&&=20=
((c)->state=20&=20MMC_CARD_REMOVED))=0A=20#define=20=
mmc_card_doing_bkops(c)=09((c)->state=20&=20MMC_STATE_DOING_BKOPS)=0A=
+#define=20mmc_card_locked(c)=09((c)->state=20&=20MMC_STATE_LOCKED)=0A=20=
=0A=20#define=20mmc_card_set_present(c)=09((c)->state=20|=3D=20=
MMC_STATE_PRESENT)=0A=20#define=20mmc_card_set_readonly(c)=20((c)->state=20=
|=3D=20MMC_STATE_READONLY)=0A@@=20-429,6=20+431,8=20@@=20static=20inline=20=
void=20__maybe_unused=20remove_quirk(struct=20mmc_card=20*card,=20int=20=
data)=0A=20#define=20mmc_card_set_removed(c)=20((c)->state=20|=3D=20=
MMC_CARD_REMOVED)=0A=20#define=20mmc_card_set_doing_bkops(c)=09=
((c)->state=20|=3D=20MMC_STATE_DOING_BKOPS)=0A=20#define=20=
mmc_card_clr_doing_bkops(c)=09((c)->state=20&=3D=20=
~MMC_STATE_DOING_BKOPS)=0A+#define=20mmc_card_set_locked(c)=09=
((c)->state=20|=3D=20MMC_STATE_LOCKED)=0A+#define=20=
mmc_card_clr_locked(c)=09((c)->state=20&=3D=20~MMC_STATE_LOCKED)=0A=20=0A=
=20/*=0A=20=20*=20Quirk=20add/remove=20for=20MMC=20products.=0A--=20=0A=
1.7.0.4=0A=0A=

--Apple-Mail=_B38C3337-6168-466C-8C58-7822B9722734--
