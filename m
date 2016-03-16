From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: Add CONFIG_MMC_SIMULATE_MAX_SPEED
Date: Wed, 16 Mar 2016 14:03:21 +0100
Message-ID: <CAPDyKFp99i6zOnhLYmnK4mKdx5HRV+RxXKJBHVi9dzp-A10Fsg@mail.gmail.com>
References: <1456161565-24154-1-git-send-email-salyzyn@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1456161565-24154-1-git-send-email-salyzyn@android.com>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Adrian Hunter <adrian.hunter@intel.com>, Yangbo Lu <yangbo.lu@freescale.com>, Tomas Winkler <tomas.winkler@intel.com>, Andrew Morton <akpm@linux-foundation.org>, James Bottomley <JBottomley@odin.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Grant Grundler <grundler@chromium.org>, Jon Hunter <jonathanh@nvidia.com>, Luca Porzio <lporzio@micron.com>, Yunpeng Gao <yunpeng.gao@intel.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 22 February 2016 at 18:18, Mark Salyzyn <salyzyn@android.com> wrote:
> When CONFIG_MMC_SIMULATE_MAX_SPEED is enabled, Expose max_read_speed,
> max_write_speed and cache_size sysfs controls to simulate a slow
> eMMC device. The boot default values, should one wish to set this
> behavior right from kernel start:
>
> CONFIG_MMC_SIMULATE_MAX_READ_SPEED
> CONFIG_MMC_SIMULATE_MAX_WRITE_SPEED
> CONFIG_MMC_SIMULATE_CACHE_SIZE
>
> respectively; and if not defined are 0 (off), 0 (off) and 4 MB
> also respectively.

So this changelog doesn't really tell me *why* this feature is nice to
have. Could you elaborate on this and thus also extend the information
in the changelog please.

Moreover, I have briefly reviewed the code, but I don't want to go
into the details yet... Instead, what I am trying to understand if
this is something that useful+specific for the MMC subsystem, or if
it's something that belongs in the upper generic BLOCK layer. Perhaps
you can comment on this as well?

Kind regards
Uffe

