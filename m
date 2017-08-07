From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: See SD ECC errors with 4.13-rc kernel
Date: Mon, 7 Aug 2017 13:12:19 +0800
Message-ID: <20170807051218.GY31819@dragon>
References: <20170806031357.GX31819@dragon>
 <8f77f49c-118e-0aa0-41d8-b62db50fdb6a@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751424AbdHGFNf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 7 Aug 2017 01:13:35 -0400
Content-Disposition: inline
In-Reply-To: <8f77f49c-118e-0aa0-41d8-b62db50fdb6a@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>

On Mon, Aug 07, 2017 at 09:34:18AM +0800, Shawn Lin wrote:
> + Jaehoon,
> 
> On 2017/8/6 11:14, Shawn Guo wrote:
> >Hi Wolfram,
> >
> >I'm seeing SD card errors on Hikey board with 4.13-rc kernel.  Full log
> >can be found at the bottom.
> >
> >As it's never seen before with 4.12, I ran bisect down to the following
> >commits.
> >
> >9820a5b11101 (mmc: core: for data errors, take response of stop cmd into account)
> >a04e6bae9e6f (mmc: core: check also R1 response for stop commands)
> >
> >I understand that the commits might just expose the problem with my
> >platform (dw_mmc-k3 driver, Kingston 16GB UHS-I card).  But I'd like to
> >fix the problem, so I appreciate it if you can give some suggestion on
> >where I should start looking into.  Thanks.
> 
> I did slove this last week but haven't had time to sent out the patch
> until now.
> 
> Could you try this?
> 
> https://patchwork.kernel.org/patch/9884197/

Yes, it fixes my problem.  Thanks for the patch.

Shawn
