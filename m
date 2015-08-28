From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [v4,1/6] mmc: dt: add DT binding for big endian controller
Date: Fri, 28 Aug 2015 09:46:20 +0200
Message-ID: <CAPDyKFqc_fQQz-5xJkr3ZBkPXS=0yK6bOdbpkDFwyLKJKwWnzg@mail.gmail.com>
References: <DM2PR0301MB0734002AABE322D7106D3AF6BA620@DM2PR0301MB0734.namprd03.prod.outlook.com>
	<BY1PR0301MB1192D64A16D187E5485796DCF2610@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<CAPDyKFpR=qbheQ8hJueAbHA_5f9kBDNb9_zqanGTna+1POhbdg@mail.gmail.com>
	<BY1PR0301MB11925C4491BEA2DC7ECB5C75F2600@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<CAPDyKFoYXEU+1k9nsdnrc2pUTgtN3-FvsPGVjDNYxwaEHOQmvA@mail.gmail.com>
	<DM2PR0301MB07348CE40074F4DDA239B172BA6F0@DM2PR0301MB0734.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <DM2PR0301MB07348CE40074F4DDA239B172BA6F0-Cwg/PA1lyPnRfvLtmsd4/5wN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Li Leo <LeoLi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "Lu Y.B." <yangbo.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 27 August 2015 at 20:39, Li Leo <LeoLi-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
>> > Or Maybe there is another method, use conditional compilation. The previous
>> method would delete the MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER to
>> use accessors defined in sdhci-esdhc.h, and add dependency of ARM. This
>> method could use 'select <accessors> if <ARCH>' to compile LE or BE accessors
>> according ARCH.
>>
>> I don't really follow your suggestion.
>>
>> Isn't the problem that you need the
>> MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER for configurations and for
>> some you don't? More precisely, for those where you don't you would
>> rather just use the regulator ioread* functions since those will
>> internally deal with the endianess in runtime?
>>
>> If you can make these decisions at compile time an depending of the
>> ARCH - I believe I would be fine with that as well.
>
> I know it is a little bit weird.  But the endian of the peripheral device is not always consistent with the type/endian of the core.

Yes got it. So it seems relying on the ARCH in compile time isn't
going to be a long term solution.

Then it's better to have a default mode and then via DT be able to
change that, right? As you suggested above.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
