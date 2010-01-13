From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/8] omap_hsmmc: RX51: set padconfs to pull down when
 powering off eMMC
Date: Wed, 13 Jan 2010 17:30:45 -0600
Message-ID: <4B4E57A5.4050400@ti.com>
References: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com> <20100113114048.7615.51097.sendpatchset@ahunter-work.research.nokia.com> <20100113203745.GK2986@atomide.com> <20100113203958.GL2986@atomide.com> <20100113210042.GM2986@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100113210042.GM2986@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
List-Id: linux-mmc@vger.kernel.org

Tony Lindgren had written, on 01/13/2010 03:00 PM, the following:
> * Tony Lindgren <tony@atomide.com> [100113 12:38]:
>> * Tony Lindgren <tony@atomide.com> [100113 12:36]:
>>> You might want to check what happens in omap off-idle mode in these cases
>>> and see if enabling OMAP_PIN_OFF_INPUT_PULLDOWN makes any difference in
>>> power consumption in off state. That probably does not matter unless the
>>> floating lines cause the eMMC to do something on it's own :)
>> Or OMAP_PIN_OFF_OUTPUT_LOW actually.
> 
> One more time.. Most likely OMAP_PIN_OFF_INPUT_PULLDOWN is safer
> in general as the OMAP_PIN_OFF_OUTPUT_LOW does not work for all
> pins. According to the TRM, OMAP_PIN_OFF_OUTPUT_LOW only works
> for pins where at least one of the mux modes supports output
> mode.

is'nt vaux/vmmc/whatever voltage to eMMC shutoff for the device on the 
board in off mode? I wonder why the behavior is seen. The only thing 
that I am worried is that the board potentially will draw more current 
as the lines are driven low.


-- 
Regards,
Nishanth Menon
