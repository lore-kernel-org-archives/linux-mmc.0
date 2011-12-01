From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] omap_hsmmc: consider MMC_PM_KEEP_POWER on suspend/resume
Date: Thu, 01 Dec 2011 13:16:05 -0500
Message-ID: <87r50okviy.fsf@laptop.org>
References: <1321970539-7104-1-git-send-email-eliad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1321970539-7104-1-git-send-email-eliad@wizery.com> (Eliad
	Peller's message of "Tue, 22 Nov 2011 16:02:17 +0200")
Sender: linux-omap-owner@vger.kernel.org
To: Eliad Peller <eliad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Nov 22 2011, Eliad Peller wrote:
> When an mmc card has the MMC_PM_KEEP_POWER flag, it shouldn't
> be powered off on suspend (and thus doesn't have to be powered-on
> on resume)
>
> While on it, change the suspend flow a bit, to make it a bit
> easier to follow.
>
> Signed-off-by: Eliad Peller <eliad@wizery.com>

Tony, feel free to merge this patchset (if you're happy with the rest of
it) through your tree, with my:

Acked-by: Chris Ball <cjb@laptop.org>

for this patch.  Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
