From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH] mmc: block: Add new ioctl to send combo commands
Date: Thu, 10 Sep 2015 09:43:42 +0100
Message-ID: <55F142BE.5020403@nvidia.com>
References: <1441203711-19538-1-git-send-email-jonathanh@nvidia.com>
 <CAOesGMh9d6yX-dS6jg2eu2hvN5S=87rr7L-+ZUreX=GGHDxRaA@mail.gmail.com>
 <55E86260.3010203@nvidia.com>
 <CAPDyKFqFd+Dki6rbhEah_10z4eyfT1WaDmAUpagqQJc56-9B1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqFd+Dki6rbhEah_10z4eyfT1WaDmAUpagqQJc56-9B1A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grant Grundler <grundler@google.com>, Olof Johansson <olofj@chromium.org>, Seshagiri Holi <sholi@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On 09/09/15 13:42, Ulf Hansson wrote:

[snip]

>> +static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>> +                       struct mmc_ioc_cmd __user *ic_ptr)
>> +{
>> +       struct mmc_blk_ioc_data *idata;
>> +       struct mmc_blk_data *md;
>> +       struct mmc_card *card;
>> +       int err;
>> +
>> +       /*
>> +        * The caller must have CAP_SYS_RAWIO, and must be calling this on the
>> +        * whole block device, not on a partition.  This prevents overspray
>> +        * between sibling partitions.
>> +        */
>> +       if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
>> +               return -EPERM;
>> +
>> +       idata = mmc_blk_ioctl_copy_from_user(ic_ptr);
>> +       if (IS_ERR(idata))
>> +               return PTR_ERR(idata);
>> +
>> +       md = mmc_blk_get(bdev->bd_disk);
>> +       if (!md) {
>> +               err = -EINVAL;
>> +               goto cmd_err;
>> +       }
>> +
>> +       card = md->queue.card;
>> +       if (IS_ERR(card)) {
>> +               err = PTR_ERR(card);
>> +               goto cmd_done;
>> +       }
>> +
>> +       mmc_claim_host(card->host);
> 
> As __mmc_blk_ioctl_cmd() already does mmc_get_card(), you don't need
> mmc_claim_host() here.

Thinking about this some more, does it make sense to have a
mmc_get_card() above and then remove the one from __mmc_blk_ioctl_cmd()?
The mmc_blk_ioctl_multi_cmd() needs to call mmc_get_card() before
calling __mmc_blk_ioctl_cmd() and so currently we are calling
mmc_get_card() twice in the case of mmc_blk_ioctl_multi_cmd() which
seems unnecessary.

Cheers
Jon
