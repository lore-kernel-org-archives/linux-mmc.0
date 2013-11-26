From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: fix host release issue after discard operation
Date: Tue, 26 Nov 2013 17:06:06 -0500
Message-ID: <87fvqig6nl.fsf@octavius.laptop.org>
References: <1382810624-17659-1-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382810624-17659-1-git-send-email-rjui@broadcom.com> (Ray Jui's
	message of "Sat, 26 Oct 2013 11:03:44 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <rjui@broadcom.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Ray,

On Sat, Oct 26 2013, Ray Jui wrote:
> Under function mmc_blk_issue_rq, after an MMC discard operation,
> the MMC request data structure may be freed in memory. Later in
> the same function, the check of req->cmd_flags & MMC_REQ_SPECIAL_MASK
> is dangerous and invalid. It causes the MMC host not to be released
> when it should
>
> This patch fixes the issue by marking the special request down before
> the discard/flush operation
>
> Reported by: Harold (SoonYeal) Yang <haroldsy@broadcom.com>
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.14 and -stable.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
