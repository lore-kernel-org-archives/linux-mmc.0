Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eAu/deUk"
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9268B1725
	for <linux-mmc@vger.kernel.org>; Thu, 30 Nov 2023 02:36:47 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5cd0af4a7d3so8969287b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Nov 2023 02:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701340606; x=1701945406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gD8Ayf1AYhbmM4fh3YeF8ox1Jjwazt6b4ZRYpU2f+DM=;
        b=eAu/deUk8vj1QupJnhv9Nzwa4gQUaVvwPPqjJTYL0NiVVunUkL1zLBkUS8eGT42dYe
         AnnLB17Ybn+0ihEVMKld7uws4o3YLuU0ZIwDqgX4edfHXyWNWLG+hXi7qv47Kv4LxnxZ
         lcgqaCKdRAPz6D4ORYadXzdtOt6LCv/K0AHzdnoxuPx8BvBQ4rjiFE3ycTgKXbSJOIO/
         SeSpNJ4lWDBOuVnpISFzzFIHBR6wAfyCwS+q9nTTNAfGZXsIRJQ2d351UMOMw2cZhzIQ
         4BsgCn3XzXp6vKMQPr5xKt4IuurZRFFQ3Vl/11czGtfh3a1rftn8BBNOWGkxrjqaicOj
         o7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701340606; x=1701945406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gD8Ayf1AYhbmM4fh3YeF8ox1Jjwazt6b4ZRYpU2f+DM=;
        b=Xc4FQThlCqDCN1YJ8fnuLguAXEUsQA8c68Nbdlns35bLAxkYXcWzmvJ7mR6rwKljS2
         nPzsY3j6TzJT24aDljY7A0lVSa5I0I6pmSKs/rP1Iv+TZlwwwOr3FILivCVkF//e5Evx
         Plo5QuW+93PEb9JGCaEHcZtx8eKawBN0OCC4x0LvustBiGc4bfogIrZe/iUnfRptplad
         jybNXPgZMU3h9VbsB24bc+CARS0GnrIAvVvYl424espT0diAnVxAduDj8laLZAjFK2c1
         VP5xjX73Ni/RPfndo1dzVgkVaCfQJ7X+KnnDe3ER3BEsBroU91vwl6gzD+BBJREB7+km
         s7nQ==
X-Gm-Message-State: AOJu0YxDkhqz5BDNFgeWRSP0xbAgpUKv2o91HwiN5FNDMeRMn5pntX/v
	6yrc/qkrJGoPiY5eU4yc6XVKZW8OfbXzFvBwLbTgsQ==
X-Google-Smtp-Source: AGHT+IErmhqOy3vJAJROQwvf8lOjylHakErCnyq0sWGAel0cDMr7y4YlM2EdT1OhLyT729SbyApyM90MsgLbSVM23GM=
X-Received: by 2002:a0d:c287:0:b0:5c9:9815:b8ef with SMTP id
 e129-20020a0dc287000000b005c99815b8efmr21996593ywd.49.1701340606411; Thu, 30
 Nov 2023 02:36:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129092535.3278-1-avri.altman@wdc.com>
In-Reply-To: <20231129092535.3278-1-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Nov 2023 11:36:10 +0100
Message-ID: <CAPDyKFqsyp=isawJKH0Q7Qqxqtkx=gmPZru9NnK-ndV20VRmFA@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: core: Use mrq.sbc in close-ended ffu
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Daniil Lunev <dlunev@google.com>, Asutosh Das <quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Nov 2023 at 10:25, Avri Altman <avri.altman@wdc.com> wrote:
>
> Field Firmware Update (ffu) may use close-ended or open ended sequence.
> Each such sequence is comprised of a write commands enclosed between 2
> switch commands - to and from ffu mode. So for the close-ended case, it
> will be: cmd6->cmd23-cmd25-cmd6.
>
> Some host controllers however, get confused when multi-block rw is sent
> without sbc, and may generate auto-cmd12 which breaks the ffu sequence.
> I encountered  this issue while testing fwupd (github.com/fwupd/fwupd)
> on HP Chromebook x2, a qualcomm based QC-7c, code name - strongbad.
>
> Instead of a quirk, or hooking the request function of the msm ops,
> it would be better to fix the ioctl handling and make it use mrq.sbc
> instead of issuing SET_BLOCK_COUNT separately.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Applied for next (to get it tested a bit more) and by adding a stable
tag, thanks!

