From: Andrei Warkentin <awarkentin@vmware.com>
Subject: Re: [PATCH v10] mmc : general purpose partition support.
Date: Tue, 4 Oct 2011 13:20:16 -0700 (PDT)
Message-ID: <1093389.39472.1317759616924.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
References: <1317750317-4489-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317750317-4489-1-git-send-email-linkinjeon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: linux-kernel@vger.kernel.org, adrian hunter <adrian.hunter@intel.com>, linus walleij <linus.walleij@linaro.org>, james p freyensee <james_p_freyensee@linux.intel.com>, sebras@gmail.com, Ulf Hansson <Ulf.Hansson@stericsson.com>, stefan xk nilsson <stefan.xk.nilsson@stericsson.com>, per forlin <per.forlin@stericsson.com>, johan rudholm <johan.rudholm@stericsson.com>, cjb@laptop.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

----- Original Message -----
> From: "Namjae Jeon" <linkinjeon@gmail.com>
> To: cjb@laptop.org, linux-mmc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org, awarkentin@vmware.com, "adrian hunter" <adrian.hunter@intel.com>, "linus walleij"
> <linus.walleij@linaro.org>, "james p freyensee" <james_p_freyensee@linux.intel.com>, sebras@gmail.com, "Ulf Hansson"
> <Ulf.Hansson@stericsson.com>, "stefan xk nilsson" <stefan.xk.nilsson@stericsson.com>, "per forlin"
> <per.forlin@stericsson.com>, "johan rudholm" <johan.rudholm@stericsson.com>, "Namjae Jeon" <linkinjeon@gmail.com>
> Sent: Tuesday, October 4, 2011 1:45:17 PM
> Subject: [PATCH v10] mmc : general purpose partition support.
> 
> It allows gerneral purpose partitions in MMC Device.
> And I try to simpliy make mmc_blk_alloc_parts using mmc_part
> structure suggested by Andrei Warkentin.
> After patching, we can see general purpose partitions like this.
> > cat /proc/partitions
>           179 0 847872 mmcblk0
>           179 192 4096 mmcblk0gp3
>           179 160 4096 mmcblk0gp2
>           179 128 4096 mmcblk0gp1
>           179 96  1052672 mmcblk0gp0
>           179 64  1024 mmcblk0boot1
>           179 32  1024 mmcblk0boot0
> 
> Signed-off-by: Namjae Jeon <linkinjeon@gmail.com>
> ---

Acked-by: Andrei Warkentin <andrey.warkentin@gmail.com>

A
