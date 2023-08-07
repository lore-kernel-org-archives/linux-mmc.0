Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2C1C001DB
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Aug 2023 13:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjHGNt0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Aug 2023 09:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbjHGNtV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2023 09:49:21 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2878C1BE3
        for <linux-mmc@vger.kernel.org>; Mon,  7 Aug 2023 06:49:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d4364cf8be3so3519477276.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2023 06:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691416148; x=1692020948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LrwjN5Q8LetwblRISR8oyofHz7AZ81IID5+NzR+/8cA=;
        b=V7Jh7Nsn3GJVY+ygsTFOkvGh4bLV8N8/Ew/DUfO2RWeke7HQyKDyjJX+JH09EUP2rA
         Jju6Z82uwl1JMOag6O15FNgv0xHCpxqyF6scOiN5H6wvWBVLBpQAZYVxgKhm29sonjSH
         TUYPL4ckDcXINMIpHVuFl+V+kpgsZjqnuZdEpGzTr8XStLu6S+g4JDUmGdlgBXaAUM9n
         bjPmpPjvVEQJr0K3eRuPaaXg4zdZFd/S2DaXMRrvLdjIBJLBqdqpOTfsnkgnGeK64FJR
         NxGiN3P3Vg/fHgZLkbbIvyLeA/NV8B11XiV/mObIGlymdQt9CJQqeELnuL5Kv2Sayvt0
         dJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691416148; x=1692020948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrwjN5Q8LetwblRISR8oyofHz7AZ81IID5+NzR+/8cA=;
        b=HRAwGB9Pr9acMwWFfFl1tjeuhqG75w8+ijAAuKWvBReWFq8SFcAJhrxgq6GipwdInG
         wdLQ2ZY05xEbwASi5xlN+AZ3/k4OvSZqziROAwcHSUAwtzyyXXomEmtHwI3a9e573yL5
         Fl87obiU+zaoyLkoJ7w5sXRc/+bagkz3YHg6I6YCHJahaGok9LVziJxoMlRQYzEsqGfV
         1G7Wolu4OBldyNX2+cELB/ykwDBW/19P06z3GH23Cfx6VaELyz6QoMXrgUUf75OcHJPr
         UT1YoNgBja2ETY6oX5YOGY2qU2NOkWE6oxdvjV/9h5PS/UApc4HO2M2XZl/MzXMPI66D
         57lQ==
X-Gm-Message-State: AOJu0YzXhuMM5wBVEvsHomuQnzufuZM9ZyqPLxHwmPKQFfSVk5cVaciI
        ccNSo9tnxMJWgYo2weiWF5YT1KUD5moQ55MuicMVdQ==
X-Google-Smtp-Source: AGHT+IFlfGibypvOnYH7G4eRsSzX2n2Sgj1wUF/VjFKrm12jEANuab024sswGKNkLGhC7dNM+6Cl6fZVefMCQC5Ucn4=
X-Received: by 2002:a25:b316:0:b0:cea:b62d:620f with SMTP id
 l22-20020a25b316000000b00ceab62d620fmr9376359ybj.45.1691416147971; Mon, 07
 Aug 2023 06:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689802933.git.daniel@makrotopia.org> <1ce5f56df546cec25ef741f381286f1d7c33d000.1689802933.git.daniel@makrotopia.org>
In-Reply-To: <1ce5f56df546cec25ef741f381286f1d7c33d000.1689802933.git.daniel@makrotopia.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Aug 2023 15:48:31 +0200
Message-ID: <CAPDyKFqhZtCHVmCNnm_Qm7X+=GtJY8uNJOWOgZXuTTVEw0msNA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] mmc: block: set fwnode of disk devices
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Chinner <dchinner@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Min Li <min15.li@samsung.com>,
        Christian Loehle <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@ionos.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yeqi Fu <asuk4.q@gmail.com>, Avri Altman <avri.altman@wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ye Bin <yebin10@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 20 Jul 2023 at 00:02, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Set fwnode of disk devices to 'block', 'boot0' and 'boot1' subnodes of
> the mmc-card. This is done in preparation for having the eMMC act as
> NVMEM provider.

Sorry, but I don't quite understand what you are trying to do here.
Maybe you should re-order the patches in the series so it becomes
clear why this is needed?

Moreover, I don't see any DT docs being updated as a part of the
series, which looks like it is needed too. That would also help to
understand what you are proposing, I think.

>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/mmc/core/block.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f701efb1fa785..fc1a9f31bd253 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2413,6 +2413,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>                                               int area_type,
>                                               unsigned int part_type)
>  {
> +       struct fwnode_handle *fwnode;
> +       struct device *ddev;
>         struct mmc_blk_data *md;
>         int devidx, ret;
>         char cap_str[10];
> @@ -2509,6 +2511,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>
>         blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
>
> +       ddev = disk_to_dev(md->disk);
> +       fwnode = device_get_named_child_node(subname ? md->parent->parent :
> +                                                      md->parent,
> +                                            subname ? subname : "block");
> +       ddev->fwnode = fwnode;
> +
>         string_get_size((u64)size, 512, STRING_UNITS_2,
>                         cap_str, sizeof(cap_str));
>         pr_info("%s: %s %s %s%s\n",

Kind regards
Uffe