Kind regards
Uffe


> ---
>
> Changelog:
> v3--v4:
>         check sbc.error as well
> v2--v3:
>         Adopt Adrian's proposal
> v1--v2:
>         remove redundant reference of reliable write
> ---
>  drivers/mmc/core/block.c | 46 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f9a5cffa64b1..892e74e611a0 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -400,6 +400,10 @@ struct mmc_blk_ioc_data {
>         struct mmc_ioc_cmd ic;
>         unsigned char *buf;
>         u64 buf_bytes;
> +       unsigned int flags;
> +#define MMC_BLK_IOC_DROP       BIT(0)  /* drop this mrq */
> +#define MMC_BLK_IOC_SBC        BIT(1)  /* use mrq.sbc */
> +
>         struct mmc_rpmb_data *rpmb;
>  };
>
> @@ -465,7 +469,7 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
>  }
>
>  static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
> -                              struct mmc_blk_ioc_data *idata)
> +                              struct mmc_blk_ioc_data **idatas, int i)
>  {
>         struct mmc_command cmd = {}, sbc = {};
>         struct mmc_data data = {};
> @@ -475,10 +479,18 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         unsigned int busy_timeout_ms;
>         int err;
>         unsigned int target_part;
> +       struct mmc_blk_ioc_data *idata = idatas[i];
> +       struct mmc_blk_ioc_data *prev_idata = NULL;
>
>         if (!card || !md || !idata)
>                 return -EINVAL;
>
> +       if (idata->flags & MMC_BLK_IOC_DROP)
> +               return 0;
> +
> +       if (idata->flags & MMC_BLK_IOC_SBC)
> +               prev_idata = idatas[i - 1];
> +
>         /*
>          * The RPMB accesses comes in from the character device, so we
>          * need to target these explicitly. Else we just target the
> @@ -532,7 +544,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>                         return err;
>         }
>
> -       if (idata->rpmb) {
> +       if (idata->rpmb || prev_idata) {
>                 sbc.opcode = MMC_SET_BLOCK_COUNT;
>                 /*
>                  * We don't do any blockcount validation because the max size
> @@ -540,6 +552,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>                  * 'Reliable Write' bit here.
>                  */
>                 sbc.arg = data.blocks | (idata->ic.write_flag & BIT(31));
> +               if (prev_idata)
> +                       sbc.arg = prev_idata->ic.arg;
>                 sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
>                 mrq.sbc = &sbc;
>         }
> @@ -557,6 +571,15 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         mmc_wait_for_req(card->host, &mrq);
>         memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
>
> +       if (prev_idata) {
> +               memcpy(&prev_idata->ic.response, sbc.resp, sizeof(sbc.resp));
> +               if (sbc.error) {
> +                       dev_err(mmc_dev(card->host), "%s: sbc error %d\n",
> +                                                       __func__, sbc.error);
> +                       return sbc.error;
> +               }
> +       }
> +
>         if (cmd.error) {
>                 dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
>                                                 __func__, cmd.error);
> @@ -1032,6 +1055,20 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
>         md->reset_done &= ~type;
>  }
>
> +static void mmc_blk_check_sbc(struct mmc_queue_req *mq_rq)
> +{
> +       struct mmc_blk_ioc_data **idata = mq_rq->drv_op_data;
> +       int i;
> +
> +       for (i = 1; i < mq_rq->ioc_count; i++) {
> +               if (idata[i - 1]->ic.opcode == MMC_SET_BLOCK_COUNT &&
> +                   mmc_op_multi(idata[i]->ic.opcode)) {
> +                       idata[i - 1]->flags |= MMC_BLK_IOC_DROP;
> +                       idata[i]->flags |= MMC_BLK_IOC_SBC;
> +               }
> +       }
> +}
> +
>  /*
>   * The non-block commands come back from the block layer after it queued it and
>   * processed it with all other requests and then they get issued in this
> @@ -1059,11 +1096,14 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
>                         if (ret)
>                                 break;
>                 }
> +
> +               mmc_blk_check_sbc(mq_rq);
> +
>                 fallthrough;
>         case MMC_DRV_OP_IOCTL_RPMB:
>                 idata = mq_rq->drv_op_data;
>                 for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
> -                       ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
> +                       ret = __mmc_blk_ioctl_cmd(card, md, idata, i);
>                         if (ret)
>                                 break;
>                 }
> --
> 2.42.0
>
