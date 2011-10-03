From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: Re: slow eMMC write speed
Date: Mon, 03 Oct 2011 11:01:52 -0700
Message-ID: <4E89F890.9040503@linux.intel.com>
References: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com> <CACRpkdYamRVpBbhAcgn7rXBGcgHUp7+9PCrmOUkXV1BvZ+4pDw@mail.gmail.com> <CAHzg1A9H31hWdEKR5+_p8HuA_oq6o8EkESpJ22kQ4e4oFDH8GQ@mail.gmail.com> <4E837C89.9020109@linux.intel.com> <CAHzg1A8Cgz8DNje_We9MKJ90E4=9BDw9XzvEQU5h2et8HPHBjw@mail.gmail.com> <4E838B43.5090605@linux.intel.com> <CAHzg1A-wa0Gm2jXrU6q3L7-NBzQQJmZszraDsfs-Dgb8F6gT6w@mail.gmail.com> <4E839302.5020001@linux.intel.com> <CACRpkdYdrfhFSfLh=Zgjox60KbYCqN+n_WdOaP2sv_mhai+iig@mail.gmail.com> <4E84297C.3060408@stericsson.com> <4E84D20A.4040707@linux.intel.com> <CANz0V+6zKiEs5YdpipM6iid_JwyQaN2cd5y9BKh1mXXgKpxXkA@mail.gmail.com> <4E865FD0.8010309@linux.intel.com> <CANz0V+5dcZ_kn2qp4T=WbfstfqBqf--E+zD2QS1o-wE5qGhqyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090807030902090308010800"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:65138 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756159Ab1JCRxe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Oct 2011 13:53:34 -0400
In-Reply-To: <CANz0V+5dcZ_kn2qp4T=WbfstfqBqf--E+zD2QS1o-wE5qGhqyQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Andrei E. Warkentin" <andrey.warkentin@gmail.com>
Cc: Praveen G K <praveen.gk@gmail.com>, =?UTF-8?B?UGVyIEbDtnJsaW4=?= <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>

This is a multi-part message in MIME format.
--------------090807030902090308010800
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/01/2011 11:20 PM, Andrei E. Warkentin wrote:
> Hi James,
>
> 2011/9/30 J Freyensee<james_p_freyensee@linux.intel.com>:
>>
>> So I have a question on write behavior.
>>
>> Say mmc_blk_issue_rw_rq() is called.  Say the mmc_queue *mq variable passed
>> in is a write.
>
> You mean the struct request?
>
>>   Say that write is buffered, delayed into being sent via
>> mmc_wait_for_req() for 5 seconds, and it's sent to mmc_wait_for_req() later.
>>   Would that delay of sending the brq->mrq entry to mmc_wait_for_req() cause
>> a timeout, ie:
>
> Are you working off of mmc-next? Sounds like you don't have Per
> Förlin's async work yet.
> I don't want to sound lame (yes, I know your Medfield or whatever
> projects build on a particular baseline),
> but you would be doing yourself a huge favor by doing your interesting
> investigations on top of the top of
> tree.

Yeah, I know I'd be doing myself a huge favor by working off of mmc-next 
(or close to it), but product-wise, my department doesn't care for 
sustaining current platforms...yet (still trying to convince).

>
> The old code indeed calls mmc_wait_for_req in  mmc_blk_issue_rw_rq,
> while the new code does a
> mmc_start_req, which waits for a previous async request to complete
> before issuing the new one.
>
> Could you describe in greater detail what you're doing? What exactly
> do you mean by buffering?

So I was looking into sticking a write cache into block.c driver as a 
parameter, so it can be turned on and off upon driver load.  Any write 
operation goes to the cache and only on a cache collision will the
write operation get sent to the host controller for a write.  What I 
have working so far is just with an MMC card in an MMC slot of a laptop, 
and just bare-bones.  No general flush routine, error-handling, etc. 
 From a couple performance measurements I did on the MMC slot using 
blktrace/blkparse and 400MB write transactions, I was seeing huge 
performance boost with no data corruption.  So it is not looking like a 
total hair-brained idea.  But I am still pretty far from understanding 
everything here.  And the real payoff we want to see is performance a 
user can see on a handheld (i.e., Android) systems.

I did attach the code if you do want to look at it.  I heavily commented 
the code additions I made so it shouldn't be too scary to follow.  Any 
kernel contributions in the past I have made have had similar coding 
documentation in it.  I have currently turned on debugging in the host 
controller so I'm trying to understand what is going on there.

Thanks,
Jay


> As far as I understand, until you call mmc_wait_for_req (old code) or
> mmc_start_req (new code), your
> request only exists as a data structure, and the host controller
> doesn't know or care about it. So it doesn't
> matter when you send it - now, or five seconds in the future (of
> course, you probably don't want other requests
> to get ahead of a barrier request).
>
> The mmc_set_data_timeout routine is used to calculate the time the
> host controller will wait for the card to
> process the read/write. This is obviously tied to the transfer size,
> type (read or write), card properties as inferred
> from its registers and technology.
>
>>
>> mmc0: Timeout waiting for hardware interrupt.
>>
>> ??
>>
>> If this is true, how would you extend the timeout?  I would not have
>> expected this until mmc_wait_for_req() is called.
>
> The fact that you got a timeout implies that the host was processing a
> struct mmc_request already.
>
>   It appeared to me
>> mmc_set_data_timeout() was just setting a variable in brq to be used when
>> mmc_wait_for_req() is called.  I only see this behavior in eMMC cards, not
>> MMC cards being stuck into an MMC slot of a laptop.
>>
>
> It's hard to say what is going without seeing some code. My other suggestion is
> instrument the host driver (and block driver as well) and figure out
> what request is failing
> and why.
>
> A


-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation

--------------090807030902090308010800
Content-Type: text/x-csrc;
 name="block.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="block.c"

/*
 * Block driver for media (i.e., flash cards)
 *
 * Copyright 2002 Hewlett-Packard Company
 * Copyright 2005-2008 Pierre Ossman
 *
 * Use consistent with the GNU GPL is permitted,
 * provided that this copyright notice is
 * preserved in its entirety in all copies and derived works.
 *
 * HEWLETT-PACKARD COMPANY MAKES NO WARRANTIES, EXPRESSED OR IMPLIED,
 * AS TO THE USEFULNESS OR CORRECTNESS OF THIS CODE OR ITS
 * FITNESS FOR ANY PARTICULAR PURPOSE.
 *
 * Many thanks to Alessandro Rubini and Jonathan Corbet!
 *
 * Author:  Andrew Christian
 *          28 May 2002
 */
#define DEBUG
#include <linux/moduleparam.h>
#include <linux/module.h>
#include <linux/init.h>

#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/slab.h>
#include <linux/errno.h>
#include <linux/hdreg.h>
#include <linux/kdev_t.h>
#include <linux/blkdev.h>
#include <linux/mutex.h>
#include <linux/scatterlist.h>
#include <linux/string_helpers.h>

