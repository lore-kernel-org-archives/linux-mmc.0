From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RESEND v4 1/2] mmc: card: Move MMC specific attributes to mmc sub-directory
Date: Sat, 14 Jul 2012 14:59:48 -0400
Message-ID: <87a9z2kw2j.fsf@octavius.laptop.org>
References: <1342291613-3189-2-git-send-email-merez@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1342291613-3189-2-git-send-email-merez@codeaurora.org> (Maya
	Erez's message of "Sat, 14 Jul 2012 21:46:52 +0300")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Maya Erez <merez@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sat, Jul 14 2012, Maya Erez wrote:
> Separate MMC specific attributes from general block device
> attributes and move them from the /sys/block/<BLOCK_DEV> directory
> to /sys/block/<BLOCK_DEV>/mmc directory

I don't think we can do this, even though the change is a good one.
What happens if someone has userspace scripts that manipulate force_ro,
or ro_lock_until_next_power_on?

sysfs isn't a firmly stable kernel ABI, but I think it's much closer
to one than this patch implies.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
