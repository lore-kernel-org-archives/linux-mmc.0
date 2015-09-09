From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: block: Add new ioctl to send multi commands
Date: Wed, 09 Sep 2015 17:56:05 +0200
Message-ID: <1481090.IIYrKtDeR0@wuerfel>
References: <1441811161-18513-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:65100 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbbIIP4K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2015 11:56:10 -0400
In-Reply-To: <1441811161-18513-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, grundler@google.com, olofj@chromium.org, Seshagiri Holi <sholi@nvidia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 09 September 2015 16:06:01 Jon Hunter wrote:
> +
> +       idata = kcalloc(mcci.num_of_cmds, sizeof(*idata), GFP_KERNEL);
> +       if (!idata) {
> +               err = -ENOMEM;
> +               goto cmd_err;
> +       }
> +
> +       cmds = (struct mmc_ioc_cmd __user *)(unsigned long)mcci.cmds_ptr;
> +       for (n_cmds = 0; n_cmds < mcci.num_of_cmds; n_cmds++) {
> +               idata[n_cmds] = mmc_blk_ioctl_copy_from_user(&cmds[n_cmds]);
> +               if (IS_ERR(idata[n_cmds])) {
> +                       err = PTR_ERR(idata[n_cmds]);
> +                       goto cmd_err;
> +               }
> +       }
> +

You have no upper bound on the number of commands, which means you end
up catching overly large arguments only through -ENOMEM. Can you come
up with an upper bound that is guaranteed to succeed with the allocation?

Or would it be possible to process the user data one at a time while
going through the commands?

> +struct mmc_ioc_multi_cmd {
> +       __u64 cmds_ptr;
> +       uint8_t num_of_cmds;
> +};
 
complex commands are always nasty in one way or another. Can you describe
in the patch description why you picked an indirect pointer over something
like

struct mmc_ioc_multi_cmd {
	__u64 num_of_cmds;
	struct mmc_ioc_cmd cmds[0];
};

as I said, both are ugly. My first choice would have been the other one,
but I'm sure you have some reasons yourself.

	Arnd