#include <linux/mmc/card.h>
#include <linux/mmc/host.h>
#include <linux/mmc/mmc.h>
#include <linux/mmc/sd.h>

#include <asm/system.h>
#include <asm/uaccess.h>

#if defined(CONFIG_DEBUG_FS)
#include <linux/dcache.h>
#include <linux/debugfs.h>
#endif

#include "queue.h"

MODULE_ALIAS("mmc:block");
#ifdef MODULE_PARAM_PREFIX
#undef MODULE_PARAM_PREFIX
#endif
#define MODULE_PARAM_PREFIX "mmcblk."

// jpf: This isn't working...probably need a spinlock because we probably
// don't want this to sleep
//static DEFINE_MUTEX(cache_mutex);
static DEFINE_MUTEX(block_mutex);

/*
 * The defaults come from config options but can be overriden by module
 * or bootarg options.
 */
static int perdev_minors = CONFIG_MMC_BLOCK_MINORS;

/*
 * We've only got one major, so number of mmcblk devices is
 * limited to 256 / number of minors per device.
 */
static int max_devices;

/* 256 minors, so at most 256 separate devices */
static DECLARE_BITMAP(dev_use, 256);

/*
 * There is one mmc_blk_data per slot.
 */
struct mmc_blk_data {
	spinlock_t	lock;
	struct gendisk	*disk;
	struct mmc_queue queue;

	unsigned int	usage;
	unsigned int	read_only;
};

static DEFINE_MUTEX(open_lock);

module_param(perdev_minors, int, 0444);
MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");

struct mmc_blk_request {
	struct mmc_request	mrq;
	struct mmc_command	cmd;
	struct mmc_command	stop;
	struct mmc_data		data;
};

/*
 * The following is for a handset cache. Data collected using blktrace 
 * and blkparse on ARM and Intel handset/tablet solutions show 
 * a roughly 10:1 write-to-read ratio on end-user operations, with 
 * many of the writes only being 1-2 sectors.  This is to try to capture 
 * and optimize many of those 1-2 sector writes. Since this has been 
 * primarily targeted for certain Linux-based computers, the parameter
 * defaults to 'off'. 
 *  
 */

/*
 * handset_cachesize is used to specify the size of the cache. 
 * 0 for off, 1-5 is the two's exponent of how 
 * many cache entries (1=2^1=2 entries, 5=2^5=32 entries) there 
 * will be in the cache. 
 * The cachesize should be small and simple,
 * to try and minimize issues like power consumption.  The max 
 * size of the cache is enforced during creation. 
 */
unsigned short static handset_cachesize = 0;
module_param(handset_cachesize, ushort, 0444);
MODULE_PARM_DESC(handset_cachesize, "Small cache targeted for handsets");

struct mmc_cache_contents {
	sector_t cache_addr;         /* starting sector address  */
	unsigned int num_sectors;    /* number of sectors/blocks */
        struct mmc_blk_request *brq; /* The 'data' we need to keep */
	unsigned char valid;         /* If data in entry is valid */
	struct request *req;         /* ptr to outstanding request */
};
struct mmc_cache_frame {
	struct mmc_cache_contents *entry;
};
static struct mmc_cache_frame mmc_cache;

/**
 * mmc_cachesize() - return the number of actual or potential
 *      	     entries of the cache, irregardless if the
 *      	     cache has been actually created yet.
 *  
 * Returns: 
 *      size of allocated cache based on handset_cachesize. if
 *      handset_cachesize is 0, then it will return 0.
 */
static unsigned int mmc_cachesize(void) 
{
	return (1 << handset_cachesize);
}

/**
 * mmc_create_cache() - Allocate the cache. Cache is created 
 *      		based on handset_cachesize:
 *      		0 = no cache created
 *      		1 = 2^1 = cache size of 2 entries
 *      		2 = 2^2 = cache size of 4 entries
 *      		etc...
 *  
 * Caveats: Since the goal is to keep the cache small and not 
 * blow up power usage or the kernel itself, this function 
 * enforces a maximum cache cap. 
 *  
 * Returns: 
 *      0 for success
 *      -EPERM for inappropriate handset_cachesize value and no
 *       	creation of cache
 *      -ENOMEM for memory issue
 *      other value, error
 *  
 */
static int mmc_create_cache(void) 
{
	const unsigned short MAXSIZE = 5;
	int retval = -EPERM;
	unsigned int i;

	/* 
	 * In case this function gets called with
	 * handset_cachesize equal to 0, we want 
	 * to inform a cache didn't get created.
	 */ 
	if (handset_cachesize == 0) {
		return retval;
	}
	//mutex_lock(&cache_mutex);
	if (handset_cachesize > MAXSIZE) {
		handset_cachesize = MAXSIZE;
	}
	
	mmc_cache.entry = kmalloc(mmc_cachesize() * 
				  sizeof(struct mmc_cache_contents),
				  GFP_NOWAIT);
	if (mmc_cache.entry == NULL)
		retval = -ENOMEM;
	else {
		/* 
		 * Should be good enough to set 'valid' to 0, NULL brq,
		 * and allow junk data in the rest of the fields.
		 */
		for (i = 0; i < mmc_cachesize(); i++) {
			mmc_cache.entry[i].valid = 0;
			mmc_cache.entry[i].brq   = NULL;
		}
		retval = 0;
	}
	//mutex_unlock(&cache_mutex);
	return retval;
}

/**
 * mmc_index_cache() - provides entry number of the cache based 
 * on the sector number. 
 *  
 * Caveats: Note this should not be used if handset_cachesize is
 * 0. It's really meant as a helper function for all the other 
 * mmc cache functions. 
 *  
 * @sector_addr: Unsigned 64-bit sector address number. 
 * 
 * Returns: 
 * 	Math result of (sector_addr % handset_cachesize)
 */
static unsigned int mmc_index_cache(sector_t sector_addr)
{
	sector_t mask_modulo = 1;
	unsigned int i = 1;
	const unsigned int CACHESIZE = handset_cachesize;

	while (i < CACHESIZE) {
		mask_modulo = mask_modulo << 1 | 1;
		i++;
	}
	pr_debug("%s return value: %d\n", __func__,
		 ((unsigned int) (sector_addr & mask_modulo)));
	return ((unsigned int) (sector_addr & mask_modulo));
}

/**
 * mmc_insert_cacheentry() - caches entry into the cache. Remember this 
 * is write-policy cache based on workloads measured with 
 * blktrace, so only writes go here. If there is a read miss, it 
 * just simply goes to the storage device to get it's info and 
 * the read data does NOT get pulled from the device and stored 
 * here. 
 *  
 * Caveats: This assumes we have an exact hit (cache_addr + 
 * num_sectors) or it's the first entry (valid == 0).
 * mmc_check_cachehit() should be called first to check 
 * if: 
 *      -we have an exact hit (cache_addr + num_sectors)
 *      -we have a semi-hit (cache_addr hit but num_sectors
 *       miss)
 *  
 * @cache_addr: sector_t address to be used to be inserted into 
 *              the cache.
 * @num_sectors: Number of sectors that will be accessed 
 *               starting with cache_addr.
 * @brq: the mmc_blk_request pointer that is sent to the host 
 *       controller for an actual write to the address.
 * 
 * Returns: 
 *      positive integer, which is the index of entry that was
 *      	successfully placed into the cache.
 *      negative integer, which symbolizes an error.
 *  
 */
