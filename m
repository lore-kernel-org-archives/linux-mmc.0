From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v5] mmc: Export host capabilities to debugfs.
Date: Tue, 6 Mar 2018 22:27:25 +0800
Message-ID: <6d51c3b3-abd3-82a8-ec7b-da063a9e5aaa@rock-chips.com>
References: <1520344425-13131-1-git-send-email-harish_kandiga@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520344425-13131-1-git-send-email-harish_kandiga@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harish Jenny K N <harish_kandiga@mentor.com>
Cc: ulf.hansson@linaro.org, linus.walleij@linaro.org, adrian.hunter@intel.com, avri.altman@wdc.com, andriy.shevchenko@linux.intel.com, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir_Zapolskiy@mentor.com
List-Id: linux-mmc@vger.kernel.org

On 2018/3/6 21:53, Harish Jenny K N wrote:
> This patch exports the host capabilities to debugfs
> 
> This idea of sharing host capabilities over debugfs
> came up from Abbas Raza <Abbas_Raza@mentor.com>
> Earlier discussions:
> https://lkml.org/lkml/2018/3/5/357
> https://www.spinics.net/lists/linux-mmc/msg48219.html
> 
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> ---
> 
> Changes in v5:
> - Added parser logic in kernel by using debugfs_create_file
>   for caps and caps2 instead of debugfs_create_x32

I'm fine with your method if Ulf likes it, but could you use
DEFINE_SHOW_ATTRIBUTE instead? :)



-- 
Best Regards
Shawn Lin
