From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCHv3 0/3] OMAP: HSMMC: cleanup and runtime pm
Date: Fri, 1 Jul 2011 11:46:01 +0530
Message-ID: <BANLkTikwEH+wFzn-7gno5tXzJSeweDvTLw@mail.gmail.com>
References: <1309460700-25898-1-git-send-email-balajitk@ti.com>
	<4E0CD055.30902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35482 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754792Ab1GAGQE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Jul 2011 02:16:04 -0400
In-Reply-To: <4E0CD055.30902@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "tony@atomide.com" <tony@atomide.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>

On Fri, Jul 1, 2011 at 1:06 AM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
> Hi Balaji,
>
> On 6/30/2011 9:04 PM, Krishnamoorthy, Balaji T wrote:
>>
>> Removing the custom state machine - lazy disable framework in omap_h=
smmc
>> to make way for runtime pm to handle host controller
>> power states.
>> This allows mmc_host_enable/mmc_host_disable to be replaced by
>> runtime get_sync and put_sync at host controller driver.
>>
>> Enable runtime PM in omap_hsmmc
>>
>> Rebased to 3.0-rc5
>> Tested on OMAP4430SDP, OMAP3430SDP, OMAP2430SDP
>>
>> MMC runtime patch has dependency on
>> [PATCH 0/6] OMAP2+: hwmod framework fixes [1]
>> for MMC1/MMC2 clock to get ungated after idle in OMAP4.
>>
>> Without [1] patches, MMC1/MMC2 fails to get detected on OMAP4.
>
> Mmm, that's weird, which one exactly is fixing the issue?

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg51458.html
[PATCH 1/6] OMAP2+: hwmod: Fix smart-standby + wakeup support

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg51461.html
[PATCH 2/6] OMAP4: hwmod data: Add MSTANDBY_SMART_WKUP flag


> BTW, what is the issue exactly?

with SIDLE_SMART_WKUP flag set in omap44xx_mmc_sysc,
module got stuck after second clock enable.
It got resolved after adding MSTANDBY_SMART_WKUP fixes
=2E
Removing SIDLE_SMART_WKUP also solves the issue..

>
> Benoit
>
>>
>> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg51457.=
html
>>
>> Balaji T K (3):
>> =A0 MMC: OMAP: HSMMC: Remove lazy_disable
>> =A0 MMC: OMAP: HSMMC: add runtime pm support
>> =A0 MMC: OMAP: HSMMC: Remove unused iclk
>>
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0365
>> +++++++----------------------------------
>> =A01 files changed, 57 insertions(+), 308 deletions(-)
>>
>
>