static int mmc_insert_cacheentry(sector_t cache_addr, 
				 unsigned int num_sectors,
				 struct mmc_blk_request *brq,
				 struct request *req)
{
	int retval = -EPERM;
	int cache_index;

	if (handset_cachesize == 0)
		return retval;

	//mutex_lock(&cache_mutex);

	cache_index = mmc_index_cache(cache_addr);
	mmc_cache.entry[cache_index].cache_addr  = cache_addr;
	mmc_cache.entry[cache_index].num_sectors = num_sectors;

	if (mmc_cache.entry[cache_index].brq == NULL) {
		mmc_cache.entry[cache_index].brq = 
			kzalloc(sizeof(struct mmc_blk_request), 
			GFP_NOWAIT);
		if (mmc_cache.entry[cache_index].brq != NULL) {
		
		/* in lib/scatterlist.c, it is unlikely the scatterlist
		 * is actually chained.  In other words, it is expected
		 * that a scatterlist here will only have 1 node instead 
		 * of a chain (which that is 'very unlikely'). So 
		 * assuming one scatterlist node.
		 */ 
			mmc_cache.entry[cache_index].brq->data.sg = 
			kzalloc(sizeof(struct scatterlist),
				GFP_NOWAIT);
			if (mmc_cache.entry[cache_index].brq->data.sg ==
			    NULL) {
				retval = -ENOMEM;
				goto no_memory;
			}
		} else {
			retval = -ENOMEM;
			goto no_memory;
		}
		
	}
	mmc_cache.entry[cache_index].brq->mrq.cmd = 
		&(mmc_cache.entry[cache_index].brq->cmd);
	mmc_cache.entry[cache_index].brq->mrq.data = 
		&(mmc_cache.entry[cache_index].brq->data);
	mmc_cache.entry[cache_index].brq->mrq.stop = NULL;

	mmc_cache.entry[cache_index].brq->cmd.arg =
		brq->cmd.arg;
	mmc_cache.entry[cache_index].brq->cmd.flags =
		brq->cmd.flags;
	mmc_cache.entry[cache_index].brq->data.blksz =
		brq->data.blksz;
	mmc_cache.entry[cache_index].brq->stop.opcode =
		brq->stop.opcode;
	mmc_cache.entry[cache_index].brq->stop.arg =
		brq->stop.arg;
	mmc_cache.entry[cache_index].brq->stop.flags =
		brq->stop.flags;
	mmc_cache.entry[cache_index].brq->data.blocks =
		brq->data.blocks;
	mmc_cache.entry[cache_index].brq->cmd.opcode =
		brq->cmd.opcode;
	mmc_cache.entry[cache_index].brq->data.flags =
		brq->data.flags;

	mmc_cache.entry[cache_index].brq->data.sg->dma_address =
		brq->data.sg->dma_address;
	mmc_cache.entry[cache_index].brq->data.sg->dma_length =
		brq->data.sg->dma_length;
	mmc_cache.entry[cache_index].brq->data.sg->length =
		brq->data.sg->length;
	mmc_cache.entry[cache_index].brq->data.sg->offset =
		brq->data.sg->offset;
	mmc_cache.entry[cache_index].brq->data.sg->page_link =
		brq->data.sg->page_link;
	mmc_cache.entry[cache_index].brq->data.sg_len =
		brq->data.sg_len;
	
	mmc_cache.entry[cache_index].req = req;
	/* 
	 * We set valid flag here, in the event
	 * kzalloc() fails so we know the entry
	 * is still not valid and can be used again.
	 */
	mmc_cache.entry[cache_index].valid = 1;
	retval = cache_index;

	no_memory:
	//mutex_unlock(&cache_mutex);
	return retval;
}

/**
 * mmc_check_cachehit() - Checks to see what type of cache hit 
 * occured for a given entry. 
 *  
 * @sector_addr: Sector address location start of which will be 
 *               used to check for a cache hit or miss.
 * @num_sectors: number of sectors to write to starting with 
 *               sector_addr.
 *  
 * Returns 
 *      - 0: Exact cache hit (sector_addr + num_sectors).  In
 *           this case, new data can just be written over the
 *           old data. In the case for a read, data can be read
 *           from the entry.
 *      - 1: partial cache hit (sector_addr) or miss and the
 *           data is valid.  In this case, for simplicity, the
 *           entry is written to the device. For a read, this
 *           data would first have to be written to the device,
 *           then the read would be allowed to proceed to the
 *           device.
 *      - 2: valid is 0.  In this case, write to the cache.  If
 *           it's a read, go to the device to get the
 *           information.
 *	- 3: entry is valid but cache_addr and sector_addr
 *	     don't match; we have a cache collision.  Report it,
 *	     and code calling this function should flush this entry
 *	     before insertion.
 *      - EPERM: function got called without handset_cachesize
 *        parameter being appropriately set
 *      - ENXIO: Unexpected cache address case; we should never see this.
 *        The only valid cases should be 0,1,2,EPERM (called wo/
 *        handset_cachesize set to a positive integer).
 */
static int mmc_check_cachehit(sector_t sector_addr, unsigned int num_sectors)
{
	int retval = -EPERM;
	unsigned int index;

	if (handset_cachesize == 0)
		return retval;

	//mutex_lock(&cache_mutex);
	pr_debug("mmc: %s() cache_addr/sector_addr: %#llx\n",
		__func__, sector_addr);
	pr_debug("mmc: %s() num_sectors:               %d\n",
		__func__, num_sectors);
	index = mmc_index_cache(sector_addr);
	pr_debug("mmc: %s() index:                     %d\n",
		__func__, index);
	
	/* case 2- valid is 0.*/
	if (mmc_cache.entry[index].valid == 0)
		retval = 2;

	/* case 0- perfect match */
	else if ((mmc_cache.entry[index].valid == 1) &&
		 ((mmc_cache.entry[index].cache_addr == sector_addr) &&
		  (mmc_cache.entry[index].num_sectors == num_sectors)))
		retval = 0;

	/* case 1- cache_addr matched and it's a valid entry */
	else if ((mmc_cache.entry[index].valid == 1) &&
		 ((mmc_cache.entry[index].cache_addr == sector_addr) &&
		  (mmc_cache.entry[index].num_sectors != num_sectors)))
		retval = 1;

	/* 
	 * case 3- entry is valid but cache_addr and sector_addr
	 * don't match; we have a cache collision.  Report it,
	 * and code calling this function should flush this entry
	 * before insertion.
         */
	else if ((mmc_cache.entry[index].valid == 1) &&
		 (mmc_cache.entry[index].cache_addr != sector_addr))
		return 3;

	/* We should never hit here */
	else
		retval = -ENXIO;

	pr_debug("mmc: %s(): returning %d\n", __func__, retval);
	//mutex_unlock(&cache_mutex);
	return retval;
}

