From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/7] mmc: omap_hsmmc: Fix Oops in case of data errors
Date: Sun, 25 Nov 2012 15:49:50 -0500
Message-ID: <87sj7x76hd.fsf@octavius.laptop.org>
References: <1353342601-15210-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1353342601-15210-1-git-send-email-svenkatr@ti.com> (Venkatraman
	S.'s message of "Mon, 19 Nov 2012 21:59:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Hi Venkat,

On Mon, Nov 19 2012, Venkatraman S wrote:
> From: Balaji T K <balajitk@ti.com>
>
> "commit ae4bf788ee9bf7c2d51b0309117d1fcccbdd50a2
> mmc: omap_hsmmc: consolidate error report handling of HSMMC IRQ"
> sets both end_cmd and end_trans to 1.
>
> Setting end_cmd to 1 for Data Timeout/CRC leads to NULL pointer dereference of
> host->cmd as the command complete has previously been handled.
> Set end_cmd only in case of command Timeout/CRC.
>
> Moreover host->cmd->error should not be updated on data error case, only
> host->data->error needs to be updated.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>

Thanks, pushed all 7 patches to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
