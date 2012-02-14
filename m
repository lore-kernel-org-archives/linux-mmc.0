From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 0/6] mmc: omap_hsmmc: Clean up use/abuse of pdev->id
Date: Tue, 14 Feb 2012 10:48:46 +0530
Message-ID: <4F39EEB6.2020208@ti.com>
References: <1328367090-10402-1-git-send-email-rnayak@ti.com>	<CANfBPZ-pD55YgneQSyfs1kKB-DUH8g7TQkKO7O6B95Ydfc8cFg@mail.gmail.com> <CANrkHUbXHrQ=LowgNq9nt+rnrcE-fTqLuOs2+MeCtodv_H-_Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CANrkHUbXHrQ=LowgNq9nt+rnrcE-fTqLuOs2+MeCtodv_H-_Cw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: "S, Venkatraman" <svenkatr@ti.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Friday 10 February 2012 06:57 PM, T Krishnamoorthy, Balaji wrote:
> On Tue, Feb 7, 2012 at 3:32 PM, S, Venkatraman<svenkatr@ti.com>  wrote:
>> >  On Sat, Feb 4, 2012 at 8:21 PM, Rajendra Nayak<rnayak@ti.com>  wrote:
>>> >>  This series mainly cleans up all instances of hardcoding's in
>>> >>  the driver based on pdev->id. This is cleanup leading to the
>>> >>  DT adaptation of omap_hsmmc driver.
>>> >>
>>> >>  Patches are based on 3.3-rc2 and can be found here
>>> >>  git://gitorious.org/omap-pm/linux.git omap_hsmmc_cleanup
>>> >>
>>> >>  Tested the patches on my omap4 boards (panda and SDP) but
>>> >>  haven't tested yet on omap3/2 since I did'nt have boards
>>> >>  handy. So any testing on any omap3/2 boards is really
>>> >>  appreciated.
> Tested this series on 2430SDP with FS on SD card
>
Thanks, will repost adding Tested-by from you and Venkat, also
getting rid of the one instance of host->id usage left in a
debug print.