/**
 * mmc_destroy_cache() - deallocates the cache. 
 *  
 * Caveats: It is believed this should only be called 
 * on shutdown, when everything is being destroyed. 
 */
static void mmc_destroy_cache(void) 
{	
	unsigned int i;

	if (handset_cachesize == 0)
		return;

	//mutex_lock(&cache_mutex);
	for (i = 0; i < mmc_cachesize(); i++) {
		if (mmc_cache.entry[i].brq->data.sg != NULL) {
			kfree(mmc_cache.entry[i].brq->data.sg);
			mmc_cache.entry[i].brq->data.sg = NULL;
		}
		if (mmc_cache.entry[i].brq != NULL) {
			kfree(mmc_cache.entry[i].brq);
			mmc_cache.entry[i].brq = NULL;
		}
	}
	kfree(mmc_cache.entry);
	mmc_cache.entry = NULL;
	//mutex_unlock(&cache_mutex);
	return;
}

static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
{
	struct mmc_blk_data *md;

	mutex_lock(&open_lock);
	md = disk->private_data;
	if (md && md->usage == 0)
		md = NULL;
	if (md)
		md->usage++;
	mutex_unlock(&open_lock);

	return md;
}

static void mmc_blk_put(struct mmc_blk_data *md)
{
	mutex_lock(&open_lock);
	md->usage--;
	if (md->usage == 0) {
		int devmaj = MAJOR(disk_devt(md->disk));
		int devidx = MINOR(disk_devt(md->disk)) / perdev_minors;

		if (!devmaj)
			devidx = md->disk->first_minor / perdev_minors;

		blk_cleanup_queue(md->queue.queue);

		__clear_bit(devidx, dev_use);

		put_disk(md->disk);
		kfree(md);
	}
	mutex_unlock(&open_lock);
}

static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
{
	struct mmc_blk_data *md = mmc_blk_get(bdev->bd_disk);
	int ret = -ENXIO;

	mutex_lock(&block_mutex);
	if (md) {
		if (md->usage == 2)
			check_disk_change(bdev);
		ret = 0;

		if ((mode & FMODE_WRITE) && md->read_only) {
			mmc_blk_put(md);
			ret = -EROFS;
		}
	}
	mutex_unlock(&block_mutex);

	return ret;
}

static int mmc_blk_release(struct gendisk *disk, fmode_t mode)
{
	struct mmc_blk_data *md = disk->private_data;

	mutex_lock(&block_mutex);
	mmc_blk_put(md);
	mutex_unlock(&block_mutex);
	return 0;
}

static int
mmc_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
{
	geo->cylinders = get_capacity(bdev->bd_disk) / (4 * 16);
	geo->heads = 4;
	geo->sectors = 16;
	return 0;
}

static const struct block_device_operations mmc_bdops = {
	.open			= mmc_blk_open,
	.release		= mmc_blk_release,
	.getgeo			= mmc_blk_getgeo,
	.owner			= THIS_MODULE,
};

static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
{
	int err;
	u32 result;
	__be32 *blocks;

	struct mmc_request mrq;
	struct mmc_command cmd;
	struct mmc_data data;
	unsigned int timeout_us;

	struct scatterlist sg;

	memset(&cmd, 0, sizeof(struct mmc_command));

	cmd.opcode = MMC_APP_CMD;
	cmd.arg = card->rca << 16;
	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;

	err = mmc_wait_for_cmd(card->host, &cmd, 0);
	if (err)
		return (u32)-1;
	if (!mmc_host_is_spi(card->host) && !(cmd.resp[0] & R1_APP_CMD))
		return (u32)-1;

	memset(&cmd, 0, sizeof(struct mmc_command));

	cmd.opcode = SD_APP_SEND_NUM_WR_BLKS;
	cmd.arg = 0;
	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;

	memset(&data, 0, sizeof(struct mmc_data));

	data.timeout_ns = card->csd.tacc_ns * 100;
	data.timeout_clks = card->csd.tacc_clks * 100;

	timeout_us = data.timeout_ns / 1000;
	timeout_us += data.timeout_clks * 1000 /
		(card->host->ios.clock / 1000);

	if (timeout_us > 100000) {
		data.timeout_ns = 100000000;
		data.timeout_clks = 0;
	}

	data.blksz = 4;
	data.blocks = 1;
	data.flags = MMC_DATA_READ;
	data.sg = &sg;
	data.sg_len = 1;

	memset(&mrq, 0, sizeof(struct mmc_request));

	mrq.cmd = &cmd;
	mrq.data = &data;

	blocks = kmalloc(4, GFP_KERNEL);
	if (!blocks)
		return (u32)-1;

	sg_init_one(&sg, blocks, 4);

	mmc_wait_for_req(card->host, &mrq);

	result = ntohl(*blocks);
	kfree(blocks);

	if (cmd.error || data.error)
		result = (u32)-1;

	return result;
}

static u32 get_card_status(struct mmc_card *card, char *disk_name)
{
	struct mmc_command cmd;
	int err;

	memset(&cmd, 0, sizeof(struct mmc_command));
	cmd.opcode = MMC_SEND_STATUS;
	if (!mmc_host_is_spi(card->host))
		cmd.arg = card->rca << 16;
	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
	err = mmc_wait_for_cmd(card->host, &cmd, 0);
	if (err)
		printk(KERN_ERR "%s: error %d sending status comand",
		       disk_name, err);
	return cmd.resp[0];
}

static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
{
	struct mmc_blk_data *md = mq->data;
	struct mmc_card *card = md->queue.card;
	unsigned int from, nr, arg;
	int err = 0;

	mmc_claim_host(card->host);

	if (!mmc_can_erase(card)) {
		err = -EOPNOTSUPP;
		goto out;
	}

	from = blk_rq_pos(req);
	nr = blk_rq_sectors(req);

	if (mmc_can_trim(card))
		arg = MMC_TRIM_ARG;
	else
		arg = MMC_ERASE_ARG;

	/*
	 * Before issuing a user req, host driver should
	 * wait for the BKOPS is done or just use HPI to
	 * interrupt it.
	 */
	/* jpf: wasn't here in past recent versions, so must
	   not be that important to use Ubuntu to test
	err = mmc_wait_for_bkops(card);
	if (err)
		goto out;
	*/
	err = mmc_erase(card, from, nr, arg);
out:
	spin_lock_irq(&md->lock);
	__blk_end_request(req, err, blk_rq_bytes(req));
	spin_unlock_irq(&md->lock);

	mmc_release_host(card->host);

	return err ? 0 : 1;
}

