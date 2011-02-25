From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v4 0/6] OMAP: HSMMC: hwmod adaptation
Date: Fri, 25 Feb 2011 14:12:37 +0100
Message-ID: <4D67AAC5.5080102@ti.com>
References: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com> <4D67A677.4000407@ti.com> <AANLkTim=g6a-nq-J4wmaqZWSgR9OmaQMi=KUkXmfPAHJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35937 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755321Ab1BYNMo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Feb 2011 08:12:44 -0500
In-Reply-To: <AANLkTim=g6a-nq-J4wmaqZWSgR9OmaQMi=KUkXmfPAHJ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "cjb@laptop.org" <cjb@laptop.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>

On 2/25/2011 2:06 PM, Kadiyala, Kishore wrote:
> Hi Benoit,
>
> On Fri, Feb 25, 2011 at 6:24 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> Hi Kishore,
>>
>> On 2/24/2011 8:26 PM, Kadiyala, Kishore wrote:
>>>
>>> Adding hwmod data for hsmmc device on OMAP2430/OMAP3/OMAP4.
>>> Adapting the omap_hsmmc driver to hwmod framework.
>>>
>>> The patch series is based on omap-for-linus and tested on
>>> OMAP2430, OMAP3430SDP&    OMAP4430SDP.
>>> Also boot tested on OMAP2420SDP.
>>>
>>> V4:
>>> ---
>>> Omap2420 platform consists of mmc block as in omap1 and not the
>>> hsmmc block as present in omap2430, omap3, omap4 platforms.
>>> The series takes care of hwmod adaptation of hsmmc drivers and
>>> thus excluding the omap2420 platforms.
>>>
>>> Also includes renaming of device&    driver name.
>>>
>>> The patch series has dependency on :
>>>   1)https://patchwork.kernel.org/patch/585281/

That link is broken... that's why it's tricky to get the dependency...

>>>   2)https://patchwork.kernel.org/patch/538301/
>>
>> This is still not omap-for-linus (at 7cab871)...
>> I cannot apply the series on it:-(
>
> The patch series has dependency on
> link (1)  mentioned above [Opening link is throwing error] ,
> below is the new link
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg45190.html
>
> Could you please check once.

OK so in fact none of these patches are yet in omap-for-linus.
It should be OK for me, because I can apply the hwmod data patch at least.

I'll send you my comment on the data in 1 minute...

Thanks,
Benoit

