From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Add support for Erratum 2.1.1.128 in
 device tree boot
Date: Thu, 13 Feb 2014 23:48:54 -0600
Message-ID: <52FDAE46.4060501@ti.com>
References: <1390260542-22213-1-git-send-email-nm@ti.com> <52F0E098.3050404@ti.com> <52F104B7.6040606@ti.com> <52F2465A.6060804@ti.com> <52F246CC.6070600@ti.com> <20140213230554.GI28216@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20140213230554.GI28216@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Balaji T K <balajitk@ti.com>, Chris Ball <chris@printf.net>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 02/13/2014 05:05 PM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [140205 06:15]:
>> On Wed 05 Feb 2014 08:10:34 AM CST, Balaji T K wrote:
>>>>>
>>>>> Rather than ti,errata.. specific property, something like
>>>>> caps no/disable multiblock read is more readable in my opinion, Otherwise
>>>>
>>>> Is'nt the better definition to state i have quirk X and allow the
>>>> driver to do the necessary thing/things needed to handle quirk X? in
>>>> this case, there is just one thing to do: broken multi_block_read, in
>>>> the case of other quirks, there might be more than 1 thing to do.. let
>>>> driver figure that out, dts just states the h/w capabilty or in this
>>>> case, the quirk capability.
>>>>
>>>
>>> But in this case there is only one. disable multi block read is more readable
>>> than the errata reference, No strong feelings though.
>>
>> Considering this might set an precedence for other quirk description, 
>> I'd like to leave it as it stands.
> 
> Hmm if this really depends on the hardware version, how about
> just add new compatible flag ti,omap3430-rev-xyz-hsmmc that
> allows the driver to deal with the errata?
> 

yep - that is a very good idea. updated v2 series tested and posted:
http://marc.info/?l=linux-omap&m=139235682727541&w=2
https://patchwork.kernel.org/patch/3650061/
https://patchwork.kernel.org/patch/3650031/


-- 
Regards,
Nishanth Menon