static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
{
	struct mmc_blk_data *md = mq->data;
	struct mmc_card *card = md->queue.card;
	struct mmc_blk_request brq;
	int ret = 1, disable_multi = 0;

	mmc_claim_host(card->host);

	do {
		struct mmc_command cmd;
		u32 readcmd, writecmd, status = 0;

		memset(&brq, 0, sizeof(struct mmc_blk_request));
		brq.mrq.cmd = &brq.cmd;
		brq.mrq.data = &brq.data;

		brq.cmd.arg = blk_rq_pos(req);
		if (!mmc_card_blockaddr(card))
			brq.cmd.arg <<= 9;
		brq.cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
		brq.data.blksz = 512;
		brq.stop.opcode = MMC_STOP_TRANSMISSION;
		brq.stop.arg = 0;
		brq.stop.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
		brq.data.blocks = blk_rq_sectors(req);

		/*
		 * The block layer doesn't support all sector count
		 * restrictions, so we need to be prepared for too big
		 * requests.
		 */
		if (brq.data.blocks > card->host->max_blk_count)
			brq.data.blocks = card->host->max_blk_count;

		/*
		 * After a read error, we redo the request one sector at a time
		 * in order to accurately determine which sectors can be read
		 * successfully.
		 */
		if (disable_multi && brq.data.blocks > 1)
			brq.data.blocks = 1;

		if (brq.data.blocks > 1) {
			/* SPI multiblock writes terminate using a special
			 * token, not a STOP_TRANSMISSION request.
			 */
			if (!mmc_host_is_spi(card->host)
					|| rq_data_dir(req) == READ)
				brq.mrq.stop = &brq.stop;
			readcmd = MMC_READ_MULTIPLE_BLOCK;
			writecmd = MMC_WRITE_MULTIPLE_BLOCK;
		} else {
			brq.mrq.stop = NULL;
			readcmd = MMC_READ_SINGLE_BLOCK;
			writecmd = MMC_WRITE_BLOCK;
		}
		if (rq_data_dir(req) == READ) {
			brq.cmd.opcode = readcmd;
			brq.data.flags |= MMC_DATA_READ;
		} else {
			brq.cmd.opcode = writecmd;
			brq.data.flags |= MMC_DATA_WRITE;
		}

		mmc_set_data_timeout(&brq.data, card);

		brq.data.sg = mq->sg;
		brq.data.sg_len = mmc_queue_map_sg(mq);

		/*
		 * Adjust the sg list so it is the same size as the
		 * request.
		 */
		if (brq.data.blocks != blk_rq_sectors(req)) {
			int i, data_size = brq.data.blocks << 9;
			struct scatterlist *sg;

			for_each_sg(brq.data.sg, sg, brq.data.sg_len, i) {
				data_size -= sg->length;
				if (data_size <= 0) {
					sg->length += data_size;
					i++;
					break;
				}
			}
			brq.data.sg_len = i;
		}
		
		/* jpf: CACHE GOES HERE AND CALLS THE REST OF THE CODE
		 * ONLY IF ON A MISS, FLUSH, OR DEACTIVATION OF CACHE
		 */
		if (handset_cachesize > 0) {
			int cachehit_result = 0;
			int cache_index = mmc_index_cache(blk_rq_pos(req));

			cachehit_result = mmc_check_cachehit(
					  blk_rq_pos(req),
					  blk_rq_sectors(req));

			if ((brq.cmd.opcode == MMC_WRITE_BLOCK) ||
			    (brq.cmd.opcode == MMC_WRITE_MULTIPLE_BLOCK)) {

				if (brq.cmd.opcode == MMC_WRITE_BLOCK) {
					pr_debug("%s: single write block occuring",
						req->rq_disk->disk_name);
				}
				
				if ((cachehit_result == 0) ||
				    (cachehit_result == 2)) {
					
					/* I think if it's a cache hit I need to
					 * call __blk_end_request() to retire the
					 * old req entry before overwriting it
					 */
					if (cachehit_result == 0) {

					}
					cachehit_result = mmc_insert_cacheentry(
							  blk_rq_pos(req),
							  blk_rq_sectors(req),
							  &brq, req);
					// jpf: try2- retire all commands, per Shane
					spin_lock_irq(&md->lock);
					ret = __blk_end_request(req, 0,
								blk_rq_bytes(req));
					if (ret == 0) {
						pr_debug("%s: ret in __blk_end_request is 0\n", 
						__func__);
					}
					else {
						pr_debug("%s: ret in __blk_end_request is %d\n", 
						__func__, ret);
					}
					spin_unlock_irq(&md->lock);
					pr_debug("%s: cache entry filled: %d\n",
						req->rq_disk->disk_name,
						cachehit_result);
					pr_debug("===write: entry complete===");

				} else if ((cachehit_result == 1) || 
					   (cachehit_result == 3)) {
 
					pr_debug("%s: Partial/Collision write cache hit\n",
						req->rq_disk->disk_name);
					pr_debug("%s: mmc_check_cachehit(): %d\n",
						req->rq_disk->disk_name,
						cachehit_result);
					/* 
					 * CODE HERE TO SEND WRITE REQUEST 
					 * IN CACHE BEFORE CACHING PARTIAL HIT 
					 * OR COLLISION ENTRY. 
					 */
					/* jpf: hope this queue can be used, or :-( */
					mmc_queue_bounce_pre(&(md->queue));
										
					pr_crit("%s: call before write via cache\n", __func__);
					// jpf: 9/27/11: THIS CALL HERE SEEMS TO BE THE SMOKING GUN BETWEEN
					// eMMC IN ANDROID AND MMC IN LAPTOP.  NOT SURE WHY IT'S BROKEN WHEN
					// I USE MY mrq COPY ON AN ANDROID PLATFORM.
					mmc_wait_for_req(card->host,
					  &(mmc_cache.entry[cache_index].brq->mrq));
					  //&brq.mrq);
					pr_crit("%s: call after write via cache:\n", __func__);

					cachehit_result = mmc_insert_cacheentry(
							  blk_rq_pos(req),
							  blk_rq_sectors(req),
							  &brq, req);
					// jpf: try 2- retire request as soon as it's stored in cache, per Shane
					spin_lock_irq(&md->lock);
					ret = __blk_end_request(req, 0, brq.data.bytes_xfered);
					spin_unlock_irq(&md->lock);

					pr_debug("%s: cache entry filled: %d\n",
						req->rq_disk->disk_name,
						cachehit_result);
					pr_debug("===write: entry complete===");

				} else {
					pr_err("%s: mmc_check_cachehit() ",
						__func__);
					pr_err("returned unexpected value\n");
				}

			}
			else if ((brq.cmd.opcode == MMC_READ_SINGLE_BLOCK) ||
				 (brq.cmd.opcode == MMC_READ_MULTIPLE_BLOCK)) {

				/*
				 * Partial read hit would send the write 
				 * entry to the device before the read would 
				 * go to the device.  Perfect read hit 
				 * would go to the cache. Since this cache
				 * is for writes, we aren't going to do the
				 * more complicated thing and bring data
				 * to cache on a read miss.
				 */
				if (cachehit_result == 0) {
					pr_debug("%s: Perfect cache read hit",
						req->rq_disk->disk_name);
					pr_debug("cache stuff: %#llx | %d",
						(unsigned long long) 
						blk_rq_pos(req),
						blk_rq_sectors(req));

					/* "mmc_queue object"->queue */
					/* 
					 * jpf: 9/21/11
					 * Looks like there is one md, one queue
					 * per mmc 'slot' (area to stick mmc card)
					 * so i'm probably alright here.  Question is-
					 * how is the data from the cache getting to the
					 * read?? Not sure if this will work.
					 * From looking at mmc_queue_bounce_post(),
					 * data from a buffer gets copied to mmc_queue
					 * *mq's bounce_sg structure.  So the theory
					 * is, on host controller reads the data from
					 * the MMC card gets copied to a buffer, which
					 * then gets copied to mq->bounce_sg.  So all
					 * I need to do is just assign the cache entry
					 * hit's scatterlist to mq->bounce_sg.
					 * If this doen't work, then I'm defaulting
					 * to what I do with partial reads.
					 */
					mmc_queue_bounce_post(&(md->queue));
					spin_lock_irq(&md->lock);
					
					mmc_cache.entry[cache_index].brq->data.sg->dma_address =
						mq->bounce_sg->dma_address;
					#ifdef CONFIG_NEED_SG_DMA_LENGTH
					mmc_cache.entry[cache_index].brq->data.sg->dma_length =
						mq->bounce_sg->dma_length;
					#endif
					mmc_cache.entry[cache_index].brq->data.sg->length =
						mq->bounce_sg->length;
					mmc_cache.entry[cache_index].brq->data.sg->offset =
						mq->bounce_sg->offset;
					mmc_cache.entry[cache_index].brq->data.sg->page_link =
						mq->bounce_sg->page_link;
					mmc_cache.entry[cache_index].brq->data.sg_len =
						mq->bounce_sg_len;

					/* jpf: kind-of praying this works.  I do in fact
					   do not want to use what is in the cache
					   for __blk_end_request() though...I want to
					   retire the request passed into the function.
					*/
					 
					ret = __blk_end_request(req, 0,
								brq.data.bytes_xfered);
					spin_unlock_irq(&md->lock);
					pr_debug("===read: entry complete===");

				/* for now, we want to first write the entry to the
				   HW, then read from the HW
				 */
				} else if (cachehit_result == 1) {
					pr_debug("%s: Partial cache read hit",
						req->rq_disk->disk_name);
					pr_debug("cache stuff: %#llx | %d",
						(unsigned long long)
						blk_rq_pos(req),
						blk_rq_sectors(req));

					mmc_queue_bounce_pre(&(md->queue));
					mmc_wait_for_req(card->host,
					   &(mmc_cache.entry[cache_index].brq->mrq));
					mmc_queue_bounce_post(&(md->queue));
					mmc_cache.entry[cache_index].valid = 0;
					
					/* jpf: try and utilize what we got for the read in this
					   code so for now I'm not re-inventing the wheel
					 */
					goto normal_req_flow;

					pr_debug("===read: entry complete===");
				} else {
					pr_debug("=read: cache entry invalid=");
					goto normal_req_flow;
				}
			}
		} /* end handset_cachesize section */
		else {
			/*
			 * Based on looking at this code and from comments 
			 * in host.c, it is believed this module cannot 
			 * handle scatter-gather lists; therefore, this 
			 * call eventually does an operation in which it takes 
			 * a scatter-gather list and 'redoes it' as a 
			 * contiguous area of memory.  This is for writes ONLY.
			 */
			mmc_queue_bounce_pre(mq);
	
			/*
			 * Before issuing a user req, host driver should
			 * wait for the BKOPS is done or just use HPI to
			 * interrupt it.
			 */
	
			/* not here for Ubuntu 11.04 w/2.6.38 kernel either
			if (mmc_wait_for_bkops(card))
				goto cmd_err;
			*/
	
			/*
			 * Actual request being sent to the host 
			 * for writing/reading to the device. 
			 * This call waits for completion. 
			 */
			normal_req_flow: 
			mmc_wait_for_req(card->host, &brq.mrq);
	
			/*
			 * Since mmc_queue_bounce_pre() turns a scatter-gather 
			 * list and re-organizes it and writes it into a contiguous 
			 * memory for write operations, this does the opposite 
			 * for reads ONLY. 
			 */
			mmc_queue_bounce_post(mq);
	
			/*
			 * Check for errors here, but don't jump to cmd_err
			 * until later as we need to wait for the card to leave
			 * programming mode even when things go wrong.
			 */
			if (brq.cmd.error || brq.data.error || brq.stop.error) {
				if (brq.data.blocks > 1 && rq_data_dir(req) == READ) {
					/* Redo read one sector at a time */
					printk(KERN_WARNING "%s: retrying using single "
					       "block read\n", req->rq_disk->disk_name);
					disable_multi = 1;
					continue;
				}
				status = get_card_status(card, req->rq_disk->disk_name);
			} else if (disable_multi == 1) {
				disable_multi = 0;
			}
	
			if (brq.cmd.error) {
				printk(KERN_ERR "%s: error %d sending read/write "
				       "command, response %#x, card status %#x\n",
				       req->rq_disk->disk_name, brq.cmd.error,
				       brq.cmd.resp[0], status);
			}
	
			if (brq.data.error) {
				if (brq.data.error == -ETIMEDOUT && brq.mrq.stop)
					/* 'Stop' response contains card status */
					status = brq.mrq.stop->resp[0];
				printk(KERN_ERR "%s: error %d transferring data,"
				       " sector %u, nr %u, card status %#x\n",
				       req->rq_disk->disk_name, brq.data.error,
				       (unsigned)blk_rq_pos(req),
				       (unsigned)blk_rq_sectors(req), status);
			}
	
			if (brq.stop.error) {
				printk(KERN_ERR "%s: error %d sending stop command, "
				       "response %#x, card status %#x\n",
				       req->rq_disk->disk_name, brq.stop.error,
				       brq.stop.resp[0], status);
			}
	
			if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
				do {
					int err;
	
					cmd.opcode = MMC_SEND_STATUS;
					cmd.arg = card->rca << 16;
					cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
					err = mmc_wait_for_cmd(card->host, &cmd, 5);
					if (err) {
						printk(KERN_ERR "%s: error %d requesting status\n",
						       req->rq_disk->disk_name, err);
						goto cmd_err;
					}
					/*
					 * Some cards mishandle the status bits,
					 * so make sure to check both the busy
					 * indication and the card state.
					 */
				} while (!(cmd.resp[0] & R1_READY_FOR_DATA) ||
					(R1_CURRENT_STATE(cmd.resp[0]) == 7));
	
	#if 0
				if (cmd.resp[0] & ~0x00000900)
					printk(KERN_ERR "%s: status = %08x\n",
					       req->rq_disk->disk_name, cmd.resp[0]);
				if (mmc_decode_status(cmd.resp))
					goto cmd_err;
	#endif
			}
	
			if (brq.cmd.error || brq.stop.error || brq.data.error) {
				if (rq_data_dir(req) == READ) {
					/*
					 * After an error, we redo I/O one sector at a
					 * time, so we only reach here after trying to
					 * read a single sector.
					 */
					spin_lock_irq(&md->lock);
					ret = __blk_end_request(req, -EIO, brq.data.blksz);
					spin_unlock_irq(&md->lock);
					continue;
				}
				goto cmd_err;
			}
	
			/*
			 * Check if need to do bkops by each R1 response command
			 */
	
			/* jpf: not here for ubuntu 11.04 w/2.6.38 kernel 
			if (mmc_card_mmc(card) &&
					(brq.cmd.resp[0] & R1_URGENT_BKOPS))
				mmc_card_set_need_bkops(card);
			*/
	
			/*
			 * A block was successfully transferred.
			 */
			spin_lock_irq(&md->lock);
			ret = __blk_end_request(req, 0, brq.data.bytes_xfered);
			spin_unlock_irq(&md->lock);
		} /* jpf: else(handset_cachesize is 0) */
pr_debug("%s: inside while()\n", __func__);
	} while (ret);
