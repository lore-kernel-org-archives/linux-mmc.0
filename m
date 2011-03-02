From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 2/3] MMC: Add block quirks support.
Date: Wed, 2 Mar 2011 18:19:52 +0100
Message-ID: <201103021819.52837.arnd@arndb.de>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com> <1299017344-25361-3-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:53234 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898Ab1CBRUA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2011 12:20:00 -0500
In-Reply-To: <1299017344-25361-3-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

On Tuesday 01 March 2011, Andrei Warkentin wrote:
> Quirks are card-specific workarounds. Usually they involve
> tuning mmcblk parameters at mmc_blk_probe time, but can
> involve affecting the way mmcblk I/O requests are handled.
> The later is necessary to handle Sandisk out-of-spec discard support,
> and the small-writes reliability workaround for Toshiba.

I was hoping for a simpler method, let me elaborate below
 
> Change-Id: Ia5e56d7a2803daba4b9085f2ca12afeadc7d9095

We don't put a Change-Id into kernel patches, they are meaningless.

> +struct gendisk;
> +
> +#ifdef CONFIG_MMC_BLOCK_QUIRKS
> +struct mmc_blk_data;
> +
> +#define mmc_blk_qrev(hwrev, fwrev, year, month) \
> +	(((u64) hwrev) << 40 |                  \
> +	 ((u64) fwrev) << 32 |                  \
> +	 ((u64) year) << 16 |                   \
> +	 ((u64) month))
> +
> +#define mmc_blk_qrev_card(card)       \
> +	mmc_blk_qrev(card->cid.hwrev, \
> +		     card->cid.fwrev, \
> +		     card->cid.year,  \
> +		     card->cid.month)
> +
> +struct mmc_blk_quirk {
> +	struct rb_node rb_node;
> +	const char *name;
> +
> +	/* First valid revision */
> +	u64 rev_start;
> +
> +	/* Last valid revision */
> +	u64 rev_end;
> +
> +	unsigned int manfid;
> +	unsigned short oemid;
> +	int (*probe)(struct mmc_blk_data *, struct mmc_card *);

So far so good.

> +	int (*adjust)(struct mmc_queue *, struct request *, struct mmc_request *);
> +};

The adjust function looks out of place here, I would leave it out until it
really is used.

> +/*
> + * There is one mmc_blk_data per slot.
> + */
> +struct mmc_blk_data {
> +	spinlock_t	lock;
> +	struct gendisk	*disk;
> +	struct mmc_queue queue;
> +
> +	unsigned int	usage;
> +	unsigned int	read_only;
> +	unsigned int	write_align_size;
> +#ifdef CONFIG_MMC_BLOCK_QUIRKS
> +	struct mmc_blk_quirk *quirk;
> +#endif /* CONFIG_MMC_BLOCK_QUIRKS */
> +};

I don't think a pointer to the quirk is needed here, you can probably
leave the mmc_blk_data alone.


> +/*
> +   Since the goal is to support quirks in removable media, ideally
> +   such quirks would be always built into a kernel, hence we need
> +   a smarter way to search.
> +*/
> +static struct rb_root quirk_tree[2] = { RB_ROOT, RB_ROOT };
> +
> +static int mmc_blk_quirk_cmp(const struct mmc_blk_quirk *quirk,
> +			     const struct mmc_blk_quirk *cquirk)
> +{
> +	int ret;
> +
> +	if (quirk->manfid > cquirk->manfid)
> +		return 1;
> +	else if (quirk->manfid < cquirk->manfid)
> +		return -1;
> +
> +	if (quirk->oemid > cquirk->oemid)
> +		return 1;
> +	else if (quirk->oemid < cquirk->oemid)
> +		return -1;
> +
> +	ret = strcmp(quirk->name, cquirk->name);
> +	if (!ret)
> +		return ret;
> +
> +	if (quirk->rev_start > cquirk->rev_end)
> +		return 1;
> +	else if (quirk->rev_end < cquirk->rev_start)
> +		return -1;
> +
> +	/* Overlap in revs or equal. */
> +	return 0;
> +}
> +
> +static int mmc_blk_quirk_cmpc(const struct mmc_blk_quirk *quirk,
> +			      const struct mmc_card *card)
> +{
> +	struct mmc_blk_quirk cquirk;
> +	cquirk.name = card->cid.prod_name;
> +	cquirk.rev_start = mmc_blk_qrev_card(card);
> +	cquirk.rev_end = cquirk.rev_start;
> +	cquirk.manfid = card->cid.manfid;
> +	cquirk.oemid = card->cid.oemid;
> +	return mmc_blk_quirk_cmp(quirk, &cquirk);
> +}

