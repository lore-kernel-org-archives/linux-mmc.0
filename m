From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2 11/16] mmc: omap_hsmmc: ensure pbias configuration is always done
Date: Fri, 14 Oct 2011 10:01:29 -0400
Message-ID: <m2ty7bekp2.fsf@bob.laptop.org>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
	<1304673255-31634-12-git-send-email-adrian.hunter@nokia.com>
	<CANrkHUYp-6a+qBZLk7SL9zHoy0wKuoYYYVEo0yb5=qzzicGepQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CANrkHUYp-6a+qBZLk7SL9zHoy0wKuoYYYVEo0yb5=qzzicGepQ@mail.gmail.com>
	(T. Krishnamoorthy's message of "Thu, 29 Sep 2011 19:10:30 +0530")
Sender: linux-omap-owner@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Sep 29 2011, T Krishnamoorthy, Balaji wrote:
> On Fri, May 6, 2011 at 2:44 PM, Adrian Hunter <adrian.hunter@nokia.com> wrote:
>> Go through the driver's set_power() functions rather than
>> calling regulator_enable/disable() directly because otherwise
>> pbias configuration for MMC1 is not done.
> Hi Chris,
>
> Are you OK to queue this patch as bug fix. Rest of the patches of this
> series is either
> merged or not needed. Should I rebase and repost this alone ?
>
> FWIW:
> Acked-by: Balaji T K <balajitk@ti.com>

Thanks, I've pushed this to mmc-next for 3.2 now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
