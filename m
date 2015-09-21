From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V3] mmc: block: Add new ioctl to send multi commands
Date: Mon, 21 Sep 2015 10:56:55 +0100
Message-ID: <55FFD467.9020801@nvidia.com>
References: <1442242844-6859-1-git-send-email-jonathanh@nvidia.com>
 <CAMHSBOUKYLfrYe+xBYY=ZVsqdXStPdmsJQRBTYsf4Pk=jNMrBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19924 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbbIUJ5C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Sep 2015 05:57:02 -0400
In-Reply-To: <CAMHSBOUKYLfrYe+xBYY=ZVsqdXStPdmsJQRBTYsf4Pk=jNMrBg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Seshagiri Holi <sholi@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Grant Grundler <grundler@google.com>, Olof Johansson <olofj@chromium.org>


On 16/09/15 18:54, Gwendal Grignou wrote:

[snip]

>> +static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
>> +                                  struct mmc_ioc_multi_cmd __user *user)
>> +{
>> +       struct mmc_blk_ioc_data **idata = NULL;
>> +       struct mmc_ioc_cmd __user *cmds = user->cmds;
>> +       struct mmc_card *card;
>> +       struct mmc_blk_data *md;
>> +       int i, err = -EFAULT;
>> +       __u64 num_of_cmds;
>> +
>> +       /*
>> +        * The caller must have CAP_SYS_RAWIO, and must be calling this on the
>> +        * whole block device, not on a partition.  This prevents overspray
>> +        * between sibling partitions.
>> +        */
>> +       if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
>> +               return -EPERM;
>> +
>> +       if (copy_from_user(&num_of_cmds, &user->num_of_cmds,
>> +                          sizeof(num_of_cmds)))
>> +               return -EFAULT;
>> +
>> +       if (num_of_cmds > MMC_IOC_MAX_CMDS)
>> +               return -EINVAL;
>> +
>> +       idata = kcalloc(num_of_cmds, sizeof(*idata), GFP_KERNEL);
>> +       if (!idata)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < num_of_cmds; i++) {
>> +               idata[i] = mmc_blk_ioctl_copy_from_user(&cmds[i]);
>> +               if (IS_ERR(idata[i])) {
>> +                       err = PTR_ERR(idata[i]);
>> +                       num_of_cmds = i;
>> +                       goto cmd_err;
>> +               }
>> +       }
>> +
>> +       md = mmc_blk_get(bdev->bd_disk);
>> +       if (!md)
>> +               goto cmd_err;
>> +
>> +       card = md->queue.card;
>> +       if (IS_ERR(card)) {
>> +               err = PTR_ERR(card);
>> +               goto cmd_done;
>> +       }
>> +
>> +       mmc_get_card(card);
>> +
>> +       for (i = 0; i < num_of_cmds; i++) {
>> +               err = __mmc_blk_ioctl_cmd(card, md, idata[i]);
>> +               if (err) {
>> +                       mmc_put_card(card);
>> +                       goto cmd_done;
> Instead of exiting here, you should first copy to the user the data
> and response of successful commands, mark the failed command as failed
> and the remaining ones as "not executed".
> This way, it will be easier for the user space application to find out
> where the sequence failed. This especially true if some reverts are
> needed.

Yes that sounds like a sensible thing to do. I will incorporate that change.

Cheers
Jon