This can be simplified slightly if you avoid calling mmc_blk_quirk_cmp.

> +struct mmc_blk_quirk *mmc_blk_quirk_find(struct mmc_card *card)
> +{
> +	int ret;
> +	struct mmc_blk_quirk *quirk;
> +	struct rb_node *node = quirk_tree[!mmc_card_mmc(card)].rb_node;
> +
> +	while (node) {
> +		quirk = container_of(node, struct mmc_blk_quirk, rb_node);
> +		ret = mmc_blk_quirk_cmpc(quirk,	card);
> +
> +		if (ret < 0)
> +			node = node->rb_left;
> +		else if (ret > 0)
> +			node = node->rb_right;
> +		else
> +			return quirk;
> +	}
> +
> +	return NULL;
> +}
> +
> +int mmc_blk_quirk_register(struct mmc_blk_quirk *quirk, bool is_mmc)
> +{
> +	int ret;
> +	struct mmc_blk_quirk *cq;
> +	struct rb_node **new = &(quirk_tree[!is_mmc].rb_node), *parent = NULL;
> +
> +	while (*new) {
> +		cq = container_of(*new, struct mmc_blk_quirk, rb_node);
> +
> +		ret = mmc_blk_quirk_cmp(quirk, cq);
> +
> +		parent = *new;
> +		if (ret < 0)
> +			new = &(parent->rb_left);
> +		else if(ret > 0)
> +			new = &(parent->rb_right);
> +		else
> +			/* Overlap */
> +			return -EINVAL;
> +
> +	}
> +
> +	rb_link_node(&quirk->rb_node, parent, new);
> +	rb_insert_color(&quirk->rb_node, &quirk_tree[!is_mmc]);
> +	return 0;
> +}

Instead of the dynamic registration, I'd just put all quirks into
one file and have an array of them:

#define MMC_BLK_QUIRK_VERSION(_name, _manfid, _oemid, _rev_start, _rev_end, _probe) \
{				\
       .name = (_name),		\
       .manfid = (_manfid),	\
       .oemid = (_oemid),	\
       .rev_start = (_rev_start),\
       .rev_end = (_rev_end),	\
       .probe = (_probe),	\
}

#define MMC_BLK_QUIRK(_name, _manfid, _oemid, _probe) \
 MMC_BLK_QUIRK_VERSION(_name, _manfid, _oemid, 0, -1ull, _probe)

struct mmc_blk_quirk mmc_blk_quirks[] = {
	MMC_BLK_QUIRK("MMC32G", 0x11, 0x0100, toshiba_mmc32g),
	...
};

> +#ifdef CONFIG_MMC_BLOCK_QUIRKS
> +		if (md->quirk && md->quirk->adjust)
> +			md->quirk->adjust(mq, req, &brq.mrq);
> +#endif /* CONFIG_MMC_BLOCK_QUIRKS */

Instead of having a function pointer here, I'd start out with
an open-coded version of the one function that you know is required,
and make it depend on members of struct mmc_card that can get
set in the .probe function.

> +#ifdef CONFIG_MMC_BLOCK_QUIRKS
> +	md->quirk = mmc_blk_quirk_find(card);
> +	if (md->quirk && md->quirk->probe)
> +		err = quirk->probe(md, card);
> +	if (err)
> +		goto out;
> +#endif /* CONFIG_MMC_BLOCK_QUIRKS */

Just make this an inline function in the header and call it unconditionally:

#ifdef CONFIG_MMC_BLOCK_QUIRKS
extern int mmc_blk_quirk_find(struct mmc_card *card);
#else
static inline int mmc_blk_quirk_find(struct mmc_card *card)
{
	return 0;
}
#endif

	Arnd
