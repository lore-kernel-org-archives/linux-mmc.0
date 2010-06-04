From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 2/4] mmc: Add erase, secure erase, trim and secure trim
	operations
Date: Sat, 5 Jun 2010 00:37:28 +0900
Message-ID: <AANLkTinwhCi-mPm1oSDceJ51t62XvQfanIumvVBUXpys@mail.gmail.com>
References: <4C081AF1.4070103@nokia.com>
	<AANLkTinI6ScNcFSRbWL_Oi2E7WUzfHOmSgzdde7xezm7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f185.google.com ([209.85.222.185]:50768 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab0FDPha convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Jun 2010 11:37:30 -0400
In-Reply-To: <AANLkTinI6ScNcFSRbWL_Oi2E7WUzfHOmSgzdde7xezm7@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi,

After apply patches, I know that it's not integrated with filesystem
discard request.
Only ioctl interface is allowed to support trim.

okay I will see the how to integrate with filesystem.

Thank you,
Kyungmin Park

On Fri, Jun 4, 2010 at 7:07 AM, Kyungmin Park <kmpark@infradead.org> wr=
ote:
> Hi adrian,
>
> First thank you for your works. we have to implement it but you did.
>
> Before the code review, can you provide the results of trim effect?
> I wonder how much we can gain performance from trim command.
>
> So please give any benchmark result based on vfat or btrfs. since it'=
s
> already implemented the discard request.
>
> Thank you,
> Kyungmin Park
>
> On Fri, Jun 4, 2010 at 6:13 AM, Adrian Hunter <adrian.hunter@nokia.co=
m> wrote:
>> From 8f9a8227c528c3853ee9eef2209cefcf1616ebb3 Mon Sep 17 00:00:00 20=
01
>> From: Adrian Hunter <adrian.hunter@nokia.com>
>> Date: Tue, 1 Jun 2010 13:20:22 +0300
>> Subject: [PATCH 2/4] mmc: Add erase, secure erase, trim and secure t=
rim
>> operations
>>
>> As SD and MMC cards have a NAND core, they can support an erase
>> operation that is typically 10x to 100x faster than writing.
>>
>> In addition, eMMCv4.4 also offers:
>> =A0 =A0 =A0 o Secure Erase
>> =A0 =A0 =A0 o Trim
>> =A0 =A0 =A0 o Secure Trim
>>
>> The "secure" variants also ensure that any copies of the data
>> (for example remnants of garbage collection) are also erased.
>>
>> "Trim" is the same as "erase" except that individual sectors
>> can be erased instead of whole Erase Groups.
>>
>> The erase operation and its variants are not supported by
>> default and drivers must set MMC_CAP_ERASE. =A0This is because
>> the operation can take a long time and drivers that rely on
>> polling the status may perform very badly. =A0Also drivers
>> may need changes to support the very long erase timeouts.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
>> ---
>> drivers/mmc/core/core.c =A0 | =A0330
>> +++++++++++++++++++++++++++++++++++++++++++++
>> drivers/mmc/core/core.h =A0 | =A0 =A02 +
>> drivers/mmc/core/mmc.c =A0 =A0| =A0 44 ++++++-
>> drivers/mmc/core/sd.c =A0 =A0 | =A0 81 +++++++++++
>> drivers/mmc/core/sd_ops.c | =A0 48 +++++++
>> drivers/mmc/core/sd_ops.h | =A0 =A01 +
>> include/linux/mmc/card.h =A0| =A0 19 +++
>> include/linux/mmc/core.h =A0| =A0 19 +++
>> include/linux/mmc/host.h =A0| =A0 =A01 +
>> include/linux/mmc/mmc.h =A0 | =A0 24 +++-
>> include/linux/mmc/sd.h =A0 =A0| =A0 =A05 +
>> 11 files changed, 567 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 569e94d..2627147 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1050,6 +1050,336 @@ void mmc_detect_change(struct mmc_host *host=
,
>> unsigned long delay)
>>
>> EXPORT_SYMBOL(mmc_detect_change);
>>
>> +void mmc_init_erase(struct mmc_card *card)
>> +{
>> + =A0 =A0 =A0 unsigned int sz;
>> +
>> + =A0 =A0 =A0 if (is_power_of_2(card->erase_size))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erase_shift =3D ffs(card->erase_=
size) - 1;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erase_shift =3D 0;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* It is possible to erase an arbitrarily large area=
 of an SD or MMC
>> + =A0 =A0 =A0 =A0* card. =A0That is not desirable because it can tak=
e a long time
>> + =A0 =A0 =A0 =A0* (minutes) potentially delaying more important I/O=
, and also the
>> + =A0 =A0 =A0 =A0* timeout calculations become increasingly hugely o=
ver-estimated.
>> + =A0 =A0 =A0 =A0* Consequently, 'max_erase' is defined as a guide t=
o upper layers
>> + =A0 =A0 =A0 =A0* (i.e. the MMC Block driver) to limit erases to th=
at size and
>> + =A0 =A0 =A0 =A0* alignment.
>> + =A0 =A0 =A0 =A0*
>> + =A0 =A0 =A0 =A0* For SD cards that define Allocation Unit size, li=
mit erases to
>> one
>> + =A0 =A0 =A0 =A0* Allocation Unit at a time. =A0For MMC cards that =
define High
>> Capacity
>> + =A0 =A0 =A0 =A0* Erase Size, whether it is switched on or not, lim=
it to that size.
>> + =A0 =A0 =A0 =A0* Otherwise just have a stab at a good value. =A0Fo=
r modern cards it
>> + =A0 =A0 =A0 =A0* will end up being 4MiB. =A0Note that if the value=
 is too small, it
>> + =A0 =A0 =A0 =A0* can end up taking longer to erase.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (mmc_card_sd(card) && card->ssr.au) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->max_erase =3D card->ssr.au;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erase_shift =3D ffs(card->ssr.au=
) - 1;
>> + =A0 =A0 =A0 } else if (card->ext_csd.hc_erase_size) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->max_erase =3D card->ext_csd.hc_e=
rase_size;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sz =3D (card->csd.capacity << (card->c=
sd.read_blkbits - 9)) >>
>> 11;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sz < 128)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->max_erase =3D 51=
2 * 1024 / 512;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (sz < 512)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->max_erase =3D 10=
24 * 1024 / 512;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (sz < 1024)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->max_erase =3D 2 =
* 1024 * 1024 / 512;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->max_erase =3D 4 =
* 1024 * 1024 / 512;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->max_erase < card->erase_size=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->max_erase =3D ca=
rd->erase_size;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sz =3D card->max_erase=
 % card->erase_size;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sz)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->=
