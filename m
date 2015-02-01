From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/5] drivers: mmc: card: Fixes Missing blank line after
 variable initialization, coding style warning
Date: Sun, 01 Feb 2015 12:20:22 -0800
Message-ID: <1422822022.12856.3.camel@perches.com>
References: <1422821222-24079-1-git-send-email-sheetal.tigadoli@gmail.com>
	 <1422821222-24079-2-git-send-email-sheetal.tigadoli@gmail.com>
	 <1422821222-24079-3-git-send-email-sheetal.tigadoli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422821222-24079-3-git-send-email-sheetal.tigadoli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
Cc: chris@printf.net, linux-mmc@vger.kernel.org, ben@decadent.org.uk, kuninori.morimoto.gx@renesas.com, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 2015-02-02 at 01:36 +0530, Sheetal Tigadoli wrote:
> This patch fixes "Missing blank line warnings". Following lines show warnings
> generated upon running checkpatch.pl script
> 
>         drivers/mmc/card/block.c:186: WARNING: Missing a blank line after declarations
>         drivers/mmc/card/block.c:280: WARNING: Missing a blank line after declarations
>         drivers/mmc/card/block.c:620: WARNING: Missing a blank line after declarations
>         drivers/mmc/card/block.c:1720: WARNING: Missing a blank line after declarations

4 lines here, 3 changes below?

>  drivers/mmc/card/block.c |    3 +++
>  1 file changed, 3 insertions(+)

btw: checkpatch has a --fix feature that could help

For instance, this:

$ ./scripts/checkpatch.pl -f --types=line_spacing --fix-inplace drivers/mmc/card/block.c
$ git diff drivers/mmc/card/block.c
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c69afb5..247044f 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -183,6 +183,7 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 	md->usage--;
 	if (md->usage == 0) {
 		int devidx = mmc_get_devidx(md->disk);
+
 		blk_cleanup_queue(md->queue.queue);
 
 		__clear_bit(devidx, dev_use);
@@ -277,6 +278,7 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
 	char *end;
 	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
 	unsigned long set = simple_strtoul(buf, &end, 0);
+
 	if (end == buf) {
 		ret = -EINVAL;
 		goto out;
@@ -617,6 +619,7 @@ static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
 	int ret = -EINVAL;
+
 	if (cmd == MMC_IOC_CMD)
 		ret = mmc_blk_ioctl_cmd(bdev, (struct mmc_ioc_cmd __user *)arg);
 	return ret;
@@ -1717,6 +1720,7 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 			   int ret)
 {
 	struct mmc_queue_req *mq_rq;
+
 	mq_rq = container_of(brq, struct mmc_queue_req, brq);
 
 	/*
