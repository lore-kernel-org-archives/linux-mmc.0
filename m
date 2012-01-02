From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 RESEND 0/2] mmc: core: Fix cache control for eMMC4.5
Date: Mon, 02 Jan 2012 18:48:02 -0500
Message-ID: <m2pqf1psy5.fsf@bob.laptop.org>
References: <000701ccc3ad$12661420$37323c60$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <000701ccc3ad$12661420$37323c60$%jun@samsung.com> (Seungwon
	Jeon's message of "Mon, 26 Dec 2011 18:02:18 +0900")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Dec 26 2011, Seungwon Jeon wrote:
> This patch-set fixed the cache control for eMMC4.5
>
> Seungwon Jeon (2):
>       mmc: core: Separate the timeout value for cache-ctrl
>       mmc: core: Add claiming a host during mmc_cache_ctrl
>
>  drivers/mmc/core/core.c |   29 +++++++++++++++++++----------
>  drivers/mmc/core/mmc.c  |   13 +++++++++++--
>  2 files changed, 30 insertions(+), 12 deletions(-)

Thanks, pushed to mmc-next for 3.3.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
