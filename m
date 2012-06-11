From: Muthu Kumar <muthu.lkml@gmail.com>
Subject: Re: [PATCH v2 1/1] mmc: block: Add write packing control
Date: Mon, 11 Jun 2012 14:19:46 -0700
Message-ID: <CAFR8uefCD_WXDM6m+-XwG10+W0UXqOtK7_sxWD3uVckh3pnR-Q@mail.gmail.com>
References: <1338576911-17089-1-git-send-email-merez@codeaurora.org>
	<1338576911-17089-2-git-send-email-merez@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1338576911-17089-2-git-send-email-merez@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Maya Erez <merez@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 1, 2012 at 11:55 AM, Maya Erez <merez@codeaurora.org> wrote:
> The write packing control will ensure that read requests latency is
> not increased due to long write packed commands.
>
> The trigger for enabling the write packing is managing to pack several
> write requests. The number of potential packed requests that will trigger
> the packing can be configured via sysfs by writing the required value to:
> /sys/block/<block_dev_name>/num_wr_reqs_to_start_packing.
> The trigger for disabling the write packing is fetching a read request.
>

If it is applicable only to MMC why do we have this sysfs attr for all
block devices?