pr_debug("%s: outside while()\n", __func__);
	mmc_release_host(card->host);

	return 1;

 cmd_err:
 	/*
 	 * If this is an SD card and we're writing, we can first
 	 * mark the known good sectors as ok.
 	 *
	 * If the card is not SD, we can still ok written sectors
	 * as reported by the controller (which might be less than
	 * the real number of written sectors, but never more).
	 */
	if (mmc_card_sd(card)) {
		u32 blocks;

		blocks = mmc_sd_num_wr_blocks(card);
		if (blocks != (u32)-1) {
			spin_lock_irq(&md->lock);
			ret = __blk_end_request(req, 0, blocks << 9);
			spin_unlock_irq(&md->lock);
		}
	} else {
		spin_lock_irq(&md->lock);
		ret = __blk_end_request(req, 0, brq.data.bytes_xfered);
		spin_unlock_irq(&md->lock);
	}

	mmc_release_host(card->host);

	spin_lock_irq(&md->lock);
	while (ret)
		ret = __blk_end_request(req, -EIO, blk_rq_cur_bytes(req));
	spin_unlock_irq(&md->lock);

	return 0;
}

static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
{
	if (req->cmd_flags & REQ_DISCARD) {
		return mmc_blk_issue_discard_rq(mq, req);
	} else {
		return mmc_blk_issue_rw_rq(mq, req);
	}
}

