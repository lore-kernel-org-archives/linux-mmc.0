From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/8][git pull] mmc: omap: Assorted fixes for 3.4 merge window
Date: Sun, 01 Apr 2012 00:40:45 -0400
Message-ID: <87hax4kqsy.fsf@laptop.org>
References: <1331905144-31655-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1331905144-31655-1-git-send-email-svenkatr@ti.com> (Venkatraman
	S.'s message of "Fri, 16 Mar 2012 19:08:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, balajitk@ti.com, balbi@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Mar 16 2012, Venkatraman S wrote:
> Chris,
>    Here are a group of fixes posted by Felipe and Balaji for the
> OMAP hsmmc driver in the past few days. 
>    I've rebased them to the lastest mmc-next and posted them
> here again. These have also been tested on OMAP4 development platform.
>
> Please feel to apply directly or pull if that's convenient.
>
> Changes since yesterday (v1):-
> 	Fixed formatting issues as suggested by Felipe
> 	Marked some patches for stable.
>
> The following changes since commit 5f0390f10c0e9c9c504cdbf4af802252628a2490:
>
>   mmc: omap_hsmmc: Avoid a regulator voltage change with dt (2012-03-14 11:33:20 -0400)
>
> are available in the git repository at:
>
>   git://github.com/svenkatr/linux.git omap-mmc-pending-for-3.4
>
> for you to fetch changes up to 8d54766b608915035b47616ea564e4e9b4dda29c:
>
>   mmc: omap4: hsmmc: fix module re-insertion (2012-03-16 11:38:41 +0530)

I've just rebased mmc-next on top of 3.4-rc1, and now there are many
conflicts against your tree -- please could you resend patches 3-8
against that base?  I'll take them for 3.4, and will take patches 1-2
for 3.5.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
