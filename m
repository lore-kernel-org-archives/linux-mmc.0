From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [RFC 2/3] MMC: Add block quirks support.
Date: Wed, 2 Mar 2011 14:48:25 -0600
Message-ID: <AANLkTimYf01Y6FLYGdyeozvxVO0mxX_QOn2XQ5AHGEFk@mail.gmail.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
	<1299017344-25361-3-git-send-email-andreiw@motorola.com>
	<201103021819.52837.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:39474 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755766Ab1CBUs2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2011 15:48:28 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p22KlD4X022105
	for <linux-mmc@vger.kernel.org>; Wed, 2 Mar 2011 15:47:13 -0500 (EST)
Received: from mail-vx0-f170.google.com (mail-vx0-f170.google.com [209.85.220.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p22INguZ004202
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 2 Mar 2011 15:47:13 -0500 (EST)
Received: by mail-vx0-f170.google.com with SMTP id 39so261627vxb.15
        for <linux-mmc@vger.kernel.org>; Wed, 02 Mar 2011 12:48:26 -0800 (PST)
In-Reply-To: <201103021819.52837.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

On Wed, Mar 2, 2011 at 11:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 01 March 2011, Andrei Warkentin wrote:
>> Quirks are card-specific workarounds. Usually they involve
>> tuning mmcblk parameters at mmc_blk_probe time, but can
>> involve affecting the way mmcblk I/O requests are handled.
>> The later is necessary to handle Sandisk out-of-spec discard support=
,
>> and the small-writes reliability workaround for Toshiba.
>
> I was hoping for a simpler method, let me elaborate below
>
>> Change-Id: Ia5e56d7a2803daba4b9085f2ca12afeadc7d9095
>
> We don't put a Change-Id into kernel patches, they are meaningless.
>

Oops, sorry about that.

>> +struct gendisk;
>> +
>> +#ifdef CONFIG_MMC_BLOCK_QUIRKS
>> +struct mmc_blk_data;
>> +
>> +#define mmc_blk_qrev(hwrev, fwrev, year, month) \
>> + =A0 =A0 (((u64) hwrev) << 40 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
\
>> + =A0 =A0 =A0((u64) fwrev) << 32 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
\
>> + =A0 =A0 =A0((u64) year) << 16 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 \
>> + =A0 =A0 =A0((u64) month))
>> +
>> +#define mmc_blk_qrev_card(card) =A0 =A0 =A0 \
>> + =A0 =A0 mmc_blk_qrev(card->cid.hwrev, \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->cid.fwrev, \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->cid.year, =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->cid.month)
>> +
>> +struct mmc_blk_quirk {
>> + =A0 =A0 struct rb_node rb_node;
>> + =A0 =A0 const char *name;
>> +
>> + =A0 =A0 /* First valid revision */
>> + =A0 =A0 u64 rev_start;
>> +
>> + =A0 =A0 /* Last valid revision */
>> + =A0 =A0 u64 rev_end;
>> +
>> + =A0 =A0 unsigned int manfid;
>> + =A0 =A0 unsigned short oemid;
>> + =A0 =A0 int (*probe)(struct mmc_blk_data *, struct mmc_card *);
>
> So far so good.
>
>> + =A0 =A0 int (*adjust)(struct mmc_queue *, struct request *, struct=
 mmc_request *);
>> +};
>
> The adjust function looks out of place here, I would leave it out unt=
il it
> really is used.
>

Yes, out of place at the moment, I'll pull it out into the patch where
it will be used.

>> +/*
>> + * There is one mmc_blk_data per slot.
>> + */
>> +struct mmc_blk_data {
>> + =A0 =A0 spinlock_t =A0 =A0 =A0lock;
>> + =A0 =A0 struct gendisk =A0*disk;
>> + =A0 =A0 struct mmc_queue queue;
>> +
>> + =A0 =A0 unsigned int =A0 =A0usage;
>> + =A0 =A0 unsigned int =A0 =A0read_only;
>> + =A0 =A0 unsigned int =A0 =A0write_align_size;
>> +#ifdef CONFIG_MMC_BLOCK_QUIRKS
>> + =A0 =A0 struct mmc_blk_quirk *quirk;
>> +#endif /* CONFIG_MMC_BLOCK_QUIRKS */
>> +};
>
> I don't think a pointer to the quirk is needed here, you can probably
> leave the mmc_blk_data alone.
>
>

I'll pull it out along with the adjust pointer.

>> +/*
>> + =A0 Since the goal is to support quirks in removable media, ideall=
y
>> + =A0 such quirks would be always built into a kernel, hence we need
>> + =A0 a smarter way to search.
>> +*/
>> +static struct rb_root quirk_tree[2] =3D { RB_ROOT, RB_ROOT };
>> +
>> +static int mmc_blk_quirk_cmp(const struct mmc_blk_quirk *quirk,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct mm=
c_blk_quirk *cquirk)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 if (quirk->manfid > cquirk->manfid)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 else if (quirk->manfid < cquirk->manfid)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> +
>> + =A0 =A0 if (quirk->oemid > cquirk->oemid)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 else if (quirk->oemid < cquirk->oemid)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> +
>> + =A0 =A0 ret =3D strcmp(quirk->name, cquirk->name);
>> + =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 if (quirk->rev_start > cquirk->rev_end)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 else if (quirk->rev_end < cquirk->rev_start)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> +
>> + =A0 =A0 /* Overlap in revs or equal. */
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int mmc_blk_quirk_cmpc(const struct mmc_blk_quirk *quirk,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct m=
mc_card *card)
>> +{
>> + =A0 =A0 struct mmc_blk_quirk cquirk;
>> + =A0 =A0 cquirk.name =3D card->cid.prod_name;
>> + =A0 =A0 cquirk.rev_start =3D mmc_blk_qrev_card(card);
>> + =A0 =A0 cquirk.rev_end =3D cquirk.rev_start;
>> + =A0 =A0 cquirk.manfid =3D card->cid.manfid;
>> + =A0 =A0 cquirk.oemid =3D card->cid.oemid;
>> + =A0 =A0 return mmc_blk_quirk_cmp(quirk, &cquirk);
>> +}
>
> This can be simplified slightly if you avoid calling mmc_blk_quirk_cm=
p.
>

If you get rid of the rb-tree, sure, but I need to be able to compare
an mmc_card against the mmc_blk_quirk, and duplicating
mmc_blk_quirk_cmp didn't seem like a good idea :).

>> +struct mmc_blk_quirk *mmc_blk_quirk_find(struct mmc_card *card)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 struct mmc_blk_quirk *quirk;
>> + =A0 =A0 struct rb_node *node =3D quirk_tree[!mmc_card_mmc(card)].r=
b_node;
>> +
>> + =A0 =A0 while (node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 quirk =3D container_of(node, struct mmc_bl=
k_quirk, rb_node);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_blk_quirk_cmpc(quirk, card);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node =3D node->rb_left;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (ret > 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node =3D node->rb_right;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return quirk;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return NULL;
>> +}
>> +
>> +int mmc_blk_quirk_register(struct mmc_blk_quirk *quirk, bool is_mmc=
)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 struct mmc_blk_quirk *cq;
>> + =A0 =A0 struct rb_node **new =3D &(quirk_tree[!is_mmc].rb_node), *=
parent =3D NULL;
>> +
>> + =A0 =A0 while (*new) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 cq =3D container_of(*new, struct mmc_blk_q=
uirk, rb_node);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_blk_quirk_cmp(quirk, cq);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 parent =3D *new;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new =3D &(parent->rb_left)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if(ret > 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new =3D &(parent->rb_right=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Overlap */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 }
>> +
>> + =A0 =A0 rb_link_node(&quirk->rb_node, parent, new);
>> + =A0 =A0 rb_insert_color(&quirk->rb_node, &quirk_tree[!is_mmc]);
>> + =A0 =A0 return 0;
>> +}
>
> Instead of the dynamic registration, I'd just put all quirks into
> one file and have an array of them:

Ideally, you'd have the most important workarounds always built in, to
deal with important problems like out-of-spec devices. The eMMC ones
you would select, but the external device ones would be "by default".
This could potentially explode in the amount of quirks, so maybe
linear search isn't the best?

Or you think that there will be sufficiently small number that doesn't
justify the complexity?

>
> #define MMC_BLK_QUIRK_VERSION(_name, _manfid, _oemid, _rev_start, _re=
v_end, _probe) \
> { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 .name =3D (_name), =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 .manfid =3D (_manfid), =A0 =A0 \
> =A0 =A0 =A0 .oemid =3D (_oemid), =A0 =A0 =A0 \
> =A0 =A0 =A0 .rev_start =3D (_rev_start),\
> =A0 =A0 =A0 .rev_end =3D (_rev_end), =A0 \
> =A0 =A0 =A0 .probe =3D (_probe), =A0 =A0 =A0 \
> }
>
> #define MMC_BLK_QUIRK(_name, _manfid, _oemid, _probe) \
> =A0MMC_BLK_QUIRK_VERSION(_name, _manfid, _oemid, 0, -1ull, _probe)
>
> struct mmc_blk_quirk mmc_blk_quirks[] =3D {
> =A0 =A0 =A0 =A0MMC_BLK_QUIRK("MMC32G", 0x11, 0x0100, toshiba_mmc32g),
> =A0 =A0 =A0 =A0...
> };
>
>> +#ifdef CONFIG_MMC_BLOCK_QUIRKS
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (md->quirk && md->quirk->adjust)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 md->quirk->adjust(mq, req,=
 &brq.mrq);
>> +#endif /* CONFIG_MMC_BLOCK_QUIRKS */
>
> Instead of having a function pointer here, I'd start out with
> an open-coded version of the one function that you know is required,
> and make it depend on members of struct mmc_card that can get
> set in the .probe function.
>

I'll pull out the adjust member right now. It's not relevant to this pa=
tch set.

>> +#ifdef CONFIG_MMC_BLOCK_QUIRKS
>> + =A0 =A0 md->quirk =3D mmc_blk_quirk_find(card);
>> + =A0 =A0 if (md->quirk && md->quirk->probe)
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D quirk->probe(md, card);
>> + =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +#endif /* CONFIG_MMC_BLOCK_QUIRKS */
>
> Just make this an inline function in the header and call it unconditi=
onally:
>
> #ifdef CONFIG_MMC_BLOCK_QUIRKS
> extern int mmc_blk_quirk_find(struct mmc_card *card);
> #else
> static inline int mmc_blk_quirk_find(struct mmc_card *card)
> {
> =A0 =A0 =A0 =A0return 0;
> }
> #endif

Ok, great, I'll do that.

Thanks for the feedback,
A