static inline int mmc_blk_readonly(struct mmc_card *card)
{
	return mmc_card_readonly(card) ||
	       !(card->csd.cmdclass & CCC_BLOCK_WRITE);
}

static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
{
	struct mmc_blk_data *md;
	int devidx, ret;

	devidx = find_first_zero_bit(dev_use, max_devices);
	if (devidx >= max_devices)
		return ERR_PTR(-ENOSPC);
	__set_bit(devidx, dev_use);

	md = kzalloc(sizeof(struct mmc_blk_data), GFP_KERNEL);
	if (!md) {
		ret = -ENOMEM;
		goto out;
	}


	/*
	 * Set the read-only status based on the supported commands
	 * and the write protect switch.
	 */
	md->read_only = mmc_blk_readonly(card);

	md->disk = alloc_disk(perdev_minors);
	if (md->disk == NULL) {
		ret = -ENOMEM;
		goto err_kfree;
	}

	spin_lock_init(&md->lock);
	md->usage = 1;

	ret = mmc_init_queue(&md->queue, card, &md->lock);
	if (ret)
		goto err_putdisk;

	md->queue.issue_fn = mmc_blk_issue_rq;
	md->queue.data = md;

	md->disk->major	= MMC_BLOCK_MAJOR;
	md->disk->first_minor = devidx * perdev_minors;
	md->disk->fops = &mmc_bdops;
	md->disk->private_data = md;
	md->disk->queue = md->queue.queue;
	md->disk->driverfs_dev = &card->dev;
	set_disk_ro(md->disk, md->read_only);

	/*
	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
	 *
	 * - be set for removable media with permanent block devices
	 * - be unset for removable block devices with permanent media
	 *
	 * Since MMC block devices clearly fall under the second
	 * case, we do not set GENHD_FL_REMOVABLE.  Userspace
	 * should use the block device creation/destruction hotplug
	 * messages to tell when the card is present.
	 */

	snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
		"mmcblk%d", devidx);

	blk_queue_logical_block_size(md->queue.queue, 512);

	if (!mmc_card_sd(card) && mmc_card_blockaddr(card)) {
		/*
		 * The EXT_CSD sector count is in number or 512 byte
		 * sectors.
		 */
		set_capacity(md->disk, card->ext_csd.sectors);
	} else {
		/*
		 * The CSD capacity field is in units of read_blkbits.
		 * set_capacity takes units of 512 bytes.
		 */
		set_capacity(md->disk,
			card->csd.capacity << (card->csd.read_blkbits - 9));
	}
	return md;

 err_putdisk:
	put_disk(md->disk);
 err_kfree:
	kfree(md);
 out:
	return ERR_PTR(ret);
}

static int
mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
{
	int err;

	mmc_claim_host(card->host);
	err = mmc_set_blocklen(card, 512);
	mmc_release_host(card->host);

	if (err) {
		printk(KERN_ERR "%s: unable to set block size to 512: %d\n",
			md->disk->disk_name, err);
		return -EINVAL;
	}

	return 0;
}

static int mmc_blk_probe(struct mmc_card *card)
{
	struct mmc_blk_data *md;
	int err;
	char cap_str[10];

	/*
	 * Check that the card supports the command class(es) we need.
	 */
	if (!(card->csd.cmdclass & CCC_BLOCK_READ))
		return -ENODEV;

	md = mmc_blk_alloc(card);
	if (IS_ERR(md))
		return PTR_ERR(md);

	err = mmc_blk_set_blksize(md, card);
	if (err)
		goto out;

	string_get_size((u64)get_capacity(md->disk) << 9, STRING_UNITS_2,
			cap_str, sizeof(cap_str));
	printk(KERN_INFO "%s: %s %s %s %s\n",
		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
		cap_str, md->read_only ? "(ro)" : "");

	mmc_set_drvdata(card, md);
	add_disk(md->disk);
	return 0;

 out:
	mmc_cleanup_queue(&md->queue);
	mmc_blk_put(md);

	return err;
}

static void mmc_blk_remove(struct mmc_card *card)
{
	struct mmc_blk_data *md = mmc_get_drvdata(card);

	if (md) {
		/* Stop new requests from getting into the queue */
		del_gendisk(md->disk);

		/* Then flush out any already in there */
		mmc_cleanup_queue(&md->queue);

		mmc_blk_put(md);
	}
	mmc_set_drvdata(card, NULL);
}

