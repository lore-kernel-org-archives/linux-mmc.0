From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v1] mmc: core: move the cache disabling operation to mmc_suspend
Date: Mon, 28 Jan 2013 16:45:45 -0500
Message-ID: <87k3qx6kxi.fsf@laptop.org>
References: <1358681368-13044-1-git-send-email-merez@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358681368-13044-1-git-send-email-merez@codeaurora.org> (Maya
	Erez's message of "Sun, 20 Jan 2013 13:29:16 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Maya Erez <merez@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sun, Jan 20 2013, Maya Erez wrote:
> Cache control is an eMMC feature and in therefore should be
> part of MMC's bus resume operations, performed in mmc_suspend,
> rather than in the generic mmc_suspend_host().
>
> Signed-off-by: Maya Erez <merez@codeaurora.org>

Thanks, pushed to mmc-next for 3.9.

(Please ignore the mail I just sent asking you to repost this patch --
I was confused by the v1 and change in Subject line.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
