From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 09/13] mmc: block: Use local variables in
 mmc_blk_data_prep()
Date: Mon, 21 Aug 2017 12:27:02 +0300
Message-ID: <a003ddd8-0bb3-fb83-dedd-ed98eb80b170@intel.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
 <1502366898-23691-10-git-send-email-adrian.hunter@intel.com>
 <CACRpkda2SCGcN2ivVQJPLoeGxrudPqy883EpmRWcvNdGRe7GKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:55722 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752452AbdHUJde (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 21 Aug 2017 05:33:34 -0400
In-Reply-To: <CACRpkda2SCGcN2ivVQJPLoeGxrudPqy883EpmRWcvNdGRe7GKQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On 20/08/17 14:43, Linus Walleij wrote:
> On Thu, Aug 10, 2017 at 2:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> Use local variables in mmc_blk_data_prep() in preparation for adding CQE
>> support which doesn't use the output variables.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> on the patch as such but:
> 
>>  static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>> -                             int disable_multi, bool *do_rel_wr,
>> -                             bool *do_data_tag)
>> +                             int disable_multi, bool *do_rel_wr_p,
>> +                             bool *do_data_tag_p)
> 
> We need to figure out what we mean by "tag" in eMMC.

Data tags are an eMMC invention to categorize the type of data.  They have
nothing to do with block layer tags.