>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> ---
> changes in v2: change from CONFIG_MMC_BLOCK_MAX_SPEED to
> CONFIG_MMC_SIMULATE_MAX_SPEED. Add documentation.
>
>  Documentation/block/00-INDEX          |   6 +
>  Documentation/block/mmc-max-speed.txt |  39 +++++
>  drivers/mmc/card/Kconfig              |  57 +++++++
>  drivers/mmc/card/block.c              | 294 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/card/queue.h              |   8 +
>  5 files changed, 404 insertions(+)
>  create mode 100644 Documentation/block/mmc-max-speed.txt
>
> diff --git a/Documentation/block/00-INDEX b/Documentation/block/00-INDEX
> index e840b47..bc51487 100644
> --- a/Documentation/block/00-INDEX
> +++ b/Documentation/block/00-INDEX
> @@ -26,3 +26,9 @@ switching-sched.txt
>         - Switching I/O schedulers at runtime
>  writeback_cache_control.txt
>         - Control of volatile write back caches
> +mmc-max-speed.txt
> +       - eMMC layer speed simulation, related to /sys/block/mmcblk*/
> +          attributes:
> +            max_read_speed
> +            max_write_speed
> +            cache_size
> diff --git a/Documentation/block/mmc-max-speed.txt b/Documentation/block/mmc-max-speed.txt
> new file mode 100644
> index 0000000..3ad1260
> --- /dev/null
> +++ b/Documentation/block/mmc-max-speed.txt
> @@ -0,0 +1,39 @@
> +eMMC Block layer simulation speed controls in /sys/block/mmcblk*/
> +===============================================
> +
> +Turned on with CONFIG_MMC_SIMULATE_MAX_SPEED which enables MMC device speed
> +limiting. Used to test and simulate the behavior of the system when
> +confronted with a slow MMC.
> +
> +Enables max_read_speed, max_write_speed and cache_size attributes to control
> +the write or read maximum KB/second speed behaviors. The defaults are set
> +by CONFIG_MMC_SIMULATE_MAX_READ_SPEED, CONFIG_MMC_SIMULATE_MAX_WRITE_SPEED and
> +CONFIG_MMC_SIMULATE_CACHE_SIZE config parameters respectively.
> +
> +NB: There is room for improving the algorithm for aspects tied directly to
> +eMMC specific behavior. For instance, wear leveling and stalls from an
> +exhausted erase pool. We would expect that if there was a need to provide
> +similar speed simulation controls to other types of block devices, aspects of
> +their behavior are modelled separately (e.g. head seek times, heat assist,
> +shingling and rotational latency).
> +
> +/sys/block/mmcblk0/max_read_speed:
> +
> +Number of KB/second reads allowed to the block device. Used to test and
> +simulate the behavior of the system when confronted with a slow reading MMC.
> +Set to 0 or "off" to place no speed limit.
> +
> +/sys/block/mmcblk0/max_write_speed:
> +
> +Number of KB/second writes allowed to the block device. Used to test and
> +simulate the behavior of the system when confronted with a slow writing MMC.
> +Set to 0 or "off" to place no speed limit.
> +
> +/sys/block/mmcblk0/cache_size:
> +
> +Number of MB of high speed memory or high speed SLC cache expected on the
> +eMMC device being simulated. Used to help simulate the write-back behavior
> +more accurately. The assumption is the cache has no delay, but draws down
> +in the background to the MLC/TLC primary store at the max_write_speed rate.
> +Any write speed delays will show up when the cache is full, or when an I/O
> +request to flush is issued.
> diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
> index 5562308..1abef59 100644
> --- a/drivers/mmc/card/Kconfig
> +++ b/drivers/mmc/card/Kconfig
> @@ -68,3 +68,60 @@ config MMC_TEST
>
>           This driver is only of interest to those developing or
>           testing a host driver. Most people should say N here.
> +
> +config MMC_SIMULATE_MAX_SPEED
> +       bool "Turn on maximum speed control per block device"
> +       depends on MMC_BLOCK
> +       help
> +         Say Y here to enable MMC device speed limiting. Used to test and
> +         simulate the behavior of the system when confronted with a slow MMC.
> +
> +         Enables max_read_speed, max_write_speed and cache_size attributes to
> +         control the write or read maximum KB/second speed behaviors.
> +
> +         If unsure, say N here.
> +
> +config MMC_SIMULATE_MAX_READ_SPEED
> +       int "KB/second read speed limit per block device"
> +       depends on MMC_BLOCK
> +       depends on MMC_SIMULATE_MAX_SPEED
> +       default 0
> +       help
> +         Number of KB/second reads allowed to the block device. Used to
> +         test and simulate the behavior of the system when confronted with
> +         a slow MMC. Set this value if it is required that the simulation
> +         starts at boot time.
> +
> +         Value can be overridden at runtime with the max_read_speed attribute.
> +
> +         If unsure, say 0 here (no speed limit)
> +
> +config MMC_SIMULATE_MAX_WRITE_SPEED
> +       int "KB/second write speed limit per block device"
> +       depends on MMC_BLOCK
> +       depends on MMC_SIMULATE_MAX_SPEED
> +       default 0
> +       help
> +         Number of KB/second writes allowed to the block device. Used to
> +         test and simulate the behavior of the system when confronted with
> +         a slow MMC. Set this value if it is required that the simulation
> +         starts at boot time.
> +
> +         Value can be overridden at runtime with the max_write_speed attribute.
> +
> +         If unsure, say 0 here (no speed limit)
> +
> +config MMC_SIMULATE_MAX_SPEED_CACHE_SIZE
> +       int "MB of memory or SLC cache"
> +       depends on MMC_BLOCK
> +       depends on MMC_SIMULATE_MAX_SPEED
> +       default 4
> +       help
> +         Number of MB of high speed memory or SLC cache expected on the
> +         eMMC device. Used to help simulate the write-back behavior more
> +         accurately. Set this value if it is required that the simulation
> +         starts at boot time.
> +
> +         Value can be overridden at runtime with the cache_size attribute.
> +
> +         If unsure, say 4 here
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index fe207e5..7642673 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -286,6 +286,241 @@ out:
>         return ret;
>  }
>
> +#ifdef CONFIG_MMC_SIMULATE_MAX_SPEED
> +
> +/*
> + * helper macros and expectations:
> + *  size    - unsigned long number of bytes
> + *  jiffies - unsigned long HZ timestamp difference
> + *  speed   - unsigned KB/s transfer rate
> + */
> +#define size_and_speed_to_jiffies(size, speed) \
> +               ((size) * HZ / (speed) / 1024UL)
> +#define jiffies_and_speed_to_size(jiffies, speed) \
> +               (((speed) * (jiffies) * 1024UL) / HZ)
> +#define jiffies_and_size_to_speed(jiffies, size) \
> +               ((size) * HZ / (jiffies) / 1024UL)
> +
> +/* Limits to report warning */
> +/* jiffies_and_size_to_speed(10*HZ, queue_max_hw_sectors(q) * 512UL) ~ 25 */
> +#define MIN_SPEED(q) 250 /* 10 times faster than a floppy disk */
> +#define MAX_SPEED(q) jiffies_and_size_to_speed(1, queue_max_sectors(q) * 512UL)
> +
> +#define speed_valid(speed) ((speed) > 0)
> +
> +static const char off[] = "off\n";
> +
> +static int max_speed_show(int speed, char *buf)
> +{
> +       if (speed)
> +               return scnprintf(buf, PAGE_SIZE, "%uKB/s\n", speed);
> +       else
> +               return scnprintf(buf, PAGE_SIZE, off);
> +}
> +
> +static int max_speed_store(const char *buf, struct request_queue *q)
> +{
> +       unsigned int limit, set = 0;
> +
> +       if (!strncasecmp(off, buf, sizeof(off) - 2))
> +               return set;
> +       if (kstrtouint(buf, 0, &set) || (set > INT_MAX))
> +               return -EINVAL;
> +       if (set == 0)
> +               return set;
> +       limit = MAX_SPEED(q);
> +       if (set > limit)
> +               pr_warn("max speed %u ineffective above %u\n", set, limit);
> +       limit = MIN_SPEED(q);
> +       if (set < limit)
> +               pr_warn("max speed %u painful below %u\n", set, limit);
> +       return set;
> +}
> +
> +static ssize_t max_write_speed_show(struct device *dev,
> +                                struct device_attribute *attr, char *buf)
> +{
> +       struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
> +       int ret = max_speed_show(atomic_read(&md->queue.max_write_speed), buf);
> +
> +       mmc_blk_put(md);
> +       return ret;
> +}
> +
> +static ssize_t max_write_speed_store(struct device *dev,
> +                                 struct device_attribute *attr,
> +                                 const char *buf, size_t count)
> +{
> +       struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
> +       int set = max_speed_store(buf, md->queue.queue);
> +
> +       if (set < 0) {
> +               mmc_blk_put(md);
> +               return set;
> +       }
> +
> +       atomic_set(&md->queue.max_write_speed, set);
> +       mmc_blk_put(md);
> +       return count;
> +}
> +
> +static const DEVICE_ATTR(max_write_speed, S_IRUGO | S_IWUSR,
> +       max_write_speed_show, max_write_speed_store);
> +
> +static ssize_t max_read_speed_show(struct device *dev,
> +                                struct device_attribute *attr, char *buf)
> +{
> +       struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
> +       int ret = max_speed_show(atomic_read(&md->queue.max_read_speed), buf);
> +
> +       mmc_blk_put(md);
> +       return ret;
> +}
> +
> +static ssize_t max_read_speed_store(struct device *dev,
> +                                 struct device_attribute *attr,
> +                                 const char *buf, size_t count)
> +{
> +       struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
> +       int set = max_speed_store(buf, md->queue.queue);
> +
> +       if (set < 0) {
> +               mmc_blk_put(md);
> +               return set;
> +       }
> +
> +       atomic_set(&md->queue.max_read_speed, set);
> +       mmc_blk_put(md);
> +       return count;
> +}
> +
> +static const DEVICE_ATTR(max_read_speed, S_IRUGO | S_IWUSR,
> +       max_read_speed_show, max_read_speed_store);
> +
> +static ssize_t cache_size_show(struct device *dev,
> +                              struct device_attribute *attr, char *buf)
> +{
> +       struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
> +       struct mmc_queue *mq = &md->queue;
> +       int cache_size = atomic_read(&mq->cache_size);
> +       int ret;
> +
> +       if (!cache_size)
> +               ret = scnprintf(buf, PAGE_SIZE, off);
> +       else {
> +               int speed = atomic_read(&mq->max_write_speed);
> +
> +               if (!speed_valid(speed))
> +                       ret = scnprintf(buf, PAGE_SIZE, "%uMB\n", cache_size);
> +               else { /* We accept race between cache_jiffies and cache_used */
> +                       unsigned long size = jiffies_and_speed_to_size(
> +                               jiffies - mq->cache_jiffies, speed);
> +                       long used = atomic_long_read(&mq->cache_used);
> +
> +                       if (size >= used)
> +                               size = 0;
> +                       else
> +                               size = (used - size) * 100 / cache_size
> +                                       / 1024UL / 1024UL;
> +
> +                       ret = scnprintf(buf, PAGE_SIZE, "%uMB %lu%% used\n",
> +                               cache_size, size);
> +               }
> +       }
> +
> +       mmc_blk_put(md);
> +       return ret;
> +}
> +
> +static ssize_t cache_size_store(struct device *dev,
> +                                 struct device_attribute *attr,
> +                                 const char *buf, size_t count)
> +{
> +       struct mmc_blk_data *md;
> +       unsigned int set = 0;
> +
> +       if (strncasecmp(off, buf, sizeof(off) - 2)
> +        && (kstrtouint(buf, 0, &set) || (set > INT_MAX)))
> +               return -EINVAL;
> +
> +       md = mmc_blk_get(dev_to_disk(dev));
> +       atomic_set(&md->queue.cache_size, set);
> +       mmc_blk_put(md);
> +       return count;
> +}
> +
> +static const DEVICE_ATTR(cache_size, S_IRUGO | S_IWUSR,
> +       cache_size_show, cache_size_store);
> +
> +/* correct for write-back */
> +static long mmc_blk_cache_used(struct mmc_queue *mq, unsigned long waitfor)
> +{
> +       long used = 0;
> +       int speed = atomic_read(&mq->max_write_speed);
> +
> +       if (speed_valid(speed)) {
> +               unsigned long size = jiffies_and_speed_to_size(
> +                                       waitfor - mq->cache_jiffies, speed);
> +               used = atomic_long_read(&mq->cache_used);
> +
> +               if (size >= used)
> +                       used = 0;
> +               else
> +                       used -= size;
> +       }
> +
> +       atomic_long_set(&mq->cache_used, used);
> +       mq->cache_jiffies = waitfor;
> +
> +       return used;
> +}
> +
> +static void mmc_blk_simulate_delay(
> +       struct mmc_queue *mq,
> +       struct request *req,
> +       unsigned long waitfor)
> +{
> +       int max_speed;
> +
> +       if (!req)
> +               return;
> +
> +       max_speed = (rq_data_dir(req) == READ)
> +               ? atomic_read(&mq->max_read_speed)
> +               : atomic_read(&mq->max_write_speed);
> +       if (speed_valid(max_speed)) {
> +               unsigned long bytes = blk_rq_bytes(req);
> +
> +               if (rq_data_dir(req) != READ) {
> +                       int cache_size = atomic_read(&mq->cache_size);
> +
> +                       if (cache_size) {
> +                               unsigned long size = cache_size * 1024L * 1024L;
> +                               long used = mmc_blk_cache_used(mq, waitfor);
> +
> +                               used += bytes;
> +                               atomic_long_set(&mq->cache_used, used);
> +                               bytes = 0;
> +                               if (used > size)
> +                                       bytes = used - size;
> +                       }
> +               }
> +               waitfor += size_and_speed_to_jiffies(bytes, max_speed);
> +               if (time_is_after_jiffies(waitfor)) {
> +                       long msecs = jiffies_to_msecs(waitfor - jiffies);
> +
> +                       if (likely(msecs > 0))
> +                               msleep(msecs);
> +               }
> +       }
> +}
> +
> +#else
> +
> +#define mmc_blk_simulate_delay(mq, req, waitfor)
> +
> +#endif
> +
>  static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
>  {
>         struct mmc_blk_data *md = mmc_blk_get(bdev->bd_disk);
> @@ -1250,6 +1485,23 @@ static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
>         if (ret)
>                 ret = -EIO;
>
> +#ifdef CONFIG_MMC_SIMULATE_MAX_SPEED
> +       else if (atomic_read(&mq->cache_size)) {
> +               long used = mmc_blk_cache_used(mq, jiffies);
> +
> +               if (used) {
> +                       int speed = atomic_read(&mq->max_write_speed);
> +
> +                       if (speed_valid(speed)) {
> +                               unsigned long msecs = jiffies_to_msecs(
> +                                       size_and_speed_to_jiffies(
> +                                               used, speed));
> +                               if (msecs)
> +                                       msleep(msecs);
> +                       }
> +               }
> +       }
> +#endif
>         blk_end_request_all(req, ret);
>
>         return ret ? 0 : 1;
> @@ -1929,6 +2181,9 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>         struct mmc_async_req *areq;
>         const u8 packed_nr = 2;
>         u8 reqs = 0;
> +#ifdef CONFIG_MMC_SIMULATE_MAX_SPEED
> +       unsigned long waitfor = jiffies;
> +#endif
>
>         if (!rqc && !mq->mqrq_prev->req)
>                 return 0;
> @@ -1979,6 +2234,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>                          */
>                         mmc_blk_reset_success(md, type);
>
> +                       mmc_blk_simulate_delay(mq, rqc, waitfor);
> +
>                         if (mmc_packed_cmd(mq_rq->cmd_type)) {
>                                 ret = mmc_blk_end_packed_req(mq_rq);
>                                 break;
> @@ -2397,6 +2654,14 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
>                                         card->ext_csd.boot_ro_lockable)
>                                 device_remove_file(disk_to_dev(md->disk),
>                                         &md->power_ro_lock);
> +#ifdef CONFIG_MMC_SIMULATE_MAX_SPEED
> +                       device_remove_file(disk_to_dev(md->disk),
> +                                               &dev_attr_max_write_speed);
> +                       device_remove_file(disk_to_dev(md->disk),
> +                                               &dev_attr_max_read_speed);
> +                       device_remove_file(disk_to_dev(md->disk),
> +                                               &dev_attr_cache_size);
> +#endif
>
>                         del_gendisk(md->disk);
>                 }
> @@ -2432,6 +2697,27 @@ static int mmc_add_disk(struct mmc_blk_data *md)
>         ret = device_create_file(disk_to_dev(md->disk), &md->force_ro);
>         if (ret)
>                 goto force_ro_fail;
> +#ifdef CONFIG_MMC_SIMULATE_MAX_SPEED
> +       atomic_set(&md->queue.max_write_speed,
> +                       CONFIG_MMC_SIMULATE_MAX_WRITE_SPEED);
> +       ret = device_create_file(disk_to_dev(md->disk),
> +                       &dev_attr_max_write_speed);
> +       if (ret)
> +               goto max_write_speed_fail;
> +       atomic_set(&md->queue.max_read_speed,
> +                       CONFIG_MMC_SIMULATE_MAX_READ_SPEED);
> +       ret = device_create_file(disk_to_dev(md->disk),
> +                       &dev_attr_max_read_speed);
> +       if (ret)
> +               goto max_read_speed_fail;
> +       atomic_set(&md->queue.cache_size,
> +                       CONFIG_MMC_SIMULATE_MAX_SPEED_CACHE_SIZE);
> +       atomic_long_set(&md->queue.cache_used, 0);
> +       md->queue.cache_jiffies = jiffies;
> +       ret = device_create_file(disk_to_dev(md->disk), &dev_attr_cache_size);
> +       if (ret)
> +               goto cache_size_fail;
> +#endif
>
>         if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
>              card->ext_csd.boot_ro_lockable) {
> @@ -2456,6 +2742,14 @@ static int mmc_add_disk(struct mmc_blk_data *md)
>         return ret;
>
>  power_ro_lock_fail:
> +#ifdef CONFIG_MMC_SIMULATE_MAX_SPEED
> +       device_remove_file(disk_to_dev(md->disk), &dev_attr_cache_size);
> +cache_size_fail:
> +       device_remove_file(disk_to_dev(md->disk), &dev_attr_max_read_speed);
> +max_read_speed_fail:
> +       device_remove_file(disk_to_dev(md->disk), &dev_attr_max_write_speed);
> +max_write_speed_fail:
> +#endif
>         device_remove_file(disk_to_dev(md->disk), &md->force_ro);
>  force_ro_fail:
>         del_gendisk(md->disk);
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index 36cddab..d890d88 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -58,6 +58,14 @@ struct mmc_queue {
>         struct mmc_queue_req    mqrq[2];
>         struct mmc_queue_req    *mqrq_cur;
>         struct mmc_queue_req    *mqrq_prev;
> +#ifdef CONFIG_MMC_SIMULATE_MAX_SPEED
> +       atomic_t max_write_speed;
> +       atomic_t max_read_speed;
> +       atomic_t cache_size;
> +       /* i/o tracking */
> +       atomic_long_t cache_used;
> +       unsigned long cache_jiffies;
> +#endif
>  };
>
>  extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
> --
> 2.7.0.rc3.207.g0ac5344
>
