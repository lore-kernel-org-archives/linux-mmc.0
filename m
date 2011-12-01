From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: boot partition ro lock support
Date: Thu, 01 Dec 2011 14:02:04 -0500
Message-ID: <87k46gjetv.fsf@laptop.org>
References: <1321964155-8275-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47675 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755830Ab1LATCC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Dec 2011 14:02:02 -0500
In-Reply-To: <1321964155-8275-1-git-send-email-johan.rudholm@stericsson.com>
	(Johan Rudholm's message of "Tue, 22 Nov 2011 13:15:55 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, John Beckett <john.beckett@stericsson.com>

Hi Johan,

On Tue, Nov 22 2011, Johan Rudholm wrote:
> Enable boot partitions to be read-only locked until next power on via
> a sysfs entry. There will be one sysfs entry for each boot partition:
>
> /sys/block/mmcblkXbootY/ro_lock_until_next_power_on
>
> Both boot partitions are locked by writing 1 to one of the files.
>
> Signed-off-by: John Beckett <john.beckett@stericsson.com>
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> ---
>  Documentation/mmc/mmc-dev-parts.txt |   13 ++++
>  drivers/mmc/card/block.c            |  126 ++++++++++++++++++++++++++++++++--
>  drivers/mmc/core/mmc.c              |   14 +++-
>  include/linux/mmc/card.h            |   10 +++-
>  include/linux/mmc/mmc.h             |    6 ++
>  5 files changed, 158 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/mmc/mmc-dev-parts.txt b/Documentation/mmc/mmc-dev-parts.txt
> index 2db28b8..f08d078 100644
> --- a/Documentation/mmc/mmc-dev-parts.txt
> +++ b/Documentation/mmc/mmc-dev-parts.txt
> @@ -25,3 +25,16 @@ echo 0 > /sys/block/mmcblkXbootY/force_ro
>  To re-enable read-only access:
>  
>  echo 1 > /sys/block/mmcblkXbootY/force_ro
> +
> +The boot partitions can also be locked read only until the next power on,
> +with:
> +
> +echo 1 > /sys/block/mmcblkXbootY/ro_lock_until_next_power_on
> +
> +This is a feature of the card and not of the kernel. If the card does
> +not support boot partition locking, the file will not exist. If the
> +feature has been disabled on the card, the file will be read-only.
> +
> +The boot partitions can also be locked permanently, but this feature is
> +not accessible through sysfs in order to avoid accidental or malicious
> +bricking.
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index e0acf2a..2d318b7 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -107,6 +107,8 @@ struct mmc_blk_data {
>  	 */
>  	unsigned int	part_curr;
>  	struct device_attribute force_ro;
> +	struct device_attribute power_ro_lock;
> +	int	area_type;
>  };
>  
>  static DEFINE_MUTEX(open_lock);
> @@ -165,6 +167,74 @@ static void mmc_blk_put(struct mmc_blk_data *md)
>  	mutex_unlock(&open_lock);
>  }
>  
> +static ssize_t power_ro_lock_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	int ret;
> +	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
> +	struct mmc_card *card = md->queue.card;
> +	int locked = 0;
> +
> +	if (card->ext_csd.boot_ro_lock
> +			& EXT_CSD_BOOT_WP_B_PERM_WP_EN)
> +		locked = 2;
> +	else if (card->ext_csd.boot_ro_lock
> +			& EXT_CSD_BOOT_WP_B_PWR_WP_EN)
> +		locked = 1;
> +
> +	ret = snprintf(buf, PAGE_SIZE, "%d\n", locked);
> +
> +	return ret;
> +}
> +
> +static ssize_t power_ro_lock_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int ret;
> +	struct mmc_blk_data *md, *part_md;
> +	struct mmc_card *card;
> +	unsigned long set;
> +
> +	if (kstrtoul(buf, 0, &set))
> +		return -EINVAL;
> +
> +	if (set != 1)
> +		return count;
> +
> +	md = mmc_blk_get(dev_to_disk(dev));
> +	card = md->queue.card;
> +
> +	mmc_claim_host(card->host);
> +
> +	ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BOOT_WP,
> +				card->ext_csd.boot_ro_lock |
> +				EXT_CSD_BOOT_WP_B_PWR_WP_EN,
> +				card->ext_csd.part_time);
> +	if (ret)
> +		pr_err("%s: Locking boot partition ro until next power on "
> +				"failed: %d\n", md->disk->disk_name, ret);
> +	else
> +		card->ext_csd.boot_ro_lock |= EXT_CSD_BOOT_WP_B_PWR_WP_EN;
> +
> +	mmc_release_host(card->host);
> +
> +	if (!ret) {
> +		pr_info("%s: %s\n", md->disk->disk_name, BOOT_PART_MSG);

BOOT_PART_MSG is undefined, so this breaks compilation.  Please test and
resubmit.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