max_erase +=3D card->erase_size - sz;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +}
>> +
>> +static void mmc_set_mmc_erase_timeout(struct mmc_card *card,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct mmc_command *cmd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 unsigned int arg, unsigned int qty)
>> +{
>> + =A0 =A0 =A0 unsigned int erase_timeout;
>> +
>> + =A0 =A0 =A0 if (card->ext_csd.erase_group_def & 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* High Capacity Erase Group Size uses=
 HC timeouts */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (arg =3D=3D MMC_TRIM_ARG)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 erase_timeout =3D card=
->ext_csd.trim_timeout;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 erase_timeout =3D card=
->ext_csd.hc_erase_timeout;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* CSD Erase Group Size uses write tim=
eout */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int mult =3D (10 << card->csd=
=2Er2w_factor);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int timeout_clks =3D card->cs=
d.tacc_clks * mult;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int timeout_us;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Avoid overflow: e.g. tacc_ns=3D8000=
0000 mult=3D1280 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->csd.tacc_ns < 1000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout_us =3D (card->=
csd.tacc_ns * mult) / 1000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout_us =3D (card->=
csd.tacc_ns / 1000) * mult;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* ios.clock is only a target. =A0Th=
e real clock rate might be
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* less but not that much less, so f=
udge it by multiplying
>> by 2.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout_clks <<=3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout_us +=3D (timeout_clks * 1000) =
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->hos=
t->ios.clock / 1000);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 erase_timeout =3D timeout_us / 1000;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Theoretically, the calculation co=
uld underflow so round
>> up
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to 1ms in that case.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!erase_timeout)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 erase_timeout =3D 1;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* Multiplier for secure operations */
>> + =A0 =A0 =A0 if (arg & MMC_SECURE_ARGS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (arg =3D=3D MMC_SECURE_ERASE_ARG)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 erase_timeout *=3D car=
d->ext_csd.sec_erase_mult;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 erase_timeout *=3D car=
d->ext_csd.sec_trim_mult;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 erase_timeout *=3D qty;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Ensure at least a 1 second timeout for SPI as per
>> + =A0 =A0 =A0 =A0* 'mmc_set_data_timeout()'
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (mmc_host_is_spi(card->host) && erase_timeout < 100=
0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 erase_timeout =3D 1000;
>> +
>> + =A0 =A0 =A0 cmd->erase_timeout =3D erase_timeout;
>> +}
>> +
>> +static void mmc_set_sd_erase_timeout(struct mmc_card *card,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct mmc_command *cmd, unsigned int
>> arg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0unsigned int qty)
>> +{
>> + =A0 =A0 =A0 if (card->ssr.erase_timeout) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Erase timeout specified in SD Statu=
s Register (SSR) */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd->erase_timeout =3D card->ssr.erase=
_timeout * qty +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0card->ssr.erase_offset;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Erase timeout not specified in SD=
 Status Register (SSR)
>> so
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* use 250ms per write block.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd->erase_timeout =3D 250 * qty;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* Must not be less than 1 second */
>> + =A0 =A0 =A0 if (cmd->erase_timeout < 1000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd->erase_timeout =3D 1000;
>> +}
>> +
>> +static void mmc_set_erase_timeout(struct mmc_card *card,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 st=
ruct mmc_command *cmd, unsigned int arg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 un=
signed int qty)
>> +{
>> + =A0 =A0 =A0 if (mmc_card_sd(card))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_sd_erase_timeout(card, cmd, ar=
g, qty);
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_mmc_erase_timeout(card, cmd, a=
rg, qty);
>> +}
>> +
>> +static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int to, unsig=
ned int arg)
>> +{
>> + =A0 =A0 =A0 struct mmc_command cmd;
>> + =A0 =A0 =A0 unsigned int qty =3D 0;
>> + =A0 =A0 =A0 int err;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* qty is used to calculate the erase timeout which =
depends on how
>> many
>> + =A0 =A0 =A0 =A0* erase groups (or allocation units in SD terminolo=
gy) are
>> affected.
>> + =A0 =A0 =A0 =A0* We count erasing part of an erase group as one er=
ase group.
>> + =A0 =A0 =A0 =A0* For SD, the allocation units are always a power o=
f 2. =A0For MMC,
>> the
>> + =A0 =A0 =A0 =A0* erase group size is almost certainly also power o=
f 2, but it does
>> not
>> + =A0 =A0 =A0 =A0* seem to insist on that in the JEDEC standard, so =
we fall back to
>> + =A0 =A0 =A0 =A0* division in that case. =A0SD may not specify an a=
llocation unit
>> size,
>> + =A0 =A0 =A0 =A0* in which case the timeout is based on the number =
of write blocks.
>> + =A0 =A0 =A0 =A0*
>> + =A0 =A0 =A0 =A0* Note that the timeout for secure trim 2 will only=
 be correct if
>> the
>> + =A0 =A0 =A0 =A0* number of erase groups specified is the same as t=
he total of all
>> + =A0 =A0 =A0 =A0* preceding secure trim 1 commands. =A0Since the po=
wer may have been
>> + =A0 =A0 =A0 =A0* lost since the secure trim 1 commands occurred, i=
t is generally
>> + =A0 =A0 =A0 =A0* impossible to calculate the secure trim 2 timeout=
 correctly.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (card->erase_shift)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qty +=3D ((to >> card->erase_shift) -
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (from >> card->erase_s=
hift)) + 1;
>> + =A0 =A0 =A0 else if (mmc_card_sd(card))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qty +=3D to - from + 1;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qty +=3D ((to / card->erase_size) -
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (from / card->erase_si=
ze)) + 1;
>> +
>> + =A0 =A0 =A0 if (!mmc_card_blockaddr(card)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 from <<=3D 9;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 to <<=3D 9;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 memset(&cmd, 0, sizeof(struct mmc_command));
>> + =A0 =A0 =A0 if (mmc_card_sd(card))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D SD_ERASE_WR_BLK_START;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D MMC_ERASE_GROUP_START;
>> + =A0 =A0 =A0 cmd.arg =3D from;
>> + =A0 =A0 =A0 cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC=
;
>> + =A0 =A0 =A0 err =3D mmc_wait_for_cmd(card->host, &cmd, 0);
>> + =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "mmc_erase: group star=
t error %d, "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"status %#x\n", err, cm=
d.resp[0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 memset(&cmd, 0, sizeof(struct mmc_command));
>> + =A0 =A0 =A0 if (mmc_card_sd(card))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D SD_ERASE_WR_BLK_END;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D MMC_ERASE_GROUP_END;
>> + =A0 =A0 =A0 cmd.arg =3D to;
>> + =A0 =A0 =A0 cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC=
;
>> + =A0 =A0 =A0 err =3D mmc_wait_for_cmd(card->host, &cmd, 0);
>> + =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "mmc_erase: group end =
error %d, status
>> %#x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err, cmd.resp[0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 memset(&cmd, 0, sizeof(struct mmc_command));
>> + =A0 =A0 =A0 cmd.opcode =3D MMC_ERASE;
>> + =A0 =A0 =A0 cmd.arg =3D arg;
>> + =A0 =A0 =A0 cmd.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_=
AC;
>> + =A0 =A0 =A0 mmc_set_erase_timeout(card, &cmd, arg, qty);
>> + =A0 =A0 =A0 err =3D mmc_wait_for_cmd(card->host, &cmd, 0);
>> + =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "mmc_erase: erase erro=
r %d, status %#x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err, cmd.resp[0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EIO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (mmc_host_is_spi(card->host))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(&cmd, 0, sizeof(struct mmc_comm=
and));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D MMC_SEND_STATUS;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.arg =3D card->rca << 16;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Do not retry else we can't see erro=
rs */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_wait_for_cmd(card->host, &=
cmd, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err || (cmd.resp[0] & 0xFDF92000))=
 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "error=
 %d requesting status %#x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err, c=
md.resp[0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EIO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 } while (!(cmd.resp[0] & R1_READY_FOR_DATA) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0R1_CURRENT_STATE(cmd.resp[0]) =3D=3D=
 7);
>> +out:
>> + =A0 =A0 =A0 return err;
>> +}
>> +
>> +/**
>> + * mmc_erase - erase sectors.
>> + * @card: card to erase
>> + * @from: first sector to erase
>> + * @nr: number of sectors to erase
>> + * @arg: erase command argument (SD supports only %MMC_ERASE_ARG)
>> + *
>> + * Caller must claim host before calling this function.
>> + */
>> +int mmc_erase(struct mmc_card *card, unsigned int from, unsigned in=
t nr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int arg)
>> +{
>> + =A0 =A0 =A0 unsigned int to =3D from + nr;
>> +
>> + =A0 =A0 =A0 if (!(card->host->caps & MMC_CAP_ERASE) ||
>> + =A0 =A0 =A0 =A0 =A0 !(card->csd.cmdclass & CCC_ERASE))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
>> +
>> + =A0 =A0 =A0 if (!card->erase_size)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
>> +
>> + =A0 =A0 =A0 if (mmc_card_sd(card) && arg !=3D MMC_ERASE_ARG)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
>> +
>> + =A0 =A0 =A0 if ((arg & MMC_SECURE_ARGS) &&
>> + =A0 =A0 =A0 =A0 =A0 !(card->ext_csd.sec_feature_support & EXT_CSD_=
SEC_ER_EN))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
>> +
>> + =A0 =A0 =A0 if ((arg & MMC_TRIM_ARGS) &&
>> + =A0 =A0 =A0 =A0 =A0 !(card->ext_csd.sec_feature_support & EXT_CSD_=
SEC_GB_CL_EN))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
>> +
>> + =A0 =A0 =A0 if (arg =3D=3D MMC_ERASE_ARG || arg =3D=3D MMC_SECURE_=
ERASE_ARG) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (from % card->erase_size || nr % ca=
rd->erase_size)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (nr =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 =A0 if (to <=3D from)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 /* 'from' and 'to' are inclusive */
>> + =A0 =A0 =A0 to -=3D 1;
>> +
>> + =A0 =A0 =A0 return mmc_do_erase(card, from, to, arg);
>> +}
>> +EXPORT_SYMBOL(mmc_erase);
>> +
>> +int mmc_can_erase(struct mmc_card *card)
>> +{
>> + =A0 =A0 =A0 if ((card->host->caps & MMC_CAP_ERASE) &&
>> + =A0 =A0 =A0 =A0 =A0 (card->csd.cmdclass & CCC_ERASE) && card->eras=
e_size)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL(mmc_can_erase);
>> +
>> +int mmc_can_trim(struct mmc_card *card)
>> +{
>> + =A0 =A0 =A0 if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB=
_CL_EN)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL(mmc_can_trim);
>> +
>> +int mmc_can_secure_erase_trim(struct mmc_card *card)
>> +{
>> + =A0 =A0 =A0 if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER=
_EN)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL(mmc_can_secure_erase_trim);
>> +
>> +int mmc_erase_group_aligned(struct mmc_card *card, unsigned int fro=
m,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int n=
r)
>> +{
>> + =A0 =A0 =A0 if (!card->erase_size)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 if (from % card->erase_size || nr % card->erase_size)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 return 1;
>> +}
>> +EXPORT_SYMBOL(mmc_erase_group_aligned);
>>
>> void mmc_rescan(struct work_struct *work)
>> {
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>> index a811c52..9d9eef5 100644
>> --- a/drivers/mmc/core/core.h
>> +++ b/drivers/mmc/core/core.h
>> @@ -29,6 +29,8 @@ struct mmc_bus_ops {
>> void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops =
*ops);
>> void mmc_detach_bus(struct mmc_host *host);
>>
>> +void mmc_init_erase(struct mmc_card *card);
>> +
>> void mmc_set_chip_select(struct mmc_host *host, int mode);
>> void mmc_set_clock(struct mmc_host *host, unsigned int hz);
>> void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 89f7a25..9603720 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -108,13 +108,23 @@ static int mmc_decode_cid(struct mmc_card *car=
d)
>> =A0 =A0 =A0 =A0return 0;
>> }
>>
>> +static void mmc_set_erase_size(struct mmc_card *card)
>> +{
>> + =A0 =A0 =A0 if (card->ext_csd.erase_group_def & 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erase_size =3D card->ext_csd.hc_=
erase_size;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erase_size =3D card->csd.erase_s=
ize;
>> +
>> + =A0 =A0 =A0 mmc_init_erase(card);
>> +}
>> +
>> /*
>> =A0* Given a 128-bit response, decode to our card CSD structure.
>> =A0*/
>> static int mmc_decode_csd(struct mmc_card *card)
>> {
>> =A0 =A0 =A0 =A0struct mmc_csd *csd =3D &card->csd;
>> - =A0 =A0 =A0 unsigned int e, m, csd_struct;
>> + =A0 =A0 =A0 unsigned int e, m, a, b, csd_struct;
>> =A0 =A0 =A0 =A0u32 *resp =3D card->raw_csd;
>>
>> =A0 =A0 =A0 =A0/*
>> @@ -151,6 +161,12 @@ static int mmc_decode_csd(struct mmc_card *card=
)
>> =A0 =A0 =A0 =A0csd->write_blkbits =3D UNSTUFF_BITS(resp, 22, 4);
>> =A0 =A0 =A0 =A0csd->write_partial =3D UNSTUFF_BITS(resp, 21, 1);
>>
>> + =A0 =A0 =A0 a =3D UNSTUFF_BITS(resp, 42, 5);
>> + =A0 =A0 =A0 b =3D UNSTUFF_BITS(resp, 37, 5);
>> + =A0 =A0 =A0 csd->erase_size =3D (a + 1) * (b + 1);
>> + =A0 =A0 =A0 csd->erase_size <<=3D csd->write_blkbits;
>> + =A0 =A0 =A0 csd->erase_size >>=3D 9;
>> +
>> =A0 =A0 =A0 =A0return 0;
>> }
>>
>> @@ -247,8 +263,30 @@ static int mmc_read_ext_csd(struct mmc_card *ca=
rd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (sa_shift > 0 && sa_shift <=3D 0x1=
7)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.sa_time=
out =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A01 << ext_csd[EXT_CSD_S_A_TIMEOUT];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.erase_group_def =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_ERASE_=
GROUP_DEF];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hc_erase_timeout =3D 300=
 *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_ERASE_=
TIMEOUT_MULT];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hc_erase_size =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_HC_ERA=
SE_GRP_SIZE] << 19;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (card->ext_csd.rev >=3D 4) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.sec_trim_mult =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_SEC_TR=
IM_MULT];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.sec_erase_mult =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_SEC_ER=
ASE_MULT];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.sec_feature_support =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_SEC_FE=
ATURE_SUPPORT];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.trim_timeout =3D 300 *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_TRIM_M=
ULT];
>> =A0 =A0 =A0 =A0}
>>
>> + =A0 =A0 =A0 if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erased_byte =3D 0xFF;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erased_byte =3D 0x0;
>> +
>> out:
>> =A0 =A0 =A0 =A0kfree(ext_csd);
>>
>> @@ -260,6 +298,7 @@ MMC_DEV_ATTR(cid, "%08x%08x%08x%08x\n",
>> card->raw_cid[0], card->raw_cid[1],
>> MMC_DEV_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0], card->raw_=
csd[1],
>> =A0 =A0 =A0 =A0card->raw_csd[2], card->raw_csd[3]);
>> MMC_DEV_ATTR(date, "%02d/%04d\n", card->cid.month, card->cid.year);
>> +MMC_DEV_ATTR(erase_size, "%u\n", card->erase_size);
>> MMC_DEV_ATTR(fwrev, "0x%x\n", card->cid.fwrev);
>> MMC_DEV_ATTR(hwrev, "0x%x\n", card->cid.hwrev);
>> MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
>> @@ -271,6 +310,7 @@ static struct attribute *mmc_std_attrs[] =3D {
>> =A0 =A0 =A0 =A0&dev_attr_cid.attr,
>> =A0 =A0 =A0 =A0&dev_attr_csd.attr,
>> =A0 =A0 =A0 =A0&dev_attr_date.attr,
>> + =A0 =A0 =A0 &dev_attr_erase_size.attr,
>> =A0 =A0 =A0 =A0&dev_attr_fwrev.attr,
>> =A0 =A0 =A0 =A0&dev_attr_hwrev.attr,
>> =A0 =A0 =A0 =A0&dev_attr_manfid.attr,
>> @@ -407,6 +447,8 @@ static int mmc_init_card(struct mmc_host *host, =
u32 ocr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_read_ext_csd(card);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_card;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Erase size depends on CSD and Exten=
ded CSD */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_erase_size(card);
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0/*
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 5eac21d..fe6bc74 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -119,6 +119,14 @@ static int mmc_decode_csd(struct mmc_card *card=
)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0csd->r2w_factor =3D UNSTUFF_BITS(resp=
, 26, 3);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0csd->write_blkbits =3D UNSTUFF_BITS(r=
esp, 22, 4);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0csd->write_partial =3D UNSTUFF_BITS(r=
esp, 21, 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (UNSTUFF_BITS(resp, 46, 1))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csd->erase_size =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csd->erase_size =3D UN=
STUFF_BITS(resp, 39, 7) + 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csd->erase_size <<=3D =
csd->write_blkbits;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csd->erase_size >>=3D =
9;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> =A0 =A0 =A0 =A0case 1:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>> @@ -147,6 +155,7 @@ static int mmc_decode_csd(struct mmc_card *card)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0csd->r2w_factor =3D 4; /* Unused */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0csd->write_blkbits =3D 9;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0csd->write_partial =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 csd->erase_size =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> =A0 =A0 =A0 =A0default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: unrecognised CSD=
 structure version
>> %d\n",
>> @@ -154,6 +163,8 @@ static int mmc_decode_csd(struct mmc_card *card)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> =A0 =A0 =A0 =A0}
>>
>> + =A0 =A0 =A0 card->erase_size =3D csd->erase_size;
>> +
>> =A0 =A0 =A0 =A0return 0;
>> }
>>
>> @@ -179,10 +190,68 @@ static int mmc_decode_scr(struct mmc_card *car=
d)
>> =A0 =A0 =A0 =A0scr->sda_vsn =3D UNSTUFF_BITS(resp, 56, 4);
>> =A0 =A0 =A0 =A0scr->bus_widths =3D UNSTUFF_BITS(resp, 48, 4);
>>
>> + =A0 =A0 =A0 if (UNSTUFF_BITS(resp, 55, 1))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erased_byte =3D 0xFF;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erased_byte =3D 0x0;
>> +
>> =A0 =A0 =A0 =A0return 0;
>> }
>>
>> /*
>> + * Fetch and process SD Status register.
>> + */
>> +static int mmc_read_ssr(struct mmc_card *card)
>> +{
>> + =A0 =A0 =A0 unsigned int au, es, et, eo;
>> + =A0 =A0 =A0 int err, i;
>> + =A0 =A0 =A0 u32 *ssr;
>> +
>> + =A0 =A0 =A0 if (!(card->csd.cmdclass & CCC_APP_SPEC)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: card lacks ma=
ndatory SD Status "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "function.\n", mmc_hos=
tname(card->host));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ssr =3D kmalloc(64, GFP_KERNEL);
>> + =A0 =A0 =A0 if (!ssr)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 =A0 err =3D mmc_app_sd_status(card, ssr);
>> + =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: problem readi=
ng SD Status "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "register.\n", mmc_hos=
tname(card->host));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i < 16; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssr[i] =3D be32_to_cpu(ssr[i]);
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* UNSTUFF_BITS only works with four u32s so we have=
 to offset the
>> + =A0 =A0 =A0 =A0* bitfield positions accordingly.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 au =3D UNSTUFF_BITS(ssr, 428 - 384, 4);
>> + =A0 =A0 =A0 if (au > 0 || au <=3D 9) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ssr.au =3D 1 << (au + 4);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 es =3D UNSTUFF_BITS(ssr, 408 - 384, 16=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 et =3D UNSTUFF_BITS(ssr, 402 - 384, 6)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eo =3D UNSTUFF_BITS(ssr, 400 - 384, 2)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (es && et) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ssr.erase_timeou=
t =3D (et * 1000) / es;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ssr.erase_offset=
 =3D eo * 1000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: SD Status: In=
valid Allocation Unit
>> "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "size.\n", mmc_hostnam=
e(card->host));
>> + =A0 =A0 =A0 }
>> +out:
>> + =A0 =A0 =A0 kfree(ssr);
>> + =A0 =A0 =A0 return err;
>> +}
>> +
>> +/*
>> =A0* Fetches and decodes switch information
>> =A0*/
>> static int mmc_read_switch(struct mmc_card *card)
>> @@ -289,6 +358,7 @@ MMC_DEV_ATTR(csd, "%08x%08x%08x%08x\n",
>> card->raw_csd[0], card->raw_csd[1],
>> =A0 =A0 =A0 =A0card->raw_csd[2], card->raw_csd[3]);
>> MMC_DEV_ATTR(scr, "%08x%08x\n", card->raw_scr[0], card->raw_scr[1]);
>> MMC_DEV_ATTR(date, "%02d/%04d\n", card->cid.month, card->cid.year);
>> +MMC_DEV_ATTR(erase_size, "%u\n", card->erase_size);
>> MMC_DEV_ATTR(fwrev, "0x%x\n", card->cid.fwrev);
>> MMC_DEV_ATTR(hwrev, "0x%x\n", card->cid.hwrev);
>> MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
>> @@ -302,6 +372,7 @@ static struct attribute *sd_std_attrs[] =3D {
>> =A0 =A0 =A0 =A0&dev_attr_csd.attr,
>> =A0 =A0 =A0 =A0&dev_attr_scr.attr,
>> =A0 =A0 =A0 =A0&dev_attr_date.attr,
>> + =A0 =A0 =A0 &dev_attr_erase_size.attr,
>> =A0 =A0 =A0 =A0&dev_attr_fwrev.attr,
>> =A0 =A0 =A0 =A0&dev_attr_hwrev.attr,
>> =A0 =A0 =A0 =A0&dev_attr_manfid.attr,
>> @@ -442,6 +513,16 @@ static int mmc_sd_init_card(struct mmc_host *ho=
st, u32
>> ocr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_card;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Fetch and process SD Status regis=
ter.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_read_ssr(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Erase init depends on CSD and SSR *=
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_init_erase(card);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Fetch switch information from card=
=2E
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_read_switch(card);
>> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
>> index 63772e7..797cdb5 100644
>> --- a/drivers/mmc/core/sd_ops.c
>> +++ b/drivers/mmc/core/sd_ops.c
>> @@ -346,3 +346,51 @@ int mmc_sd_switch(struct mmc_card *card, int mo=
de, int
>> group,
>> =A0 =A0 =A0 =A0return 0;
>> }
>>
>> +int mmc_app_sd_status(struct mmc_card *card, void *ssr)
>> +{
>> + =A0 =A0 =A0 int err;
>> + =A0 =A0 =A0 struct mmc_request mrq;
>> + =A0 =A0 =A0 struct mmc_command cmd;
>> + =A0 =A0 =A0 struct mmc_data data;
>> + =A0 =A0 =A0 struct scatterlist sg;
>> +
>> + =A0 =A0 =A0 BUG_ON(!card);
>> + =A0 =A0 =A0 BUG_ON(!card->host);
>> + =A0 =A0 =A0 BUG_ON(!ssr);
>> +
>> + =A0 =A0 =A0 /* NOTE: caller guarantees ssr is heap-allocated */
>> +
>> + =A0 =A0 =A0 err =3D mmc_app_cmd(card->host, card);
>> + =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> +
>> + =A0 =A0 =A0 memset(&mrq, 0, sizeof(struct mmc_request));
>> + =A0 =A0 =A0 memset(&cmd, 0, sizeof(struct mmc_command));
>> + =A0 =A0 =A0 memset(&data, 0, sizeof(struct mmc_data));
>> +
>> + =A0 =A0 =A0 mrq.cmd =3D &cmd;
>> + =A0 =A0 =A0 mrq.data =3D &data;
>> +
>> + =A0 =A0 =A0 cmd.opcode =3D SD_APP_SD_STATUS;
>> + =A0 =A0 =A0 cmd.arg =3D 0;
>> + =A0 =A0 =A0 cmd.flags =3D MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AD=
TC;
>> +
>> + =A0 =A0 =A0 data.blksz =3D 64;
>> + =A0 =A0 =A0 data.blocks =3D 1;
>> + =A0 =A0 =A0 data.flags =3D MMC_DATA_READ;
>> + =A0 =A0 =A0 data.sg =3D &sg;
>> + =A0 =A0 =A0 data.sg_len =3D 1;
>> +
>> + =A0 =A0 =A0 sg_init_one(&sg, ssr, 64);
>> +
>> + =A0 =A0 =A0 mmc_set_data_timeout(&data, card);
>> +
>> + =A0 =A0 =A0 mmc_wait_for_req(card->host, &mrq);
>> +
>> + =A0 =A0 =A0 if (cmd.error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return cmd.error;
>> + =A0 =A0 =A0 if (data.error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return data.error;
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
>> index 9742d8a..ffc2305 100644
>> --- a/drivers/mmc/core/sd_ops.h
>> +++ b/drivers/mmc/core/sd_ops.h
>> @@ -19,6 +19,7 @@ int mmc_send_relative_addr(struct mmc_host *host, =
unsigned
>> int *rca);
>> int mmc_app_send_scr(struct mmc_card *card, u32 *scr);
>> int mmc_sd_switch(struct mmc_card *card, int mode, int group,
>> =A0 =A0 =A0 =A0u8 value, u8 *resp);
>> +int mmc_app_sd_status(struct mmc_card *card, void *ssr);
>>
>> #endif
>>
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index d02d2c6..eff7a08 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -30,6 +30,7 @@ struct mmc_csd {
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0tacc_ns;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0r2w_factor;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0max_dtr;
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_size; =A0 =A0=
 =A0 =A0 =A0 =A0 /* In sectors */
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0read_blkbits;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0write_blkbits;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0capacity;
>> @@ -41,9 +42,16 @@ struct mmc_csd {
>>
>> struct mmc_ext_csd {
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev;
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0erase_gr=
oup_def;
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sec_feat=
ure_support;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sa_timeout; =A0 =A0=
 =A0 =A0 =A0 =A0 /* Units: 100ns */
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0hs_max_dtr;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sectors;
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0hc_erase_size; =A0=
 =A0 =A0 =A0 =A0/* In sectors */
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0hc_erase_timeout; =
=A0 =A0 =A0 /* In milliseconds
>> */
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0sec_trim_mult; =A0=
/* Secure trim multiplier
>> =A0*/
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0sec_erase_mult; /*=
 Secure erase multiplier
>> */
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0trim_timeout; =A0 =
=A0 =A0 =A0 =A0 /* In milliseconds
>> */
>> };
>>
>> struct sd_scr {
>> @@ -53,6 +61,12 @@ struct sd_scr {
>> #define SD_SCR_BUS_WIDTH_4 =A0 =A0 =A0(1<<2)
>> };
>>
>> +struct sd_ssr {
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0au; =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* In sectors */
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_timeout; =A0=
 =A0 =A0 =A0 =A0/* In milliseconds
>> */
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_offset; =A0 =
=A0 =A0 =A0 =A0 /* In milliseconds
>> */
>> +};
>> +
>> struct sd_switch_caps {
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0hs_max_dtr;
>> };
>> @@ -101,6 +115,10 @@ struct mmc_card {
>> #define MMC_QUIRK_LENIENT_FN0 =A0 (1<<0) =A0 =A0 =A0 =A0 =A0/* allow=
 SDIO FN0 writes
>> outside of the VS CCCR range */
>> #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) =A0 =A0/* use func->cur=
_blksize */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0/* for byte mode */
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_size; =A0 =A0=
 /* erase size in sectors */
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_shift; =A0 =A0=
/* if erase unit is power 2
>> */
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0max_erase; =A0 =A0=
 =A0/* in sectors */
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0erased_b=
yte; =A0 =A0/* value of erased bytes */
>>
>> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 raw_cid[4=
]; =A0 =A0 /* raw card CID */
>> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 raw_csd[4=
]; =A0 =A0 /* raw card CSD */
>> @@ -109,6 +127,7 @@ struct mmc_card {
>> =A0 =A0 =A0 =A0struct mmc_csd =A0 =A0 =A0 =A0 =A0csd; =A0 =A0 =A0 =A0=
 =A0 =A0/* card specific */
>> =A0 =A0 =A0 =A0struct mmc_ext_csd =A0 =A0 =A0ext_csd; =A0 =A0 =A0 =A0=
/* mmc v4 extended card
>> specific */
>> =A0 =A0 =A0 =A0struct sd_scr =A0 =A0 =A0 =A0 =A0 scr; =A0 =A0 =A0 =A0=
 =A0 =A0/* extra SD information */
>> + =A0 =A0 =A0 struct sd_ssr =A0 =A0 =A0 =A0 =A0 ssr; =A0 =A0 =A0 =A0=
 =A0 =A0/* yet more SD information
>> */
>> =A0 =A0 =A0 =A0struct sd_switch_caps =A0 sw_caps; =A0 =A0 =A0 =A0/* =
switch (CMD6) caps */
>>
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sdio_funcs; =A0 =A0=
 /* number of SDIO functions
>> */
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index e4898e9..7429033 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -92,6 +92,8 @@ struct mmc_command {
>> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0actively failing requests
>> =A0*/
>>
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_timeout; =A0=
/* in milliseconds */
>> +
>> =A0 =A0 =A0 =A0struct mmc_data =A0 =A0 =A0 =A0 *data; =A0 =A0 =A0 =A0=
 =A0/* data segment associated
>> with cmd */
>> =A0 =A0 =A0 =A0struct mmc_request =A0 =A0 =A0*mrq; =A0 =A0 =A0 =A0 =A0=
 /* associated request */
>> };
>> @@ -134,6 +136,23 @@ extern int mmc_wait_for_cmd(struct mmc_host *, =
struct
>> mmc_command *, int);
>> extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *=
,
>> =A0 =A0 =A0 =A0struct mmc_command *, int);
>>
>> +#define MMC_ERASE_ARG =A0 =A0 =A0 =A0 =A00x00000000
>> +#define MMC_SECURE_ERASE_ARG =A0 0x80000000
>> +#define MMC_TRIM_ARG =A0 =A0 =A0 =A0 =A0 0x00000001
>> +#define MMC_SECURE_TRIM1_ARG =A0 0x80000001
>> +#define MMC_SECURE_TRIM2_ARG =A0 0x80008000
>> +
>> +#define MMC_SECURE_ARGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x80000000
>> +#define MMC_TRIM_ARGS =A0 =A0 =A0 =A0 =A00x00008001
>> +
>> +extern int mmc_erase(struct mmc_card *card, unsigned int from, unsi=
gned int
>> nr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int arg);
>> +extern int mmc_can_erase(struct mmc_card *card);
>> +extern int mmc_can_trim(struct mmc_card *card);
>> +extern int mmc_can_secure_erase_trim(struct mmc_card *card);
>> +extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned =
int
>> from,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
unsigned int nr);
>> +
>> extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc=
_card
>> *);
>> extern unsigned int mmc_align_data_size(struct mmc_card *, unsigned =
int);
>>
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index f65913c..3beb29d 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -155,6 +155,7 @@ struct mmc_host {
>> #define MMC_CAP_DISABLE =A0 =A0 =A0 =A0 (1 << 7) =A0 =A0 =A0 =A0/* C=
an the host be disabled
>> */
>> #define MMC_CAP_NONREMOVABLE =A0 =A0(1 << 8) =A0 =A0 =A0 =A0/* Nonre=
movable e.g. eMMC */
>> #define MMC_CAP_WAIT_WHILE_BUSY (1 << 9) =A0 =A0 =A0 =A0/* Waits whi=
le card is busy
>> */
>> +#define MMC_CAP_ERASE =A0 =A0 =A0 =A0 =A0(1 << 10) =A0 =A0 =A0 /* A=
llow erase/trim commands
>> */
>>
>> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
>>
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index 8a49cbf..82cdf8b 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -251,12 +251,20 @@ struct _mmc_csd {
>> =A0* EXT_CSD fields
>> =A0*/
>>
>> -#define EXT_CSD_BUS_WIDTH =A0 =A0 =A0183 =A0 =A0 /* R/W */
>> -#define EXT_CSD_HS_TIMING =A0 =A0 =A0185 =A0 =A0 /* R/W */
>> -#define EXT_CSD_CARD_TYPE =A0 =A0 =A0196 =A0 =A0 /* RO */
>> -#define EXT_CSD_REV =A0 =A0 =A0 =A0 =A0 =A0192 =A0 =A0 /* RO */
>> -#define EXT_CSD_SEC_CNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0212 =A0 =A0 =
/* RO, 4 bytes */
>> -#define EXT_CSD_S_A_TIMEOUT =A0 =A0217
>> +#define EXT_CSD_ERASE_GROUP_DEF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0175 =
=A0 =A0 /* R/W */
>> +#define EXT_CSD_ERASED_MEM_CONT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0181 =
=A0 =A0 /* RO */
>> +#define EXT_CSD_BUS_WIDTH =A0 =A0 =A0 =A0 =A0 =A0 =A0183 =A0 =A0 /*=
 R/W */
>> +#define EXT_CSD_HS_TIMING =A0 =A0 =A0 =A0 =A0 =A0 =A0185 =A0 =A0 /*=
 R/W */
>> +#define EXT_CSD_CARD_TYPE =A0 =A0 =A0 =A0 =A0 =A0 =A0196 =A0 =A0 /*=
 RO */
>> +#define EXT_CSD_REV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0192 =A0 =
=A0 /* RO */
>> +#define EXT_CSD_SEC_CNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0212 =A0 =A0 /* RO, 4 bytes */
>> +#define EXT_CSD_S_A_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0217 =A0 =A0 /* R=
O */
>> +#define EXT_CSD_ERASE_TIMEOUT_MULT =A0 =A0 223 =A0 =A0 /* RO */
>> +#define EXT_CSD_HC_ERASE_GRP_SIZE =A0 =A0 =A0224 =A0 =A0 /* RO */
>> +#define EXT_CSD_SEC_TRIM_MULT =A0 =A0 =A0 =A0 =A0229 =A0 =A0 /* RO =
*/
>> +#define EXT_CSD_SEC_ERASE_MULT =A0 =A0 =A0 =A0 230 =A0 =A0 /* RO */
>> +#define EXT_CSD_SEC_FEATURE_SUPPORT =A0 =A0231 =A0 =A0 /* RO */
>> +#define EXT_CSD_TRIM_MULT =A0 =A0 =A0 =A0 =A0 =A0 =A0232 =A0 =A0 /*=
 RO */
>>
>> /*
>> =A0* EXT_CSD field definitions
>> @@ -274,6 +282,10 @@ struct _mmc_csd {
>> #define EXT_CSD_BUS_WIDTH_4 =A0 =A0 1 =A0 =A0 =A0 /* Card is in 4 bi=
t mode */
>> #define EXT_CSD_BUS_WIDTH_8 =A0 =A0 2 =A0 =A0 =A0 /* Card is in 8 bi=
t mode */
>>
>> +#define EXT_CSD_SEC_ER_EN =A0 =A0 =A0BIT(0)
>> +#define EXT_CSD_SEC_BD_BLK_EN =A0BIT(2)
>> +#define EXT_CSD_SEC_GB_CL_EN =A0 BIT(4)
>> +
>> /*
>> =A0* MMC_SWITCH access modes
>> =A0*/
>> diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
>> index f310062..3fd85e0 100644
>> --- a/include/linux/mmc/sd.h
>> +++ b/include/linux/mmc/sd.h
>> @@ -21,8 +21,13 @@
>> =A0/* class 10 */
>> #define SD_SWITCH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 6 =A0 /* adtc [31:=
0] See below =A0 R1 =A0*/
>>
>> + =A0/* class 5 */
>> +#define SD_ERASE_WR_BLK_START =A0 =A032 =A0 /* ac =A0 [31:0] data a=
ddr =A0 R1 =A0*/
>> +#define SD_ERASE_WR_BLK_END =A0 =A0 =A033 =A0 /* ac =A0 [31:0] data=
 addr =A0 R1 =A0*/
>> +
>> =A0/* Application commands */
>> #define SD_APP_SET_BUS_WIDTH =A0 =A0 =A06 =A0 /* ac =A0 [1:0] bus wi=
dth =A0 =A0R1 =A0*/
>> +#define SD_APP_SD_STATUS =A0 =A0 =A0 =A0 13 =A0 /* adtc =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0R1 =A0*/
>> #define SD_APP_SEND_NUM_WR_BLKS =A022 =A0 /* adtc =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0R1 =A0*/
>> #define SD_APP_OP_COND =A0 =A0 =A0 =A0 =A0 41 =A0 /* bcr =A0[31:0] O=
CR =A0 =A0 =A0 =A0 R3 =A0*/
>> #define SD_APP_SEND_SCR =A0 =A0 =A0 =A0 =A051 =A0 /* adtc =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0R1 =A0*/
>> --
>> 1.6.3.3
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