#ifdef CONFIG_PM
static int mmc_blk_suspend(struct mmc_card *card)
{
	struct mmc_blk_data *md = mmc_get_drvdata(card);

	if (md) {
		mmc_queue_suspend(&md->queue);
	}
	return 0;
}

static int mmc_blk_resume(struct mmc_card *card)
{
	struct mmc_blk_data *md = mmc_get_drvdata(card);

	if (md) {
		mmc_blk_set_blksize(md, card);
		mmc_queue_resume(&md->queue);
	}
	return 0;
}
#else
#define	mmc_blk_suspend	NULL
#define mmc_blk_resume	NULL
#endif

static struct mmc_driver mmc_driver = {
	.drv		= {
		.name	= "mmcblk",
	},
	.probe		= mmc_blk_probe,
	.remove		= mmc_blk_remove,
	.suspend	= mmc_blk_suspend,
	.resume		= mmc_blk_resume,
};

#if defined(CONFIG_DEBUG_FS)

struct mmc_cache_debugfs {
	struct dentry *cacherow;
	struct dentry *cache_addr;
	struct dentry *num_sectors;
	struct dentry *brq;
	struct dentry *valid;
	//struct debugfs_blob_wrapper nullflag;
};

static struct dentry *mmc_dentry_start = NULL;
static struct mmc_cache_debugfs *mmc_cache_debug = NULL;

#endif

static int __init mmc_blk_init(void)
{
	int res;
pr_debug("Jay's mmc_block driver init called\n");
	if (perdev_minors != CONFIG_MMC_BLOCK_MINORS)
		pr_debug("mmcblk: using %d minors per device\n", perdev_minors);

	max_devices = 256 / perdev_minors;

	res = register_blkdev(MMC_BLOCK_MAJOR, "mmc");
	if (res)
		goto out;

	res = mmc_register_driver(&mmc_driver);
	if (res)
		goto out2;

	/* 
	 * I think we really only want to have the mmc_cache called
	 * when no errors occur.
	 */
	if (handset_cachesize != 0) {
		res = mmc_create_cache();
		if (res != 0) {
			pr_err("mmcblk: error occured on creating cache: %d",
			       res);
			pr_err("mmcblk: cache will not be used.");
			handset_cachesize = 0;
		}
		
		#if defined(CONFIG_DEBUG_FS)
		mmc_cache_debug = kcalloc(mmc_cachesize(), 
					  sizeof *mmc_cache_debug, 
					  GFP_KERNEL);
		if ((mmc_cache_debug != NULL) && 
		    (mmc_dentry_start = debugfs_create_dir("mmc_cache", NULL))
		   ) {
			unsigned int i;
			for (i = 0; i < mmc_cachesize(); i++) {
				char cacherow[12];
				struct dentry *d;
				snprintf(cacherow, 12, "entry_%d", i);
				d = debugfs_create_dir(cacherow,
						       mmc_dentry_start);

				if (d != NULL) {
					mmc_cache_debug[i].cacherow = d;
					mmc_cache_debug[i].cache_addr =
					   debugfs_create_x64(
					   "cache_addr",
					   0444, d, 
					   &mmc_cache.entry[i].cache_addr);
					mmc_cache_debug[i].num_sectors =
					   debugfs_create_u32("num_sectors", 
					   0444, d, 
					   &mmc_cache.entry[i].num_sectors);
					/*
					I need to see brq actually changing,
					and using this method won't let me see
					it unless I add more debug code elsewhere,
					which I don't want to do.
					if (mmc_cache.entry[i].brq == NULL) {
						mmc_cache_debug[i].nullflag.data =
						"NULL\n";
						mmc_cache_debug[i].nullflag.size =
						5;
					} else {
						mmc_cache_debug[i].nullflag.data =
						"NOT_NULL\n";
						mmc_cache_debug[i].nullflag.size =
						9;
					}
					
					mmc_cache_debug[i].brq =
					   debugfs_create_blob("brq",
					   0444,d,
					   &mmc_cache_debug[i].nullflag);
					*/
					/* 
					 * jpf: Should be good enough; I just want
					 * to see brq change from 0 to !0.
					 * Since I'm targeting 32-bit archs, 
					 * an unsigned int * cast to see the pointer
					 * value should be fine...I hope...
					 */
					mmc_cache_debug[i].brq = d;
					mmc_cache_debug[i].brq =
					   debugfs_create_x32(
					   "brq",
					   0444, d, 
					   ((unsigned int *) &mmc_cache.entry[i].brq));
					/*
					 * This is read/write because allowing 
					 * the opportunity to write the valid 
					 * bit could provide good tests. 
					 */
					mmc_cache_debug[i].valid =
						debugfs_create_u8("valid",
						0666, d,
						&mmc_cache.entry[i].valid);

				} else { 
					pr_err("mmcblk: ");
					pr_err("debugfs_create_dir(%s) ",
					       cacherow);
					
					pr_err("failed to get created");
					pr_err("Returned error %ld\n", 
					       PTR_ERR(d));
				}
			}
		} else {
			pr_err("mmcblk: ");
			pr_err("debugfs_create_dir(mmc_cache) ");
			pr_err("failed to get created");
			pr_err("Returned error %ld\n", 
			       PTR_ERR(mmc_dentry_start));
		}
		#endif
	}
	pr_debug("%s mmc successful\n", __func__);
	return 0;
 out2:
	unregister_blkdev(MMC_BLOCK_MAJOR, "mmc");
 out:
	return res;
}

static void __exit mmc_blk_exit(void)
{
	mmc_unregister_driver(&mmc_driver);
	unregister_blkdev(MMC_BLOCK_MAJOR, "mmc");

	if (handset_cachesize != 0) {
		mmc_destroy_cache();
	}

	#if defined(CONFIG_DEBUG_FS)
	if (mmc_cache_debug != NULL) {
		if (!IS_ERR_OR_NULL(mmc_dentry_start)) {
			unsigned int i;
			for (i = 0; i < mmc_cachesize(); i++) {
				if (!IS_ERR_OR_NULL(
				     mmc_cache_debug[i].cacherow)) {
					if (!IS_ERR_OR_NULL(
						mmc_cache_debug[i].cache_addr))
						debugfs_remove(
						   mmc_cache_debug[i].cache_addr);
					if (!IS_ERR_OR_NULL(
						mmc_cache_debug[i].num_sectors))
						debugfs_remove(
						   mmc_cache_debug[i].num_sectors);
					if (!IS_ERR_OR_NULL(
						mmc_cache_debug[i].brq))
						debugfs_remove(
						   mmc_cache_debug[i].brq);
					if (!IS_ERR_OR_NULL(
						mmc_cache_debug[i].valid))
						debugfs_remove(
						   mmc_cache_debug[i].valid);
					debugfs_remove(
					    mmc_cache_debug[i].cacherow);
				}
			}
			debugfs_remove(mmc_dentry_start);
		}
		kfree(mmc_cache_debug);
	}
	#endif
}

module_init(mmc_blk_init);
module_exit(mmc_blk_exit);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");


--------------090807030902090308010800--
