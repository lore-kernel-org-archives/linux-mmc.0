From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v9] mmc : general purpose partition support.
Date: Tue, 04 Oct 2011 12:19:57 -0400
Message-ID: <m2botwloeq.fsf@bob.laptop.org>
References: <1317745057-6328-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317745057-6328-1-git-send-email-linkinjeon@gmail.com> (Namjae
	Jeon's message of "Wed, 5 Oct 2011 01:17:37 +0900")
Sender: linux-kernel-owner@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, awarkentin@vmware.com, adrian.hunter@intel.com, linus.walleij@linaro.org, james_p_freyensee@linux.intel.com, sebras@gmail.com, Ulf.Hansson@stericsson.com, stefan.xk.nilsson@stericsson.com, per.forlin@stericsson.com, johan.rudholm@stericsson.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Oct 04 2011, Namjae Jeon wrote:
> It allows gerneral purpose partitions in MMC Device.
> And I try to simpliy make mmc_blk_alloc_parts using mmc_part structure suggested by Andrei Warkentin.
> After patching, we can see general purpose partitions like this.
>> cat /proc/partitions
>           179 0 847872 mmcblk0
>           179 192 4096 mmcblk0gp3
>           179 160 4096 mmcblk0gp2
>           179 128 4096 mmcblk0gp1
>           179 96  1052672 mmcblk0gp0
>           179 64  1024 mmcblk0boot1
>           179 32  1024 mmcblk0boot0
>
> Signed-off-by: Namjae Jeon <linkinjeon@gmail.com>

Still doesn't apply here.  Are you sure you're on the "mmc-next" branch
of the repository?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
