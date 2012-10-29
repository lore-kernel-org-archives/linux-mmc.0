From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] mmc: omap_hsmmc: remove warning message for debounce clock
Date: Mon, 29 Oct 2012 17:26:02 -0400
Message-ID: <874nldq8b9.fsf@octavius.laptop.org>
References: <1351180715-26761-1-git-send-email-balajitk@ti.com>
	<20121025161231.GO11928@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20121025161231.GO11928@atomide.com> (Tony Lindgren's message of
	"Thu, 25 Oct 2012 09:12:32 -0700")
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, svenkatr@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Oct 25 2012, Tony Lindgren wrote:
> * Balaji T K <balajitk@ti.com> [121025 09:00]:
>> MMC debounce clock is applicable only for omap2430, warning message gets
>> printed when enable fails for debounce clock. Remove the get debounce clock
>> failure message as it is noisy for other platforms.
>> 
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> This would be good to get in during the -rc cycle if possible to remove
> the bogus warnings on non-2430 omaps. But since it's been there for a
> long time, we can wait too if needed.
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks; pushed to mmc-next, I'll send it for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
