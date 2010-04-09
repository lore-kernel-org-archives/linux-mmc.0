From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: How to make kernel block layer generate bigger request in the
 request queue?
Date: Fri, 9 Apr 2010 22:07:54 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731CAF351C@shsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46693 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917Ab0DIOHy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Apr 2010 10:07:54 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

I'm working on a block device driver (NAND flash driver with FTL layer) on 2.6.31 Kernel. And try to improve sequential read/write performance of the block driver.

When I debug the driver, I found that the sector numbers of every r/w request in the request queue is always not bigger than 8. That means, for every r/w request, it only handle 512 * 8 = 4KB bytes at most. And I think the sequential r/w speed can be improved if the Linux block layer generates bigger size data (for example, 64KB) for every request in the request queue.

To implement this, I have added some code as below (My hardware doesn't support scatter/gather, but can do 512KB DMA data transfer):
	...
	blk_queue_max_sectors(dev->queue, 1024);
	blk_queue_max_phys_segments(dev->queue, 128);
	blk_queue_max_hw_segments(dev->queue, 1);
	blk_queue_max_segment_size(dev->queue, 524288);
	...
And also set NOOP as the default IO Scheduler (because the underlying 'block' device is NAND flash, not a real hard disk).

But seems it doesn't work. The block layer still generate at most 8 sector r/w request in request queue even if I read/write 1GB data from/to the device with dd command.

Did I miss something to make the block layer generate bigger size data for every request in the request queue? 
Below is part of my source code. Any comments are highly appreciated. Thank you in advance.

-----------------------------------------------------------------------------------------------------
...

static int GLOB_SBD_majornum;
static struct spectra_nand_dev nand_device[NUM_DEVICES];
static struct mutex spectra_lock;
struct spectra_indentfy_dev_tag IdentifyDeviceData;

...

static void SBD_prepare_flush(struct request_queue *q, struct request *rq)
{
	rq->cmd_type = REQ_TYPE_LINUX_BLOCK;
	rq->cmd[0] = REQ_LB_OP_FLUSH;
}

/* Transfer a full request. */
static int do_transfer(struct spectra_nand_dev *tr, struct request *req)
{
	u64 start_addr, addr;
	u32 logical_start_sect, hd_start_sect;
	u32 nsect, hd_sects;
	u32 rsect, tsect = 0;
	char *buf;
	u32 ratio = IdentifyDeviceData.PageDataSize >> 9;

	start_addr = (u64)(blk_rq_pos(req)) << 9;

	if (req->cmd_type == REQ_TYPE_LINUX_BLOCK &&
			req->cmd[0] == REQ_LB_OP_FLUSH) {
		if (force_flush_cache()) /* Fail to flush cache */
			return -EIO;
		else
			return 0;
	}

	if (!blk_fs_request(req))
		return -EIO;

	if (blk_rq_pos(req) + blk_rq_cur_sectors(req) > get_capacity(tr->gd)) {
		printk(KERN_ERR "Error: request over the device "
			"capacity!sector %d, current_nr_sectors %d, "
			"while capacity is %d\n",
			(int)blk_rq_pos(req),
			blk_rq_cur_sectors(req),
			(int)get_capacity(tr->gd));
		return -EIO;
	}

	logical_start_sect = start_addr >> 9;
	hd_start_sect = logical_start_sect / ratio;
	rsect = logical_start_sect - hd_start_sect * ratio;

	addr = (u64)hd_start_sect * ratio * 512;
	buf = req->buffer;
	nsect = blk_rq_cur_sectors(req);

	switch (rq_data_dir(req)) {
	case READ:
		/* Call the low level function to read data from NAND device */
		...
		return 0;
	case WRITE:
		/* Call the low level function to write data to NAND device */
		...
		return 0;
	default:
		printk(KERN_NOTICE "Unknown request %u\n", rq_data_dir(req));
		return -EIO;
	}
}

/* This function is copied from drivers/mtd/mtd_blkdevs.c */
static int spectra_trans_thread(void *arg)
{
	struct spectra_nand_dev *tr = arg;
	struct request_queue *rq = tr->queue;
	struct request *req = NULL;

	/* we might get involved when memory gets low, so use PF_MEMALLOC */
	current->flags |= PF_MEMALLOC;

	spin_lock_irq(rq->queue_lock);
	while (!kthread_should_stop()) {
		int res;

		if (!req) {
			req = blk_fetch_request(rq);
			if (!req) {
				set_current_state(TASK_INTERRUPTIBLE);
				spin_unlock_irq(rq->queue_lock);
				schedule();
				spin_lock_irq(rq->queue_lock);
				continue;
			}
		}

		spin_unlock_irq(rq->queue_lock);

		mutex_lock(&spectra_lock);
		res = do_transfer(tr, req);
		mutex_unlock(&spectra_lock);

		spin_lock_irq(rq->queue_lock);

		if (!__blk_end_request_cur(req, res))
			req = NULL;
	}

	if (req)
		__blk_end_request_all(req, -EIO);

	spin_unlock_irq(rq->queue_lock);

	return 0;
}

static void GLOB_SBD_request(struct request_queue *rq)
{
	struct spectra_nand_dev *pdev = rq->queuedata;
	wake_up_process(pdev->thread);
}

static struct block_device_operations GLOB_SBD_ops = {
	.owner = THIS_MODULE,
	.open = GLOB_SBD_open,
	.release = GLOB_SBD_release,
	.locked_ioctl = GLOB_SBD_ioctl,
	.getgeo = GLOB_SBD_getgeo,
};

static int SBD_setup_device(struct spectra_nand_dev *dev, int which)
{
	u32 sects;

	memset(dev, 0, sizeof(struct spectra_nand_dev));
	dev->size = (u64)IdentifyDeviceData.PageDataSize * IdentifyDeviceData.PagesPerBlock * IdentifyDeviceData.wDataBlockNum;
	spin_lock_init(&dev->qlock);

	dev->tmp_buf = kmalloc(IdentifyDeviceData.PageDataSize, GFP_ATOMIC);
	if (!dev->tmp_buf) {
		printk(KERN_ERR "Failed to kmalloc memory in %s Line %d, exit.\n",
			__FILE__, __LINE__);
		goto out_vfree;
	}

	dev->queue = blk_init_queue(GLOB_SBD_request, &dev->qlock);
	if (dev->queue == NULL) {
		printk(KERN_ERR
		       "Spectra: Request queue could not be initialized. Aborting\n ");
		goto out_vfree;
	}
	dev->queue->queuedata = dev;

	/* As Linux block layer doens't support >4KB hardware sector,  */
	/* Here we force report 512 byte hardware sector size to Kernel */
	blk_queue_logical_block_size(dev->queue, 512);

	blk_queue_ordered(dev->queue, QUEUE_ORDERED_DRAIN_FLUSH, SBD_prepare_flush);

	/* Set paratmeters to optimize sequential r/w performance */
	blk_queue_max_sectors(dev->queue, 1024);
	blk_queue_max_phys_segments(dev->queue, 128);
	blk_queue_max_hw_segments(dev->queue, 1);
	blk_queue_max_segment_size(dev->queue, 524288);

	dev->thread = kthread_run(spectra_trans_thread, dev, "nand_thd");
	if (IS_ERR(dev->thread)) {
		blk_cleanup_queue(dev->queue);
		unregister_blkdev(GLOB_SBD_majornum, GLOB_SBD_NAME);
		return PTR_ERR(dev->thread);
	}

	dev->gd = alloc_disk(PARTITIONS);
	if (!dev->gd) {
		printk(KERN_ERR
		       "Spectra: Could not allocate disk. Aborting \n ");
		goto out_vfree;
	}
	dev->gd->major = GLOB_SBD_majornum;
	dev->gd->first_minor = which * PARTITIONS;
	dev->gd->fops = &GLOB_SBD_ops;
	dev->gd->queue = dev->queue;
	dev->gd->private_data = dev;
	snprintf(dev->gd->disk_name, 32, "%s%c", GLOB_SBD_NAME, which + 'a');

	sects = dev->size >> 9;
	nand_dbg_print(NAND_DBG_WARN, "Capacity sects: %d\n", sects);
	set_capacity(dev->gd, sects);

	add_disk(dev->gd);

	return 0;
out_vfree:
	return -ENOMEM;
}

static int GLOB_SBD_init(void)
{
	int i, ret;

	mutex_init(&spectra_lock);

	GLOB_SBD_majornum = register_blkdev(0, GLOB_SBD_NAME);
	if (GLOB_SBD_majornum <= 0) {
		printk(KERN_ERR "Unable to get the major %d for Spectra",
		       GLOB_SBD_majornum);
		return -EBUSY;
	}

	if (PASS != GLOB_FTL_Flash_Init()) {
		printk(KERN_ERR "Spectra: Unable to Initialize Flash Device. "
		       "Aborting\n");
		goto out_flash_register;
	}

	if (PASS != GLOB_FTL_IdentifyDevice(&IdentifyDeviceData)) {
		printk(KERN_ERR "Spectra: Unable to Read Flash Device. "
		       "Aborting\n");
		goto out_flash_register;
	}

	if (GLOB_FTL_Init() != PASS) {
		printk(KERN_ERR "Spectra: Unable to Initialize FTL Layer. "
		       "Aborting\n");
		goto out_ftl_flash_register;
	}

	for (i = 0; i < NUM_DEVICES; i++)
		if (SBD_setup_device(&nand_device[i], i) == -ENOMEM)
			goto out_ftl_flash_register;

	return 0;

out_ftl_flash_register:
	GLOB_FTL_Cache_Release();
out_flash_register:
	GLOB_FTL_Flash_Release();
	unregister_blkdev(GLOB_SBD_majornum, GLOB_SBD_NAME);

	return -ENOMEM;
}

static void __exit GLOB_SBD_exit(void)
{
	...
}

module_init(GLOB_SBD_init);
module_exit(GLOB_SBD_exit);
